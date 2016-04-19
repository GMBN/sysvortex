case node['platform_family']
when 'rhel', 'fedora'
  # centos php compiled with curl
when 'debian'

  package 'php5-intl' do
    action :install
  end
  package 'php5-pgsql' do
    action :install
  end
  package 'php5' do
    action :install
  end
  execute "update-php56" do
  command "add-apt-repository ppa:ondrej/php5-5.6 -y "
  action :run
end
execute "update-php" do
  command "apt-get update"
  action :run
end
package 'python-software-properties' do
    action :install
  end
execute "update-php2" do
  command "apt-get update"
  action :run
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
