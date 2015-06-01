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
	#figlet Crakotte # Now using ascii art ;p
	. _crakott_logo_colored # 'source' the '_crakott_logo_colored' file > wich displays ascii art of the tool's logo ;p
	#echo -e "\n"
	# R: all the following are being 'externalized' in files whose cod starts with an ' echo -e '' ' command (..)
	#echo "\"a neat littl' RegExp bruteForce PDF cracker \"" 
	echo "v0.1b"
	#echo -e "" 
        #echo "by StephaneAG - 2013"
	#echo -e "\n######    Crakott help    ######" 
	#echo -e "\nUsing this tool, you can crack owner & user passwords of any PDF file"
	#echo -e "\n" 
	#echo "Usage:"
	#echo -e "" 	
	#echo "short syntax: \"<RexExp_universe>\" \"<RegExp_length>\""
	#echo -e "\n > will try to crack a pdf named 'pdf_to_crack.pdf' in the same directory as Crakotte, and will safe both a 'cracked_pdf.pdf' and a 'original_pdf_password.txt' ifle in the same directory"
	#echo -e "" 
	#echo "complete syntax: \"<RexExp_universe>\" \"<RegExp_length>\" <file_to_crack> <output_unlocked_file> <saved_password_file>"
	#echo -e "\n > more practical, as we are able to choose where to get & set the files depending on our needs dynamically ( > from another script ? ^;p )"
	#echo -e "\n              ####              "
	. _crakott_help # 'source' the '_crakott_help' file > wich displays the tools's help
	. _crakott_credits_colored # 'source' the '_crakott_logo_colored' file > wich displays ascii art of the tool's credits ( > to me ;) )
}
# the 'display_error' Fcn
display_error(){
	echo "ERROR: you must provide at least 2 arguments, or 5"
	echo -e ""
	echo "Usage:"
	echo -e ""    
        echo "short syntax: \"<RexExp_universe>\" \"<RegExp_length>\""
        echo " > will try to crack a pdf named 'pdf_to_crack.pdf' in the same directory as Crakotte, and will safe both a 'cracked_pdf.pdf' and a 'original_pdf_password.txt' ifle in the same directory"
        echo -e "" 
	echo "complete syntax: \"<RexExp_universe>\" \"<RegExp_length>\" <file_to_crack> <output_unlocked_file> <saved_password_file>"
        echo " > more practical, as we are able to choose where to get & set the files depending on our needs dynamically ( > from another script ? ^;p )"
}
# Fcn 'display_animation'
display_animation(){
	for a in \\ \| \/ -; do
        	echo -n $a; # originally ' echo -n $a; '
                sleep 0.01;
                echo -n -e \\r;
        done
}


# the 'crack_it' Fcn
crack_it(){
	echo "Crakotte current parameters:"
	#echo "$2 $2 $3 $4 $5"
	#echo "wich will result in:"
	echo -e ""
	echo "\"$1\" \"$2\" $3 $4 $5"

	## CRACKING SCRIPT BEGINS HERE ##
	
	testedPswdCounter=0 # a counter to know how much tries have already been done
	
	echo "The RegExp that will be performed is: \"$1\" \"$2\""
	echo "The loked file that will be cracked is: $3"
	echo "The unlocked file will be saved to: $4"
	echo "The original password will be saved to: $5"

	# R: for later implm, think about the 'animation' in terminal, to 'refresh' the screen with current infos instead of printing a huge list of junk ;p
	
		## -------- crack code start-------- ##		
			# generate the combinations from the passed params using regldg command & use its output line by line to perform a mupdf command
			#/Users/stephanegarnier/defi_papa_iMac/regldg-1.0.0/regldg "--universe-set=7" ".{16}" | while read p; do # static for now, 'til I resolve this 'quote problem' (..)
			/Users/stephanegarnier/defi_papa_iMac/regldg-1.0.0/regldg $1 $2 | while read p; do # 'quote problem' solved ;p
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
					echo -n "        TRY number $testedPswdCounter >> Password '$p' did match"
					echo "PASSWORD FOUND > password is : $p"
                			echo "password found: $p" >>  $password_file #$5 # append the password to the text file used to store all the ones I've found ;p
					figlet "pdf file cracking done !"
                			exit 0 # password has been found, so we exit gently
        			else
                			#echo "Password did not match, continuing looping over dictionary .." # before adding animation
					echo -n "    > PASS / TRY number $testedPswdCounter >> Password '$p' did not match, continuing looping over dictionary .." # write a line of infos ..
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
