--[[
	Azure Rir (아주르 리르) - 패시브(Passive)
	뒤집힌 리라로 Beast 처치

	- 모든 장신구가 아쿠아 장신구로 등장
	- 적 처치 판정 시 해당 적은 '방 큻리어 조건'에서 제외

	REPENTOGON 한정
	- 체력 상한 24칸으로 증가

	뒤집힌 리라 한정
	- 토끼 와드가 주변에 없으면 지속적으로 체력 감소
	- 모든 보물방이 '리라의 야릇한 보물방'으로 교체됨
	-- 모든 보물방에 적용 가능, 해당 방은 아이템 대신 아쿠아 장신구가 등장
 ]]

local isc = require("wakaba_src.libs.isaacscript-common")

wakaba.AzureRirBlacklistEntities = {
	{EntityType.ENTITY_DOGMA},
	{EntityType.ENTITY_ROTGUT},
	{EntityType.ENTITY_SATAN, 0},
	{EntityType.ENTITY_MEGA_SATAN, 0},
	{EntityType.ENTITY_ISAAC, 2},
	{EntityType.ENTITY_BEAST, 0},
	{EntityType.ENTITY_ENVY},
	{EntityType.ENTITY_FALLEN},
	{EntityType.ENTITY_MATRIARCH},
	{EntityType.ENTITY_MOTHER, 0},
}

local function isAzureRirBlacklisted(entity)
	for _, dict in ipairs(wakaba.AzureRirBlacklistEntities) do
		if entity.Type == dict[1] then
			if not dict[2] or entity.Variant == dict[2] then
				if not dict[3] or entity.SubType == dict[3] then
					return true
				end
			end
		end
	end
end


---@param player EntityPlayer
---@return boolean
function wakaba:hasAzureRir(player)
	if not player then
		return false
	end
	if player:GetPlayerType() == wakaba.Enums.Players.RIRA_B then
		return true
	elseif player:HasCollectible(wakaba.Enums.Collectibles.AZURE_RIR) then
		return true
	else
		return false
	end
end

---Check any player has Winter Albireo, or playing as Tainted Richer
---@return boolean hasAzureRir
---@return boolean onlyTaintedRira
function wakaba:anyPlayerHasAzureRir()
	local hasAzureRir = false
	local onlyTaintedRira = true
	for i = 1, wakaba.G:GetNumPlayers() do
		local player = Isaac.GetPlayer(i-1)
		hasAzureRir = hasAzureRir or (player.Variant == 0 and wakaba:hasAzureRir(player))
		onlyTaintedRira = wakaba:IsLunatic() or (onlyTaintedRira and player:GetPlayerType() == wakaba.Enums.Players.RIRA_B)
	end
	return hasAzureRir, onlyTaintedRira
end

---@param npc EntityNPC
function wakaba:NPCRender_AzureRir(npc)
	if wakaba:IsLunatic() then return end
	if not wakaba:anyPlayerHasAzureRir() then return end
	if (npc:IsDead() or npc:GetSprite():IsPlaying("Death")) and npc.CanShutDoors and not isAzureRirBlacklisted(npc) then
		npc:GetData().wakaba_rirCooldown = npc:GetData().wakaba_rirCooldown or 0
		npc:GetData().wakaba_rirCooldown = npc:GetData().wakaba_rirCooldown + 1
		if npc:GetData().wakaba_rirCooldown >= 5 then
			npc.CanShutDoors = false
			local s = npc:GetSprite()
			local c = s.Color
			c.A = 0.5
			s.Color = c
		end
	end

end
--wakaba:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, wakaba.NPCRender_AzureRir)

---@param type EntityType
---@param variant integer
---@param subType integer
---@param gridIndex integer
---@param seed integer
function wakaba:RoomSpawn_AzureRir(type, variant, subType, gridIndex, seed)
	local room = wakaba.G:GetRoom()
	--print(type, variant, subType, gridIndex, seed)
	if room:IsFirstVisit()
	and room:GetFrameCount() <= 2
	and room:GetType() == RoomType.ROOM_TREASURE
	and type == EntityType.ENTITY_PICKUP
	and variant == PickupVariant.PICKUP_COLLECTIBLE
	and (subType <= 0 or not wakaba:IsQuestItem(subType)) then
		local rir, onlyRira = wakaba:anyPlayerHasAzureRir()
		if rir and onlyRira then
			return {EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 0}
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, wakaba.RoomSpawn_AzureRir)