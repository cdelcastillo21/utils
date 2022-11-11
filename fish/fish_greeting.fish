function fish_greeting

    if type -q lolcat 
        if type -q figlet 
            figlet -f (figlet -l | shuf -n 1) (hostname | awk '{print $1}' FS='.') | lolcat -a -d 1 -F 0.5
        end
        if type -q cowsay
            cowsay -r (fortune) | lolcat 
        end
    end

end
