#!/bin/bash
#portal
set -e
IP = 192.168.2.2
mkdir -p /${bamboo_build_working_directory}/portal.${bamboo_deploy_release}
cd /${bamboo_build_working_directory}/portal.${bamboo_deploy_release}


file1=($(grep "noarch" /${bamboo_build_working_directory}/install-scripts/portal/${bamboo_deploy_release}/be-install-portal.sh | sed 's/yum -y localinstall//'))
for f in ($file1[@]); do
	wget --user user --password password https://yourrepisotory.com/RPMS/$f
done


cp /${bamboo_build_working_directory}/install-scripts/portal/${bamboo_deploy_release}/be-install-portal.sh /${bamboo_build_working_directory}/portal.${bamboo_deploy_release}
zip /${bamboo_build_working_directory}/portal_${bamboo_deploy_release}.zip  ${bamboo_build_working_directory}/portal.${bamboo_deploy_release}/*
touch /${bamboo_build_working_directory}/portal_${bamboo_deploy_release}.md5
md5sum  /${bamboo_build_working_directory}/portal_${bamboo_deploy_release}.zip > /${bamboo_build_working_directory}/portal_${bamboo_deploy_release}.md5
scp -P 51515 /${bamboo_build_working_directory}/portal_${bamboo_deploy_release}.zip user@$IP:
scp -P 51515 /${bamboo_build_working_directory}/portal_${bamboo_deploy_release}.md5 user@$IP:
