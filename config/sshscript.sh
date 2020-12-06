mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
sed -i '65s/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
for i in /proc/sys/net/ipv4/conf/*/rp_filter ; do echo 0 > $i ; done
          
          


