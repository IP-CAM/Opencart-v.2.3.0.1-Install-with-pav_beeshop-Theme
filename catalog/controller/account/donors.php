<?php
class ControllerAccountDonors extends Controller {
	public function index() {

		$this->load->language('account/donors');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home'),
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_donors'),
			'href' => $this->url->link('account/donors', '', 'SSL'),
		);

		$data['heading_title'] = $this->language->get('heading_title');
		$data['button_continue'] = $this->language->get('button_continue');

		$data['text_empty'] = $this->language->get('text_empty');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/account.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/donors.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/donors.tpl', $data));
		}

	}
}