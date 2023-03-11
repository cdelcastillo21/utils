function fish_greeting

    function default_greeting
        if not type -q lolcat 
           alias lolcat="echo"
        end

        if type -q figlet 
            figlet --width 80 -n -f (figlet -l | shuf -n 1) (hostname | awk '{print $1}' FS='.') | lolcat -a -d 1 -F 0.5
        end

        if type -q cowsay
            cowsay -w 80 -r (fortune ~/.config/fish/fortunes.txt) | lolcat 
        end

        if type -q neofetch
            neofetch
        end

        if type -q dust
            dust -z 500MB -i -n 10 -d 5 -w 80 $WORK 2> /dev/null
        end
    end

    if status is-interactive
	default_greeting
    end

end
