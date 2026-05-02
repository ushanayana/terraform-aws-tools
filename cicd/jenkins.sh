#!/bin/bash
yum update -y
yum install -y wget

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

yum install -y fontconfig java-17-openjdk jenkins

systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins


# #!/bin/bash
# curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# yum install fontconfig java-17-openjdk jenkins -y
# systemctl daemon-reload
# systemctl enable jenkins
# systemctl start jenkins