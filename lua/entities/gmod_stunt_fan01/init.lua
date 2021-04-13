AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnInitialize()
	self:PhysicsInitShadow( true, true )
	timer.Simple( 0, function() 
		if IsValid(self) then
			self.OriginPos = self:GetPos()
			self.OriginAngles = self:GetAngles()
			self.OriginDir = self:GetForward()
			self.FanRot = 0
		end
	end )
end

function ENT:Think( entity )
	if !self.FanRot then return true end

	--increase speed until max
	self.FanRot = math.Clamp(0, self:GetSpeed(), self.FanRot + 0.1)

	--calculate the rotation
	self.OriginAngles:RotateAroundAxis( self.OriginDir, self.FanRot )

	--set the new rotation
	local phys = self:GetPhysicsObject()
	phys:UpdateShadow(self.OriginPos, self.OriginAngles, 0)

	--call again now
	self:NextThink( CurTime() )
	return true
end