#!/bin/bash

if [ ! -e $START/.progress ]
then
	cat /dev/null > $START/.progress
fi

if [ ! -s $START/.progress ]
then
	echo 1 >$START/.progress
fi

read lastcmd
current_step=$(tail -n 1 $START/.progress)

# Step 1: Navigation the directory structre.
step_1(){
	case "$current_step" in
		"1")
			echo -e "\e[1;34mWelcome to the Server Farm, fellow pentester!"
			echo "My manager told me to share the infected data server with you so you can access it."
			echo "Let me boot you up the terminal for you."
			
			echo -e "\e[0m----------------------------------------------------------"
			echo -e "booting up terminal..."
			echo "----------------------------------------------------------"
			
			echo -e "\e[1;33mTask I: Let's begin by figuring out where we are and try to get inside the infected server. Check out the current directory.\e[0m"
			echo 1.1>>$START/.progress
			;;
		"1.1")
			case "$lastcmd" in
				"pwd")
					echo
					echo -e "\e[1;32mOkay so we are here!"
					echo "As you can see above, the current directory is \"`pwd`\"."
					echo
					if [ "`pwd`" = "$HOME" ]
					then
						echo "You are already in your home directory. You can always get back here at any time"
						echo -e "by issuing the change directory command 'cd'. Try it now.\e[0m"
					else
						echo "You are not in your home directory. Please change to your home directory"
						echo -e "by issuing the change directory command 'cd'.\e[0m"
					fi
					echo 1.2>>$START/.progress
					;;
				*)
					echo -e "\e[1;31mTry again. You typed \"$lastcmd\" \nHint: Check out command to check current directory in linux.\e[0m"
					;;
			esac
			;;
		"1.2")
			if [ "`pwd`" = "$HOME" ]
			then
				echo -e "\e[1;32mGreat! Now we're in your home directory."
				echo "Let's make a directory to use for the rest of this pentesting session. To make a directory"
				echo "issue the make directory command 'mkdir' with the name of a directory you want to"
				echo -e "create. In this case, we'll make the 'pentest' directory.\e[0m"
				echo 1.3>>$START/.progress
			else
				echo -e "\e[1;31mTry again. You typed \"$lastcmd\" \nHint: Try typing cd\e[0m"
			fi
			;;
		"1.3")
			if [ -d "$HOME/pentest" ]
			then
				echo -e "\e[1;32mYou've just created a directory. Now lets change into that directory. To change"
				echo -e "directory you use the command 'cd' with the name of the directory you want to change to.\e[0m"
				echo 1.4>>$START/.progress
			else
				echo -e "\e[1;31mTry again. You typed \"$lastcmd\" \nHint: Try typing 'mkdir pentest'\e[0m"
			fi
			;;

		"1.4")
			if [ "`pwd`" = "$HOME/pentest" ]
			then
				echo -e "\e[1;32mNicely done. You're now in the pentest directory. Your flag is: gk{l1nux_bas1cs}. \nYou can exit. \e[0m"
				echo 1.5>>$START/.progress
			fi
			;;
	esac
}

# Run the handler for the current step.
step_${current_step%%.*}

