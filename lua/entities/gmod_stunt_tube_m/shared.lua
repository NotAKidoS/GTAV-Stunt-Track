DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "Medium Tube"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_tube_m"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_tube_m.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "White"
ENT.ShouldPersist = true
-- x pitch, y roll, z is up/down
-- you can not go above 90 or itll break
ENT.ExitAngles = {
	Angle(0,0,180),
	Angle(0,0,0),
}

list.Set("NAKStuntTrack", "tube_m", {
	Name = ENT.PrintName,
	Class = ENT.Class,
	MDL = ENT.MDL,
	Type = "Tube",
	ExitAngles = ENT.ExitAngles
})