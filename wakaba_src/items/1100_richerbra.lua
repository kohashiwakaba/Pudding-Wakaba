--[[
	Richer's Bra (리셰의 속옷) - 패시브(Passive)
	- 모든 피격에 대한 패널티 방어
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")

function wakaba:AlterPlayerDamage_RicherBra(player, amount, flags, source, countdown)
	if player:HasCollectible(wakaba.Enums.Collectibles.RICHERS_BRA) then
		return amount, flags | DamageFlag.DAMAGE_NO_PENALTIES
	end
end
wakaba:AddCallback(wakaba.Callback.EVALUATE_DAMAGE_AMOUNT, wakaba.AlterPlayerDamage_RicherBra)

function wakaba:NewRoom_RicherBra()
	local room = wakaba.G:GetRoom()
	if room:IsFirstVisit() and wakaba:AnyPlayerHasCollectible(wakaba.Enums.Collectibles.RICHERS_BRA) then
		for i=0, room:GetGridSize() - 1 do
			local gridEnt = room:GetGridEntity(i)
			if gridEnt then
				local plate = gridEnt:ToPressurePlate()
				if plate and plate:GetVariant() == 0 then
					wakaba.Log("Richer's Bra - Pressure plate found : pressing...")
					plate.State = 3
					plate:GetSprite():Play("On", true)
					plate:Update()
					plate:GetSprite():Update()
				end
			end
		end
	end
end
wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_RicherBra)