<?php
class ControllerAccountNeeds extends Controller {
	private $error = array();

	public function index() {

		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/needs', '', 'SSL');
			
			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->language('account/needs');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_needs'),
			'href' => $this->url->link('account/account', '', 'SSL')
		);

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('account/needs', $url, 'SSL')
		);
		
		$data['heading_title']     = $this->language->get('heading_title');
		
		$data['text_empty']        = $this->language->get('text_empty');
		
		$data['column_date_added'] = $this->language->get('column_date_added');
		$data['column_product']    = $this->language->get('column_product');
		$data['column_status']     = $this->language->get('column_status');
		$data['column_donor']      = $this->language->get('column_donor');
		

		$data['button_new_need']   = $this->language->get('button_new_need');
		$data['button_continue']   = $this->language->get('button_continue');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['objects'] = array();

		$this->load->model('account/customer');
		$this->load->model('catalog/product');

		$customer_id   = $this->session->data['customer_id'];		
		
		$results_total = $this->model_account_customer->getTotalProductsByCustomerId($customer_id);
		
		$results       = $this->model_account_customer->getProductsByCustomerId($customer_id, ($page - 1) * 10, 10);

		foreach ($results as $result) {

			$product = $this->model_catalog_product->getProduct($result['product_id']);

			$donor = $this->model_account_customer->getDonor($result['product_id'], $result['customer_id']);

			if ($result['product_status'] == 'complete') {
				
				$data['objects'][] = array(
					'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'product_url' => $this->url->link('product/product', 'product_id=' . $product['product_id'], 'SSL'),
					'product'     => $product['name'],
					'donor_url'   => $this->url->link('account/profile', 'customer_id=' . $donor['customer_id'], 'SSL'),
					'donor'       => $donor['firstname'] . ' ' . $donor['lastname'],
					'status'      => $this->language->get($result['product_status'])
				);

			} else {

				$data['objects'][] = array(

					'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'product_url' => $this->url->link('product/product', 'product_id=' . $product['product_id'], 'SSL'),
					'product'     => $product['name'],
					'donor'       => '',
					'status'      => $this->language->get($result['product_status'])
				);
			}


		}

		$pagination             = new Pagination();
		$pagination->total      = $results_total;
		$pagination->page       = $page;
		$pagination->limit      = 10;
		$pagination->url        = $this->url->link('account/needs', 'page={page}', 'SSL');
		
		$data['pagination']     = $pagination->render();
		
		$data['results']        = sprintf($this->language->get('text_pagination'), ($results_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($results_total - 10)) ? $results_total : ((($page - 1) * 10) + 10), $results_total, ceil($results_total / 10));
		
		$data['continue']       = $this->url->link('account/account', '', 'SSL');
		$data['new']            = $this->url->link('account/needs/new_need', '', 'SSL');
		
		$data['column_left']    = $this->load->controller('common/column_left');
		$data['column_right']   = $this->load->controller('common/column_right');
		$data['content_top']    = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer']         = $this->load->controller('common/footer');
		$data['header']         = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/need_list.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/need_list.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/need_list.tpl', $data));
		}
	}

	public function new_need() {

		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/needs', '', 'SSL');
			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->language('account/needs');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/customer');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_account_customer->addNeeds($this->request->post, $this->session->data['customer_id']);

			$this->session->data['success'] = $this->language->get('text_success');

			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			$this->model_account_activity->addActivity('addNeed', $activity_data);

			$this->response->redirect($this->url->link('account/needs', '', 'SSL'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_needs'),
			'href'      => $this->url->link('account/needs', '', 'SSL')
		);
		
		$data['heading_title']          = $this->language->get('heading_title');
		
		$data['text_choose_your_needs'] = $this->language->get('text_choose_your_needs');
		$data['text_additional']        = $this->language->get('text_additional');
		$data['text_select']            = $this->language->get('text_select');
		$data['text_loading']           = $this->language->get('text_loading');
		
		$data['entry_products']         = $this->language->get('entry_products');
		
		$data['button_submit']          = $this->language->get('button_submit');
		$data['button_back']            = $this->language->get('button_back');
		$data['button_upload']          = $this->language->get('button_upload');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['error_needs'])) {
			$data['error_needs'] = $this->error['error_needs'];
		} else {
			$data['error_needs'] = '';
		}

		$data['action'] = $this->url->link('account/needs/new_need', '', 'SSL');

		$this->load->model('catalog/product');

		$products = $this->model_catalog_product->getAllProducts();

		if (isset($this->request->post['products'])) {
			$data['products'] = $this->request->post['products'];
		} elseif (!empty($products)) {
			$data['products'] = $products;
		} else {
			$data['products'] = array();
		}

		$data['back']           = $this->url->link('account/needs', '', 'SSL');

		$data['column_left']    = $this->load->controller('common/column_left');
		$data['column_right']   = $this->load->controller('common/column_right');
		$data['content_top']    = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer']         = $this->load->controller('common/footer');
		$data['header']         = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/need_form.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/need_form.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/need_form.tpl', $data));
		}
	}


	protected function validate() {

		if (!array_key_exists('needs', $this->request->post)) {
			$this->error['error_needs'] = $this->language->get('error_no_needs_selected');
		}
		
		return !$this->error;
	}
}