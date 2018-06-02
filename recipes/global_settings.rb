chef_user = my_chef_user
template chef_user.global_rbenv_path do
  source 'rbenv-vars.erb'
  owner chef_user.name
  group chef_user.name
  mode '0644'
end

template chef_user.global_bundle_config_path do
  source 'bundle_config.erb'
  owner chef_user.name
  group chef_user.name
  mode '0644'
end
