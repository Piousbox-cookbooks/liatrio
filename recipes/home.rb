
#
# This liatrio::home recipe 
#

#
# home config
#
case node['platform']
when 'redhat', 'centos', 'fedora' do
  node[:home][:centos][:packages].each do |pkg|
    package pkg
  end
when 'ubuntu', 'debian' do
  node[:home][:ubuntu][:packages].each do |pkg|
    package pkg
  end
end



#
# networking
# From: http://stackoverflow.com/questions/24756240/how-can-i-use-iptables-on-centos-7
#
case node['platform']
when 'redhat', 'centos', 'fedora' do
  # disable and mask firewalld
  execute " systemctl stop   firewalld  "
  execute " systemctl mask   firewalld  "
  execute " systemctl enable iptables   "
when 'ubuntu', 'debian' do
end

service 'iptables'
node['home']['open_ports'].each do |port|
  execute "Open port #{port}" do
    command <<-EOL
      iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport #{port} -j ACCEPT -m comment --comment "some comment"
    EOL
    notifies :restart, 'service[iptables]', :delayed
  end
end
#execute "save iptables" do
#  command <<-EOL
#    service iptables save
#  EOL
#end







