<?php

class ControllerMmosSocialmmossocial extends Controller {

    private $error = array();
    private $is_error = false;
    private $redirect = '';
    private $exit = false;
    private $mmos_social = null;
    private $mmos_social_setting = null;

    public function get_session() {
        echo json_encode($this->session->data[$this->request->get['session']]);
    }

    public function index() {
        ob_start();
        try {
            $this->load->library('Hybrid/Auth'); //required
            $this->load->library('Hybrid/Endpoint');

            //require_once('config.php');
//        require_once( DIR_SYSTEM."library/Hybrid/Auth.php" );
//        require_once( DIR_SYSTEM."library/Hybrid/Endpoint.php" ); 

            Hybrid_Endpoint::process();
        } catch (Exception $e) {
            //redirect to original page
            if (isset($this->session->data['mmos_social_base_redirect'])) {
                $this->load->language('mmos_social/auth');
                //set error session
                $this->session->data['mmos_social_notify_message'] = $this->language->get('mmos_text_provider_login_common_error');

                $this->response->redirect($this->session->data['mmos_social_base_redirect']);
            } else {
                //echo $e->getMessage();
                echo 'Sorry, something error!';
            }
        }
         ob_end_clean();
    }

    private function pre_validate() {
        $this->load->language('mmos_social/auth');
        $this->load->language('account/register');
        $this->load->model('localisation/country');
        $this->load->model('account/customer');
        $this->load->model('mmos_social/auth');
        try {
            if ($this->customer->isLogged()) {
                $this->redirect = $this->url->link('account/account', '', 'SSL');
                throw new Exception("error");
            }
            if (empty($this->session->data['mmos_social_customer']) || empty($this->session->data['mmos_social_customer_auth'])) {
                $this->redirect = $this->url->link('account/login', '', 'SSL');
                throw new Exception("error");
            }

            $this->mmos_social = $this->config->get('mmos_social_login');
            if (!($this->mmos_social && isset($this->mmos_social['social_login_status']))) {
                $this->redirect = $this->url->link('account/login', '', 'SSL');
                throw new Exception("error");
            }

            $this->mmos_social_setting = $this->mmos_social['social_login'];

            $provider = !empty($this->session->data['mmos_social_customer_auth']['provider']) ? $this->session->data['mmos_social_customer_auth']['provider'] : false;
            if (!$provider || !isset($this->mmos_social_setting[$provider])) {
                $this->redirect = $this->url->link('account/login', '', 'SSL');
                throw new Exception("error");
            }

            //check if email already existed
            if ($this->session->data['mmos_social_customer']['email']) {
                $customer_id = $this->model_mmos_social_auth->findCustomerByEmail($this->session->data['mmos_social_customer']['email']);

                if ($customer_id) {
                    //actual the warning session
                    $this->session->data['mmos_social_notify_message'] = sprintf($this->language->get('mmos_text_provider_email_already_exists'), $this->session->data['mmos_social_customer_auth']['provider'], $this->session->data['mmos_social_customer']['email']);
                    $this->error['warning'] = $this->language->get('error_exists');
                    $this->redirect = $this->url->link('account/login', '', 'SSL');
                    throw new Exception("error");
                }
            }
        } catch (Exception $e) {
            $this->unset_social_login_sessions();
            $this->is_error = TRUE;
        }
        return !$this->is_error;
    }

    protected function unset_social_login_sessions() {
        unset($this->session->data['mmos_social_customer']);
        unset($this->session->data['mmos_social_customer_auth']);
        unset($this->session->data['mmos_social_redirect']);
        unset($this->session->data['mmos_social_base_redirect']);
    }

