#! /usr/bin/env bash

###################################
############ crakotte #############
###################################
# by StephaneAG - 2013

# 'Crakotte' is a shell script that can be used to 'brute force' or 'dictionnary attack' a .pdf file
# Unless the techniques mentionned above, Crakotte uses Regular Expressions to create any possible combinations
# before trying them as password to open the file.
# Thing is: in 'professional software' or using this script, the most complicated RegExp will take a huge amount of time to compute (..)
#
# version: 0.1a



###### Crakotte Script ######



### Fcns definitions ###

# the 'display_help' Fcn
display_help(){
	. _crakott_logo_colored # 'source' the '_crakott_logo_colored' file > wich displays ascii art of the tool's logo ;p
	echo "v0.1b"
	. _crakott_help # 'source' the '_crakott_help' file > wich displays the tools's help
	. _crakott_credits_colored # 'source' the '_crakott_logo_colored' file > wich displays ascii art of the tool's credits ( > to me ;) )
}
# the 'display_error' Fcn
display_error(){
	echo "ERROR: the short syntax requires 2 arguments and the complete one 5."
	. _crakott_examples_only # 'source' the '_crakott_help' file > wich only displays examples extracted from the tools's help             
}
# Fcn 'display_animation'
display_animation(){
	for a in \\ \| \/ -; do
		echo -e -n '\033[1;36m'
        	echo -n $a; # originally ' echo -n $a; '
                echo -e -n '\033[0m'
		sleep 0.01;
                echo -n -e \\r;
        done
}


