include_recipe 'deploy'

node[:deploy].each do |app_name, deploy|
  directory "#{deploy[:deploy_to]}/current/data" do
    recursive true
    user deploy[:user]
    group deploy[:group]
    mode 0775
    action :create
  end
  directory "#{deploy[:deploy_to]}/current/data/DoctrineORMModule" do
    recursive true
    user deploy[:user]
    group deploy[:group]
    mode 0775
    action :create
  end
  directory "#{deploy[:deploy_to]}/current/data/DoctrineORMModule/Proxy" do
    recursive true
    user deploy[:user]
    group deploy[:group]
    mode 0775
    action :create
  end

  template "#{deploy[:deploy_to]}/current/config/autoload/db.local.php" do
    source "db.local.php.erb"
    mode "0644"
    variables(
      :environment_variables => deploy["environment_variables"]
    )
  end
  
 execute 'doctrine-update' do
   command "php #{deploy[:deploy_to]}/current/vendor/doctrine/doctrine-module/bin/doctrine-module orm:schema-tool:update -f"
   action :run
 end

end
