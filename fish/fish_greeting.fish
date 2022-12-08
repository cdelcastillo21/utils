function fish_greeting

    if type -q lolcat 
        if type -q figlet 
            figlet -n -f (figlet -l | shuf -n 1) (hostname | awk '{print $1}' FS='.') | lolcat -a -d 1 -F 0.5
        end
        if type -q cowsay
            cowsay -r (fortune) | lolcat 
        end
    end

    if type -q neofetch
        neofetch
    end

    if type -q duf
	echo "Disk info: " | lolcat
        duf -only-mp /etc/hosts
    end
    if type -q dust
	echo "Home Dir Info: " | lolcat
	dust -n 5 -d 1 -w 80 | lolcat
    end
end
