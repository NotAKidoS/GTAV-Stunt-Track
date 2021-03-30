AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName )
	if not tr.Hit then return end

	local pos
	local ang
	local ent = tr.Entity
	if tr.Entity.Class == "gmod_stunt_tube_baseentity" then
		local angle = ent.ExitAngle
		pos = ent:GetPointB()
		ang = ent:GetAngles()
	else
		pos = tr.HitPos + (self.SpawnOffset or Vector(0,0,0))
		ang = ply:EyeAngles()
		ang.pitch = 0
		ang.roll = 0
		ang.yaw = ang.yaw + 180 + (self.SpawnAngleOffset and self.SpawnAngleOffset or 0)
	end
 
	local self = ents.Create( ClassName )
	self:SetPos( pos )
	self:SetAngles( ang )
	self:Spawn()
	self:Activate()
	
	if tr.Entity.Class == "gmod_stunt_tube_baseentity" then
		local pls = self:GetAngles()
		pls:RotateAroundAxis( self:GetRight(), -ent.ExitAngle.x )
		self:SetAngles(pls)

		local pls = self:GetAngles()
		pls:RotateAroundAxis( self:GetForward(), -ent.ExitAngle.y )
		self:SetAngles(pls)
		
		local pls = self:GetAngles()
		pls:RotateAroundAxis( self:GetUp(), -ent.ExitAngle.z )
		self:SetAngles(pls)
	end

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