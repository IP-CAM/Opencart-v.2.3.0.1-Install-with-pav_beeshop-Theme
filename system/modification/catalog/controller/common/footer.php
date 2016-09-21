<?php
class ControllerCommonFooter extends Controller {
	public function index() {
                
            /* MMOSolution.com add language */
              $data['logged'] = $this->customer->isLogged();
              $mmos_social = $this->config->get('mmos_social_login');                                     
                $social_login_items = array();
                if(!$this->customer->isLogged() && $mmos_social && isset($mmos_social['social_login_status']) ){
				if ($this->request->server['HTTPS']) {
							$server = $this->config->get('config_ssl');
						} else {
							$server = $this->config->get('config_url');
						}

						$data['base'] = $server;
               
                    if(isset($mmos_social['social_login']) && !empty($mmos_social['social_login'])){

                     $this->document->addStyle('catalog/view/javascript/mmosolution/bootstrap-social/bootstrap-social.css');
                
                        foreach($mmos_social['social_login'] as $provoder => $value) {
                
                            if(isset($value['enabled']) && $value['enabled'] == 1){
                                $social_login_items[$provoder]['text'] = $value['text'][$this->config->get('config_language_id')];
                                //var_dump($_SERVER['HTTPS']);
                               $to_redirect_url='http' . (empty($_SERVER['HTTPS']) ? '' : 's') . '://' . "{$_SERVER['HTTP_HOST']}{$_SERVER['REQUEST_URI']}";
                                $route=isset($this->request->get['route'])?$this->request->get['route']:'';
                               $original_route=$route;
                                if($route=='account/logout'){
                                    $route='account/account';
                                    $to_redirect_url=$this->url->link('account/account', '', 'SSL');
                                }
                                
                                if($route){
                                    $redirect_url = base64_encode($to_redirect_url);
                                    $social_login_items[$provoder]['link'] = $this->url->link('mmos_social/auth', 'provider=' . $provoder.'&redirect='.$redirect_url.'&original_route='.$original_route);
                                }else{
                                    $social_login_items[$provoder]['link'] = $this->url->link('mmos_social/auth', 'provider=' . $provoder.'&original_route='.$original_route);
                                }
                            }
                     }

                  }
                    $this->load->language('account/login');   
                    $data['heading_title'] = $this->language->get('heading_title');
                    $data['text_register'] = $this->language->get('text_register');
                    $data['text_login'] = $this->language->get('text_login');
                    $data['text_new_customer'] = $this->language->get('text_new_customer');
                    $data['text_forgotten'] = $this->language->get('text_forgotten');
                    $data['error_login'] = $this->language->get('error_login');
                    $data['entry_email'] = $this->language->get('entry_email');
                    $data['entry_password'] = $this->language->get('entry_password');                
                    $data['social_login_items']= $social_login_items;
					
                if(isset($mmos_social['social_login_show']['popup'])){
                     $data['social_login_popup']= 1;
                     $data['social_login_popup_width']= $mmos_social['social_login_popup_width'];
                    }                    
                    $data['social_login_custom_css'] = (isset($mmos_social['social_login_Advanced_css']) &&  $mmos_social['social_login_Advanced_css'] != '') ? $mmos_social['social_login_Advanced_css'] : false;
                                       
                    $data['show_social_custom_page'] = '';
                
                  if(isset($this->request->get['route']) && isset($mmos_social['social_login_show']) && is_array($mmos_social['social_login_show'])) {
                    
                     $current_layout =  explode('/', $this->request->get['route']);
                                   
                     if(isset($current_layout[1]) && is_array($current_layout) && isset($mmos_social['social_login_show'][strtolower($current_layout[1])])){
                     $data['show_social_custom_page'] =  $current_layout[1];
                    }
                 }
                $data['register'] = $this->url->link('account/register', '', 'SSL');
		        $data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
				$data['login_link'] = $this->url->link('account/login', '', 'SSL');
                
                $route=isset($this->request->get['route'])?$this->request->get['route']:'';
                if($route != 'mmos_social/mmos_social/enter_required_fields'){
                    $data['mmos_social_login_required_fields_form']=$this->load->controller('mmos_social/mmos_social/social_required_fields_form');   
                }
				}
        
		$this->load->language('common/footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', 'SSL');
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
		$data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/footer.tpl', $data);
		} else {
			return $this->load->view('default/template/common/footer.tpl', $data);
		}
	}
}