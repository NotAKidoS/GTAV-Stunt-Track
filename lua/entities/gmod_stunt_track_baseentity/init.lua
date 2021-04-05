AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

--aligns the tube with another tube
function ENT:AlignWithTube(ent, rr)
	local angle = ent.ExitAngle
	local pos = ent:GetPointB()
	local ang = ent:GetAngles()
	local rot = rr and rr or 0
	
	self:SetAngles(ent:GetAngles())
	
	local pls = self:GetAngles()
	pls:RotateAroundAxis( self:GetRight(), -ent.ExitAngle.x )
	self:SetAngles(pls)

	pls = self:GetAngles()
	pls:RotateAroundAxis( self:GetForward(), -ent.ExitAngle.y + rot )
	self:SetAngles(pls)
	
	pls = self:GetAngles()
	pls:RotateAroundAxis( self:GetUp(), -ent.ExitAngle.z )
	self:SetAngles(pls)
	
	--need to call again as RotateAroundAxis refuses to allow the prop to clip into anything
	timer.Simple( 0, function() if IsValid(self) then self:SetPos(pos) end end )
end

function ENT:SpawnFunction( ply, tr, ClassName )
	if not tr.Hit then return end

	local ent = tr.Entity
	
	local self = ents.Create( ClassName )
	
	--align the tube with its parent tube, or just to the players eyes
	if ent.StuntTrack then
		self:AlignWithTube(ent)
	else 
		local pos = tr.HitPos + (self.SpawnOffset or Vector(0,0,0))
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