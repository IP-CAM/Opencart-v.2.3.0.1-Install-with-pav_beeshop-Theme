<?php 
	
	class HelperForm extends Model{
		
		public $module;
		public $name_controller;
		public $identifier ;
		public $token ; 
		public $tpl_vars;

		public $langid = 1;

		public function generateForm( $fields, $data=array() ){

			

				$output =  '<form action="" method="post">';
				foreach( $fields as $field ){  
					$output .= '<fieldset>';
				//  echo '<pre>'.print_r( $field ,1 );die; 
					$output .= '<legend>'.$field['form']['legend']['title'].'</legend>';
					$output .='<div class="forms-content">';
				 	$output .= $this->_renderFormByFields(  $field['form']['input'], $data );
					$output .='</div>'; 
					$output .='</fieldset>';
				}
				

		
				$output .= '</form>';
			return $output;
		}	

		/**
	 * render widget setting form with passed  fields. And auto fill data values in inputs.
	 */
	protected function _renderFormByFields( $fields, $data ){
		
	
		$data = $this->tpl_vars['fields_value'];


		//	d( $data ); 	



		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();

		// d( $data );
		$output = '<table class="form">';

		$default_value= '';
		foreach( $fields as $widget => $field ){

			
			$input = '';
 			$val = isset($data[$field['name']])?$data[$field['name']]:"";
 			$default_value= $val;
			$attrs = isset($fields['attrs'])?$fields['attrs']:""; 

			$attrs .= isset( $field['class'] )? ' class="'.$field['class'].' form-control"' :'class="form-control"';
			$attrs .= isset( $field['id'] )? ' id="'.$field['id'].'"' :"";


			$widget = 'html';

			if( $field['type'] == 'hidden' ){
				$output .= '<tr><td colspan="2"><input  '.$attrs.' type="hidden" name="'.$field['name'].'" value="'.$val.'"></td</tr>';
				continue;
			}
		 

 			$output .= '<tr>';
 			$output .=  '<td>'.$field['label'].'</td>';

 			switch( $field['type']  ){
 				case 'switch':
 					$input .= '<select  '.$attrs.' name="'.$field['name'].'">';
 					 	
					foreach( $field['values'] as $val ){
						if($default_value == $val['value']){
							$input .= '<option value="'.$val['value'].'" selected="selected">'.$val['label'].'</option>';
						}else{
							$input .= '<option value="'.$val['value'].'">'.$val['label'].'</option>';
						}
					}
 					$input .= '</select>';

 					break;	
 				case 'text':  
 					if( is_array($val) ){
 						$val = implode( ",", $val );
 					}
 					if( isset($field['lang']) ){
 				
						 
						 foreach( $languages as $language ){
						 	$input .= '<div class="input-language'.$language['language_id'].' switch-langs clearfix">';
						 	$input .= '<p><label>'.$language['name'].' : </label></p>';
						 	
						 	$fname = $field['name'].'_'.$language['language_id'];
						  	$val = isset($data[$fname])?$data[$fname]:"";

						 	$input .= '<input style="width:400px;" '.$attrs.' type="text" value="'.$val.'" name="'.$fname.'">';
						 	$input .= '</div>';
						 }

 					}else { 					
 						$input .= '<input '.$attrs.' type="text" name="'.$field['name'].'" value="'.$val.'">';
 					}	

 					break;
 				case 'file':
 						$this->load->model('tool/image');
 						if ($val && file_exists(DIR_IMAGE . $val)) {
							$image = $val;
						} else {
							$image = 'no_image.jpg';
						}
 						$thumb = $this->model_tool_image->resize($image, 100, 100);
 						$placeholder = $this->model_tool_image->resize('no_image.png', 50, 50);

                        $input .= '
			                <div class="image"><a href="" id="thumb-image-'.$field['name'].'" data-toggle="image" class="img-thumbnail">
			                  <img src="'.$thumb.'" alt="" title="" data-placeholder="'.$placeholder.'" /></a>
			                  <input type="hidden" name="'.$field['name'].'" value="'.$val.'" id="input-image'.$field['name'].'" />
			                </div>';

 				break;
 				case 'select':

 				 	 // echo '<pre>'.print_r( $field , 1);die; 
 					$input .= '<select  '.$attrs.' name="'.$field['name'].'">';
 					 
 					$default_value =  isset($data[$field['name']]) ? $data[$field['name']] : "";
 
 						foreach( $field['options']['query'] as $val ){
 							if($default_value == $val[$field['options']['id']] ){
 								$input .= '<option value="'.$val[$field['options']['id']].'" selected="selected">'.$val[$field['options']['name']].'</option>';
 							}else{
 								$input .= '<option value="'.$val[$field['options']['id']].'">'.$val[$field['options']['name']].'</option>';
 							}
 							 
 						}
 					$input .= '</select>';
 					
 					break;
 				case 'textarea':
 					

 					if( isset($field['lang']) ){
						 
						 foreach( $languages as $language ){
						 	$input .= '<div class="input-language'.$language['language_id'].' switch-langs clearfix">';
						 	$input .= '<p><label>'.$language['name'].' : </label></p>';
						  	
						 	$fname = $field['name'].'_'.$language['language_id'];
						  	$val = isset($data[$fname])?$data[$fname]:"";

						 	$input .= '<textarea class="input-langs form-control" '.$attrs.' type="text" id="content'.$fname.'"  name="'.$fname.'">'.$val.'</textarea>';
						 	$input .= '</div>';
						 }

						 if( $field['autoload_rte'] ) {
							 $input .= '<script type="text/javascript">';

							  foreach( $languages as $language ){
							 	$input .= "
							 		//	$('#content".$field['name'].'_'.$language['language_id']."').destroy();
									//	$('#content".$field['name'].'_'.$language['language_id']."').summernote({'height':300});
							 	";
							 }
							 $input .= '</script>';
						}	 
 					}else {
 					  
 						$input .= '<textarea  '.$attrs.' style="height:80px" name="'.$field['name'].'">'.$val.'</textarea>';
 					}	
 					break;	
 			}
 			$btn = '';

 		// 	echo '<pre>'.print_r( $languages,1 );die;
 			if( isset($field['lang']) ){
 				$btn = ' <div class="btn-group group-langs">
						  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						    '.$this->language->get('Switch Language').' <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">';

				foreach( $languages as $language ){		  
					$btn .=	   '<li data-lang="input-language'.$language['language_id'].'"><div >'. $language['name'].'</div></li>';
				}	
				$btn .=		'</ul>
						</div> ';
 			}
 			$output .= '<td><div class="input-wrap">'.$input.$btn.(isset($field['desc']) && $field['desc']? '<div class="input-desc">'.$field['desc'].'</div>':"").'</div></td>';
			$output .= '</tr>';
 		}	
 		
 		$output .= '</table>';


 		$output .= '<script type="text/javascript">
 				reloadLanguage( "input-language'.$this->config->get('config_language_id').'" );
 		';
 		$output .='</script>';

 		return $output;
	}
	}
?>