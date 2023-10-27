#!/bin/bash

# Welcome message
cat << "EOF"

NovaAbramson's
    ____  __          __  ___         _____        __   
   / __ \/ /_        /  |/  /_  __   /__  /  _____/ /_  
  / / / / __ \______/ /|_/ / / / /_____/ /  / ___/ __ \ 
 / /_/ / / / /_____/ /  / / /_/ /_____/ /__(__  ) / / / 
 \____/_/ /_/     /_/  /_/\__, /     /____/____/_/ /_/  
                         /____/                         
             _          __       ____       
            (_)__  ___ / /____ _/ / /__ ____
           / / _ \(_-</ __/ _ `/ / / -_) __/
          /_/_//_/___/\__/\_,_/_/_/\__/_/    
EOF

echo " "
echo " "
echo " "

# Package manager selection
echo "1. apt"
echo "2. dnf"
echo "3. yum"
echo "4. pacman"
read -p "Choose your package manager (enter the number): " package_manager

case "$package_manager" in
    1)
        sudo apt update && sudo apt install ansible bc passwd snapd -y
        package_manager_name="apt"
        ;;
    2)
        sudo dnf update && sudo dnf install ansible bc util-linux-user snapd -y
        sudo ln -s /var/lib/snapd/snap /snap
        package_manager_name="dnf"
        ;;
    3)
        sudo yum update && sudo yum install ansible bc util-linux-ng snapd -y
        sudo systemctl enable --now snapd.socket
        sudo ln -s /var/lib/snapd/snap /snap
        package_manager_name="yum"
        ;;
    4)
        sudo pacman -Sy ansible-core ansible bc util-linux --noconfirm
        git clone https://aur.archlinux.org/snapd.git
        cd snapd
        makepkg -si
        cd ..
        sudo systemctl enable --now snapd.socket
        sudo ln -s /var/lib/snapd/snap /snap
        package_manager_name="pacman"
        ;;
    *)
        read -p "Enter one of THE NUMBERS, you idiot! c: " package_manager
        ;;
esac

# Setting up username and password
echo ""
echo ""
echo "Please enter your username and password to be inserted in playbooks"
read -p "Username: " name
read -p "Password: " password

echo ""
echo ""

# Setting up installation mode and path to the playbook(s)
echo "1. Install just Oh-my-zsh"
echo "2. Install Oh-my-zsh with Powerlever10k"
read -p "Choose your installation mode (enter the number): " installation_mode

echo ""
echo ""

# They don't need a setup, it's just fact
belov=""
evsikov=""
evsikov_number=$(awk 'BEGIN {srand(); print rand()}')
belov_number=$(awk 'BEGIN {srand(); print rand()}')
if (( $(echo "$belov_number < 1" | bc -l) )); then
    belov="urod"
fi
if (( $(echo "$evsikov_number < 1" | bc -l) )); then
    evsikov="pidor"
fi

# Replacing vars in playbooks
echo "Тип переменные отработали, окда?"
# if [ "$installation_mode" -eq "1" ]; then
#     sed -i "s/your_username/$name/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/your_password/$password/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/your_manager/$package_manager_name/g" ./playbooks/Oh-my-zsh_install.yml
# fi
# if [ "$installation_mode" -eq "2" ]; then
#     sed -i "s/your_username/$name/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/your_password/$password/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/your_manager/$package_manager_name/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/your_username/$name/g" ./playbooks/P10k_install.yml
#     sed -i "s/your_password/$password/g" ./playbooks/P10k_install.yml
#     sed -i "s/your_manager/$package_manager_name/g" ./playbooks/P10k_install.yml
# fi

echo "User data replace succeed! Starting playbook(s)..."

echo ""
echo ""

# Runing playbooks
if [ "$installation_mode" -eq "1" ]; then
    echo "Тип плейбук отработал, окда?"
    #sudo ansible-playbook -c local -i localhost, ./playbooks/Oh-my-zsh_install.yml
fi
if [ "$installation_mode" -eq "2" ]; then
    echo "Тип плейбуки отработали, окда?"
    #sudo ansible-playbook -c local -i localhost, ./playbooks/Oh-my-zsh_install.yml
    #sudo ansible-playbook -c local -i localhost, ./playbooks/P10k_install.yml
fi

# Replacing back vars in playbook
echo "Тип переменные обратно отработали, окда?"
# if [ "$installation_mode" -eq "1" ]; then
#     sed -i "s/$name/your_username/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/$password/your_password/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/$package_manager_name/your_manager/g" ./playbooks/Oh-my-zsh_install.yml
# fi
# if [ "$installation_mode" -eq "2" ]; then
#     sed -i "s/$name/your_username/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/$password/your_password/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/$package_manager_name/your_manager/g" ./playbooks/Oh-my-zsh_install.yml
#     sed -i "s/$name/your_username/g" ./playbooks/P10k_install.yml
#     sed -i "s/$password/your_password/g" ./playbooks/P10k_install.yml
#     sed -i "s/$package_manager_name/your_manager/g" ./playbooks/P10k_install.yml
# fi

echo "Done, enjoy your shell!"
echo " "

# Restarting the shell
#source /home/abramson/.zshrc
