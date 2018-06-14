#!/usr/bin/env bash

echo "172.16.20.50    labipa.example.com labipa" >> /etc/hosts
echo "172.16.20.51    system1.example.com system1" >> /etc/hosts
echo "172.16.20.52    system2.example.com system2" >> /etc/hosts
yum upgrade -y
yum install -y ansible
