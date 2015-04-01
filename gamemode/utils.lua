

function timer.Round( name, delay, func )

	timer.Create( name, delay, 1, func )

end

function PrintHUDMsg( str )

	PrintMessage(HUD_PRINTTALK, str)

end