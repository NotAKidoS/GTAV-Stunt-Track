DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "End Cap Tube"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_end"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_tube_end.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "White"
ENT.ShouldPersist = true

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