<?php 
class PtsWidgetFeatured_collection extends PtsWidgetPageBuilder {

		public $name = 'featured_collection';
		public $group = 'opencart';
		
		public static function getWidgetInfo(){
			return  array('label' => ('Featured Collection'), 'explain' => 'Alow show information about category', 'group' => 'opencart'  ) ;
		}

		public function renderForm( $args, $data ){

			$helper = $this->getFormHelper();

			$this->fields_form[1]['form'] = array(
	            'legend' => array(
	                'title' => $this->l('Featured Collection'),
	            ),
	            'input' => array(
	           		array(
	           			'lang'  => true,
	                    'type'  => 'text',
	                    'label' => $this->l('Description'),
	                    'name'  => 'description',
	                    'default'=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
	                ),
	           		// item 1
	                array(
	                	'lang'  => true,
	                    'type'  => 'text',
	                    'label' => $this->l('Title item 1'),
	                    'name'  => 'title_1',
	                    'default'=> "Lorem ipsum dolor sit amet",
	                ),
	                array(
	                	'lang'  => true,
	                    'type'  => 'text',
	                    'label' => $this->l('Heading item 1'),
	                    'name'  => 'des_1',
	                    'default'=> "Lorem ipsum dolor sit amet",
	                ),
	                 array(
	                    'type'  => 'file',
	                    'label' => $this->l('Image 1'),
	                    'name'  => 'img_1',
	                    'default'=> "",
	                ),
	                 array(
	                    'type'  => 'text',
	                    'label' => $this->l('Link item 1'),
	                    'name'  => 'link_1',
	                    'default'=> "#",
	                ),
	                // item 2
	                array(
	                	'lang'  => true,
	                    'type'  => 'text',
	                    'label' => $this->l('Title item 2'),
	                    'name'  => 'title_2',
	                    'default'=> "Lorem ipsum dolor sit amet",
	                ),
	                array(
	                	'lang'  => true,
	                    'type'  => 'text',
	                    'label' => $this->l('Heading item 2'),
	                    'name'  => 'des_2',
	                    'default'=> "Lorem ipsum dolor sit amet",
	                ),
	                 array(
	                    'type'  => 'file',
	                    'label' => $this->l('Image 2'),
	                    'name'  => 'img_2',
	                    'default'=> "",
	                ),
	                 array(
	                    'type'  => 'text',
	                    'label' => $this->l('Link item 2'),
	                    'name'  => 'link_2',
	                    'default'=> "#",
	                ),
		            // item 3
	                array(
	                	'lang'  => true,
	                    'type'  => 'text',
	                    'label' => $this->l('Title item 3'),
	                    'name'  => 'title_3',
	                    'default'=> "Lorem ipsum dolor sit amet",
	                ),
	                array(
	                	'lang'  => true,
	                    'type'  => 'text',
	                    'label' => $this->l('Heading item 3'),
	                    'name'  => 'des_3',
	                    'default'=> "Lorem ipsum dolor sit amet",
	                ),
	                array(
	                    'type'  => 'file',
	                    'label' => $this->l('Image 3'),
	                    'name'  => 'img_3',
	                    'default'=> "",
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Link item 3'),
	                    'name'  => 'link_3',
	                    'default'=> "#",
	                ),

	                 array(
	                    'type'  => 'text',
	                    'label' => $this->l('width'),
	                    'name'  => 'width',
	                    'default'=> 200,
	                ),
	                 array(
	                    'type'  => 'text',
	                    'label' => $this->l('height'),
	                    'name'  => 'height',
	                    'default'=> 200,
	                ),

	            ),
	      		 'submit' => array(
	                'title' => $this->l('Save'),
	                'class' => 'button'
           		 )
	        );

 
		 	$default_lang = (int)$this->config->get('config_language_id');
			
			$helper->tpl_vars = array(
	                'fields_value' => $this->getConfigFieldsValues( $data  ),
	                'id_language' => $default_lang
        	);  
			return  $helper->generateForm( $this->fields_form );
		}

		public function renderContent( $args, $setting ){

			$this->load->model('tool/image');
			$this->language->load('module/themecontrol');

			$languageID = $this->config->get('config_language_id');
			$setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';
		 	
		 	$setting['shopnow'] = $this->language->get("text_shopnow");

			$t  = array(
				'description' => '',
			);
			$setting = array_merge( $t, $setting );

			//echo "<pre>"; print_r($setting); die;

			$setting['description'] = isset($setting['description_'.$languageID])?$setting['description_'.$languageID]:'';

			$setting['title_1'] = isset($setting['title_1_'.$languageID])?$setting['title_1_'.$languageID]:'';
			$setting['title_2'] = isset($setting['title_2_'.$languageID])?$setting['title_2_'.$languageID]:'';
			$setting['title_3'] = isset($setting['title_3_'.$languageID])?$setting['title_3_'.$languageID]:'';

			$setting['des_1'] = isset($setting['des_1_'.$languageID])?$setting['des_1_'.$languageID]:'';
			$setting['des_2'] = isset($setting['des_2_'.$languageID])?$setting['des_2_'.$languageID]:'';
			$setting['des_3'] = isset($setting['des_3_'.$languageID])?$setting['des_3_'.$languageID]:'';

			$setting['img_1'] = $this->model_tool_image->resize($setting['img_1'], $setting['width'], $setting['height']);
			$setting['img_2'] = $this->model_tool_image->resize($setting['img_2'], $setting['width'], $setting['height']);
			$setting['img_3'] = $this->model_tool_image->resize($setting['img_3'], $setting['width'], $setting['height']);

			$output = array('type'=>'manufacture','data' => $setting );
			return $output;
		} 

	}
?>