    public function social_required_fields_form($render = TRUE) {
        $data = array();

        if ($this->pre_validate()) {

            $fields = $this->get_required_fields();

            $data['fields'] = $fields;
            $data['action'] = $this->url->link('mmos_social/mmos_social/save', '', 'SSL');

            // <editor-fold defaultstate="collapsed" desc="ERROR">

            if (isset($this->error['warning'])) {
                $data['error_warning'] = $this->error['warning'];
            } else {
                $data['error_warning'] = '';
            }

            # Update Start By: Ismail Ashour
            if (isset($this->error['customer_group'])) {
                $data['error_customer_group'] = $this->error['customer_group'];
            } else {
                $data['error_customer_group'] = '';
            }
            # Update End

            if (isset($this->error['firstname'])) {
                $data['error_firstname'] = $this->error['firstname'];
            } else {
                $data['error_firstname'] = '';
            }

            if (isset($this->error['lastname'])) {
                $data['error_lastname'] = $this->error['lastname'];
            } else {
                $data['error_lastname'] = '';
            }

            if (isset($this->error['email'])) {
                $data['error_email'] = $this->error['email'];
            } else {
                $data['error_email'] = '';
            }

            if (isset($this->error['telephone'])) {
                $data['error_telephone'] = $this->error['telephone'];
            } else {
                $data['error_telephone'] = '';
            }

            if (isset($this->error['address_1'])) {
                $data['error_address_1'] = $this->error['address_1'];
            } else {
                $data['error_address_1'] = '';
            }

            if (isset($this->error['city'])) {
                $data['error_city'] = $this->error['city'];
            } else {
                $data['error_city'] = '';
            }

            if (isset($this->error['postcode'])) {
                $data['error_postcode'] = $this->error['postcode'];
            } else {
                $data['error_postcode'] = '';
            }

            if (isset($this->error['country'])) {
                $data['error_country'] = $this->error['country'];
            } else {
                $data['error_country'] = '';
            }

            if (isset($this->error['zone'])) {
                $data['error_zone'] = $this->error['zone'];
            } else {
                $data['error_zone'] = '';
            }

            if (isset($this->error['custom_field'])) {
                $data['error_custom_field'] = $this->error['custom_field'];
            } else {
                $data['error_custom_field'] = array();
            }

            if (isset($this->error['password'])) {
                $data['error_password'] = $this->error['password'];
            } else {
                $data['error_password'] = '';
            }

            if (isset($this->error['confirm'])) {
                $data['error_confirm'] = $this->error['confirm'];
            } else {
                $data['error_confirm'] = '';
            }// </editor-fold>
            // <editor-fold defaultstate="collapsed" desc="FIELDS DATA">

            if (isset($this->request->post['firstname'])) {
                $data['firstname'] = $this->request->post['firstname'];
            } else {
                $data['firstname'] = '';
            }

            if (isset($this->request->post['lastname'])) {
                $data['lastname'] = $this->request->post['lastname'];
            } else {
                $data['lastname'] = '';
            }

            if (isset($this->request->post['email'])) {
                $data['email'] = $this->request->post['email'];
            } else {
                $data['email'] = '';
            }

            if (isset($this->request->post['telephone'])) {
                $data['telephone'] = $this->request->post['telephone'];
            } else {
                $data['telephone'] = '';
            }

            if (isset($this->request->post['fax'])) {
                $data['fax'] = $this->request->post['fax'];
            } else {
                $data['fax'] = '';
            }

            if (isset($this->request->post['company'])) {
                $data['company'] = $this->request->post['company'];
            } else {
                $data['company'] = '';
            }

            if (isset($this->request->post['address_1'])) {
                $data['address_1'] = $this->request->post['address_1'];
            } else {
                $data['address_1'] = '';
            }

            if (isset($this->request->post['address_2'])) {
                $data['address_2'] = $this->request->post['address_2'];
            } else {
                $data['address_2'] = '';
            }

            if (isset($this->request->post['postcode'])) {
                $data['postcode'] = $this->request->post['postcode'];
            } else {
                $data['postcode'] = '';
            }

            if (isset($this->request->post['city'])) {
                $data['city'] = $this->request->post['city'];
            } else {
                $data['city'] = '';
            }

            # Update Start By: Ismail Ashour
            if (isset($this->request->post['customer_group_id'])) {
                $data['customer_group_id'] = $this->request->post['customer_group_id'];
            } else if ($this->session->data['mmos_social_customer']['customer_group_id']) {
                $data['customer_group_id'] = (int) $this->session->data['mmos_social_customer']['customer_group_id'];
            } else {
                $data['customer_group_id'] = $this->config->get('config_country_id');
            }
            # Update End

            if (isset($this->request->post['country_id'])) {
                $data['country_id'] = $this->request->post['country_id'];
            } else if ($this->session->data['mmos_social_customer']['country_id']) {
                $data['country_id'] = (int) $this->session->data['mmos_social_customer']['country_id'];
            } else {
                $data['country_id'] = $this->config->get('config_country_id');
            }

            if (isset($this->request->post['zone_id'])) {
                $data['zone_id'] = $this->request->post['zone_id'];
            } else if ($this->session->data['mmos_social_customer']['zone_id']) {
                $data['zone_id'] = (int) $this->session->data['mmos_social_customer']['zone_id'];
            } else {
                $data['zone_id'] = '';
            }
            
            $user = '';
            if ($this->session->data['mmos_social_customer']['firstname']) {
                $user.=$this->session->data['mmos_social_customer']['firstname'] . ' ';
            }
            if ($this->session->data['mmos_social_customer']['lastname']) {
                $user.=$this->session->data['mmos_social_customer']['lastname'] . ' ';
            }
            if ($this->session->data['mmos_social_customer']['email']) {
                if ($user) {
                    $user.=' (' . $this->session->data['mmos_social_customer']['email'] . ')';
                }
            }
            if (!$user) {
                $user = "My Friend";
            }

            $data['heading_title'] = $this->language->get('mmos_heading_title');
            $data['text_required_customer_fields'] = sprintf($this->language->get('mmos_text_required_customer_fields'), $user);
            $data['button_dismiss_social_login'] = $this->language->get('mmos_button_dismiss_social_login');

            $data['text_select'] = $this->language->get('text_select');
            $data['text_none'] = $this->language->get('text_none');
            $data['button_continue'] = $this->language->get('button_continue');

            $data['entry_firstname'] = $this->language->get('entry_firstname');
            $data['entry_lastname'] = $this->language->get('entry_lastname');
            $data['entry_email'] = $this->language->get('entry_email');
            $data['entry_telephone'] = $this->language->get('entry_telephone');
            $data['entry_address_1'] = $this->language->get('entry_address_1');
            $data['entry_city'] = $this->language->get('entry_city');
            $data['entry_postcode'] = $this->language->get('entry_postcode');
            $data['entry_country'] = $this->language->get('entry_country');
            $data['entry_zone'] = $this->language->get('entry_zone'); // </editor-fold>

            $data['countries'] = $this->model_localisation_country->getCountries();
            
            # Update Start By: Ismail Ashour
            $data['entry_customer_group'] = $this->language->get('entry_customer_group'); 
            $this->load->model('account/customer_group');
            $data['coustomer_groups'] = $this->model_account_customer_group->getCustomerGroups();
            # Update End
        }


        $data['is_error'] = $this->is_error;
        $data['redirect'] = $this->redirect;
        if ($render) {
            $this->response->setOutput($this->load->view('default/template/mmosolution/social_login_required_fields_form.tpl', $data));
        } else {
            return $this->load->view('default/template/mmosolution/social_login_required_fields_form.tpl', $data);
        }
    }

