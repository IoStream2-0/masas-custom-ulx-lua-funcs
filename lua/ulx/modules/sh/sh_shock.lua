--Coded by Masamune EXCLUSIVLY for Mayor Qwerts build server
--I will add effects eventualy
function ulx.shock( calling_ply , target_ply , dmg , rad )
	--if calling_ply:Nick() == "Masamune" or calling_ply:Nick() == "Mayor Qwert" or calling_ply:IsSuperAdmin() then
	
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
		
			local pos = pl:GetPos()
			WorldSound("ambient/levels/labs/electric_explosion"..math.random(2,4)..".wav", pos , 95, math.random( 95 , 105) )

			local tes = ents.Create( "point_tesla" )
			tes:SetPos( pos + Vector( math.random( -rad / 100 , rad / 100 ) , math.random( -rad / 100 , rad / 100 ) , 15 ) )
			tes:SetKeyValue( "m_SoundName", "" )
			tes:SetKeyValue( "texture", "sprites/bluelight1.spr" )
			tes:SetKeyValue( "m_Color", "200 175 255" )
			tes:SetKeyValue( "m_flRadius", rad )
			tes:SetKeyValue( "beamcount_min", rad )
			tes:SetKeyValue( "beamcount_max", 5rad )
			tes:SetKeyValue( "thick_min", rad )
			tes:SetKeyValue( "thick_max", 5rad )
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

			local dmginfo = DamageInfo()
			dmginfo:SetDamage( dmg )
			--dmginfo:SetDamageForce( Vector( math.random( -10000 , 10000 ) , math.random( -10000 , 10000 ) , math.random( -10000 , 10000 ) ) )
			--dmginfo:SetDamagePosition( pos )
			dmginfo:SetDamageType( DMG_DISSOLVE )
		
			--pl:SetMoveType( MOVETYPE_WALK )
			pl:TakeDamageInfo( dmginfo )
		
			for k, v in pairs( ents.FindInSphere( pos , rad ) ) do
				--v:SetMoveType( MOVETYPE_WALK )
				v:TakeDamageInfo(dmginfo)
			
				if v:GetClass() == "npc_rollermine" then -- rollermines go crazy, then explode
					v:Fire("InteractivePowerDown")
				end
			end
		end
	ulx.fancyLogAdmin( calling_ply, "#1s shocked all entities within #4i of #2s for #3i damage", target_ply, dmg , rad )
	return true
	--else
	--return false
	--end
end
local shock = ulx.command( "Fun", "ulx shock", ulx.shock, "!shock" )
shock:addParam{ type=ULib.cmds.PlayersArg }
shock:addParam{ type=ULib.cmds.NumArg, hint="damage", min=0, max=10000 }
shock:addParam{ type=ULib.cmds.NumArg, hint="damage", min=1, max=1000 , default=100 , ULib.cmds.optional }
shock:defaultAccess( ULib.ACCESS_ADMIN )
shock:help( "zaps a player with damage" )
ulx.addToMenu( ulx.ID_MCLIENT, "shock", "ulx shock" )