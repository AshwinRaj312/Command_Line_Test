<<doc
Name : Ashwin Raj K
Date : 3/3/23
Description : Project to create create a test portal
doc
echo  "1.signup"
echo  "2.signin"
echo  "3.exit"
read -p "Enter options:  " entry
case $entry in
    1)
        arr=(`cat user.csv`)
        option=y
        option_2=y
        while [ $option = "y" ]
        do
            flag=0
            read -p "Enter the name : " name
            for i in ${arr[@]}
            do
                if [ $name = $i ]
                then
                    echo "name already exists"        
                    flag=1         
                fi
            done    
            if [ $flag -eq 0 ]
            then
                option=n
                echo $name >> user.csv
                while [ $option_2 = "y" ]
                do
                    read -p "enter the password : " -s password   
                    echo
                    read -p "confirm password : " -s con_pass
                    echo
                    if [ $password = $con_pass ]
                    then
                        echo $password >> password.csv
                        echo "Signup successful :))"
                        option_2=n
                    else
                        echo "password doesnot match re-enter the password"
                        option_2=y
                    fi
                done
            fi
        done
        ;;
    2)    
        userarr=(`cat user.csv`)
        passwd=(`cat password.csv`)
        len=${#userarr[@]}
        option_3=y
        option_4=y
        signin_flag=0
        count=0
        l=0
        while [ $option_3 = "y" ]
        do
            read -p "Enter the name : " user
            for i in ${userarr[@]}
            do
                count=`expr $count + 1` 
                if [ $user = $i ]
                then
                    option_3=n
                    signin_flag=1
                    x=$((count-1)) 
                fi
            done
            if [ $signin_flag = 1 ]
            then
                    while [ $option_4 = "y" ]
                    do
                        read -p "Enter password : " -s pass
                        if [ $pass = ${passwd[x]} ]
                        then
                            echo "signed in"
                            option_4=n
                            echo "Enter your choice"
                            echo "a.take test"
                            echo "b.evaluate"
                            echo "c.exit"
                            read entry2
                            case $entry2 in
                                a)
                                    line=`cat questionbank.txt | wc -l`
                                    echo "                                                          Linux Test                                      "
                                    echo
                                    echo
                                    for i in `seq 5 5 $line`
                                    do
                                        head -$i questionbank.txt | tail -5
                                        for j in `seq 10 -1 1`
                                        do
                                            echo -ne "\rEnter your choice : $j "
                                            read -t 1 choice
                                            if [ -n "$choice" ]
                                            then
                                                echo $choice >> student_ans.txt
                                                break
                                            else
                                                choice=e
                                            fi    
                                        done       
                                    done
                                    ;;                
                                b)
                                                        
                                    stuArr=(`cat student_ans.txt`)
                                    keyArr=(`cat answerkey.txt`)
                                    line=(`cat questionbank.txt | wc -l`)
                                    score=0
                                    for i in `seq 1 1 10`
                                    do
                                        if [ "${stuArr[i]}" = "${keyArr[i]}" ]
                                        then 
                                            score=$(($score+1))
                                        fi
                                    done
                                    for j in `seq 5 5 $line`
                                    do
                                        l=$(($l+1))
                                        head -$j questionbank.txt | tail -5
                                            
                                    done
                                    
                                    echo "Your score is $score/10"                                   
                                    ;;
                                c)
                                    exit
                                    ;;
                                *)
                                    echo "invalid input"
                                    exit
                            esac
                        else
                            echo "Wrong password"
                            read -p "enter 'y' to retry : " retry
                            if [ $retry = "y" ]
                            then
                                option_4=y
                            else
                                option_4=n
                                option_3=n
                            fi
                        fi
                    done                  
            else
                echo "Username unavailable - Please Signup a new account"
            fi 
        done
        ;;
    3)
        exit
        ;;
    *)
        echo "Invalid input"    
        exit
esac        
