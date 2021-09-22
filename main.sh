#!/usr/bin/bash
Help()
{
    # Display Help
    echo
    echo "This is the help commande description"
    echo
    echo -e "\033[1mhelp :\033[0m indicate all possible command and what they do"
    echo -e "\033[1mls :\033[0m list of all files and directory hiden or not"
    echo -e "\033[1mrm :\033[0m delete a file"
    echo -e "\033[1mrmd :\033[0m delete a directory"
    echo -e "\033[1mabout :\033[0m a quick description of the program"
    echo -e "\033[1mversion :\033[0m show the version of this prompt"
    echo -e "\033[1mage :\033[0m ask for your age and tell you if you'r a minor"
    echo -e "\033[1mquit :\033[0m allow to quit the prompt"
    echo -e "\033[1mprofile :\033[0m show different information about you: First Name, Last name, age, email"
    echo -e "\033[1mpassw :\033[0m allow you to change your password after confirmation"
    echo -e "\033[1mcd :\033[0m go to file or directory of your choice or to go back one before"
    echo -e "\033[1mpwd :\033[0m show current repository"
    echo -e "\033[1mhour :\033[0m show you the current time"
    echo -e "\033[1m* :\033[0m show up whn its an unknown command"
    echo -e "\033[1mhttpget :\033[0m allow you to download the html souce code of a web page and save it on a file. The prompt will ask you to nam the file"
    echo -e "\033[1msmtp :\033[0m allow you to send an email with a subject and a message"
    echo -e "\033[1mopen:\033[0m open a file with VIM even if the file does not already exist"
    echo -e "\033[1mrps:\033[0m allow you to play Rock Paper Scissors against a bot"
    echo
    sleep 5
}
List()
{
    echo "There are all your files here and there is a"
    ls -la
}
RemoveFile()
{
    if [[ ! -z "$arg" ]] && [[ -f "$arg" ]]; then
        rm $arg
        echo "YES BO-E !"
    else
        echo "This file does not exist"
    fi
    sleep 2
}
RemoveDir()
{
    if [[ ! -z "$arg" ]] && [[ -d "$arg" ]]; then
        rm -r $arg
        echo "YES BO-E !"
    else
        echo "This directory does not exist"
    fi
    sleep 2
}
About()
{
    echo
    echo "This is a magic prompt in the terminal where you can put differents commande"
    echo "You can type help to see all commandes."
    echo
    sleep 2
}
Version()
{
    echo "My-Magic-Prompt v0.01"
    sleep 2
}
Age()
{
    read -p "Please enter your age: " age
    if [[ $((age)) -lt 18 ]]; then
        echo "You are way to young to be here"
        echo
        sleep 1
        echo "Or you haven't put a number"
        echo
        sleep 1
        echo -e "\033[1mAnyway get out of here !\033[0m"
        echo
        exit 1
    else
        echo "Okay you'r good fam ;)"
        sleep 2
    fi
}
Quit()
{
    echo "see you later, aligator"
    echo
    exit 1
}
Profile()
{
    echo "First name : Florian"
    echo "Last name : LINA"
    echo "Age : 25"
    echo "Email : florian-lina@outlook.fr"
    sleep 2
}
Password()
{
    read -p 'Enter a new password: ' newpswrd
    read -p 'Confirmation y/n ? ' conf
    re='^[yn]'
    if ! [[ $conf =~ $re ]] ; then  
            echo "Sorry I didnt get that"
            echo -e "Please try again."
        elif [ $conf == 'n' ]; then
            echo "you choose not to change it after all"
        else
            pswrd="$newpswrd"
            echo "Your password have been change to $pswrd "
    fi
    
}
Goto()
{
    cd $1
}
Where()
{
   echo "You are curently at :"
   pwd
}
Hour()
{
    date +%T
}
Gethttp()
{
    read -p "Enter a filename: " filename
    Newfilename="$filename".html
    wget -O $Newfilename $arg
}
Mail()
{
    echo
    if ! [ -x "$(command -v mail)" ]; then
        echo "Checking mailutils intallation"
        sudo apt install mailutils
    fi
    read -p 'What is the subject' subject
    read -p 'What is your message' message
    mail -s "$subject" florian-lina@outlook.fr <<< "$message"
    echo "Your mail have been send."
    # technicly working but I can't find why not
}
Open()
{
    vim $arg
}
All()
{
    echo "Unknown commande"
    echo "Please try an other one"
}
RockPapperScissors()
{
    p1Score=0
    botScore=0

    rounds=-1

    p1Chosen=-1
    botChosen=-1

    currentRound=-1

    # botWin=0
    # p1Win=0

    p1DisplayChosen=-1
    botDisplayChosen=-1

    digit='^[0-9]+$' #expression used to find any character that is NOT a digit.

    echo -e "\033[1mRock, Paper, Scissors!\033[0m"

    while true; do # Setup the numbeer of turn
    echo -n "How many rounds do you want to play: "
    read -r rounds
        if ! [[ $rounds =~ $digit ]] ; then # error if none digit enter 
            echo "That is not a valid number of rounds!"
            echo -e "Please try again."
        elif [ $rounds -lt 0 ]; then
            echo "You must chose at least 1 round!"
        else
            echo -e "$rounds rounds it is then, lets ready to rumble!"
            break
        fi
    done

    re='^[rpsk]+$' #expression used to find any character that is not 'r', 'p' or 's'
    currentRound=1

    while [ $rounds -gt 0 ]; do # setup bot choice of move
    echo "Round: $currentRound"
    botChosen=$(shuf -i 1-3 -n 1) # range shuf between 1 and 3 and 
    [ "$botChosen" == "1" ] && botChosen="r"
    [ "$botChosen" == "2" ] && botChosen="p"
    [ "$botChosen" == "3" ] && botChosen="s"
    echo -n "Rock, Paper or Scissors (r/p/s): "
    read -r p1Chosen # player choose is move
    if ! [[ "$p1Chosen" =~ $re ]] || [ "${#p1Chosen}" != "1" ]; then
        echo "That is not a valid move!"
        echo -e "Please chose again.\n"
    else

        [ "$p1Chosen" == "r" ] && p1DisplayChosen="Rock"
        [ "$p1Chosen" == "p" ] && p1DisplayChosen="Paper"
        [ "$p1Chosen" == "s" ] && p1DisplayChosen="Scissors"
        [ "$p1Chosen" == "k" ] && p1DisplayChosen="SuperKitty"


        [ "$botChosen" == "r" ] && botDisplayChosen="Rock"
        [ "$botChosen" == "p" ] && botDisplayChosen="Paper"
        [ "$botChosen" == "s" ] && botDisplayChosen="Scissors"

        echo "You chose $p1DisplayChosen !"
        echo "CPU chose $botDisplayChosen !"
        echo -e "\n"

        botWin=0
        p1Win=0
        
        # Setup every possible out come and there results
        if [ "$p1Chosen" == "r" ]; then
        [ "$botChosen" == "p" ] && botWin=1
        [ "$botChosen" == "s" ] && p1Win=1

        elif [ "$p1Chosen" == "p" ]; then
        [ "$botChosen" == "r" ] && botWin=1
        [ "$botChosen" == "s" ] && p1Win=1

        elif [ "$p1Chosen" == "s" ]; then
        [ "$botChosen" == "r" ] && botWin=1
        [ "$botChosen" == "p" ] && p1Win=1

        elif [ "$p1Chosen" == "k" ]; then
        [ "$botChosen" == "r" ] && p1Win=1
        [ "$botChosen" == "s" ] && p1Win=1
        fi

        # Add the score before going to the next round or the end
        if [ "$botWin" == "0" ] && [ "$p1Win" == "0" ]; then
        echo "It's a draw!"
        elif [ "$p1Win" == 1 ]; then
        echo "You win!"
        ((p1Score++))
        elif [ "$botWin" == 1 ]; then
        echo "Computer wins :("
        ((botScore++))
        fi

        # the number of remaining rounds decrease and the current round increase
        echo -e "\n"
        ((rounds--))
        ((currentRound++))
    fi
    done

    # end of the game with the score and who win
    echo "That's the game!"
    echo "p1 scored $p1Score"
    echo "Computer scored $botScore"
    echo -e "\n"

    if [ $botScore -gt $p1Score ]; then
    echo "You lose!"
    elif [ $p1Score -gt $botScore ]; then
    echo "You win :)"
    elif [ $botScore -eq $p1Score ]; then
    echo "The game is a draw!"
    fi

    echo -e "\n"
    echo -e "\033[1mThanks for playing!\033[0m"
}

read -p 'Type your login: ' log;
read -s -p 'Type your password: ' pswrd

if [ "$log" = "flo" ] && [ "$pswrd" = "plop" ]; then
    echo
    echo "Well done"
    while true
    do
        echo
        read -p 'Type a commande: ' cmd arg
        case $cmd in
            help | -h ) Help;;
            ls ) List;;
            rm ) RemoveFile $arg;;
            rmd | rmdir ) RemoveDir $arg;;
            about ) About;;
            version | --v | vers ) Version;;
            age ) Age;;
            quit ) Quit;;
            profile ) Profile;;
            passw ) Password;;
            cd ) Goto $arg;;
            pwd ) Where;;
            hour ) Hour;;
            httpget ) Gethttp $arg;;
            smtp ) Mail;;
            open ) Open;;
            rps ) RockPapperScissors;;
            * ) All;;
        esac
    done
else
    echo
    echo "Nope ! You fail";
    echo "Bye Bye !"
    exit 1
fi

