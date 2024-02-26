--[[
	Question Block (물음표 블럭) - 패시브
  돌이 일정 확률로 물음표 블럭으로 변경
  물음표 블럭을 공격으로 치면 아래 효과 중 하나 발동
  - 동전
  - 동전 (10연속)
  - 버섯 : 그 스테이지에서 Magic Mushroom 지급, 패널티 피격 시 초기화
  - 플라워 : 그 방의 적에게 화상 효과 발동
  - 코끼리 : 확률적으로 그 방의 적 둔화
  - 버블 : 그 방에서 가장 체력이 높은 적 약화
  - 드릴 : 랜덤 픽업 드랍
]]

function wakaba:AfterRevival_QuestionBlock(player)
	local wisp = wakaba:HasWisp(player, wakaba.Enums.Collectibles.QUESTION_BLOCK)
	if wisp then
		wisp:Kill()
	end
end