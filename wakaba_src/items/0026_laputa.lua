--[[
	Laputa (라퓨타) - 액티브(Active / 0 rooms / Mode Switch)
	뒤틀린 츠카사(TR 츠카사)로 하드 모드 체크리스트 달성
	소지 중일 때 폭탄 설치 시 즉시 타겟팅 된 적 위치에서 폭발
	사용 시 아래 중 하나의 모드로 전환, 모드에 따라 설치 위치 조절
	- 최대 절대 HP
	- 최대 상대 HP (비율 같은 경우 절대 HP)
	- 가장 가까운 적
	- 일정 거리 내에 가장 멀리 있는 적
 ]]
local isc = require("wakaba_src.libs.isaacscript-common")
