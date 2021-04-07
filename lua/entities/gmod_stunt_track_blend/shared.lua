DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "Track-Tube Blend"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Track From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_track_blend"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tracks/stunt_track_tubestart01.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "White"
ENT.ShouldPersist = true
ENT.ExitAngles = {
	Angle(0,0,180),
	Angle(0,0,0),
}
ENT.InitialBoost = 100

list.Set("NAKStuntTrack", "track_tubestart01", {
	Name = ENT.PrintName,
	Class = ENT.Class,
	MDL = ENT.MDL,
	Type = "Track",
	ExitAngles = ENT.ExitAngles
})