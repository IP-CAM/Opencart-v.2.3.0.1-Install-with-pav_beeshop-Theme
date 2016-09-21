<?php
/*
* Social Tabs Module
* Developed for OpenCart 2.x
* Author Gedielson Peixoto - http://www.gepeixoto.com.br
* @03/2015
* Under GPL license.
*/
class ControllerModuleSocialtabs extends Controller {
  public function index() {
    $tab_facebook = false;
    $tab_twitter = false;
    
    $this->document->addStyle('catalog/view/theme/default/stylesheet/socialtabs.css');
    
    $data['position'] = $this->config->get('socialtabs_position');
    
    if ($this->config->get('socialtabs_page_url')) {
      $tab_facebook = true;
      $data['page_url'] = $this->config->get('socialtabs_page_url');
      $data['facebook_height'] = $this->config->get('socialtabs_facebook_height');
      $data['show_cover'] = ($this->config->get('socialtabs_show_cover') == 'true') ? 'false' : 'true';
      $data['show_faces'] = $this->config->get('socialtabs_show_faces');
      $data['show_posts'] = $this->config->get('socialtabs_show_posts');
      $data['locale'] = ($this->config->get('socialtabs_locale')) ? $this->config->get('socialtabs_locale') : 'pt_BR';
    }
    
    if ($this->config->get('socialtabs_widget_id')) {
      $tab_twitter = true;
      $data['widget_id'] = $this->config->get('socialtabs_widget_id');
      $data['twitter_height'] = $this->config->get('socialtabs_twitter_height');
      $data['theme'] = $this->config->get('socialtabs_theme');
      $data['show_replies'] = $this->config->get('socialtabs_show_replies');
      $data['limit'] = ($this->config->get('socialtabs_limit')) ? $this->config->get('socialtabs_limit') : false;
      $data['related_users'] = ($this->config->get('socialtabs_related_users')) ? $this->config->get('socialtabs_related_users') : false;
    }
    
    $data['tab_facebook'] = $tab_facebook;
    $data['tab_twitter'] = $tab_twitter;
    
    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/socialtabs.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/socialtabs.tpl', $data);
		} else {
			return $this->load->view('default/template/module/socialtabs.tpl', $data);
		}
  }
}