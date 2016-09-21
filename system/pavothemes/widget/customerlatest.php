<?php 

class PtsWidgetCustomerlatest extends PtsWidgetPageBuilder {

	public $name = 'customerlatest';

	public  static function getWidgetInfo(){
		return array(
			'label'   => 'Customer Latest',
			'explain' => 'Retrieve Latest Customer\'s in Registered',
			'group'   => 'blog'
		);
	}

	public static function renderButton(){
	}

	public function renderForm ( $args, $data ){
		
		$helper = $this->getFormHelper();

		$this->fields_form[1]['form'] = array(
            'legend' => array(
                'title' => $this->l('Widget Form.'),
            ),
            'input' => array(
                array(
					'type'    => 'text',
					'label'   => $this->l('Customer to display.'),
					'name'    => ('nbr'),
					//'class' => 'fixed-width-xs',
					'desc'    => $this->l('Define the number of blogs displayed in this block.'),
					'default' => '4'
				),
				array(
					'type'    => 'text',
					'label'   => $this->l('Image Blog Width'),
					'name'    => ('width'),
					//'class' => 'fixed-width-xs',
					'desc'    => $this->l('Define the width of images displayed in this block.'),
					'default' => '280'
				),
				array(
					'type'    => 'text',
					'label'   => $this->l('Image Blog Height.'),
					'name'    => ('height'),
					//'class' => 'fixed-width-xs',
					'desc'    => $this->l('Define the height of images displayed in this block.'),
					'default' => '240'
				),
				 
				array(
					'type'    => 'text',
					'label'   => $this->l('Colums In Tab.'),
					'name'    => ('cols'),
					//'class' => 'fixed-width-xs',
					'desc'    => $this->l('The maximum column items  in tab.'),
					'default' => '4'
				)
            ),
      		 'submit' => array(
                'title' => $this->l('Save'),
                'class' => 'button'
       		)
        );


	 	$default_lang = (int)$this->config->get('config_language_id');
		
		$helper->tpl_vars = array(
				'fields_value' => $this->getConfigFieldsValues( $data  ),
				'id_language'  => $default_lang
    	);

		return $helper->generateForm( $this->fields_form );
	}

	public function renderContent(  $args, $setting ){

		$t  = array(
			'name'   => '',
			'html'   => '',
			'height' => 130,
			'width'  => 170,
			'nbr'    => 6,
			'page'   => 3,
			'cols'   => 4,
			'intv'   => 8000,
			'show'   => 1,
			'tabs'   => ''
		);

		$setting = array_merge( $t, $setting );

		$this->load->model('account/customer');
		$this->load->model('tool/upload');
		$this->language->load('account/customer');

		$data = array(
			'sort'  => 'c.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => $setting['nbr'],
			'filter_featured' => '1'
		);

		$beneficiaries = $this->model_account_customer->getCustomers($data);

		$objects = array(); 

		foreach( $beneficiaries as $object){

			$custom_fields_array = unserialize($object['custom_field']);
			$personal_pic_code = $custom_fields_array[6];
			$personal_pic_array = $this->model_tool_upload->getUploadByCode($personal_pic_code);
			$personal_pic = array_key_exists('filename',$personal_pic_array )?$personal_pic_array['filename']:NULL;

			if ($personal_pic) {
				$image = $this->model_tool_image->resize($personal_pic, 200, 200);
			} else {
				$image = $this->model_tool_image->resize('person.jpg', 200, 200);
			}

			$objects[] = array(
				'thumb' => $image,
				'name'  => $object['firstname'] . ' ' . $object['lastname'],
				'href'  => $this->url->link('account/profile', '&customer_id=' . $object['customer_id'], 'SSL')
			);
		}

		$setting['customers']         = $objects; // d( $setting );

		$languageID               = $this->config->get('config_language_id');
		$setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';
		
		$output                   = array(
			'type' => 'customerlatest',
			'data' => $setting
		);

  		return $output;
	}
}