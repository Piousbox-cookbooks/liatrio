
#
# This liatrio::home recipe 
#

# networking
node['home']['open_ports'].each do |port|
  execute "Open port #{port}" do
    command <<-EOL
      iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport #{port} -j ACCEPT -m comment --comment "some comment"
    EOL
end
execute "save iptables" do
  command <<-EOL
    service iptables save
  EOL
end
service 'iptables' do
  action :restart
end







