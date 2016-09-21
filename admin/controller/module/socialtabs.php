<?php
/*
* Socialtabs Module
* Developed for OpenCart 2.x
* Author Gedielson Peixoto - http://www.gepeixoto.com.br
* @03/2015
* Under GPL license.
*/
class ControllerModuleSocialtabs extends Controller {
  private $error = array(); 

  public function index() {
    $this->load->language('module/socialtabs');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('socialtabs', $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
    
    $texts = array(
      'heading_title',
      'text_module',
      'text_success',
      'text_edit',
      'text_yes',
      'text_no',
      'text_enabled',
      'text_disabled',
      'text_light',
      'text_dark',
      'tab_facebook',
      'tab_twitter',
      'entry_position',
      'entry_status',
      'entry_page_url',
      'entry_height',
      'entry_show_cover',
      'entry_show_faces',
      'entry_show_posts',
      'entry_locale',
      'entry_widget_id',
      'entry_theme',
      'entry_limit',
      'entry_show_replies',
      'entry_related_users',
      'help_locale',
      'help_widget_id',
      'help_limit',
      'help_related_users',
      'button_save',
      'button_cancel'
    );
    
    foreach($texts as $text) {
      $data[$text] = $this->language->get($text);
    }
    
    if (isset($this->error['warning'])) {
      $data['error_warning'] = $this->error['warning'];
    } else {
      $data['error_warning'] = '';
    }
    
    if (isset($this->error['page_url'])) {
      $data['error_page_url'] = $this->error['page_url'];
    } else {
      $data['error_page_url'] = '';
    }
    
    if (isset($this->error['facebook_height'])) {
      $data['error_facebook_height'] = $this->error['facebook_height'];
    } else {
      $data['error_facebook_height'] = '';
    }
    
    if (isset($this->error['widget_id'])) {
      $data['error_widget_id'] = $this->error['widget_id'];
    } else {
      $data['error_widget_id'] = '';
    }
    
    if (isset($this->error['twitter_height'])) {
      $data['error_twitter_height'] = $this->error['twitter_height'];
    } else {
      $data['error_twitter_height'] = '';
    }
    
    if (isset($this->error['limit'])) {
      $data['error_limit'] = $this->error['limit'];
    } else {
      $data['error_limit'] = '';
    }
    
    $data['breadcrumbs'] = array();

    $data['breadcrumbs'][] = array(
      'text'      => $this->language->get('text_home'),
      'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
    );

    $data['breadcrumbs'][] = array(
      'text'      => $this->language->get('text_module'),
      'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
    );

    $data['breadcrumbs'][] = array(
      'text'      => $this->language->get('heading_title'),
      'href'      => $this->url->link('module/socialtabs', 'token=' . $this->session->data['token'], 'SSL')
    );
    
    $data['action'] = $this->url->link('module/socialtabs', 'token=' . $this->session->data['token'], 'SSL');
    $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
    
    $lang = $this->config->get('config_language');
    $locale = ($lang == 'pt-br') ? 'pt_BR' : 'en_US';
    
    $data['positions'] = array(
      'top_left' => $this->language->get('text_top_left'),
      'top_right' => $this->language->get('text_top_right'),
      'bottom_left' => $this->language->get('text_bottom_left'),
      'bottom_right' => $this->language->get('text_bottom_right')
    );
    
    $datas = array(
      'socialtabs_position' => 'bottom_right',
      'socialtabs_status' => 0,
      'socialtabs_page_url' => '',
      'socialtabs_facebook_height' => '225',
      'socialtabs_show_cover' => 'true',
      'socialtabs_show_faces' => 'true',
      'socialtabs_show_posts' => 'false',
      'socialtabs_locale' => $locale,
      'socialtabs_widget_id' => '',
      'socialtabs_twitter_height' => '250',
      'socialtabs_theme' => 'light',
      'socialtabs_limit' => '',
      'socialtabs_show_replies' => 'false',
      'socialtabs_related_users' => ''
    );
    
    foreach ($datas as $key => $value) {
      if (isset($this->request->post[$key])) {
        $data[$key] = $this->request->post[$key];
      } elseif ($this->config->get($key)) {
        $data[$key] = $this->config->get($key);
      } else $data[$key] = $value;
    }
    
    $data['header'] = $this->load->controller('common/header');
    $data['column_left'] = $this->load->controller('common/column_left');
    $data['footer'] = $this->load->controller('common/footer');

    $this->response->setOutput($this->load->view('module/socialtabs.tpl', $data));
  }
  
  protected function validate() {
    if (!$this->user->hasPermission('modify', 'module/socialtabs')) {
      $this->error['warning'] = $this->language->get('error_permission');
    }
    
    if (!empty($this->request->post['socialtabs_page_url'])) {      
      if ($this->request->post['socialtabs_facebook_height'] < 130) {
        $this->error['facebook_height'] = $this->language->get('error_facebook_height');
      }
    }
    
    if (!empty($this->request->post['socialtabs_widget_id'])) {      
      if ($this->request->post['socialtabs_twitter_height'] < 250 || $this->request->post['socialtabs_twitter_height'] > 2000) {
        $this->error['twitter_height'] = $this->language->get('error_twitter_height');
      }
      
      if (!empty($this->request->post['socialtabs_limit']) && ($this->request->post['socialtabs_limit'] < 1 || $this->request->post['socialtabs_limit'] > 20)) {
        $this->error['limit'] = $this->language->get('error_limit');
      }
    }
    
    if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

    return !$this->error;
  }
}