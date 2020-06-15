if [ "$1" = "init" ]
then

if [ ! -d ".git-hse" ] 
then
mkdir .git-hse
mkdir .git-hse/index
mkdir .git-hse/history
else
echo "git-hse is already initialized"	
fi 

elif [ "$1" = "add" ]
then
if [ "$2" = "" ]
then
echo "Please, enter name of files for adding to index"
else
cp -r "$2" .git-hse/index
fi

elif [ "$1" = "commit" ]
then
if [ "$2" = "" ]
then
echo "Please, enter the commit name"
elif [ -f .git-hse/history/"$2" ]
then
echo "Commit with this name was already created. Choose new name."
else
cp -r .git-hse/index/. .git-hse/history/"$2"
fi

elif [ "$1" = "checkout" ]
then
if [ "$2" = "" ]
then 
lastcommit=$(cd .git-hse/history && ls -tr | tail -1)
ls | grep -v git-hse.sh | xargs rm
cp -r .git-hse/history/"$lastcommit"/. .
elif [ ! -d .git-hse/history/"$2" ]
then
echo "No commit with this name. Try again."
else
shopt -s extglob
ls | grep -v git-hse.sh | xargs rm
cp -r .git-hse/history/"$2"/. .
fi

elif [ "$1" = "diff" ]
then
diff -x 'git-hse.sh' -x '.git-hse' .git-hse/index .

elif [ "$1" = "status" ]
then
diff -qr -x 'git-hse.sh' -x '.git-hse' .git-hse/index .

elif [ "$1" = "push" ]
then
if [ "$2" = "" ]
then
echo "Server address is empty. Please write it."
else
sudo scp -r .git-hse/index/* "$2"
fi

fi
