--[[
	the embeded textures for the models in OpenIV are the colors defined as 1x1 pixels
	so these colors are ripped directly from the game
]]

if CLIENT then
	concommand.Add( "nak_rebuild_spawnicons", function( ply, cmd, args, str )
		local pxyclr = list.Get("NAKStuntColors").Index[args[1]] and list.Get("NAKStuntColors").Index[args[1]] or "America"
		
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 438, 700 )
		frame:Center()
		frame:MakePopup()
		
		local liist = vgui.Create("DPanelList", frame)
		liist:SetHeight(680)
		liist:SetPadding(10)
		liist:SetSpacing(10)
		liist:EnableVerticalScrollbar()
		liist:Dock(TOP)
			
		local PreviewPanel = vgui.Create( "DAdjustableModelPanel" )
		PreviewPanel:SetModel( "models/notakid/gtav/stunt_tubes/stunt_tube_xxs.mdl" )
		PreviewPanel:SetPos( 10, 10 )
		PreviewPanel:SetSize( 300, 300 )
		PreviewPanel:SetFOV( 45 )
		PreviewPanel.FarZ = 32768
		local ent = PreviewPanel.Entity
		-- ent:SetModelScale( 1, 0 )
		if ProxyColor then
			if pxyclr then
				ent:SetProxyColor(list.Get("NAKStuntColors").CTable[pxyclr])
			end
		end
		
		local mn, mx = ent:GetRenderBounds()
		local pos = LerpVector( 0.5, mn, mx )
		local fitcam = math.abs(pos.x*2) + math.abs(mn.y*2) -- fit entire model in camera

		PreviewPanel:SetCamPos(pos-Vector(-fitcam,fitcam-mx.y,-1000))
		PreviewPanel:SetLookAt(pos)
		local plsk = ( pos - (pos-Vector(-fitcam,fitcam-mx.y,-1000)) ):Angle()
		PreviewPanel:SetLookAng(plsk)
		function PreviewPanel:LayoutEntity(ent)
		end
		liist:AddItem(PreviewPanel)
		
	--the spawnicons of the tubes
	local List = vgui.Create( "DIconLayout" )
	List:SetSpaceY( 5 )
	List:SetSpaceX( 5 )
	for k,v in pairs(list.Get("NAKStuntTrack")) do 
		local ListItem = List:Add( "SpawnIcon" )
		ListItem:SetSize( 128, 128 )
		ListItem:SetModel( v.MDL )
		function ListItem:DoClick()
			PreviewPanel:SetModel(v.MDL)
			local ent = PreviewPanel.Entity
			local mn, mx = ent:GetRenderBounds()
			local pos = LerpVector( 0.5, mn, mx )
			local fitcam = math.abs(pos.x*2) + math.abs(mn.y*2) -- fit entire model in camera
			PreviewPanel:SetCamPos(pos-Vector(-fitcam,fitcam-mx.y,-1000))
			PreviewPanel:SetLookAt(pos)
			local plsk = ( pos - (pos-Vector(-fitcam,fitcam-mx.y,-1000)) ):Angle()
			PreviewPanel:SetLookAng(plsk)
			
			if ProxyColor then
				if pxyclr then
					ent:SetProxyColor(list.Get("NAKStuntColors").CTable[pxyclr])
				end
			end

			local tab = {}
			tab.ent		= ent
			tab.cam_pos = PreviewPanel:GetCamPos()
			tab.cam_ang = PreviewPanel:GetLookAng()
			tab.cam_fov = 45
			 
			ListItem:RebuildSpawnIconEx( tab )
		end
	end
	liist:AddItem(List) -- parent to the base panel
	end )
end

list.Set("NAKStuntColors", "Index", {
	America = "America",
	Red = "Red",
	Blue = "Blue",
	Purple = "Purple",
	Black = "Black",
	White = "White",
	Grey = "Grey",
	Gold = "Gold",
	Orange = "Orange",
	Green = "Green",
	Pink = "Pink",
	Race = "Race",
	BlackYellow = "BlackYellow",
	OrangeBlue = "OrangeBlue",
	GreenYellow = "GreenYellow",
	PinkGrey = "PinkGrey",
})

list.Set("NAKStuntColors", "CTable", {
	America = {
		Color(47,75,126),
		Color(170,43,68),
		Color(238,238,238),
		Color(249,249,249),
	},
	Red = { -- alpha is 238
		Color(227,33,41),
		Color(227,33,41),
		Color(227,33,41),
		Color(227,33,41),
	},
	Blue = {
		Color(30,141,214),
		Color(30,141,214),
		Color(30,141,214),
		Color(30,141,214),
	},
	Purple = {
		Color(99,73,115),
		Color(151,29,238),
		Color(99,73,115),
		Color(151,29,238),
	},
	Black = {
		Color(50,50,50),
		Color(50,50,50),
		Color(50,50,50),
		Color(50,50,50),
	},
	White = {
		Color(249,249,249),
		Color(249,249,249),
		Color(249,249,249),
		Color(249,249,249),
	},
	Grey = {
		Color(117,117,117),
		Color(117,117,117),
		Color(117,117,117),
		Color(117,117,117),
	},
	Gold = {
		Color(171,142,68),
		Color(241,209,48),
		Color(171,142,68),
		Color(241,209,48),
	},
	Orange = {
		Color(255,131,0),
		Color(255,131,0),
		Color(255,131,0),
		Color(255,131,0),
	},
	Green = {
		Color(71,139,55),
		Color(71,139,55),
		Color(71,139,55),
		Color(71,139,55),
	},
	Pink = {
		Color(234,11,132),
		Color(234,11,132),
		Color(234,11,132),
		Color(234,11,132),
	},
	Race = {
		Color(227,33,41),
		Color(0,76,148),
		Color(227,33,41),
		Color(30,141,214),
	},
	BlackYellow = {
		Color(50,50,50),
		Color(241,209,48),
		Color(50,50,50),
		Color(241,209,48),
	},
	OrangeBlue = {
		Color(255,106,36),
		Color(100,145,179),
		Color(255,106,36),
		Color(100,145,179),
	},
	GreenYellow = { -- alpha is 238
		Color(10,68,41),
		Color(238,172,46),
		Color(10,68,41),
		Color(238,172,46),
	},
	PinkGrey = { -- alpha is 238
		Color(234,11,132),
		Color(117,117,117),
		Color(234,11,132),
		Color(117,117,117),
	},
})

--[[

	MY NOTES:
	tube_clr_1-4 				= the tube texture performace
	tube_clra_1-4 				= the tube texture but with alpha test
	
	tube_support_clr_1-4 		= the poles that support the tubes
	
	ramp_tube_adjust_clr_1-4 	= the ramp that adjusts you from track to tube sections
	ramp_tube_adjust_clra_1-4 	= the ramp that adjusts you from track to tube sections but with alpha test

	prop_track_trim = the red and white trim on the sides of track
	prop_track_straight_01 = the road itself
	track_hardshoulder_clr_1-4 = the shoulder of the track, colorable
	
	-
	the extra materials for the proxy colors are making this complicated
	theres gotta be some way to color things in one material..

]]