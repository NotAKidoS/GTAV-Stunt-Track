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
ENT.ColorScheme = "America"
ENT.ShouldPersist = false
ENT.ExitAngle = Angle(0,0,0)  
ENT.InitialBoost = 100

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
		phys:SetVelocity( -modifier * self:GetForward() + phys:GetVelocity() )
	end
end

function ENT:AddDataTables()
	self:NetworkVar( "Float", 0, "BoostModifier", { KeyName = "boostmodifier", Edit = { type = "Float", order = 2, min = 0, max = 350 } } )
	self:SetBoostModifier(self.InitialBoost)
end

list.Set("NAKStuntTrack", "tube_speed", {
	Name = ENT.PrintName,
	Class = ENT.Class,
	MDL = ENT.MDL,
})