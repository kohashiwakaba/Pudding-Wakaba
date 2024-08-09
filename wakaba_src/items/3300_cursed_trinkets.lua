--[[
	Cursed Trinkets (저주받은 장신구) - 장신구(Trinket)
	Retribution, TMTRAINER 전용
-- corrupted clover (방 입장 시 캐릭터 4방향으로 빛줄기)
-- dark pendant (최종 행운 마이너스)
-- richer's broken necklace (적 눈물이 도그마화)
-- leaf needle (액티브 사용 시 헌혈 피해 반칸)
-- rira's hair (방 입장 시 캐릭터 바로 옆칸에 흰 불)
-- spy eye (방 입장 시 공격키를 누르고 있으면 헌혈 피해)
-- faded mark (스나이퍼 저주)
-- neverlasting bunny (망각의 저주)
-- ribbon cage (요정의 저주)
-- rira's worst nightmare (Host를 Mobile Host로 변경)
-- masked shovel (피격 시 트랩도어 생성)
-- broken watch 2 (주기적으로 Broken Watch 상태 변경)
-- round and round (방 입장 시 방 중앙에 Stone Eye 생성)
-- gehenna rock (모든 poky류 장애물이 grudge로 변경)
]]

local isc = require("wakaba_src.libs.isaacscript-common")

do -- Corrupted Clover
	function wakaba:Cursed_NewRoom_CorruptedClover()
		if wakaba.G:GetRoom():IsFirstVisit() then
			local player = wakaba:AnyPlayerHasTrinket(wakaba.Enums.Trinkets.CORRUPTED_CLOVER)
			if player then
				for i = 0, 3 do
					local addPos = Vector.FromAngle(Vector.Zero + (i * 90)) * 40
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, addPos, Vector.Zero, nil)
				end
			end
		end
	end
	wakaba:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, wakaba.NewRoom_BookOfAmplitude)
end

do -- Dark Pendant
	
end

do -- Broken Necklace
	
end

do -- Leaf Needle
	
end

do -- Rira's Hair
	
end

do -- Spy Eye
	
end

do -- Faded Mark
	
end

do -- Neverlasting Bunny
	
end

do -- Ribbon Cage
	
end

do -- Rira's worst nightmare
	
end

do -- Masked Shovel
	
end

do -- Broken Watch 2
	
end

do -- Round and Round
	
end

do -- Gehenna Rock
	
end

do -- Reserved
	
end

do -- Reserved
	
end

do -- Reserved
	
end

do -- Reserved
	
end

do -- Reserved
	
end

do -- Reserved
	
end