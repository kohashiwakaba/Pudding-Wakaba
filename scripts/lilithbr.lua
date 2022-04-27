local mod=RegisterMod("Lilith Birthright simulation",1)		--by im_tem (god fuck this shit i will never do this again)
testcondition=true			--replace test condition with actual check lol
local familiarblacklist={	--list all familiar variants that shouldnt be attached to front
3,14,15,16,17,20,21,22,23,24,25,26,27,28,40,41,42,43,46,47,48,50,52,53,54,55,56,57,58,59,62,63,64,66,67,71,72,73,75,76,77,78,79,82,85,86,87,88,89,90,91,93,94,96,98,99,100,101,102,103,104,105,106,107,109,110,111,112,113,114,115,118,120,122,124,127,129,130,200,201,202,203,204,205,206,207,208,210,211,212,213,214,215,216,217,218,219,221,222,223,224,225,227,228,229,231,232,233,234,235,236,237,238,239,240,241,242,243
}
--notes:
--boiler baby (208) is actually counted as offensive shooter and thus follows lilith br position but never actually goes there, lazy ass!
local temporaryfamblacklisttable={}
for k,v in pairs(familiarblacklist) do
	temporaryfamblacklisttable[v]=k
end
familiarblacklist=temporaryfamblacklisttable
temporaryfamblacklisttable=nil
local function GetPlayerIdentifier(player)
	local IDToCheck=1
	if player:GetPlayerType()==38 then	--dead lazarus hack
		IDToCheck=2
	end
	return player:GetCollectibleRNG(IDToCheck):GetSeed()
end
function mod:playerupdate(player)
	if not player:GetData().Identifier then
		player:GetData().Identifier=GetPlayerIdentifier(player)
	end
	if testcondition then
		local fams=Isaac.FindByType(3)
		local playerfams={}
		for i=1,#fams do
			local fam=fams[i]:ToFamiliar()
			if fam.Player and not familiarblacklist[fam.Variant] and not fam:GetData().BlacklistFromLilithBR and fam.Player:GetData().Identifier==player:GetData().Identifier and fam.OrbitDistance:Length()==0 then
				table.insert(playerfams,fam)
				if fam.MoveDirection~=-1 or fam.LastDirection~=-1 then
					fam:GetData().BlacklistFromLilithBR=true
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
function mod:famupd(fam)
	if testcondition and not fam:GetData().BlacklistFromLilithBR and fam:GetData().LilithBRFollowPos then
		fam.Velocity=((fam.Player.Position+fam:GetData().LilithBRFollowPos*30)-fam.Position)*0.5
	end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE,mod.famupd)
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,mod.playerupdate)