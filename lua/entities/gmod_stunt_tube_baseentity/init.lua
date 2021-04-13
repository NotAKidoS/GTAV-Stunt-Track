AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:AlignToTrack(ParentTrack, HitPos, Roll)
	--get the track we are attaching to and its master list
	local AttachList = list.Get("NAKStuntTrack")[ParentTrack:GetClass()]

	--set up some default vars, by default we use PointB / our second bone
	local AddRot = Roll and Roll or 0 --roll to add to the track
	local ExitPos = ParentTrack:GetBonePosition(1) --exit position to snap to, default to PointB
	local ExitDir = AttachList.ExitPoints[2][2] --exit direction for applying roll
	local ExitAngle = AttachList.ExitPoints[2][1] --exit angle for aligning the track
	
	--find the nearest bone to HitPos and use its ExitPoints
	if isvector(HitPos) then
		for i=1, ParentTrack:GetBoneCount() do
			local BonePos = ParentTrack:GetBonePosition(i-1)
			if HitPos:DistToSqr(BonePos) < HitPos:DistToSqr(ExitPos) then
				ExitPos = BonePos
				ExitDir = AttachList.ExitPoints[i][2]
				ExitAngle = AttachList.ExitPoints[i][1]
			end
		end
	end

	-- do da stuffs with the info we collected above
	self:SetAngles(ParentTrack:GetAngles())
	local AngleAlign = self:GetAngles()
	AngleAlign:RotateAroundAxis( self:GetRight(), -ExitAngle.x + (AddRot * ExitDir.x) )
	self:SetAngles(AngleAlign)

	AngleAlign = self:GetAngles()
	AngleAlign:RotateAroundAxis( self:GetForward(), -ExitAngle.y + (AddRot * ExitDir.y) )
	self:SetAngles(AngleAlign)

	AngleAlign = self:GetAngles()
	AngleAlign:RotateAroundAxis( self:GetUp(), -ExitAngle.z + (AddRot * ExitDir.z) )
	self:SetAngles(AngleAlign)

	--need to call again as RotateAroundAxis refuses to allow the prop to clip into anything
	timer.Simple( 0, function() if IsValid(self) then self:SetPos(ExitPos) end end )
end

function ENT:SpawnFunction( ply, tr, ClassName )
	if not tr.Hit then return end

	local ent = tr.Entity
	local hitpos = tr.HitPos
	local self = ents.Create( ClassName )
	
	--align the tube with its parent tube, or just to the players eyes
	if ent.StuntTrack then
		self:AlignToTrack(ent, hitpos)
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