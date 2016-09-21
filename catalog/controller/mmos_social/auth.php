<?php

class ControllerMmosSocialAuth extends Controller {

	private $_config = array();
	private $_redirect;
	private $_base_redirect; //use for redirect when error occurs

	public function index() {
		// get param msd_share_product_id to set callback to social discount share

		$this->_prepare();

		// Check if Logged
		if ($this->customer->isLogged()) {
			$this->response->redirect($this->_redirect);
		}

		// Check if module is Enabled
		$mmos_social = $this->config->get('mmos_social_login');

		if (!(isset($mmos_social) && isset($mmos_social['social_login_status']))) {
			$this->response->redirect($this->_redirect);
		}

		// Dependencies
		$this->load->language('mmos_social/auth');
		//require_once(DIR_SYSTEM . 'library/Hybrid/Auth.php');
		$this->load->library('Hybrid/Auth');
		$this->load->model('mmos_social/auth');

		// Load Config
		//        $this->_config['base_url']   = HTTPS_SERVER . 'mmos_social.php';
		$this->_config['base_url'] = $this->url->link('mmos_social/mmos_social');

		$this->_config['debug_file'] = DIR_SYSTEM . 'logs/aaaaa.txt';
		if (isset($mmos_social['social_login_debug'])) {
			$this->_config['debug_mode'] = (bool) $mmos_social['social_login_debug'];
		} else {
			$this->_config['debug_mode'] = false;
		}
		$settings = $mmos_social['social_login'];

		foreach ($settings as $provider => $config) {

			$scope = isset($config['scope']) ? $config['scope'] : '';
			if (isset($config['enabled'])) {
				$this->_config['providers'][$provider] = (bool) $config['enabled'];
			} else {
				$this->_config['providers'][$provider] = false;
			}
			$this->_config['providers'][$provider] = array('enabled' => $this->_config['providers'][$provider],
				'keys' => array('id' => $config['key'],
					'key' => $config['key'],
					'secret' => $config['secret'],
					'scope' => $scope));
		}

		// Receive request
		if (isset($this->request->get['provider'])) {
			$provider = $this->request->get['provider'];
		} else {

			// Save error to the System Log
			$this->log->write('Missing application provider.');

			// Set Message
			$this->session->data['error'] = sprintf("An error occurred, please <a href=\"%s\">notify</a> the administrator.", $this->url->link('information/contact'));

			// Redirect to the Login Page
			$this->response->redirect($this->_redirect);
		}

		try {

			// Authentication Begin
			$auth = new Hybrid_Auth($this->_config);
			$adapter = $auth->authenticate($provider); //navigate to mmos_social/mmos_social.php
			//$response=$adapter->setUserStatus( "Hi there! this is just a random update to test some stuff" );
			//var_dump($response);
			// $post_info=$adapter->getUserStatus($response['id']);
			//var_dump($post_info);
			$user_profile = $adapter->getUserProfile();

			// 1 - check if user already have authenticated using this provider before
			$customer = $this->model_mmos_social_auth->findCustomerByIdentifier($provider, $user_profile->identifier);

			if ($customer) {

				// 1.1 Login
				$this->model_mmos_social_auth->login($customer['customer_id']);
				$this->customer->login($customer['email'], '', true);
				$this->session->data['mmos_social_notify_message'] = sprintf($this->language->get('mmos_text_logined_by_social'), $provider);
				// 1.2 Redirect to Refer Page
				$this->response->redirect($this->_redirect);
			}

			// 2 - else, here lets check if the user email we got from the provider already exists in our database ( for this example the email is UNIQUE for each user )
			// if authentication does not exist, but the email address returned  by the provider does exist in database,
			// then we tell the user that the email  is already in use
			// but, its up to you if you want to associate the authentication with the user having the address email in the database
			if ($user_profile->email) {
				$customer_id = $this->model_mmos_social_auth->findCustomerByEmail($user_profile->email);

				if ($customer_id) {
					// 1.1 Login
					//$this->model_mmos_social_auth->login($customer_id);
					$this->customer->login($user_profile->email, '', true);
					$this->session->data['mmos_social_notify_message'] = sprintf($this->language->get('mmos_text_logined_by_social'), $provider);

					// 1.2 Redirect to Refer Page
					$this->response->redirect($this->_redirect);

					//never run
					$this->session->data['mmos_social_notify_message'] = sprintf($this->language->get('mmos_text_provider_email_already_exists'), $provider, $user_profile->email);
					$this->response->redirect($this->url->link('account/login'));
				}
			}

			// 3 - if authentication does not exist and email is not in use, then we create a new user
			$user_address = array();

			if (!empty($user_profile->address)) {
				$user_address[] = $user_profile->address;
			}

			if (!empty($user_profile->region)) {
				$user_address[] = $user_profile->region;
			}

			if (!empty($user_profile->country)) {
				$user_address[] = $user_profile->country;
			}

			$zone_id = (int) $this->model_mmos_social_auth->findZone($user_profile->region);
			$country_id = (int) $this->model_mmos_social_auth->findCountry($user_profile->country);
			if ($zone_id) {
				//get coutry, show zone and country fields
				//re-asign country id
				$country_id = $this->model_mmos_social_auth->getCountryByZone($zone_id);
				if (!$country_id) {
					$zone_id = false;
				}
			} else if ($country_id) {
				$zone_id = false;
			}

			$this->load->model('account/customer');

			# Update Start By: Ismail Ashour
			// $customer_group_id = isset($settings[$provider]['group']) ? $settings[$provider]['group'] : $this->config->get('config_customer_group_id');
			# Update End
			// 3.1 - create new customer

			$customer_data = array('mmos_social_login' => true,
				'email' => $user_profile->email,
				'firstname' => $user_profile->firstName,
				# Update Start By: Ismail Ashour
				'customer_group_id' => 1,
				# Update End
				'lastname' => $user_profile->lastName,
				'telephone' => $user_profile->phone,
				'fax' => false,
				'newsletter' => true,
				'company' => false,
				'address_1' => ($user_address ? implode(', ', $user_address) : false),
				'address_2' => false,
				'city' => $user_profile->city,
				'postcode' => $user_profile->zip,
				'country_id' => $country_id,
				'zone_id' => $zone_id,
				'password' => substr(rand() . microtime(), 0, 6));

			$customer_auth_data = array(
				'provider' => $provider,
				'identifier' => $user_profile->identifier,
				'web_site_url' => $user_profile->webSiteURL,
				'profile_url' => $user_profile->profileURL,
				'photo_url' => $user_profile->photoURL,
				'display_name' => $user_profile->displayName,
				'description' => $user_profile->description,
				'first_name' => $user_profile->firstName,
				'last_name' => $user_profile->lastName,
				'gender' => $user_profile->gender,
				'language' => $user_profile->language,
				'age' => $user_profile->age,
				'birth_day' => $user_profile->birthDay,
				'birth_month' => $user_profile->birthMonth,
				'birth_year' => $user_profile->birthYear,
				'email' => $user_profile->email,
				'email_verified' => $user_profile->emailVerified,
				'phone' => $user_profile->phone,
				'address' => $user_profile->address,
				'country' => $user_profile->country,
				'region' => $user_profile->region,
				'city' => $user_profile->city,
				'zip' => $user_profile->zip);

			$this->session->data['mmos_social_customer_auth'] = $customer_auth_data;

			$redirect_required_fields = false;
			if (!$user_profile->email) {
				$redirect_required_fields = true;
			}
			//check others required fields are supplied
			if (!$redirect_required_fields) {
				//$required_fields = !empty($settings[$provider]['required_fields']) ? $settings[$provider]['required_fields'] : array();
				$required_fields = !empty($mmos_social['social_required_fields']) ? $mmos_social['social_required_fields'] : array();
				foreach ($required_fields as $required_field) {
					if (empty($customer_data[$required_field])) {
						$redirect_required_fields = true;
						break;
					}
				}
			}
			if ($redirect_required_fields) {
				$this->session->data['mmos_social_customer'] = $customer_data;
				//do redirect to the page that customer will enter required fields
				//$this->session->data['mmos_social_redirect'] = $this->_redirect;
				if (!isset($mmos_social['show_popup_required_fields'])) {
					$this->response->redirect($this->url->link('mmos_social/mmos_social/enter_required_fields', '', 'SSL'));
				} else if (isset($this->session->data['mmos_social_redirect'])) {
					$this->response->redirect($this->session->data['mmos_social_redirect']);
				} else {
					echo "Sorry, something error!";
				}
				exit();
			}

			//$customer_id = $this->model_mmos_social_auth->addCustomer($customer_data);
			$customer_id = $this->model_account_customer->addCustomer($customer_data);
			//set success message to customer
			$this->session->data['mmos_social_notify_message'] = $this->language->get('mmos_text_social_account_created');

			// 3.2 - create a new authentication for him
			$customer_auth_data['customer_id'] = (int) $customer_id;
			//$this->session->data['mmos_social_customer_auth'] = $customer_auth_data;

			$this->model_mmos_social_auth->addAuthentication($customer_auth_data);

			// 3.3 - login
			$this->model_mmos_social_auth->login($customer_id);

			unset($this->session->data['mmos_social_customer']);
			unset($this->session->data['mmos_social_customer_auth']);
			unset($this->session->data['mmos_social_base_redirect']);
			unset($this->session->data['mmos_social_redirect']);
			// 3.4 - redirect to Refer Page
			$this->response->redirect($this->_redirect);
		} catch (Exception $e) {

			// Error Descriptions
			switch ($e->getCode()) {
			case 0:$error = "Unspecified error.";
				break;
			case 1:$error = "Hybriauth configuration error.";
				break;
			case 2:$error = "Provider not properly configured.";
				break;
			case 3:$error = "Unknown or disabled provider.";
				break;
			case 4:$error = "Missing provider application credentials.";
				break;
			case 5:$error = "Authentication failed. The user has canceled the authentication or the provider refused the connection.";
				break;
			case 6:$error = "User profile request failed. Most likely the user is not connected to the provider and he should to authenticate again.";
				$adapter->logout();
				break;
			case 7:$error = "User not connected to the provider.";
				$adapter->logout();
				break;
			}

			$error .= "\n\nHybridAuth Error: " . $e->getMessage();
			$error .= "\n\nTrace:\n " . $e->getTraceAsString();

			$this->log->write($error);

			//set error session
			$this->session->data['mmos_social_notify_message'] = $this->language->get('mmos_text_provider_login_common_error');
			//redirect to original page
			if (!empty($this->session->data['mmos_social_base_redirect'])) {
				$this->response->redirect($this->session->data['mmos_social_base_redirect']);
			} else {
				$this->response->redirect($this->url->link('common/home', '', 'SSL'));
			}
		}
	}

