#!/bin/sh

#
# This is the nightly build script.
# It does almost nothing since the process itself is kept in CVS.
#
# This causes some bootstrap problems, but we deal with that by understanding
# that this first stage bootstrap can not updated automatically. This script
# should be copied somewhere that is not in the release tree (i.e. ~/bin) 
# and invoked periodically. 
#

if [ -f $HOME/openswan-2-regress-env.sh ]
then
    . $HOME/openswan-2-regress-env.sh
fi

# /btmp is a place with a bunch of space. 
BTMP=${BTMP:-/btmp} export BTMP

GITPUBLIC=${GITPUBLIC-http://git.openswan.org/public/scm/openswan.git}

# BRANCH can also be set to test branches.
BRANCH=${BRANCH:-HEAD} export BRANCH

# rest of not to be touched.
YEAR=`date +%Y` export YEAR
MONTH=`date +%m` export MONTH
DAY=`date +%d` export DAY
TODAY=`date +%Y_%m_%d` export TODAY
TODAYSPLIT=`date +%Y/%m/%d` export TODAYSPLIT

BUILDSPOOL=$BTMP/$USER/$BRANCH/$TODAY export BUILDSPOOL

# go to subshell so that exit can abort that shell

(
mkdir -p $BUILDSPOOL || exit 3

cd $BUILDSPOOL || (echo "Can not make spool directory"; exit 4)

exec >$BUILDSPOOL/stdout.txt
exec 2>&1

# invoke file space cleanup first.
regress-cleanup.pl || (echo "Disk space cleanup failed"; exit 5)

# Now we clone git from the public repo
if [ -d openswan-2 ]
then
	echo "openswan-2 already exists - doing git pull"
	cd openswan-2
	git pull
	cd ..
else
	echo git clone $GITPUBLIC openswan-2
	git clone $GITPUBLIC openswan-2
	if [ $? != 0 ]
	then
        	echo "Failed to checkout source code. "
        	exit 10
	fi

fi
(cd openswan-2
git submodule init
git submodule sync
git submodule update --reference $GITPUBLIC )

rm -f $BTMP/$USER/$BRANCH/today
ln -f -s $BUILDSPOOL/openswan-2 $BTMP/$USER/$BRANCH/today
ln -f -s $BUILDSPOOL/stdout.txt ~/stdout.txt


# invoke stage 2 now.
chmod +x $BUILDSPOOL/$TOPMODULE/testing/utils/regress-stage2.sh  
$BUILDSPOOL/$TOPMODULE/testing/utils/regress-stage2.sh  || exit 6

# warn about changes in myself.
me=$HOME/bin/regress-nightly-git.sh
cmp $BUILDSPOOL/$TOPMODULE/testing/utils/regress-nightly-git.sh $me
	
if [ $? != 0 ]
then
    echo WARNING $BUILDSPOOL/$TOPMODULE/testing/utils/regress-nightly-git.sh differs from $me.
fi

)

