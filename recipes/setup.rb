case node['platform_family']
when 'rhel', 'fedora'
  # centos php compiled with curl
when 'debian'
execute "update-php56" do
  command "add-apt-repository ppa:ondrej/php5-5.6 -y "
  action :run
end
apt_update 'all platforms' do
  action :update
end
package 'python-software-properties' do
    action :install
  end
apt_update do
  action :update
end
  package 'php5-intl' do
    action :install
  end
  package 'php5-pgsql' do
    action :install
  end
  package 'php5' do
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
