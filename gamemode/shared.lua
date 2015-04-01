GM.Name = "Runner"
GM.Author = "BolONYz"
GM.Email = "aNARmYOfBolONYz@hotmail.ca"
GM.Website = "N/A"
//Made with the help of Goature's Tutorial

include("sh_player.lua")

team.SetUp( 0, "Unassigned", Color(0, 0, 255) )
team.SetUp( 1, "Runner", Color(0, 0, 255) )
team.SetUp( 2, "Minions", Color(255, 0, 0) )
team.SetUp( 3, "Survivors", Color(0, 255, 0) )
team.SetUp( 4, "Spectators", Color(0, 0, 0) )

function GM:Initialize()
	self.BaseClass.Initialize( self )
	
	GAMEMODE.RoundState = "WaitingForPlayers"
	GAMEMODE.RoundTime = 		10
	GAMEMODE.PostRoundTime = 	10
	GAMEMODE.PreRoundTime = 	10
	
	GAMEMODE.RunnerWalkSpeed = 	400
	GAMEMODE.RunnerRunSpeed =	700
	GAMEMODE.RunnerJumpPower =	400
	
	GAMEMODE.RunnerWeapons = {
		"weapon_crowbar"
	}
	
	GAMEMODE.RunnerModels = {
		Model("models/player/eli.mdl")
	}
	
	GAMEMODE.SurvivorWeapons = {
	}
	
	GAMEMODE.SurvivorModels = {
		Model("models/player/Group01/Male_01.mdl"),
		Model("models/player/Group01/Male_02.mdl"),
		Model("models/player/Group01/Male_03.mdl"),
		Model("models/player/Group01/Male_04.mdl"),
		Model("models/player/Group01/Male_05.mdl"),
		Model("models/player/Group01/Male_06.mdl"),
		Model("models/player/Group01/Male_07.mdl"),
		Model("models/player/Group01/Male_08.mdl"),
		Model("models/player/Group01/Male_09.mdl")
	}
	
	GAMEMODE.ValidRoles = {
		"runner",
		"minion",
		"survivor",
		"spectator",
		"unassigned"
	}
	
	GAMEMODE.ReqPlayers = 1
	
	GAMEMODE.RunnerWeapons = {
	
	}
end