#!/bin/bash 

cd `dirname $0`
pwd

###############################################################################

#
# tool install
#
setup_install_tool() {
	# install vim
	sudo apt-get install vim
	# install git
	sudo apt-get install git-core git-svn
	# install subversion
	sudo apt-get install subversion subversion-tools
        # make .subversion directory
	/usr/bin/svn --help 2>&1 > /dev/zero
}

#
# setup vundle git submodule
#
setup_vundle() {
	if [ ! -e vimfiles/vundle/.git ]; then
		# submodule(vundle)の取得
		echo "git submodule vundle init"
		git submodule init
		git submodule update
	else
		echo "already setup vundle\n"
	fi
}

#
# setup symbolic link
#
setup_ln() {
	if [ ! -L ~/.vimrc ]; then
        	ln -s vimfiles/.vimrc ~/.vimrc
	fi
	if [ ! -L ~/.gitconfig ]; then
		ln -s gitfiles/.gitconfig ~/.gitconfig
	fi
	if [ ! -L ~/.subversion/config ]; then
	        if [ -e ~/.subversion/config ]; then
        	    mv ~/.subversion/config ~/.subversion/config_$(date +%Y-%m-%d)
       		 fi
		ln -s  svnfiles/config ~/.subversion/config
	fi
}

###############################################################################
setup_install_tool
setup_vundle
setup_ln
