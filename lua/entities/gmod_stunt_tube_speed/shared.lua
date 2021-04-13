DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "Speed Tube"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_speed"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_tube_speed.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "White"
ENT.ShouldPersist = true
ENT.InitialBoost = 50000

function ENT:OnSpawn()
	self:SetTrigger(true) --to enable StartTouch()
end

function ENT:StartTouch(obj)
	local modifier = self:GetBoostModifier()
	
	local phys
	if obj:GetClass() == "gmod_sent_vehicle_fphysics_wheel" then
		local base = obj:GetBaseEnt()
		phys = base:GetPhysicsObject()
	else
		phys = obj:GetPhysicsObject()
	end
	
	if IsValid(phys) then
		-- phys:SetVelocity( -modifier * self:GetForward() + phys:GetVelocity() ) 	--attempt 1
		phys:ApplyForceCenter( -modifier * self:GetForward() )	--attempt 2
	end
end

function ENT:AddDataTables()
	self:NetworkVar( "Float", 0, "BoostModifier", { KeyName = "boostmodifier", Edit = { type = "Float", order = 2, min = 0, max = 80000 } } )
	self:SetBoostModifier(self.InitialBoost)
end

list.Set("NAKStuntTrack", ENT.Class, {
	Name = ENT.PrintName,
	MDL = ENT.MDL,
	Class = ENT.Class,
	Type = "Tube",
	ExitPoints = {
		{Angle(0,0,180), Vector(0,1,0)},
		{Angle(0,0,0), Vector(0,1,0)},
	}
})