--Coded by Masamune EXCLUSIVLY for Mayor Qwerts build server
--I will add effects eventualy
function ulx.shock( calling_ply , target_plys , dmg )
	for _,v in ipairs( target_plys ) do
		if not v:Alive() then
				ULib.tsay( calling_ply, v:Nick() .. " is dead!", true )
				return
			end
			if v.jail then
				ULib.tsay( calling_ply, v:Nick() .. " is in jail", true )
				return
			end
			if v.ragdoll then
				ULib.tsay( calling_ply, v:Nick() .. " is a ragdoll", true )
				return
			end	
	
			-- if v:InVehicle() then
				-- v:ExitVehicle()
			-- end
		
		local pos = v:GetPos()
		
		WorldSound("ambient/levels/labs/electric_explosion"..math.random(2,4)..".wav", pos , 95, math.random( 95 , 105 ) )
			
		local tes = ents.Create( "point_tesla" )
		tes:SetPos( v:GetShootPos() )
		tes:SetKeyValue( "m_SoundName", "" )
		tes:SetKeyValue( "texture", "sprites/bluelight1.spr" )
		tes:SetKeyValue( "m_Color", "200 175 255" )
		tes:SetKeyValue( "m_flRadius", "100" )
		tes:SetKeyValue( "beamcount_min", "15" )
		tes:SetKeyValue( "beamcount_max", "20" )
		tes:SetKeyValue( "thick_min", "10" )
		tes:SetKeyValue( "thick_max", "15" )
		tes:SetKeyValue( "lifetime_min", "0.1" )
		tes:SetKeyValue( "lifetime_max", "0.3" )
		tes:SetKeyValue( "interval_min", "0.1" )
		tes:SetKeyValue( "interval_max", "0.3" )
		tes:Spawn()
		tes:Fire( "DoSpark", "", 0 )
		tes:Fire( "DoSpark", "", 0.2 )
		tes:Fire( "DoSpark", "", 0.4 )
		tes:Fire( "DoSpark", "", 0.6 )
		tes:Fire( "kill", "", 1 )
		
		local Effect = EffectData()
		
		Effect:SetOrigin( pos )
		Effect:SetStart( pos )
		Effect:SetMagnitude( 512 )
		Effect:SetScale( 128 )
		util.Effect( "cball_explode" , Effect )

		local dmginfo = DamageInfo()
		dmginfo:SetDamage( dmg )
		dmginfo:SetDamageType( DMG_DISSOLVE )
		--ULib.tsay( calling_ply, "test" , true )
		
		v:TakeDamageInfo( dmginfo )
	end
	ulx.fancyLogAdmin( calling_ply, "#1s shocked #2s with #3i damage.", affected_plys , dmg )
	return true
end
local shock = ulx.command( "Fun", "ulx shock", ulx.shock, "!shock" )
shock:addParam{ type = ULib.cmds.PlayersArg }
zombify:addParam{ type = ULib.cmds.NumArg , hint="Damage", min=1 , default=21700000 , ULib.cmds.optional }
shock:defaultAccess( ULib.ACCESS_SUPERADMIN )
shock:help( "Shocks a player to death" )
--shock:logString( "#1s shocked #2s to death." )
ulx.addToMenu( ulx.ID_MCLIENT, "Shock", "ulx shock" )