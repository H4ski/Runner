
function PickRunner()

	if GAMEMODE.CurrentRunner then
		DemoteRunner( GAMEMODE.CurrentRunner )
	end

	local luckply = table.Random( player.GetAll() )
	
	if !(luckply:IsReady()) then return PickRunner() end
	
	GAMEMODE.CurrentRunner = luckply
	
	luckply:SetRole("runner")
	
	luckply:SetTeam(1)
	
	PrintMessage(HUD_PRINTTALK, "The Runner is "..luckply:Name()..".")
	
	return luckply

end

local function GenerateInitModelsWeapons()

	for id, ply in pairs( player.GetAll()) do
	
		if ply == GAMEMODE.CurrentRunner then
		
			ply:SetModel( table.Random( GAMEMODE.RunnerModels ) )
			ply:Give("weapon_crowbar")
			for k, v in pairs( GAMEMODE.RunnerWeapons ) do
			
				print("YOYOYOYOYOY")
				
				ply:Give(v)
			
			end
		
		elseif ply:GetRole() == "survivor" then
		
			ply:SetModel( table.Random( GAMEMODE.SurvivorModels ) )
			
			for k, v in pairs( GAMEMODE.SurvivorsWeapons ) do
			
				ply:Give(v)
			
			end	
			
		end
	
	end

end

function SetUpPlayers()

	for k, v in pairs(player.GetAll()) do
		if v:IsReady() then
		
			if v == GAMEMODE.CurrentRunner then
				SetUpRunnerClass( v, true )
			else
				
				v:SetRole("survivor")
				V:SetTeam(3)
			
			end
			
		end
	end
	
	GenerateInitModelsWeapons()

end

function SetUpRunnerClass( ply, bool )

	if bool then
	
		ply:SetWalkSpeed(GAMEMODE.RunnerWalkSpeed)
		ply:SetRunSpeed(GAMEMODE.RunnerRunSpeed)
		ply:SetJumpPower(GAMEMODE.RunnerJumpPower)
	
	else
	
		ply:SetWalkSpeed(200)
		ply:SetRunSpeed(400)
		ply:SetJumpPower(200)
		ply:StripWeapons()
	
	end

end

function DemoteRunner( ply )

	if !(ply == GAMEMODE.CurrentRunner) then return end

	SetUpRunnerClass( ply, false)
	
	GAMEMODE.PastRunner = ply
	
end

function TurnIntoMinion( ply )

	ply:SetRole("minion")
	
	ply:SetTeam(2)
	
	ply:CreateRagdoll()
	
	ply:SetHealth( 100 )
	
	table.insert(GAMEMODE.Minions, ply)

end

function SlowRunner( ply )

	local run = ply:GetRunSpeed()
	
	ply:SetRunSpeed( run - 10 )
	
	timer.Simple( 5, function() ply:SetRunSpeed( ply:GetRunSpeed() + 10 ) end )

end

hook.Add("PlayerShouldTakeDamage", "SlowMinionNonSense", function(ply, attacker)

	if !(attacker:IsPlayer()) then return true end

	if ply:GetRole() == "survivor" then
	
		if attacker == GAMEMODE.CurrentRunner then
			
			TurnIntoMinion( ply )
			
			return false
		
		end
	
	end
	
	if ply == GAMEMODE.CurrentRunner then
	
		if !(attacker:GetRole() == "attacker") then return true end
	
		SlowRunner( ply )
	
		return true
	
	end

end)