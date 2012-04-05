--Coded by Masamune EXCLUSIVLY for Mayor Qwerts build server
--I will add effects eventualy
function ulx.shock( calling_ply , target_ply )
	
		for _,pl in pairs( target_ply ) do
			if not pl:Alive() then
				ULib.tsay( calling_ply, pl:Nick() .. " is dead!", true )
				return
			end
			if pl.jail then
				ULib.tsay( calling_ply, pl:Nick() .. " is in jail", true )
				return
			end
			if pl.ragdoll then
				ULib.tsay( calling_ply, pl:Nick() .. " is a ragdoll", true )
				return
			end	
	
			if pl:InVehicle() then
				local vehicle = pl:GetParent()
				pl:ExitVehicle()
			end
		
			WorldSound("ambient/levels/labs/electric_explosion"..math.random(2,4)..".wav", pos , 95, math.random( 95 , 105 ) )
			
			--local pos = pl:GetPos()
			-- local tes = ents.Create( "point_tesla" )
			-- tes:SetPos( pos + Vector( 0 , 0 , 50 ) )
			-- tes:SetKeyValue( "m_SoundName", "" )
			-- tes:SetKeyValue( "texture", "sprites/bluelight1.spr" )
			-- tes:SetKeyValue( "m_Color", "200 175 255" )
			-- tes:SetKeyValue( "m_flRadius", "100" )
			-- tes:SetKeyValue( "beamcount_min", "5" )
			-- tes:SetKeyValue( "beamcount_max", "10" )
			-- tes:SetKeyValue( "thick_min", "5" )
			-- tes:SetKeyValue( "thick_max", "10" )
			-- tes:SetKeyValue( "lifetime_min", "0.1" )
			-- tes:SetKeyValue( "lifetime_max", "0.3" )
			-- tes:SetKeyValue( "interval_min", "0.1" )
			-- tes:SetKeyValue( "interval_max", "0.3" )
			-- tes:Spawn()
			-- tes:Fire( "DoSpark", "", 0 )
			-- tes:Fire( "DoSpark", "", 0.2 )
			-- tes:Fire( "DoSpark", "", 0.4 )
			-- tes:Fire( "DoSpark", "", 0.6 )
			-- tes:Fire( "kill", "", 1 )

			local dmginfo = DamageInfo()
			dmginfo:SetDamage( pl:Health() )
			dmginfo:SetDamageType( DMG_DISSOLVE )
		
			pl:TakeDamageInfo( dmginfo )
		end
	ulx.fancyLogAdmin( calling_ply, "#1s shocked #2s with OVER 9000 amps", target_ply, dmg , rad )
	return true
end
local shock = ulx.command( "Fun", "ulx shock", ulx.shock, "!shock" )
shock:addParam{ type=ULib.cmds.PlayersArg }
shock:defaultAccess( ULib.ACCESS_SUPERADMIN )
shock:help( "Shocks a player to death" )
ulx.addToMenu( ulx.ID_MCLIENT, "shock", "ulx shock" )