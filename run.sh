echo "Please select magento instant"  
echo "1. Magento2"  
echo "2. Devdocs"  
read varname
if [ $varname = '1' ]
then
echo "Magento2 repo sync"
cd /var/www/html/magento/magento2
git checkout 2.3-develop
git fetch upstream
git merge upstrea/2.3-develop
elif [ $varname = '2' ] 
then
echo "Devdocs repo sync"
cd /var/www/html/magento/devdocs
git checkout master
git fetch upstream
git merge upstrea/master
else
echo "You selected wrong input"
bash run.sh 
fi