on run {input, parameters}
	tell application "iTunes"
 	 	if current track is not loved then
    			set loved of current track to not loved of current track
		end if
	end tell

	return input
end run
