--[[ 
Lilith Birthright simulation from Im_tem
reserved for future update
https://cdn.discordapp.com/attachments/360574749639835648/925763568123650108/lilithbr.zip
 ]]



local familiarwhitelist={
  wakaba.FAMILIAR_LIL_WAKABA,
  wakaba.FAMILIAR_LIL_MOE,
  wakaba.FAMILIAR_LIL_SHIVA,
}
local testcondition = true -- Too lazy to remove this

local temporaryfamwhitelisttable={}
for k,v in pairs(familiarwhitelist) do
	temporaryfamwhitelisttable[v]=k
end
familiarwhitelist=temporaryfamwhitelisttable
temporaryfamwhitelisttable=nil

function wakaba:PlayerUpdate_LilithBR(player)
	if not player:GetData().Identifier then
		player:GetData().Identifier = wakaba.getstoredindex(player)
	end
	if testcondition then
		local fams=Isaac.FindByType(3)
		local playerfams={}
		for i=1,#fams do
			local fam=fams[i]:ToFamiliar()
			if fam.Player and familiarwhitelist[fam.Variant] and fam:GetData().WhitelistFromLilithBR and fam.Player:GetData().Identifier==player:GetData().Identifier and fam.OrbitDistance:Length()==0 then
				table.insert(playerfams,fam)
				if fam.MoveDirection~=-1 or fam.LastDirection~=-1 then
					fam:GetData().WhitelistFromLilithBR=true
				end
			end
		end
		local aimdir=player:GetAimDirection()
		if aimdir:Length()~=0 then
			aimdir=aimdir:Normalized()
			player:GetData().LilithBRLastAimDirection=aimdir
		else if player:GetData().LilithBRLastAimDirection then
			local currentangle=player:GetData().LilithBRLastAimDirection:GetAngleDegrees()
			local newangle=currentangle
				while math.floor(newangle)%90~=0 do
					newangle=newangle+1
				end
				player:GetData().LilithBRLastAimDirection=player:GetData().LilithBRLastAimDirection:Rotated(newangle-currentangle)
			end
		end
		aimdir=player:GetData().LilithBRLastAimDirection or Vector(0,1)
		local currentiterfamiliar=0
		for i=1,#playerfams do
			currentiterfamiliar=currentiterfamiliar+1
			fam=playerfams[i]
			targetangle=180*currentiterfamiliar/(#playerfams+1)
			fam:GetData().LilithBRFollowPos=aimdir:Rotated(targetangle-90)
		end
	end
end
function wakaba:FamiliarUpdate_LilithBR(fam)
	if testcondition and fam:GetData().WhitelistFromLilithBR and fam:GetData().LilithBRFollowPos then
		fam.Velocity=((fam.Player.Position+fam:GetData().LilithBRFollowPos*30)-fam.Position)*0.5
	end
end
wakaba:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE,wakaba.FamiliarUpdate_LilithBR)
wakaba:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,wakaba.PlayerUpdate_LilithBR)