#! /bin/bash
sudo apt-get install unzip
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo curl -o kubectl "https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl"
sudo chmod +x ./kubectl
sudo mv kubectl /usr/local/bin
sudo export PATH=$PATH:/usr/local/bin
sudo curl -o aws-iam-authenticator "https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator"
sudo chmod +x ./aws-iam-authenticator
sudo mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
sudo echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
mkdir -m777 /home/ubuntu/.kube
echo "${config_file}" > /home/ubuntu/.kube/config
chmod 700 /home/ubuntu/.kube/config
chown ubuntu /home/ubuntu/.kube/config
echo "${auth_file}" > /home/ubuntu/auth.yaml
chmod 700 /home/ubuntu/auth.yaml
chown ubuntu /home/ubuntu/auth.yaml
echo "${auth_file_prod}" > /home/ubuntu/auth-prod.yaml
chmod 700 /home/ubuntu/auth-prod.yaml
chown ubuntu /home/ubuntu/auth-prod.yaml
mkdir /home/ubuntu/environment
mkdir /home/ubuntu/environment/grafana
sudo curl -o gethelm3 "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
sudo chmod +x gethelm3
sudo ./gethelm3
echo "${script_file}" > /home/ubuntu/script.sh
chmod +x /home/ubuntu/script.sh
echo "${aws_auth_file}" > /home/ubuntu/aws-auth.sh
chmod +x /home/ubuntu/aws-auth.sh
sudo apt-get install git -y
wget "https://raw.githubusercontent.com/algorithm24/app/master/app/argocd-setup-application.yaml" -O /home/ubuntu/application.yaml
chmod 700 /home/ubuntu/application.yaml
chown ubuntu /home/ubuntu/application.yaml
echo "${grafana_file}" > /home/ubuntu/environment/grafana/grafana.yaml
chmod 700 /home/ubuntu/environment/grafana/grafana.yaml
chown ubuntu /home/ubuntu/environment/grafana/grafana.yaml
echo "${service_account_file}" > /home/ubuntu/service-account.yaml
chmod 700 /home/ubuntu/service-account.yaml
chown ubuntu /home/ubuntu/service-account.yaml