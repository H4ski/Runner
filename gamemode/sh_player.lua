local meta = FindMetaTable("Player")

function meta:IsReady()

	if !(self:IsValid()) then return false end
	if self:IsSpectator() then return false end
	
	return true

end

function meta:GetRole()

	return self:GetNWString( "RRole", "unassigned" )

end

function meta:SetRole( role )

	if !(table.HasValue( GAMEMODE.ValidRoles, role )) then return end
	
	self:SetNWString( "RRole", role )

end


function meta:IsSpectator()

	if self:GetRole() == "spectator" then return true end

	return false

end

function meta:SetSpectator()

	self:SetRole("spectator")
	
	self:Spectate( OBS_MODE_ROAMING )
	self:KillSilent()

end

function meta:UnSetSpectator()

	self:SetRole("unassigned")
	
	self:UnSpectate()
	self:KillSilent()

end