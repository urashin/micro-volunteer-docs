
#rm *.pem
rm env.sh
rm micro_volunteer_install.tgz
rm micro_volunteer_install/config.sh

cd ../
rm aws_deploy.tgz
tar cvzf aws_deploy.tgz aws_deploy/
