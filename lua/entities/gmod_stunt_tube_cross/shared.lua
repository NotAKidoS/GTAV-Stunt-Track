DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "Cross Section Tube"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_cross"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_tube_cross_2.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "White"
ENT.ShouldPersist = true
-- x pitch, y roll, z is up/down
-- you can not go above 90 or itll break
-- this now needs to be set for every bone on the model
ENT.ExitAngles = {
	Angle(0,0,180),
	Angle(0,0,0),
	Angle(0,0,90),
	Angle(0,0,-90),
}

list.Set("NAKStuntTrack", "tube_cross", {
	Name = ENT.PrintName,
	Class = ENT.Class,
	MDL = ENT.MDL,
	Type = "Tube",
	ExitAngles = ENT.ExitAngles
})