chef_user = my_chef_user
template chef_user.global_rbenv_path do
  source 'rbenv-vars.kitchen.erb'
  owner chef_user.name
  group chef_user.name
  mode '0644'
end

directory File.join(chef_user.home, '.bundle') do
  owner chef_user.name
  group chef_user.name
  mode '0755'
  action :create
end

template chef_user.global_bundle_config_path do
  source 'bundle_config.kitchen.erb'
  owner chef_user.name
  group chef_user.name
  mode '0644'
end
