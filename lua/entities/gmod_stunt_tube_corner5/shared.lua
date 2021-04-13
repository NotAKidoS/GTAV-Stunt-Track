DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "5° Tube Corner"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_corner5"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_tube_crn5.mdl"
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
		{Angle(5,0,0), Vector(0,1,0)},
	}
})