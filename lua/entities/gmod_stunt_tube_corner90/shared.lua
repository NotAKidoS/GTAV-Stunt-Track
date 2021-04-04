DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "90° Tube Corner"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_corner90"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_tube_crn90.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "America"
ENT.ShouldPersist = true
ENT.ExitAngle = Angle(90,0,0) 

list.Set("NAKStuntTrack", "tube_corner90", {
	Name = ENT.PrintName,
	Class = ENT.Class,
	MDL = ENT.MDL,
})