<?php
$browser = get__browser();
if(is_dir(APP_PATH.'index/'.$conf['view_url'].$conf['index_theme_name'].DS.$browser['name'].'/')){
$browser_name = $browser['device'];
}else{
$browser_name = 'pc';
}

return array (
  
    'public_dir' => $conf['base_web_url'].'public/',
	'view_dir' => $conf['base_web_url'].'app/index/'.$conf['view_url'].$conf['index_theme_name'].DS.$browser_name.DS,
	'view_path' => APP_PATH.'index/'.$conf['view_url'].$conf['index_theme_name'].DS.$browser_name.DS,
);
?>