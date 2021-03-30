DEFINE_BASECLASS("gmod_stunt_tube_baseentity")

ENT.PrintName = "45° Tube Corner"
ENT.Author = "NotAKid"
ENT.Information = "Stunt Tubes From GTAV"
ENT.Category = "GTAV Stunt Props"

ENT.Spawnable		= true
ENT.AdminSpawnable  = false
ENT.Editable = true

ENT.MDL = "models/notakid/gtav/stunt_tubes/stunt_tube_crn45.mdl"
ENT.Mass = 10000
ENT.ColorScheme = "America"
ENT.ShouldPersist = true
-- x pitch, y roll, z is up/down
-- you can not go above 90 or itll break
ENT.ExitAngle = Angle(45,0,0)