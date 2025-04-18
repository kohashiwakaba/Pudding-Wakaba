--[[
	Richer's Bra (리셰의 속옷) - 패시브(Passive)
	- 모든 피격에 대한 패널티 방어
 ]]
local isc = _wakaba.isc

function wakaba:PenaltyProtection_RicherBra(player, amount, flags, source, countdown)
	if player:HasCollectible(wakaba.Enums.Collectibles.RICHERS_BRA) then
		return {
			Protect = true,
			Override = true,
			Force = true,
		}
	end
end
wakaba:AddPriorityCallback(wakaba.Callback.EVALUATE_WAKABA_DAMAGE_PENALTY_PROTECTION, -200, wakaba.PenaltyProtection_RicherBra)

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