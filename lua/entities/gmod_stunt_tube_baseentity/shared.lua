ENT.Type            = "anim"

ENT.PrintName = "Stunt Tube Base"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_baseentity"

ENT.Spawnable		= false
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "error.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "America"
ENT.ShouldPersist = false
ENT.ExitAngle = Angle(0,0,0) 
ENT.RenderMode = RENDERGROUP_TRANSLUCENT -- RENDERGROUP_OPAQUE or RENDERGROUP_BOTH

--[[
	the embeded textures for the models in OpenIV are the colors defined as 1x1 pixels
	so these colors are ripped directly from the game
]]--

ENT.ColorSchemeIndex = {
	America = "America",
	Red = "Red",
	Blue = "Blue",
	Purple = "Purple",
	Black = "Black",
	White = "White",
	Grey = "Grey",
	Gold = "Gold",
	Orange = "Orange",
	Green = "Green",
	Pink = "Pink",
	Race = "Race",
	BlackYellow = "BlackYellow",
	OrangeBlue = "OrangeBlue",
	GreenYellow = "GreenYellow",
	PinkGrey = "PinkGrey",
}
ENT.ColorSchemeTable = {
	America = {
		Color(47,75,126),
		Color(170,43,68),
		Color(238,238,238),
		Color(249,249,249),
	},
	Red = { -- alpha is 238
		Color(227,33,41),
		Color(227,33,41),
		Color(227,33,41),
		Color(227,33,41),
	},
	Blue = {
		Color(30,141,214),
		Color(30,141,214),
		Color(30,141,214),
		Color(30,141,214),
	},
	Purple = {
		Color(99,73,115),
		Color(151,29,238),
		Color(99,73,115),
		Color(151,29,238),
	},
	Black = {
		Color(50,50,50),
		Color(50,50,50),
		Color(50,50,50),
		Color(50,50,50),
	},
	White = {
		Color(249,249,249),
		Color(249,249,249),
		Color(249,249,249),
		Color(249,249,249),
	},
	Grey = {
		Color(117,117,117),
		Color(117,117,117),
		Color(117,117,117),
		Color(117,117,117),
	},
	Gold = {
		Color(171,142,68),
		Color(241,209,48),
		Color(171,142,68),
		Color(241,209,48),
	},
	Orange = {
		Color(255,131,0),
		Color(255,131,0),
		Color(255,131,0),
		Color(255,131,0),
	},
	Green = {
		Color(71,139,55),
		Color(71,139,55),
		Color(71,139,55),
		Color(71,139,55),
	},
	Pink = {
		Color(234,11,132),
		Color(234,11,132),
		Color(234,11,132),
		Color(234,11,132),
	},
	Race = {
		Color(227,33,41),
		Color(0,76,148),
		Color(227,33,41),
		Color(30,141,214),
	},
	BlackYellow = {
		Color(50,50,50),
		Color(241,209,48),
		Color(50,50,50),
		Color(241,209,48),
	},
	OrangeBlue = {
		Color(255,106,36),
		Color(100,145,179),
		Color(255,106,36),
		Color(100,145,179),
	},
	GreenYellow = { -- alpha is 238
		Color(10,68,41),
		Color(238,172,46),
		Color(10,68,41),
		Color(238,172,46),
	},
	PinkGrey = { -- alpha is 238
		Color(234,11,132),
		Color(117,117,117),
		Color(234,11,132),
		Color(117,117,117),
	},
}

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
					values = self.ColorSchemeIndex,
				} 
			} 
		)
		
		if ( SERVER ) then
			self:NetworkVarNotify( "ColorScheme", self.UpdateColorScheme )
			self:SetColorScheme( self.ColorScheme )
		end
	end
end

if ( SERVER ) then
	if ProxyColor then
		function ENT:UpdateColorScheme( vname, vold, vnew )
			if ( vold == vnew ) then return end
			self:SetProxyColor( self.ColorSchemeTable[vnew] )
		end
	end
end