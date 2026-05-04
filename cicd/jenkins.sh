#!/bin/bash
curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install fontconfig java-17-openjdk jenkins -y
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins


# curl -O /etc/yum.repos.d/jenkins.repo \
#     https://pkg.jenkins.io/rpm/jenkins.repo
# # Add required dependencies for the jenkins package
# rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key


# yum install fontconfig java-21-openjdk
# systemctl daemon-reload
# systemctl enable jenkins
# systemctl start jenkins