# the 'crack_it' Fcn
crack_it(){
	. _crakott_logo_colored # 'source' the '_crakott_logo_colored' file > wich displays ascii art of the tool's logo ;p        
	echo "v0.1b"
	echo -e ""
	echo -e "Crakott current parameters:  "'\033[1;36m'"\"$1\"" '\033[1;34m'"\"$2\""'\033[1;35m'" $3 $4 $5"'\033[0m'
	#echo "$2 $2 $3 $4 $5"
	#echo "wich will result in:"
	echo -e ""
	#echo "\"$1\" \"$2\" $3 $4 $5"

	## CRACKING SCRIPT BEGINS HERE ##
	
	testedPswdCounter=0 # a counter to know how much tries have already been done
	now_date=`date`
	
	#echo -e 'The RegExp that will be performed is: \033[1;36m'"\"$1\"" '\033[1;34m'"\"$2\""'\033[0m'
	#echo "The RegExp that will be performed is: \"$1\" \"$2\""
	#echo "The loked file that will be cracked is: $3"
	#echo "The unlocked file will be saved to: $4"
	#echo "The original password will be saved to: $5"

	# R: for later implm, think about the 'animation' in terminal, to 'refresh' the screen with current infos instead of printing a huge list of junk ;p
	
		## -------- crack code start-------- ##		
			# generate the combinations from the passed params using regldg command & use its output line by line to perform a mupdf command
			#/Users/stephanegarnier/defi_papa_iMac/regldg-1.0.0/regldg "--universe-set=7" ".{16}" | while read p; do # static for now, 'til I resolve this 'quote problem' (..)
			#/Users/stephanegarnier/defi_papa_iMac/regldg-1.0.0/regldg $1 $2 | while read p; do # 'quote problem' solved ;p
			./../../dev__pentest/regldg-1.0.0/regldg $1 $2 | while read p; do # now runnig from the zenbook
	    			#printf "\n"
				#echo "TRY NUMBER: $testedPswdCounter"
				#echo "Trying $p .."

				## 'screen refresh' way' (> no more ugly junk list ;p )
				display_animation # display an animation (defined in an external Fcn) at the ultimate left of the screen ;p
				# the two lines following have been migrated below as they were screwing with the animation (..)
				#echo -n "    TRY NUMBER: $testedPswdCounter using password: $p" # write a line of infos ..
				#echo -n -e \\r; # .. and erase it just after 
						
				## try the password against the file using mupdf
				# R: this is where we need to redirect errors & output to /dev/null (..) ' > /dev/null 2>&1 '
				#if(mupdfclean -p $p $input_file $output_file); then # if the code returned by the command is ok
	        		if(mupdfclean -p $p $input_file $output_file > /dev/null 2>&1); then # if the code returned by the command is ok
					#printf "\n"
					#figlet "PDF password cracked !" # as I have 'figlet' installed on my mcbookpro, I can display a fancy 'Work done!' message ;p
					#echo -n "        TRY number $testedPswdCounter >> Password '$p' did match"
					echo -e "\n"
					echo -e "    > Try number "'\033[1;34m'"$testedPswdCounter"'\033[0m'" > Password '"'\033[1;35m'"$p"'\033[0m'"' >> did match !""\n"
					cracking_done_date=`date`
					# PASSWORD FOUND > display stuff !
					#echo "PASSWORD FOUND > password is : $p"
					#. _crakott_cracked_colored_simple # cause it seems that I can't 'source' stg AND pass vars to it from within a .sh [for the moment]
                			
					# SETUP ENVIRONMENT VARIABLES TO USE WITH THE FOLLOWING FILE ( wich is getting 'sourced' n: steps below are not obligatory when using the terminal but obliged to using 'sourced stuff' (..) )
					crakott_now_date=$now_date
					crakott_cracking_done_date=$cracking_done_date
					crakott_testedPswdCounter=$testedPswdCounter
					crakott_p=$p
					crakott_3=$3
					crakott_4=$4
					crakott_5=$5
					
					export crakott_now_date
					export crakott_cracking_done_date
					export crakott_testedPswdCounter
					export crakott_p
					export crakott_3
					export crakott_4
					export crakott_5
					
					. _crakott_cracked_colored # should use the 'environment variables' now ..
					#. _crakott_cracked_colored $crakott_now_date $crakott_cracking_done_date $crakott_testedPswdCounter $crakott_p $crakott_3 $crakott_4 $crakott_5  # same as comment & code just below but this time using 'environment variables' defined right above (..)					

					#. _crakott_cracked_colored $now_date $cracking_done_date $testedPswdCounter $p $3 $4 $5  # 'source' the '_crakott_cracked_colored' file > wich displays ascii art of the tool's logo and the pdf stuff ;p

					# below: 'date / original_file / password / cracked_file'
					echo "Crakott started on: $now_date on $3" >>  $password_file
					echo "Crakott ended the cracking on: $cracking_done_date :" >>  $password_file
					echo "PDF file password: $p | Cracked PDF file: $4" >>  $password_file
					echo -e "" >>  $password_file # a little space for further cracking ;D
					#echo "password found: $p" >>  $password_file #$5 # append the password to the text file used to store all the ones I've found ;p
					#figlet "pdf file cracking done !"
                			exit 0 # password has been found, so we exit gently
        			else
                			#echo "Password did not match, continuing looping over dictionary .." # before adding animation
					echo -n -e "    > Try number "'\033[1;34m'"$testedPswdCounter"'\033[0m'" >> Password '"'\033[1;35m'"$p"'\033[0m'"' did not match, continuing looping over dictionary .." # write a line of infos ..
					echo -n -e \\r; # .. and erase it just after
        			fi
				testedPswdCounter=$[$testedPswdCounter +1] # increment the tested passwords counter (..)
			done	
		## -------- crack code end-------- ##
	

	## CRACKING SCRIPT ENDS HERE
	
}

### end Fcns definitons ###


### actual script ###

# check if the user needs a little help
if [ "$1" == "--help" ]; then
	display_help # call a Fcn that displays Crakotte's help
	exit 0 # exit gently without errors
fi

# the default settings
	
	# the default 'files settings'
	input_file="./pdf_to_crack.pdf"
	output_file="./cracked_pdf.pdf"
	password_file="./original_pdf_password.txt"
	
	# the default 'RegExp settings'
	universe_setting="--universe-set=7"
	password_length=".{1,16}"

# the parameters passed

	# for users only provided the RegExp
	if [ $# = 2 ]; then
		crack_it $1 $2 $input_file $output_file $password_file
	# for users providing complete settings
	elif [ $# = 5 ]; then
		crack_it $1 $2 $3 $4 $5
	# something went wrong ?
	else
		display_error # call a Fcn that displays Crakotte's syntax in case of errors
        	exit 0 # exit gently without errors
	fi

### actual script end ###
