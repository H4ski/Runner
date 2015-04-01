local function EnoughPlayers()

	local plyrs = 0
	
	for k, v in pairs(player.GetAll()) do
	
		if v:IsReady() then
		
			plyrs = plyrs + 1
		
		end
		
	end
	
	if plyrs >= GAMEMODE.ReqPlayers then
		
		return true
		
	end	

	PrintMessage(HUD_PRINTTALK, "Not enough players to start a round.")
	
	return false	
	
end

function CheckRoundStart()

	PrintMessage(HUD_PRINTTALK, "Checking for round.")

	GAMEMODE.RoundState = "WaitingForPlayers"

	if !(EnoughPlayers()) then CheckingForPlayers() return end
	
	if timer.Exists("CheckingPlayers") then
	
		timer.Destroy("CheckingPlayers")
	
	end
	
	StartPreRound()

end

function CheckingForPlayers()

	timer.Create("CheckingPlayers", 10, 0, function()
	
		CheckRoundStart()
	
	end)

end

local function SpawnInPlayers()

	for k, b in pairs(player.GetAll()) do

		if b:IsReady() then
		
			b:Spawn()
		
		end
	end

end

function StartPreRound()

	PrintMessage(HUD_PRINTTALK, "Round will start in "..GAMEMODE.PreRoundTime.." seconds.")
	
	timer.Destroy("PostRound")
	
	SpawnInPlayers()
	
	timer.Create("PreRound", GAMEMODE.PreRoundTime, 1, function()
	
		StartRound()
	
	end)

end

function StartRound()

	GAMEMODE.RoundState = "InRound"
	
	PrintMessage(HUD_PRINTTALK, "Round has started.")

	timer.Create( "Round", GAMEMODE.RoundTime, 1, function() 
	
		CheckRoundEnd() 
	
	end)
	
	PickRunner()
	
	SetUpPlayers()
	
	SpawnInPlayers()

end

local function CleanUpMap()

	game.CleanUpMap()

end

function EndRound()

	GAMEMODE.RoundState = "PostRound"
	
	timer.Destroy("Round")
	timer.Create( "PostRound", GAMEMODE.PostRoundTime, 1, function()

		CleanUpMap()
		CheckRoundStart() 
	
	end)
	
end

local function GetSurvivors()

	local Survs = 0

	for k, v in pairs( player.GetAll()) do
	
		if v.Role == "Survivor" then
			Survs = Survs + 1
		end
	
	end
	
	return Survs
	
end

function CheckRoundEnd()

	if !(GAMEMODE.RoundState == "InRound") then return end

	if GetSurvivors() <= 0 then 

		PrintMessage(HUD_PRINTTALK, "There are no more Survivors./nThe round has ended.")

		EndRound()
		
	else
	
		PrintMessage(HUD_PRINTTALK, "There are Survivors left./nThey can now kill the Runner.")
	
		OverTimeRound()
	
	end

end

function OverTimeRound()

	GAMEMODE.RoundState = "Overtime"
	
	GiveSurvivorsWeapons()

end