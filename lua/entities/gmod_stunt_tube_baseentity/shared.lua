ENT.Type            = "anim"

ENT.PrintName = "Stunt Tube Base"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_baseentity"
ENT.StuntTrack = true
-- ENT.IconOverride -- overrides the spawn menu icon instead of using a png

ENT.Spawnable		= false
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "error.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "White"
ENT.ShouldPersist = false
ENT.ExitAngle = Angle(0,0,0) 
ENT.RenderMode = RENDERGROUP_TRANSLUCENT -- RENDERGROUP_OPAQUE or RENDERGROUP_BOTH

function ENT:OnSpawn()
end
function ENT:OnInitialize()
end
function ENT:OnTick()
end

function ENT:GetPointA()
	return self:GetBonePosition(0)
end
function ENT:GetPointB()
	return self:GetBonePosition(1)
end

function ENT:AddDataTables()
end

function ENT:SetupDataTables()
	if ProxyColor then
		self:NetworkVar( "String", 0, "ColorScheme", 
			{
				KeyName = "colorscheme",
				Edit = { 
					category = "Proxy Colors",
					type = "Combo",
					order = 1,
					--fuck you and your key = value logic
					--and why you out of order? i dont want alphabetical :((
					values = list.Get("NAKStuntColors").Index,
				} 
			} 
		)
		if SERVER then
			self:NetworkVarNotify( "ColorScheme", self.UpdateColorScheme )
			self:SetColorScheme( self.ColorScheme )
		end
	else
		self:NetworkVar( "String", 0, "ProxyColorWarning1", {KeyName="ProxyColorWarning",Edit={category="Proxy Colors",type="string",order=1}} )
		self:NetworkVar( "String", 1, "ProxyColorWarning2", {KeyName="ProxyColorWarning2",Edit={category="Proxy Colors",type="string",order=2}} )
		if SERVER then
			self:SetProxyColorWarning1("GET PROXY COLOR TOOL")
			self:SetProxyColorWarning2("TO SET COLOR SCHEMES!!")
		end
	end
	self:AddDataTables()
end

if ( SERVER ) then
	if ProxyColor then
		function ENT:UpdateColorScheme( vname, vold, vnew )
			if ( vold == vnew ) then return end
			self:SetProxyColor( list.Get("NAKStuntColors").CTable[vnew] )
		end
	end
end