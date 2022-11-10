function fish_greeting
  figlet -f (figlet -l | shuf -n 1) (hostname | awk '{print $1}' FS='.') | lolcat -a -d 1 -F 0.5
  cowsay -r (fortune) | lolcat 
end
