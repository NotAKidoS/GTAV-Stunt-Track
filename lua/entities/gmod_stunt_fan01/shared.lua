DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "Fan 01"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_fan01"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_fan01.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "White"
ENT.ShouldPersist = true

list.Set("NAKStuntTrack", ENT.Class, {
	Name = ENT.PrintName,
	MDL = ENT.MDL,
	Class = ENT.Class,
	Type = "Fan",
})

function ENT:AddDataTables()
	self:NetworkVar( "Float", 0, "Speed", { KeyName = "speed", Edit = { type = "Float", order = 2, min = 0, max = 20 } } )
	self:SetSpeed(1)
end