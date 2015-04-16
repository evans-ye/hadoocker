echo "Add private DockerHub"
sudo sh -c "echo \"EXTRA_ARGS=\\\"--insecure-registry <PRIVATE_DOCKERHUB_FQDN> --storage-driver=devicemapper\\\"\" > /var/lib/boot2docker/profile && sudo /etc/init.d/docker restart"

echo "Update home directory to permanent directory"
sudo mv /home/docker /mnt/sda1/ 2>/dev/null
sudo ln -s /mnt/sda1/docker/ /home/ 2>/dev/null
