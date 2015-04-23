echo "Add repos"
yes | /bin/cp /vagrant/Bigtop.repo /etc/yum.repos.d/Bigtop.repo

echo "Clean up"
/vagrant/cleanup.sh
