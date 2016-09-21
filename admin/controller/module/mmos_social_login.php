<?php

class ControllerModuleMmosSocialLogin extends Controller {

    private $error = array();

    public function index() {

        if (!isset($this->request->get['store_id'])) {
            $this->response->redirect($this->url->link('module/mmos_social_login', 'token=' . $this->session->data['token'] . '&store_id=0', 'SSL'));
        }

        // Load Dependencies
        $this->load->language('module/mmos_social_login');
        $this->load->model('setting/setting');
        // Save Incoming Data
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {


            // Prepare Sort Order
            if (isset($this->request->post['social_login'])) {
                $sort_order = array();
                $new_setting = array();
                foreach ($this->request->post['social_login'] as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
                }
                array_multisort($sort_order, SORT_ASC, $this->request->post['social_login']);
            }

            // Edit Settings
            $this->model_setting_setting->editSetting('mmos_social_login', array('mmos_social_login' => $this->request->post));

            $this->session->data['success'] = $this->language->get('text_success');
            if (!isset($this->request->get['stay'])) {
                $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
            } else {
                $this->response->redirect($this->url->link('module/mmos_social_login', 'token=' . $this->session->data['token'], 'SSL'));
            }
        }

        if ($this->request->server['HTTPS']) {
            $this->document->addStyle(HTTPS_CATALOG . 'catalog/view/javascript/mmosolution/bootstrap-social/bootstrap-social.css');
        } else {
            $this->document->addStyle(HTTP_CATALOG . 'catalog/view/javascript/mmosolution/bootstrap-social/bootstrap-social.css');
        }

        $this->document->addStyle('view/javascript/mmosolution/bootstrap-switch-3.3.2/bootstrap-switch.css');
        $this->document->addScript('view/javascript/mmosolution/bootstrap-switch-3.3.2/bootstrap-switch.js');

        $data['MMOS_version'] = '3.3';
        $data['MMOS_code_id'] = 'MMOSOC177';
        $data['tab_setting'] = $this->language->get('tab_setting');
        $data['tab_social_setting'] = $this->language->get('tab_social_setting');
        $data['tab_support'] = $this->language->get('tab_support');

        // Language Init
        $data['heading_title'] = $this->language->get('heading_title1');

        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_copyright'] = sprintf($this->language->get('text_copyright'), date('Y'));

        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_debug'] = $this->language->get('entry_debug');
        $data['entry_required'] = $this->language->get('entry_required');
        $data['entry_email'] = $this->language->get('entry_email');
        $data['entry_login_success'] = $this->language->get('entry_login_success');
        $data['entry_login_success_from'] = $this->language->get('entry_login_success_from');
        $data['entry_specified_page'] = $this->language->get('entry_specified_page');
        $data['entry_original'] = $this->language->get('entry_original');

        $data['entry_provider'] = $this->language->get('entry_provider');
        $data['entry_key'] = $this->language->get('entry_key');
        $data['entry_secret'] = $this->language->get('entry_secret');
        $data['entry_scope'] = $this->language->get('entry_scope');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_add_row'] = $this->language->get('button_add_row');
        $data['button_remove'] = $this->language->get('button_remove');
        $data['text_module_edit'] = $this->language->get('text_module_edit');
        $data['custom_text'] = $this->language->get('custom_text');
        $data['text_login_with'] = $this->language->get('text_login_with');
        $data['text_advanced_css'] = $this->language->get('text_advanced_css');
        $data['text_put_code'] = $this->language->get('text_put_code');

        $data['page_Show'] = $this->language->get('page_Show');
        $data['page_popup_login'] = $this->language->get('page_popup_login');
        $data['page_register'] = $this->language->get('page_register');
        $data['page_login'] = $this->language->get('page_login');
        $data['page_checkout'] = $this->language->get('page_checkout');
        $data['entry_store'] = $this->language->get('entry_store');
        $data['entry_group'] = $this->language->get('entry_group');

        $data['page_popup_login_width'] = $this->language->get('page_popup_login_width');
        $data['text_popup_add_required_fields'] = $this->language->get('text_popup_add_required_fields');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_save_stay'] = $this->language->get('button_save_stay');
        $data['text_preview'] = $this->language->get('text_preview');

        $data['how_to_set_up'] = $this->language->get('how_to_set_up');

        $this->load->language('sale/customer');
        $data['entry_firstname'] = $this->language->get('entry_firstname');
        $data['entry_lastname'] = $this->language->get('entry_lastname');
        $data['entry_email'] = $this->language->get('entry_email');
        $data['entry_telephone'] = $this->language->get('entry_telephone');
        $data['entry_address_1'] = $this->language->get('entry_address_1');
        $data['entry_city'] = $this->language->get('entry_city');
        $data['entry_postcode'] = $this->language->get('entry_postcode');
        $data['entry_country'] = $this->language->get('entry_country');
        $data['entry_zone'] = $this->language->get('entry_zone');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        // Generate Breadcrumbs
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title1'),
            'href' => $this->url->link('module/mmos_social_login', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );


        $data['action'] = $this->url->link('module/mmos_social_login', 'token=' . $this->session->data['token'] . '&store_id=' . (int) $this->request->get['store_id'], 'SSL');
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $data['token'] = $this->session->data['token'];

        // Load Providers
        $data['providers'] = array();



        $social_login_items = array();
        if (isset($this->request->post['mmos_social_login'])) {
            $social_login = $this->request->post['mmos_social_login'];
        } elseif ($this->config->get('mmos_social_login')) {
            $social_login = $this->config->get('mmos_social_login');
        }



        if (is_dir(DIR_SYSTEM . '/library/Hybrid/Providers')) {
            $providers = scandir(DIR_SYSTEM . '/library/Hybrid/Providers');

            if (count($providers)) {


                foreach ($providers as $provider) {
                    if ($provider != '.' && $provider != '..') {
                        $provider = str_replace('.php', '', $provider);
                        $data['providers'][$provider]['languages'] = $this->getLanguage($provider);
                        $data['providers'][$provider]['settings'] = isset($social_login['social_login'][$provider]) ? $social_login['social_login'][$provider] : array();
                        // $data['providers'][$i] = str_replace('.php', '', $provider);
                    }
                }
            }
        }
        $data['redirect_short_link'] = array('Yahoo', 'Facebook', 'Foursquare', 'LinkedIn', 'Twitter');


        if (isset($this->request->post['config_secure']) && $this->request->post['config_secure'] == '1') {
            $data['shop_link_social'] = HTTPS_CATALOG;
        } else {
            $data['shop_link_social'] = HTTP_CATALOG;
        }


        $this->load->model('localisation/language');
        $data['languages'] = $this->model_localisation_language->getLanguages();

        if (isset($this->request->post['social_login_debug'])) {
            $data['social_login_debug'] = $this->request->post['social_login_debug'];
        } elseif (isset($social_login['social_login_debug'])) {
            $data['social_login_debug'] = $social_login['social_login_debug'];
        } else {
            $data['social_login_debug'] = 0;
        }
        if (isset($this->request->post['social_login_Advanced_css'])) {
            $data['social_login_Advanced_css'] = $this->request->post['social_login_Advanced_css'];
        } elseif (isset($social_login['social_login_Advanced_css'])) {
            $data['social_login_Advanced_css'] = $social_login['social_login_Advanced_css'];
        } else {
            $data['social_login_Advanced_css'] = '';
        }

        if (isset($this->request->post['social_login_status'])) {
            $data['social_login_status'] = $this->request->post['social_login_status'];
        } elseif (isset($social_login['social_login_status'])) {
            $data['social_login_status'] = $social_login['social_login_status'];
        } else {
            $data['social_login_status'] = 0;
        }
        if (isset($this->request->post['social_login_show'])) {
            $data['social_login_show'] = $this->request->post['social_login_show'];
        } elseif (isset($social_login['social_login_show'])) {
            $data['social_login_show'] = $social_login['social_login_show'];
        } else {
            $data['social_login_show'] = array();
        }
        if (isset($this->request->post['social_login_popup_width'])) {
            $data['social_login_popup_width'] = $this->request->post['social_login_popup_width'];
        } elseif (isset($social_login['social_login_popup_width'])) {
            $data['social_login_popup_width'] = $social_login['social_login_popup_width'];
        } else {
            $data['social_login_popup_width'] = '300';
        }
        if (isset($this->request->post['social_required_fields'])) {
            $data['social_required_fields'] = $this->request->post['social_required_fields'];
        } elseif (isset($social_login['social_required_fields'])) {
            $data['social_required_fields'] = $social_login['social_required_fields'];
        } else {
            $data['social_required_fields'] = array();
        }
        if (isset($this->request->post['show_popup_required_fields'])) {
            $data['show_popup_required_fields'] = $this->request->post['show_popup_required_fields'];
        } elseif (isset($social_login['show_popup_required_fields'])) {
            $data['show_popup_required_fields'] = $social_login['show_popup_required_fields'];
        } else {
            $data['show_popup_required_fields'] = 0;
        }

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if (isset($this->request->post['success_redirect_page'])) {
                $data['success_redirect_page'] = $this->request->post['success_redirect_page'];
            } else {
                $data['success_redirect_page'] = array();
            }
        } elseif (isset($social_login['success_redirect_page'])) {
            $data['success_redirect_page'] = $social_login['success_redirect_page'];
        } else {
            $data['success_redirect_page'] = array();
        }

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if (isset($this->request->post['success_redirect_page_from_logout'])) {
                $data['success_redirect_page_from_logout'] = $this->request->post['success_redirect_page_from_logout'];
            } else {
                $data['success_redirect_page_from_logout'] = array();
            }
        } elseif (isset($social_login['success_redirect_page_from_logout'])) {
            $data['success_redirect_page_from_logout'] = $social_login['success_redirect_page_from_logout'];
        } else {
            $data['success_redirect_page_from_logout'] = array();
        }


        $this->load->model('setting/store');

        $data['stores'] = array();

        $data['stores'][] = array(
            'store_id' => 0,
            'name' => $this->config->get('config_name') . ' (' . $this->language->get('text_default') . ')'
        );

        $stores = $this->model_setting_store->getStores();



        foreach ($stores as $store) {
            $data['stores'][$store['store_id']] = array(
                'store_id' => $store['store_id'],
                'name' => $store['name']
            );
        }

        if (isset($this->request->get['store_id'])) {
            $data['store_id'] = $this->request->get['store_id'];
        } else {
            $data['store_id'] = 0;
        }

        $data['required_fieldlist'] = array(//Personal Details
            //'email',//always required
            'firstname',
            'lastname',
            'telephone',
            //Address
            'address_1',
            'city',
            'postcode',
            'country_id',
            'zone_id');

        $this->load->model('sale/customer_group');

        $data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();


        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/mmos_social_login.tpl', $data));
    }

    private function getLanguage($provider) {

        $language = array();

        $language['text_key'] = $this->language->get('text_key_' . $provider);
        $language['text_secret'] = $this->language->get('text_secret_' . $provider);
        $language['text_redirect'] = $this->language->get('text_secret_redirect_' . $provider);

        return $language;
    }

    private function validate() {

        // Check Permissions
        if (!$this->user->hasPermission('modify', 'module/mmos_social_login')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }


        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    public function uninstall() {
        if ($this->user->hasPermission('modify', 'extension/module')) {
            $this->load->model('setting/setting');
		
			/* unregister event */
            $this->load->model('extension/event');
            $this->model_extension_event->deleteEvent('mmos_social_login_logout');
			
			
            $this->model_setting_setting->deleteSetting('mmos_social_login');
            $this->vqmod_protect();
        }
    }

    public function install() {

        if ($this->user->hasPermission('modify', 'extension/module')) {

            $this->load->model('module/mmos_social_login');
            $this->model_module_mmos_social_login->create_customer_authentication_table();
			/* register event */
            $this->load->model('extension/event');
            $this->model_extension_event->addEvent('mmos_social_login_logout', 'pre.customer.logout', 'mmos_social/mmos_social/onUserLogout');

            $this->vqmod_protect(1);
            $this->response->redirect($this->url->link('module/mmos_social_login', 'token=' . $this->session->data['token'], 'SSL'));
        }
    }

    protected function vqmod_protect($action = 0) {
        // action 1 =  install; 0: uninstall
        $vqmod_file = 'MMOSolution_social_login_ultimate.xml';
        if ($this->user->hasPermission('modify', 'extension/module')) {
            $MMOS_ROOT_DIR = substr(DIR_APPLICATION, 0, strrpos(DIR_APPLICATION, '/', -2)) . '/vqmod/xml/';
            if ($action == 1) {
                if (is_file($MMOS_ROOT_DIR . $vqmod_file . '_mmosolution')) {
                    @rename($MMOS_ROOT_DIR . $vqmod_file . '_mmosolution', $MMOS_ROOT_DIR . $vqmod_file);
                }
            } else {
                if (is_file($MMOS_ROOT_DIR . $vqmod_file)) {
                    @rename($MMOS_ROOT_DIR . $vqmod_file, $MMOS_ROOT_DIR . $vqmod_file . '_mmosolution');
                }
            }
        }
    }

}
