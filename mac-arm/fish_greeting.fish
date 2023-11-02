function fish_greeting

    function default_greeting
        if not type -q lolcat 
           alias lolcat="echo"
        end

        if type -q figlet 
            figlet --width 80 -n -f (figlet -l | shuf -n 1) (hostname | awk '{print $1}' FS='.') | lolcat -a -d 1 -F 0.5
        end

        if type -q cowsay
            cowsay -w 80 -r (fortune) | lolcat 
        end

        if type -q neofetch
            neofetch
        end

        if type -q duf
            duf -theme dark --width 80 --only-mp /,/System/Volumes/Data
        end
        if type -q dust
            dust -z 500MB -i -n 10 -d 5 -w 80 $WORK 2> /dev/null
        end
    end


    if type -q tmux
        if status is-interactive
            default_greeting
	end
        if status is-interactive
    	and not set -q TMUX
    	    set tmux_res (tmux ls 2> /dev/null)
    	    set first_session (string split : $tmux_res | head -n 1)
	    switch $first_session
                case ''
    	            echo "No server running. Name session (default:0):" | lolcat 
    	    	    read -l -P '' value
		    switch $value
		        case ''
		            tmux
		        case '*'
	                    tmux new-session -s $value
		    end
		case '*'
	 	    set test (string join '\n' "======== Active TMUX Sessions ========" \
		    		     $tmux_res \
				     "Choose an active session or start a new one:" \
				     "[<name-of-session>/Y(defaults to first session)/N(new session-DEFAULT)]" \
				     "")
		    printf $test | lolcat
    	            read -l -P '' value
    	            switch $value
                        case ''
	                    echo "value '$value'"
	                    tmux
    	                case 'N'
	                    tmux
	                    echo "value '$value'"
    	                case 'Y'
    	                    set first_session (string split : $tmux_res | head -n 1)
	                    echo "Switching to first session $first_session"
    	                    tmux a -t $first_session
    	                case '*'
	                    echo "Attaching or creating session $value"
    	                    tmux new-session -A -s $value
	            end
	    end
    	end
    else
        if status is-interactive
            default_greeting
        end
    end

end
