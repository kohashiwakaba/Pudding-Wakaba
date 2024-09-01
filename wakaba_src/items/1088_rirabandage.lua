--[[
	Rira's Bandage (리라의 반창고) - 패시브(Passive)
	스테이지 입장 시 피격 효과 6회 발동, 소지 장신구 흡수
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:NewLevel_RiraBandage()
	wakaba:ForAllPlayers(function(player) ---@param player EntityPlayer
		local num = player:GetCollectibleNum(wakaba.Enums.Collectibles.RIRAS_BANDAGE)
		if num > 0 then
			local totalNum = wakaba.Enums.Constants.RIRA_BANDAGE_BASE + (num * wakaba.Enums.Constants.RIRA_BANDAGE_EXTRA)
			wakaba:scheduleForUpdate(function()
				player:AnimateCollectible(wakaba.Enums.Collectibles.RIRAS_BANDAGE)
			end, 1)
			wakaba:setPlayerDataEntry(player, "riraBandageCount", totalNum)
			wakaba:setPlayerDataEntry(player, "riraBandageDelay", 15)
		end
	end)
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, wakaba.NewLevel_RiraBandage)

function wakaba:PlayerUpdate_RiraBandage(player)
	local num = wakaba:getPlayerDataEntry(player, "riraBandageCount")
	if num then
		wakaba:addPlayerDataCounter(player, "riraBandageDelay", -1)
		if wakaba:getPlayerDataEntry(player, "riraBandageDelay") <= 0 then
			player:AddEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
			wakaba:SmeltHeldTrinket(player)
			for i = 1, num do
				player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR, UseFlag.USE_NOANIM)
				--player:TakeDamage(1, DamageFlag.DAMAGE_FAKE | DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_NOKILL | DamageFlag.DAMAGE_NO_MODIFIERS | DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 0)
			end
			player:ClearEntityFlags(EntityFlag.FLAG_NO_DAMAGE_BLINK)
			wakaba:removePlayerDataEntry(player, "riraBandageCount")
			wakaba:removePlayerDataEntry(player, "riraBandageDelay")
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, wakaba.PlayerUpdate_RiraBandage)