<?php

class ControllerAccountProfiles extends Controller {
	
	private $error = array();

	public function index(){
		
		$this->load->language('account/profile');

		if (isset($this->request->get['customer_group'])) {
			$customer_group = $this->request->get['customer_group'];
		} else {
			$customer_group = 'beneficiaries';
		}

		$filter = array();

		$filter['filter_customer_group'] = $customer_group;

		$this->load->model('account/profile');

		$profiles_info = $this->model_account_profile->getProfiles($filter);

		if ($profiles_info) {

			$this->document->setTitle($this->language->get('heading_title'));

			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home')
			);
			
			if ($customer_group == 'beneficiaries')
				$data['heading_title'] = $this->language->get('heading_title_benef_profiles');
			else
				$data['heading_title'] = $this->language->get('heading_title_donor_profiles'); 

			$data['breadcrumbs'][] = array(
				'text' => $data['heading_title'],
				'href' => $this->url->link('account/profiles')
			);


			$data['button_view'] = $this->language->get('button_view');
			$data['button_continue'] = $this->language->get('button_continue');

			$data['text_empty'] = $this->language->get('text_empty');
			
			$data['continue'] = $this->url->link('common/home', '', 'SSL');

			$data['customers'] = array();

			$this->load->model('tool/upload');
			$this->load->model('tool/image');

			foreach ($profiles_info as $profile_info) {

				$custom_fields_array = unserialize($profile_info['custom_field']);

				$personal_pic_code = $custom_fields_array[6];

				$personal_pic_array = $this->model_tool_upload->getUploadByCode($personal_pic_code);

				$personal_pic = array_key_exists('filename',$personal_pic_array )?$personal_pic_array['filename']:NULL;

				if ($personal_pic) {
					$image = $this->model_tool_image->resize($personal_pic, 270, 370);
				} else {
					$image = $this->model_tool_image->resize('person.jpg', 270, 370);
				}

				$data['customers'][] = array(
					'thumb' => $image,
					'name' => $profile_info['firstname'] . ' ' . $profile_info['lastname'],
					'href' => $this->url->link('account/profile', '&customer_id=' . $profile_info['customer_id'], 'SSL')
				);
			}

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/profiles.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/profiles.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/account/profiles.tpl', $data));
			}
		} else {
			$this->document->setTitle($this->language->get('text_profile'));

			$data['heading_title'] = $this->language->get('text_profile');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home')
			);

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_account'),
				'href' => $this->url->link('account/account', '', 'SSL')
			);

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('account/profile', '', 'SSL')
			);

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_profile'),
				'href' => $this->url->link('account/profile/info', 'profile_id=' . $profile_id, 'SSL')
			);

			$data['continue'] = $this->url->link('common/home', '', 'SSL');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}

}