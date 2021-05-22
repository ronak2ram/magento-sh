printf "Please enter magento directory /var/www/html/{FOLDER_PATH} OR {FOLDER_PATH}/{FOLDER_PATH} : "
read FOLDER_PATH
printf "Please input magento version Like 2.1 2.2 2.2.5 2.3 : "
read INPUT_VERSION
printf "CE Or EE :"
read DEOREE
printf "Do you want to install sample data (Y/n) : "
read SAMPLE_DATA
# printf "Do you want to install MagePal SMTP (Y/n) : "
# read MAGEPAL_DATA
DB_NAME="${FOLDER_PATH/'/'/'_'}"
MYSQL_PWD=root123 mysql -u root -e "DROP DATABASE IF EXISTS $DB_NAME;create database $DB_NAME" > /dev/null
echo "Database Created with name $DB_NAME"
if [ $INPUT_VERSION != '' ]
then
echo "Installation Start"
DIRECTORY=/var/www/html/$FOLDER_PATH;
	if [ -d $DIRECTORY ]
	then
		rm -rf $DIRECTORY
	fi
REPONAME=''
	if [ $DEOREE == 'EE' ]
	then
		REPONAME="magento/project-enterprise-edition"
	else
		REPONAME="magento/project-community-edition"
	fi
composer create-project --repository-url=https://repo.magento.com/ $REPONAME=$INPUT_VERSION $DIRECTORY

	# if [ $MAGEPAL_DATA != 'n' ]
	# then
	# 	composer require magepal/magento2-gmailsmtpapp
	# fi

cd $DIRECTORY
php bin/magento setup:install --base-url=http://127.0.0.1/$FOLDER_PATH/ \
--db-host=localhost --db-name=$DB_NAME --db-user=root --db-password=root123 \
--admin-firstname=Magento --admin-lastname=User --admin-email=admin@admin.com \
--admin-user=admin --admin-password=admin123 --language=en_US \
--currency=USD --timezone=America/Chicago --use-rewrites=1 --backend-frontname=admin

	if [ $SAMPLE_DATA != 'n' ]
	then
		echo "Sample Data Install Start";
		echo "Key : f6e07413cba0785f8d56da5d0645868e";
		echo "Secret : 1327b4d24aa58ac5b69dd40ccca08b01";
		php bin/magento sampledata:deploy
	fi
php bin/magento s:up
echo "Frontend : http://127.0.0.1/$FOLDER_PATH"
echo "Admin : http://127.0.0.1/$FOLDER_PATH/admin"
echo "Database : $DB_NAME"
else
echo "Please Enter Version"
fi


#composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=$mysqlversion /var/www/html/dev/$folderpath











# USER='root'
# PASSWORD='root123'
# DB_NAME=folderpath
# mysqladmin -u$USER -p$PASSWORD create $DB_NAME


# if [ $varname = '1' ]
# then
# echo "Magento2 repo sync"
# cd /var/www/html/magento/magento2
# git checkout 2.3-develop
# git fetch upstream
# git merge upstrea/2.3-develop
# elif [ $varname = '2' ] 
# then
# echo "Devdocs repo sync"
# cd /var/www/html/magento/devdocs
# git checkout master
# git fetch upstream
# git merge upstrea/master
# else
# echo "You selected wrong input"
# bash run.sh
# fi