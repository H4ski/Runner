AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

AddCSLuaFile("sh_player.lua")
AddCSLuaFile("sv_rounds.lua")
AddCSLuaFile("sv_functions.lua")

include("sh_player.lua")
include("sv_rounds.lua")
include("sv_functions.lua")


function GM:PlayerConnect( name, ip )
	
end

function GM:PlayerInitialSpawn( ply )
	
	CheckRoundStart()
	
end

function GM:PlayerSpawn( ply )
	
end

function GM:PlayerDeath( victime, inflictor, attacker )

	CheckRoundEnd()

end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print("Player: " .. ply:Nick() .. ", has gotten authed.")

end

function GM:PlayerDisconnected( ply )

end

concommand.Add("RR_SetSpectator", function( ply )

	ply:SetSpectator()

end)