AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

--aligns the tube with another tube
function ENT:AlignAtEnd(ent, nearpos, rr)
	local pos = ent:GetBonePosition(1)
	local ang = ent:GetAngles()
	local rot = rr and rr or 0
	local exitang = ent.ExitAngles[2]

	--use the nearest bones exit angles if we have the variable
	if isvector(nearpos) then
		for i=1, ent:GetBoneCount() do
			local bpos = ent:GetBonePosition(i-1)
			--if this bone is closer than our default (PointB), then set it as the exit angles
			if nearpos:DistToSqr(bpos) < nearpos:DistToSqr(pos) then
				pos = bpos
				exitang = ent.ExitAngles[i]
			end
		end
	end

	self:SetAngles(ent:GetAngles())
	
	local pls = self:GetAngles()
	pls:RotateAroundAxis( self:GetRight(), -exitang.x )
	self:SetAngles(pls)

	pls = self:GetAngles()
	pls:RotateAroundAxis( self:GetForward(), -exitang.y + rot )
	self:SetAngles(pls)
	
	pls = self:GetAngles()
	pls:RotateAroundAxis( self:GetUp(), -exitang.z )
	self:SetAngles(pls)
	
	--need to call again as RotateAroundAxis refuses to allow the prop to clip into anything
	timer.Simple( 0, function() if IsValid(self) then self:SetPos(pos) end end )
end

function ENT:SpawnFunction( ply, tr, ClassName )
	if not tr.Hit then return end

	local ent = tr.Entity
	local hitpos = tr.HitPos
	local self = ents.Create( ClassName )
	
	--align the tube with its parent tube, or just to the players eyes
	if ent.StuntTrack then
		self:AlignAtEnd(ent, hitpos)
	else 
		local pos = hitpos + (self.SpawnOffset or Vector(0,0,0))
		local ang = ply:EyeAngles()
		ang.pitch = 0
		ang.roll = 0
		ang.yaw = ang.yaw + 180 + (self.SpawnAngleOffset and self.SpawnAngleOffset or 0)
		self:SetPos( pos )
		self:SetAngles( ang )
	end

	self:Spawn()
	self:Activate()
 
	self:OnSpawn()
	return self
end

function ENT:Initialize()
	self:SetModel( self.MDL )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetRenderMode( self.RenderMode )
	self:AddFlags( FL_OBJECT )
	self:SetSpawnEffect(true)
	
	local PObj = self:GetPhysicsObject()
	if not IsValid( PObj ) then 
		self:Remove()
		return
	end

	PObj:EnableMotion( false )
	PObj:SetMass( self.Mass )
	self:SetPersistent( self.ShouldPersist )
	
	self:OnInitialize()
end

function ENT:Think()
	self:OnTick()
	self:NextThink( CurTime() + 0.2 )
	return true
end