    public function enter_required_fields() {

        $data['required_fields_form'] = $this->social_required_fields_form(FALSE);
        $data['heading_title'] = $this->language->get('mmos_heading_title');
        $this->document->setTitle($this->language->get('mmos_heading_title'));

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('default/template/mmosolution/social_login_required_fields.tpl', $data));
    }

    //ok
    private function add_customer() {
        $customer_id = $this->model_account_customer->addCustomer($this->session->data['mmos_social_customer']);

        $this->session->data['mmos_social_customer_auth']['customer_id'] = $customer_id;
        $this->model_mmos_social_auth->addAuthentication($this->session->data['mmos_social_customer_auth']);

        //return $customer_id;
        $this->model_mmos_social_auth->login($customer_id);
        $this->session->data['mmos_social_notify_message']=$this->language->get('mmos_text_social_account_created');
        $r = isset($this->session->data['mmos_social_redirect']) ? $this->session->data['mmos_social_redirect'] : '';

        $this->unset_social_login_sessions();
        if ($r) {
            $this->redirect = $r;
        } else {
            $this->redirect = $this->url->link('account/account', '', 'SSL');
        }
        return $customer_id;
    }

    //ok
    private function get_required_fields() {
        $fields = array();
        $required_fields = !empty($this->mmos_social['social_required_fields']) ? $this->mmos_social['social_required_fields'] : array();

        // check email required?
        if (empty($this->session->data['mmos_social_customer']['email'])) {
            $fields[] = 'email';
        }
        foreach ($required_fields as $required_field) {
            if ($required_field == 'zone_id' || $required_field == 'country_id') {
                continue;
            }
            if (empty($this->session->data['mmos_social_customer'][$required_field])) {
                $fields[] = $required_field;
            }
        }

        $zone_id = FALSE;
        $country_id = FALSE;

        if (!in_array('zone_id', $required_fields)) {
            $zone_id = (int) $this->session->data['mmos_social_customer']['zone_id'];
        }
        if (!in_array('country_id', $required_fields)) {
            $country_id = (int) $this->session->data['mmos_social_customer']['country_id'];
        }

        # Update Start By: Ismail Ashour
        $customer_group_id = 0;
        if (!in_array('customer_group_id', $required_fields)) {
            $customer_group_id = (int) $this->session->data['mmos_social_customer']['customer_group_id'];
        }
        $fields[] = 'customer_group_id';
        # Update End
       
        if ($zone_id) {
            $country_id = $this->model_mmos_social_auth->getCountryByZone($zone_id);
            if ($country_id) {
                $this->session->data['mmos_social_customer']['country_id'] = $country_id;
            } else {
                $this->session->data['mmos_social_customer']['zone_id'] = '';
                $zone_id = FALSE;
            }
        } else if ($country_id) {
            $this->session->data['mmos_social_customer']['zone_id'] = '';
            $zone_id = FALSE;
        }

        if (in_array('zone_id', $required_fields) && !$zone_id) {
            $fields[] = 'country_id';
            $fields[] = 'zone_id';
        } else if (in_array('country_id', $required_fields) && !$country_id) {
            $fields[] = 'country_id';
        } 


        return $fields;
    }

    //ok
    private function validate() {

        $fields = $this->get_required_fields();

        if (in_array('firstname', $fields))
            if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
                $this->error['firstname'] = $this->language->get('error_firstname');
            }

        if (in_array('lastname', $fields))
            if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
                $this->error['lastname'] = $this->language->get('error_lastname');
            }

        if (in_array('email', $fields)) {
            if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
                $this->error['email'] = $this->language->get('error_email');
            }

            if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
                $this->error['warning'] = $this->language->get('error_exists');
            }
        }

        if (in_array('telephone', $fields))
            if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
                $this->error['telephone'] = $this->language->get('error_telephone');
            }

        if (in_array('address_1', $fields))
            if ((utf8_strlen(trim($this->request->post['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['address_1'])) > 128)) {
                $this->error['address_1'] = $this->language->get('error_address_1');
            }

        if (in_array('city', $fields))
            if ((utf8_strlen(trim($this->request->post['city'])) < 2) || (utf8_strlen(trim($this->request->post['city'])) > 128)) {
                $this->error['city'] = $this->language->get('error_city');
            }

        if (in_array('country_id', $fields)) {

            $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);

            if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
                $this->error['postcode'] = $this->language->get('error_postcode');
            }

            if ($this->request->post['country_id'] == '') {
                $this->error['country'] = $this->language->get('error_country');
            }
        }


        # Update Start By: Ismail Ashour
        if (in_array('customer_group_id', $fields)) {
            if ($this->request->post['customer_group_id'] == '') {
                $this->error['customer_group'] = $this->language->get('error_customer_group');
            }
        }
        # Update End

        if (in_array('postcode', $fields) && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
            $this->error['postcode'] = $this->language->get('error_postcode');
        }

        if (in_array('zone_id', $fields))
            if (!isset($this->request->post['zone_id']) || $this->request->post['zone_id'] == '') {
                $this->error['zone'] = $this->language->get('error_zone');
            }


        return !$this->error;
    }

    public function save() {
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            ob_start();

            //return;
            if (isset($this->request->post['dismiss_complete_social_login'])) {
                $this->unset_social_login_sessions();
            } else {
                if ($this->pre_validate()) {
                    if ($this->validate()) {
                        $this->session->data['mmos_social_customer'] = array_merge($this->session->data['mmos_social_customer'], $this->request->post);
                        $this->add_customer();
                    }
                } else {
                    
                }
            }

            ob_end_clean();
            $json = array('redirect' => $this->redirect, 'error' => $this->error);
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));
        }
    }
	
	public function onUserLogout() {
        try {

           /* Check if module is Enabled */ 
            $mmos_social = $this->config->get('mmos_social_login');
            if (!($mmos_social && $mmos_social['social_login_status'])) {
                throw new Exception("Social Login not enabled");
            }
            $this->load->library('Hybrid/Auth');

            $mmos_social_config = array();
            $mmos_social_config['base_url'] = $this->url->link('mmos_social/mmos_social');
            $mmos_social_config['debug_file'] = DIR_SYSTEM . 'logs/mmos_social_login.txt'; /* required for debug_mode=true  */ 
            $mmos_social_config['debug_mode'] = isset($mmos_social['social_login_debug']) ? true : false;

            $settings = $mmos_social['social_login'];


            foreach ($settings as $provider => $config) {
				$config['enabled'] = isset($config['enabled']) ? true : false;
                $scope = isset($config['scope']) ? $config['scope'] : '';
                $mmos_social_config['providers'][$provider] = array('enabled' => (bool) $config['enabled'],
                    'keys' => array('id' => $config['key'],
                        'key' => $config['key'],
                        'secret' => $config['secret'],
                        'scope' => $scope));
            }

            $auth = new Hybrid_Auth($mmos_social_config);
            $auth->logoutAllProviders();
        } catch (Exception $e) {
            //print $e->getMessage();
        }
    }

}