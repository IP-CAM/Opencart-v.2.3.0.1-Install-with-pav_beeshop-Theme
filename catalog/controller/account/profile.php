<?php

class ControllerAccountProfile extends Controller {

	private $error = array();

	public function index() {

		$this->load->language('account/profile');

		if (isset($this->request->get['customer_id'])) {
			$customer_id = $this->request->get['customer_id'];
		} else {
			$customer_id = 0;
		}


		$data['customer_id'] = $customer_id;

		$this->load->model('account/profile');

		$profile_info = $this->model_account_profile->getProfile($customer_id);

		// Donor Views
		if (array_key_exists('customer_id', $this->session->data) &&
			($this->session->data['customer_id'] != $customer_id)) {

			$this->model_account_profile->addView($customer_id);
		}

		if (array_key_exists('customer_id', $this->session->data) &&
			($this->session->data['customer_id'] == $customer_id)) {
			$data['customer'] = 1;
		}

		$data['text_views'] = $this->language->get('text_views');
		$data['views'] = $this->model_account_profile->getViews($customer_id);

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home'),
		);

		if ($profile_info['group_id'] == $this->config->get('config_customer_group_donor_id')) {

			$data['text_heading'] = $this->language->get('text_heading_donor');
			$data['text_empty'] = $this->language->get('text_empty_donor');
			$href = $this->url->link('account/profiles', '&customer_group=donors', 'SSL');

			$data['user_type'] = 'donor';

		} elseif ($profile_info['group_id'] == $this->config->get('config_customer_group_benef_id')) {

			$data['text_heading'] = $this->language->get('text_heading_beneficiary');
			$data['text_empty'] = $this->language->get('text_empty_beneficiary');
			$href = $this->url->link('account/profiles', '&customer_group=beneficiaries', 'SSL');

			$data['user_type'] = 'benef';
			
		}

		// Visitor & Beneficiary Denied from add to cart.
		if (isset($_SESSION['customer_id'])){

			$benef = $this->model_account_profile->getProfile($_SESSION['customer_id']);

			if ($benef['customer_group_id'] == $this->config->get('config_customer_group_benef_id')){

				$data['add_to_cart_forbidden'] = 1;

			}
		} else {

		}
		
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_profile'),
			'href' => $href,
		);

		$user_name = $profile_info['firstname'] . ' ' . $profile_info['lastname'];

		$data['breadcrumbs'][] = array(
			'text' => $user_name,
			'href' => $this->url->link('account/profile'),
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('localisation/country');
		$country = $this->model_localisation_country->getCountry($profile_info['country_id']);

		$data['user_name'] = $user_name;
		$data['user_country'] = @$country['name'];
		$data['user_city'] = $profile_info['city'];
		$data['user_group'] = $profile_info['customer_group'];

		$this->load->model('tool/upload');
		$this->load->model('tool/image');

		$custom_fields_array = unserialize($profile_info['custom_field']);
		$personal_pic_code = $custom_fields_array[6];
		$personal_pic_array = $this->model_tool_upload->getUploadByCode($personal_pic_code);
		$personal_pic = array_key_exists('filename', $personal_pic_array) ? $personal_pic_array['filename'] : NULL;

		if ($personal_pic) {
			$data['personal_pic'] = $this->model_tool_image->resize($personal_pic, 270, 370);
		} else {
			$data['personal_pic'] = $this->model_tool_image->resize('person.jpg', 270, 370);
		}

		// Reason
		$reason = array_key_exists(7, $custom_fields_array) ? $custom_fields_array[7] : "";
		$data['reason'] = (isset($reason)) ? nl2br($reason) : "";

		$data['text_profile_details'] = $this->language->get('text_profile_details');
		$data['text_customer_group'] = $this->language->get('text_customer_group');
		$data['text_user_name'] = $this->language->get('text_user_name');
		$data['text_age'] = $this->language->get('text_age');
		$data['text_country'] = $this->language->get('text_country');
		$data['text_city'] = $this->language->get('text_city');
		$data['text_reason'] = $this->language->get('text_reason');

		$data['button_view'] = $this->language->get('button_view');
		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_cart'] = $this->language->get('button_cart');

		// $data['tab_review']  = sprintf($this->language->get('tab_review'), $product_info['reviews']);
		$data['tab_review'] = $this->language->get('tab_review');
		$data['text_write'] = $this->language->get('text_write');
		$data['text_note'] = $this->language->get('text_note');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['entry_by_email'] = $this->language->get('entry_by_email');
		$data['text_by_email'] = $this->language->get('text_by_email');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_comment'] = $this->language->get('entry_comment');

		$data['continue'] = $this->url->link('common/home', '', 'SSL');

		$data['products'] = array();

		$this->load->model('catalog/product');

		$results = $this->model_catalog_product->getProductsByCustomerId($customer_id);

		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			} else {
				$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			$data['products'][] = array(
				'product_id' => $result['product_id'],
				'customer_id' => $customer_id,
				'thumb' => $image,
				'name' => $result['name'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
				'price' => $price,
				'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
				'href' => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);
		}

		# $data['products'] = array();

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/profile.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/profile.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/profile.tpl', $data));
		}

	}

	public function review() {

		$this->load->language('account/profile');
		$this->load->model('account/profile');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['reviews'] = array();

		$review_total = $this->model_account_profile->getTotalReviewsByCustomerId($this->request->get['customer_id']);

		$results = $this->model_account_profile->getReviewsByCustomerId($this->request->get['customer_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {
			$data['reviews'][] = array(
				'author' => $result['author'],
				'text' => nl2br($result['text']),
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('account/profile/review', 'customer_id=' . $this->request->get['customer_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/review.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/review.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/review.tpl', $data));
		}
	}

	public function write() {

		$this->load->language('account/profile');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {

			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (!isset($json['error'])) {

				if (array_key_exists('text', $this->request->post)) {

					$this->load->model('account/customer');

					$customer = $this->model_account_customer->getCustomer($this->request->post['customer_id']);

					$this->load->language('mail/review');

					$subject = sprintf($this->language->get('text_subject_mail'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

					$message = sprintf($this->language->get('text_sender'), html_entity_decode($this->request->post['name'], ENT_QUOTES, 'UTF-8')) . "\n";
					$message .= $this->language->get('text_message') . "\n";
					$message .= html_entity_decode($this->request->post['text'], ENT_QUOTES, 'UTF-8') . "\n\n";

					$mail = new Mail();
					$mail->protocol = $this->config->get('config_mail_protocol');
					$mail->parameter = $this->config->get('config_mail_parameter');
					$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
					$mail->smtp_username = $this->config->get('config_mail_smtp_username');
					$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
					$mail->smtp_port = $this->config->get('config_mail_smtp_port');
					$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

					$mail->setTo($customer['email']);
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
					$mail->setSubject($subject);
					$mail->setText($message);
					$mail->send();
					$json['success'] = $this->language->get('text_success_mail');
				} else {
					$this->load->model('account/profile');
					$this->model_account_profile->addReview($this->request->get['customer_id'], $this->request->post);
					$json['success'] = $this->language->get('text_success');
				}
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

}