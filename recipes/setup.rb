case node['platform_family']
when 'rhel', 'fedora'
  # centos php compiled with curl
when 'debian'
bash "update-php56" do
  user "root"
  code <<-EOH 
  add-apt-repository ppa:ondrej/php5-5.6 
  apt-get update
   EOH
  action :run
end
 package 'python-software-properties' do
    action :install
  end
  package 'php56-intl' do
    action :install
  end
  package 'php56-pgsql' do
    action :install
  end
  package 'php56' do
    action :install
  end
   package 'tzdata' do
    action :install
  end
end

execute "update-tzdata" do
  command "dpkg-reconfigure -f noninteractive tzdata"
  action :nothing
end
 
file '/etc/timezone' do
  owner "root"
  group "root"
  mode "00644"
  content 'America/Sao_Paulo'
  notifies :run, "execute[update-tzdata]", :immediately
end
