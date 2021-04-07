DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "30° Tube Corner"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_corner30"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_tube_crn30.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "White"
ENT.ShouldPersist = true
-- x pitch, y roll, z is up/down
-- you can not go above 90 or itll break
ENT.ExitAngles = {
	Angle(0,0,180),
	Angle(30,0,0),
}

list.Set("NAKStuntTrack", "tube_corner30", {
	Name = ENT.PrintName,
	Class = ENT.Class,
	MDL = ENT.MDL,
	Type = "Tube",
	ExitAngles = ENT.ExitAngles
})