	private function _prepare() {

		// Some API returns encoded URL
		if (isset($this->request->get) && isset($_GET)) {

			// Prepare for OpenCart
			foreach ($this->request->get as $key => $value) {
				$this->request->get[str_replace('amp;', '', $key)] = $value;
			}

			// Prepare for Library
			foreach ($_GET as $key => $value) {
				$_GET[str_replace('amp;', '', $key)] = $value;
			}
		}

		// Check if module is Enabled
		$mmos_social = $this->config->get('mmos_social_login');
		if (!($mmos_social && isset($mmos_social['social_login_status']))) {
			//$this->response->redirect($this->_redirect);
		} else {
			// Base64 URL Decode
			// <editor-fold defaultstate="collapsed" desc="settting base_redirect">
			if (isset($this->request->get['redirect'])) {
				if (isset($this->request->get['original_route']) && $this->request->get['original_route'] == 'account/logout') {
					$this->_base_redirect = $this->url->link('account/logout');
				} else {
					$this->_base_redirect = base64_decode($this->request->get['redirect']);
				}

			} else {
				$this->_base_redirect = $this->url->link('common/home');
			}
			// </editor-fold>

			if (isset($this->request->get['original_route']) && $this->request->get['original_route'] == 'account/logout' && !empty($mmos_social['success_redirect_page_from_logout']['value']) && $mmos_social['success_redirect_page_from_logout']['value'] == 'page' && !empty($mmos_social['success_redirect_page_from_logout']['url'])
			) {
				//set redirect page to
				$to_redirect = $mmos_social['success_redirect_page_from_logout']['url'];
				$parse_url = parse_url($to_redirect);
				if (isset($this->request->get['msd_share_product_id'])) {

					if (!empty($parse_url['query'])) {
						$redirect_url = $to_redirect . "&msd_share_product_id=" . (int) $this->request->get['msd_share_product_id'];
					} else {
						$redirect_url = $to_redirect . "?msd_share_product_id=" . (int) $this->request->get['msd_share_product_id'];
					}

					$this->_redirect = $redirect_url;
				} else {
					$this->_redirect = $to_redirect;
				}
			} else if (!empty($mmos_social['success_redirect_page']['value']) && $mmos_social['success_redirect_page']['value'] == 'page' && !empty($mmos_social['success_redirect_page']['url'])) {
				$to_redirect = $mmos_social['success_redirect_page']['url'];

				$parse_url = parse_url($to_redirect);
				if (isset($this->request->get['msd_share_product_id'])) {
					if (!empty($parse_url['query'])) {
						$redirect_url = $to_redirect . "&msd_share_product_id=" . (int) $this->request->get['msd_share_product_id'];
					} else {
						$redirect_url = $to_redirect . "?msd_share_product_id=" . (int) $this->request->get['msd_share_product_id'];
					}

					$this->_redirect = $redirect_url;
				} else {
					$this->_redirect = $to_redirect;
				}
			} else {
				if (isset($this->request->get['redirect'])) {
					$tmp_redirect_url = base64_decode($this->request->get['redirect']);
					$parse_url = parse_url($tmp_redirect_url);
					$this->_redirect = $tmp_redirect_url; //initiate
					//for social discount callback
					if (isset($this->request->get['msd_share_product_id'])) {

						if (!empty($parse_url['query'])) {
							$redirect_url = $tmp_redirect_url . "&msd_share_product_id=" . (int) $this->request->get['msd_share_product_id'];
						} else {
							$redirect_url = $tmp_redirect_url . "?msd_share_product_id=" . (int) $this->request->get['msd_share_product_id'];
						}
						$this->_redirect = $redirect_url;
					} else {
						$this->_redirect = $tmp_redirect_url;
					}

					// $this->_redirect = base64_decode($this->request->get['redirect']);
				} else {
					//for social discount callback
					if (isset($this->request->get['msd_share_product_id'])) {
						$this->_redirect = $this->url->link('common/home', 'msd_share_product_id=' . (int) $this->request->get['msd_share_product_id']);
					} else {
						$this->_redirect = $this->url->link('account/account');
					}
				}
			}

			$this->session->data['mmos_social_base_redirect'] = str_replace('&amp;', '&', $this->_base_redirect);
			$this->session->data['mmos_social_redirect'] = str_replace('&amp;', '&', $this->_redirect);
		}
	}

}
