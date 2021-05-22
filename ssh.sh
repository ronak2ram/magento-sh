echo "Please enter number :"
echo "1. Blossom Final(Live)"
echo "2. Blossom Migrate"  
read varname
if [ $varname = '1' ]
then
echo "Conecting to blossom Final(Live) : password: fMwGnAXcD4qtLdun"
ssh m2_final@149.28.182.85
elif [ $varname = '2' ] 
then
echo "Conecting to Migrate : password: FAEFA2C9BC8a2df"
ssh migration_user@149.28.182.85
else
echo "You selected wrong input"
bash run.sh 
fi