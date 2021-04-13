DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "Track-Tube Blend"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Track From GTAV"
ENT.Category = "GTAV Stunt Props"
ENT.Class = "gmod_stunt_track_blendtube"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tracks/stunt_track_blendtube.mdl"
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