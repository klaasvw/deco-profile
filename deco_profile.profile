<?php

/**
 * Implements hook_form_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function deco_profile_form_alter(&$form, $form_state, $form_id) {
  if ($form_id == 'install_configure_form') {
    // Set default for site name field.
    $form['site_information']['site_name']['#default_value'] = 'Deco demo site';
  }
}



/**
 * Implements hook_init
 */
function deco_profile_init() {
  $cache = cache_get("deco_profile_info");

  if (isset($cache->data)) {
    $data = $cache->data;
  }
  else {
    $info =  drupal_parse_info_file(dirname(__file__) . '/deco_profile.info');
    $data = array("profile" => "deco_profile", "profile_version" => $info['version']);
    cache_set("deco_profile_info", $data);
  }

  drupal_add_js($data, 'setting');
}