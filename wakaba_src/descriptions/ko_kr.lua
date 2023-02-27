local desclang = "ko_kr"

wakaba.descriptions[desclang] = {}
wakaba.descriptions[desclang].birthrightName = "생득권"
wakaba.descriptions[desclang].birthright = {
	[wakaba.Enums.Players.WAKABA] = {
		playerName = "{{ColorWakabaBless}}Wakaba{{CR}}",
		description = "↑ 체력 상한 +1#{{AngelChance}} 천사방이 모든 층에서 항상 등장합니다.",
		queueDesc = "그녀의 순수함이 영원하기를...",
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		playerName = "{{ColorWakabaNemesis}}Tainted Wakaba{{CR}}",
		description = "↑ {{Collectible"..wakaba.Enums.Collectibles.WAKABAS_NEMESIS.."}}Wakaba's Nemesis의 능력치 감소가 해제되며 공격력 감소 속도가 느려집니다.#폭발 및 지진파에 피해를 받지 않습니다.",
		queueDesc = "폭발 피해 면역 + 식지 않는 흥분",
	},
	[wakaba.Enums.Players.SHIORI] = {
		playerName = "{{ColorBookofShiori}}Shiori",
		description = "↑ 액티브 아이템 사용에 필요한 열쇠 갯수가 절반으로 감소합니다. (최소 1)",
		queueDesc = "좀 더 똑똑해진 문학소녀",
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		playerName = "{{ColorCyan}}Minerva{{CR}}(Tainted Shiori)",
		description = "{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} 미네르바의 오라 효과 적용:"
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#↑ {{TearsSmall}}연사(+상한) +1.5"
		.. "#유도 눈물을 발사합니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_CONQUEST.."}} Book of Conquest와 액티브 아이템 사용에 필요한 열쇠 갯수가 일정량 감소합니다. (최소 1)#↑ 현재 함락된 적들의 코스트에 비례하여 모든 능력치가 상승합니다.",
		queueDesc = "문학소녀의 유대감",
	},
	[wakaba.Enums.Players.TSUKASA] = {
		playerName = "{{ColorPink}}Tsukasa",
		description = "Afterbirth ~ Repentance 아이템을 획득할 수 있습니다.#↑ {{Collectible"..wakaba.Enums.Collectibles.LUNAR_STONE.."}}Lunar Stone 게이지의 상한이 200%로 증가합니다.",
		queueDesc = "역사와 달빛을 제대로 보다",
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		playerName = "???(Tainted Tsukasa)",
		description = "눈물 공격을 할 수 있게 됩니다.#{{Collectible"..wakaba.Enums.Collectibles.FLASH_SHIFT.."}} Flash Shift는 카드/알약 슬롯으로 이동되며 사용 시 이동방향으로 기존의 돌진 공격을 합니다.",
		queueDesc = "비극적 시련을 극복하다",
	},
	[wakaba.Enums.Players.RICHER] = {
		playerName = "Richer",
		description = "{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}}Sweets Catalog의 효과가 다음 사용 전까지 유지됩니다.#{{Collectible260}} 스테이지에 입장할 때 저주에 걸리지 않습니다.#{{CurseCursedSmall}} 획득 시 Labyrinth/챌린지/특수 시드를 제외한 모든 저주를 제거합니다.",
		queueDesc = "저주 면역 + 지속성 달콤달콤",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		playerName = "Tainted Richer",
		description = "#변환된 불꽃의 방어력이 2배로 증가합니다.#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}}Water-Flame으로 흡수 시 흡수한 아이템을 추가로 획득합니다.",
		queueDesc = "점점 따뜻해져가는 달콤함",
	},
}
wakaba.descriptions[desclang].collectibles = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		itemName = "와카바의 축복",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#{{Quality0}}/{{Quality1}}등급 아이템이 등장하지 않습니다."
		.. "#모든 피격에 대한 패널티에 면역"
		.. "#{{HolyMantleSmall}} 전체 체력이 1칸 이하일 때 방마다 피격을 1회 막아주는 보호막이 제공됩니다. (T.Lost 제외)"
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "",
		queueDesc = "악마 봉인 + 더 나아진 운명",
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		itemName = "와카바의 숙명",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#↑ 공격이 적의 방어를 무시합니다.(Wakaba 제외)"
		.. "#↓ 아이템 획득 시 서서히 감소하는 {{DamageSmall}}공격력 +3.6 효과를 얻으나 나머지 스탯은 영구적으로 감소합니다."
		.. "#!!! {{Quality4}}등급 아이템이 등장하지 않으며 {{Quality3}}등급의 아이템이 50%의 확률로 다른 아이템으로 변경됩니다."
		.. "#↑ {{UltraSecretRoom}}특급 비밀방에서 반드시 {{Quality3}}/{{Quality4}} 아이템이 등장합니다."
		.. "#!!! 모든 판매 액티브/패시브 아이템이 소울하트를 요구하게 바뀝니다."
		.. "#모든 피격에 대한 패널티에 면역"
		.. "#!!! 이 아이템 획득 시 악마 거래를 한 것으로 취급됩니다."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.LEVIATHAN .. "",
		queueDesc = "천사 봉인 + 더 나빠진 운명",
	},
	[wakaba.Enums.Collectibles.WAKABA_DUALITY] = {
		itemName = "와카바 듀얼리티",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#↑ 공격이 적의 방어를 무시합니다.(Wakaba 제외)"
		.. "#↓ 아이템 획득 시 서서히 감소하는 {{DamageSmall}}공격력 +3.6 효과를 얻으나 나머지 스탯은 영구적으로 감소합니다."
		.. "#{{AngelDevilChance}}악마방/천사방이 Hush 스테이지를 제외한 모든 층에서 항상 등장합니다."
		.. "#↑ 선택형 아이템을 모두 획득할 수 있습니다."
		.. "#↑ {{UltraSecretRoom}}특급 비밀방에서 반드시 {{Quality3}}/{{Quality4}} 아이템이 등장합니다."
		.. "#모든 피격에 대한 패널티에 면역"
		.. "#{{HolyMantleSmall}} 전체 체력이 1칸 이하일 때 방마다 피격을 1회 막아주는 보호막이 제공됩니다."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.LEVIATHAN .. "",
		queueDesc = "축복과 숙명 사이",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SHIORI] = {
		itemName = "시오리의 책",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#책 유형의 액티브 아이템 사용 시 다른 부가 효과와 시오리의 추가 눈물 효과가 발동됩니다."
		.. "#시오리의 추가 눈물 효과는 다른 책을 사용하기 전까지 계속 유지됩니다."
		.. "#각 층 시작 방마다 책 아이템이 하나씩 등장합니다."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "문학소녀의 지식을 전수하다",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		itemName = "함락의 책",
		description = ""
		.. "#방 안에 있는 모든 일반 적들을 아군으로 만듭니다."
		.. "#!!! 아군 적의 수가 너무 많을 경우 아이템을 사용할 수 없습니다."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "길 잃은 어린 양의 공략집",
	},
	[wakaba.Enums.Collectibles.MINERVA_AURA] = {
		itemName = "미네르바의 오라",
		description = ""
		.. "#오라 안에 있는 아군 몬스터는 최대 체력의 2배까지 지속적으로 회복합니다."
		.. "#!!! 오라 안에 있는 모든 플레이어에게 다음 효과 발동 :"
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#↑ {{TearsSmall}}연사(+상한) +1.5"
		.. "#유도 눈물을 발사합니다."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.ANGEL .. "",
		queueDesc = "공격력, 연사 증가 + 동료를 치유해주자",
	},
	[wakaba.Enums.Collectibles.LUNAR_STONE] = {
		itemName = "월석",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#↓ 최대 체력 상한이 8칸으로 감소합니다."
		.. "#↑ 월석 게이지가 발동 중인 경우 게이지에 비례하여 {{DamageSmall}}공격력과 {{TearsSmall}}연사가 증가합니다."
		.. "#피격 시, 월석의 효과가 사라지며 월석 게이지가 서서히 감소하며 소울하트가 있을 경우, 강제로 소모하여 월석 게이지를 회복합니다."
		.. "#↑ 월석을 소지하고 있는 동안 제한 없이 부활할 수 있습니다."
		.. "#모든 피격에 대한 패널티에 면역"
		.. "#!!! 월석 게이지 전부 소진 시 월석이 증발합니다."
		.. "{{CR}}",
		queueDesc = "신성함을 유지시켜줘",
	},
	[wakaba.Enums.Collectibles.ELIXIR_OF_LIFE] = {
		itemName = "생명의 비약",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#{{WakabaAntiCurseUnknown}} Unknown 저주에 걸리지 않습니다."
		.. "#↓ {{ColorOrange}}피격 무적 시간이 제거됩니다."
		.. "#짧은 시간동안 피격되지 않았을 경우 캐릭터의 체력 보정 상태에 따라 체력을 빠른 속도로 회복합니다."
		.. "#{{Heart}} {{ColorRed}}빨간 하트를 회복하며 모든 소울 하트가 뼈 하트로 전환됩니다."
		.. "#{{SoulHeart}} {{ColorSoul}}캐릭터가 획득한 최대치까지 소울 하트를 회복합니다."
		.. "#{{Card"..Card.CARD_SOUL_LOST.."}} {{ColorSilver}}최대 5회까지 피격을 막아주는 {{HolyMantle}}신성한 보호막이 회복됩니다."
		.. "{{CR}}",
		queueDesc = "무적 시간 제거 + 초고속 회복",
	},
	[wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		itemName = "플래시 시프트",
		description = ""
		.. "#4방향으로 빠르게 움직입니다."
		.. "#3회 사용 이후 재충전이 필요합니다."
		.. "#!!! 패밀리어는 빠르게 움직이지 않습니다."
		.. "{{CR}}",
		queueDesc = "#코멧걸",
	},
	[wakaba.Enums.Collectibles.CONCENTRATION] = {
		itemName = "집중",
		description = ""
		.. "#Ctrl 키를 꾹 눌러 집중 모드로 들어갑니다."
		.. "#집중 게이지가 전부 차면 액티브 게이지를 전부 회복합니다."
		.. "#!!! 집중 게이지 증가량은 반복 사용 시 점점 감소합니다. 이 패널티는 방 클리어 시 차감됩니다."
		.. "#!!! 집중 도중 행동이 불가능하며 피격 시 2배의 대미지를 받습니다."
		.. "{{CR}}",
		queueDesc = "명상하여 에너지 재충전",
	},
	[wakaba.Enums.Collectibles.RABBIT_RIBBON] = {
		itemName = "토끼 리본",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#{{CurseCursedSmall}} 기존 저주가 다른 저주로 변경됩니다."
		.. "{{CR}}",
		queueDesc = "메이드 소녀의 부적",
	},
	[wakaba.Enums.Collectibles.SWEETS_CATALOG] = {
		itemName = "달콤달콤 카탈로그",
		description = ""
		.. "#사용 시 그 방에서 아래 중 하나의 랜덤 무기 효과를 얻습니다:"
		.. "{{CR}}",
		queueDesc = "맛집은 못 참지",
	},
	[wakaba.Enums.Collectibles.WINTER_ALBIREO] = {
		itemName = "겨울의 알비레오",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#{{PlanetariumChance}} 가능한 경우, 천체관이 반드시 등장합니다."
		.. "{{CR}}",
		queueDesc = "저 너머로 이어져 있어",
	},
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		itemName = "워터 플레임",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} 소지 중일 때 Blind 저주에 걸리지 않습니다."
		.. "#사용 시 가장 가까이에 있는 패시브 아이템을 흡수하며, 흡수한 패시브의 불꽃을 소환합니다."
		.. "{{CR}}",
		queueDesc = "역시 리셰쨩은 달콤해",
	},
	[wakaba.Enums.Collectibles.BROKEN_TOOLBOX] = {
		itemName = "망가진 도시락",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 저주에 걸리지 않습니다."
		.. "#클리어하지 않은 방에서 1초마다 픽업을 드랍합니다."
		.. "#방 안에 픽업 및 아이템이 15개 이상 있으면 그 방의 픽업 및 아이템이 폭발합니다."
		.. "{{CR}}",
		queueDesc = "흘리지 않게 조심해!",
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		itemName = "사랑을 먹자",
		description = ""
		.. "#피격이나 적들에게 대미지를 입혔을 때만 충전됩니다."
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_BATTERY .."}}배터리 없이 초과 충전이 가능합니다."
		--[[ .. "#!!! Wakaba variant : " ]]
		.. "#사용 시 현재 방 배열의 아이템을 소환합니다."
		.. "#{{Quality3}}/{{Quality4}}아이템이 반드시 등장합니다."
		.. "{{CR}}",
		queueDesc = "푸딩을 맛보듯이",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		itemName = "잊혀진 자의 책",
		description = ""
		.. "#!!! 사용 시 모든 플레이어에게 적용:"
		.. "#↑ {{BoneHeart}}뼈하트 +1"
		.. "#{{Heart}} 체력을 전부 회복합니다."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "충전식 뼈",
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		itemName = "D컵 아이스크림",
		description = ""
		.. "#↑ {{Heart}}최대 체력 +1"
		.. "#↑ {{Heart}}빨간하트 +1"
		.. "#↑ {{DamageSmall}}공격력 +0.3"
		.. "#↑ {{DamageSmall}}공격력 배율 x1.8 (중첩 불가)"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "공격력 증가 + 너가 생각한 그게 아니란다",
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		itemName = "민트초코 아이스크림",
		description = ""
		.. "#↑ {{TearsSmall}}연사 +0.2"
		.. "#↑ {{TearsSmall}}연사 배율 x2 (중첩 불가)"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "연사 대폭 증가",
	},
	[wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD] = {
		itemName = "정체불명의 게임 CD",
		description = ""
		.. "#↑ {{Heart}}최대 체력 +1"
		.. "#↑ {{TearsSmall}}연사 +0.7"
		.. "#↑ {{SpeedSmall}}이동속도 +0.16"
		.. "#↑ {{ShotspeedSmall}}탄속 +0.1"
		.. "#↑ {{RangeSmall}}사거리 +0.85"
		.. "#↑ {{DamageSmall}}공격력 +0.5"
		.. "#방 색상이 임의의 색상으로 바뀝니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "모든 능력치 증가 + 뭔가 분위기가 이상해",
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		itemName = "와카바의 펜던트",
		description = ""
		.. "#↑ {{LuckSmall}}행운을 최소 7 이상으로 설정"
		.. "#↑ {{LuckSmall}}행운에 영향을 주는 아이템의 갯수만큼 행운 +0.35"
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#{{Heart}} 체력을 모두 회복합니다"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "공격력 증가 + 엄청난 강운",
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		itemName = "와카바의 헤어핀",
		description = ""
		.. "#↑ {{LuckSmall}}알약 사용 시마다 행운 +0.35"
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "기분 좋은 느낌",
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		itemName = "극비 카드",
		description = ""
		.. "#↑ {{Coin}}동전 +22"
		.. "#방 클리어 시 랜덤한 갯수의 동전이 쌓입니다. ({{HardModeSmall}}하드:1개)"
		.. "#{{Shop}} 상점에서 Greed/Super Greed 미니보스가 등장하지 않습니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
		queueDesc = "동전 적립 + 우리 비밀친구 할래?",
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		itemName = "플럼이",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_PLUM_FLUTE.."}} 캐릭터를 따라다니는 베이비 플럼 패밀리어가 투사체를 막아줍니다."
		.. "#캐릭터가 발사하는 방향 앞에서 눈물을 따라서 발사합니다."
		.. "#너무 많이 피해를 입으면 잠시동안 활동할 수 없으며 10초동안의 휴식이 필요합니다."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
		queueDesc = "잠깐만 뭐라고?",
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		itemName = "처형자",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_ERASER .."}} 매우 낮은 확률로 지우개 눈물을 발사합니다."
		.. "#보스만 있는 상태에선 항상 지우개 눈물을 발사합니다."
		.. "#!!! {{ColorSilver}}(일부 보스의 경우 확률과 상관없이 지우개 눈물이 발사되지 않습니다){{ColorReset}}"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
		queueDesc = "???",
	},
	[wakaba.Enums.Collectibles.NEW_YEAR_BOMB] = {
		itemName = "새해 이브 폭탄",
		description = ""
		.. "#↑ {{Bomb}}폭탄 +9"
		.. "#↑ {{PoopPickup}}알트 ??? 한정으로 방마다 똥 +2"
		.. "#캐릭터의 폭발 공격에 맞은 적은 HP가 1로 줄어들지만 더 이상 캐릭터의 폭발로 죽지 않습니다"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
		queueDesc = "공허해지는 폭탄 + 폭탄 9개",
	},
	[wakaba.Enums.Collectibles.REVENGE_FRUIT] = {
		itemName = "복수과",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_BRIMSTONE .."}} 일정 확률로 눈물 대신 혈사포를 발사합니다."
		.. "#피격 시 그 스테이지에서 혈사포의 발사 확률이 증가합니다."
		--.. "#{{Collectible"..CollectibleType.COLLECTIBLE_BRIMSTONE .."}} 1.5x Damage multiplier"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
		queueDesc = "불닭맛",
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		itemName = "와카바의 교복",
		description = ""
		.. "#교복 아이템 사용 시 현재 선택된 슬롯과 들고 있는 알약/카드/룬을 서로 맞바꿉니다."
		.. "#{{Blank}} (Ctrl 키로 슬롯 선택 가능)"
		.. "#알약/카드/룬 사용 시 교복의 담긴 알약/카드/룬도 같이 사용합니다."
		.. "#교복에 담긴 알약/카드/룬은 Tab 키를 누른 상태에서 확인할 수 있습니다."
		.. "#충전량은 하드/그리디어 모드에서만 소모합니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
		queueDesc = "평안하세요!",
	},
	[wakaba.Enums.Collectibles.EYE_OF_CLOCK] = {
		itemName = "시간의 눈",
		description = ""
		.. "#원형의 레이저 3개가 캐릭터의 주변을 회전합니다."
		.. "#레이저의 공격력은 캐릭터의 공격력에 비례합니다."
		.. "#!!! 레이저의 공격력 : 캐릭터의 공격력 x0.4."
		.. "#눈물 발사 버튼을 누르고 있으면 각 원형 레이저에서 새로운 직선 레이저를 발사합니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
		queueDesc = "궤도 레이저",
	},
	[wakaba.Enums.Collectibles.LIL_WAKABA] = {
		itemName = "리틀 와카바",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_TECH_X .."}} 공격하는 방향으로 캐릭터의 공격력 x0.4의 원형 레이저를 발사합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	queueDesc = "행운의 삐비빅 친구",
	},
	[wakaba.Enums.Collectibles.COUNTER] = {
		itemName = "카운터",
		description = ""
		.. "#사용 시 캐릭터가 1초간 무적이 됩니다."
		.. "#무적 상태에서 피격을 받으면 피격을 준 대상에게 레이저를 발사합니다."
		.. "#이 아이템이 완충인 상태에서 피격 시 강제로 발동되며 대미지를 입지 않습니다."
		.. "#!!! 이 아이템이 아닌 다른 아이템의 보호막이 발동 중이면 레이저가 발사되지 않습니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.CONJOINED .. "",
	queueDesc = "레이저 반사",
	},
	[wakaba.Enums.Collectibles.RETURN_POSTAGE] = {
		itemName = "미니핀 시러시러",
		description = ""
		.. "#모든 Needle, Pasty, Dust, Polty, Kineti, Mom's Hand 몬스터들이 항상 아군이 됩니다."
		.. "#!!! 유령 상자는 여전히 캐릭터에게 대미지를 주지만 캐릭터가 아닌 다른 곳을 향해 던지게 됩니다."
		.. "#모든 Eternal Fly가 제거됩니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.CONJOINED .. "",
	queueDesc = "이런 놈들 다시 만나기 싫어",
	},
	[wakaba.Enums.Collectibles.D6_PLUS] = {
		itemName = "향상된 6면 주사위",
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} 사용 시 방 안의 모든 아이템이 랜덤한 아이템과 1초마다 전환되며 두 아이템 중 하나를 선택할 수 있습니다."
		.. "#이미 전환되고 있는 아이템에 사용 시 하나의 선택지가 추가됩니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "주사위 주문서",
	},
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		itemName = "혼돈의 6면 주사위",
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} 사용 시 아이작의 영혼 효과를 {{ColorRed}}9번{{CR}} 발동합니다 :"
		.. "#방 안의 모든 아이템이 랜덤한 아이템과 매우 빠른 속도로 전환되며 9개의 아이템 중 하나를 선택할 수 있습니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "자신의 운명을 믿는 자들을 위하여",
	},
	[wakaba.Enums.Collectibles.LIL_MOE] = {
		itemName = "리틀 모에",
		description = ""
		.. "#일정 주기로 모에 주변을 도는 유도 눈물을 발사합니다."
		.. "#눈물의 효과는 각각 랜덤이며 각각의 눈물은 적에게 최소 4의 대미지를 줍니다."
		.. "#{{Blank}} (폭발성 눈물은 발사되지 않습니다)."
		.. "#눈물의 발사 주기는 캐릭터의 연사에 비례합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	queueDesc = "퓨전 친구",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		itemName = "집중의 책",
		description = ""
		.. "#{{Weakness}} 사용 시 현재 방의 모든 적들의 피격 대미지를 두 배로 늘립니다."
		.. "#캐릭터가 움직이지 않을 경우 {{DamageSmall}}공격력 +1.4, {{TearsSmall}}연사 +1.0 증가한 상태로 유도 눈물을 발사합니다."
		.. "#!!! 캐릭터 역시 피격 시 최소 2칸의 피해를 받습니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "취급주의",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		itemName = "시오리의 룬이 담긴 병",
		description = ""
		.. "#{{Rune}} 사용 시 임의의 룬 하나를 지급합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "충전식 룬 뽑기",
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		itemName = "마이크로 도플갱어",
		description = ""
		.. "#작은 아이작 패밀리어를 12마리 소환합니다."
		.. "#작은 아이작 패밀리어는 캐릭터와 함께 이동하며 적이 있는 방향으로 공격력 1.35의 눈물을 발사합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "자기 자신을 인수분해",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		itemName = "침묵의 책",
		description = ""
		.. "#적의 모든 탄환을 지웁니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "탄막 청소기",
	},
	[wakaba.Enums.Collectibles.VINTAGE_THREAT] = {
		itemName = "빈티지의 위협",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#{{Player"..wakaba.Enums.Players.SHIORI_B.."}} 사망 시 현재 방에서 Tainted Shiori로 부활하며;"
		.. "#{{Blank}} 열쇠 갯수가 0개로 초기화, 4개의 {{Collectible656}}Damocles의 검이 활성화됩니다."
		.. "#{{Warning}} {{ColorBlink}}{{ColorRed}}경고 : 패널티 피격을 받으면 피격받는 그 즉시 Damocles의 검이 떨어지며 추가 목숨 갯수 및 남은 플레이어와 관계없이 즉시 게임이 종료됩니다.{{ColorReset}}"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "영원한 생명?",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_GOD] = {
		itemName = "신의 책",
		description = ""
		.. "#피격 시 체력이 없을 경우 천사로 변신합니다."
		.. "#!!! 천사 상태로 돌입 시 이하 효과 발동:"
		.. "#↓ {{DamageSmall}}공격력 배율 x0.5"
		.. "#눈물에 후광이 생기며 후광에 닿은 적은 프레임당 캐릭터의 공격력의 피해를 입습니다."
		.. "#피격 시 부서진 하트 하나가 추가되며 모든 하트가 {{BrokenHeart}}부서진 하트로 채워질 경우 사망합니다."
		.. "#!!! 천사 상태로 돌입하면 더 이상 희생 방의 희생 보상을 받을 수 없습니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "더 강해져서 돌아오마",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		itemName = "사신의 대응책",
		description = ""
		.. "#현재 방에서 사신의 가호를 발동시켜 캐릭터의 사망을 막으며 캐릭터가 받는 모든 피해를 체력 반칸으로 고정시켜 줍니다."
		.. "#사신의 가호를 받는 동안에는 빨간 하트 피격을 먼저 받으며 피격 시 발생하는 패널티를 막아줍니다."
		.. "#!!! {{ColorYellow}}희생 방 가시는 이 아이템의 효과를 무시합니다.{{ColorReset}}"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "생명 보호서",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_TRAUMA] = {
		itemName = "트라우마의 책",
		description = ""
		.. "#사용 시 최대 15개의 캐릭터의 눈물이 폭발합니다."
		.. "#폭발 지점마다 혈사포를 4방향으로 발사합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "분노의 눈물 폭파기",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		itemName = "타천사의 책",
		description = ""
		--.. "#!!! 타천사로 부활 전까지 아이템 사용 불가"
		.. "#피격 시 하트가 없을 경우 타천사로 변신하며 블랙하트 6개를 획득합니다."
		.. "#!!! {{ColorSilver}}타천사 상태로 돌입 시 이하 효과 발동:"
		.. "#{{ColorSilver}}사용 시 임의의 적의 위치에 캐릭터의 공격력 +35의 피해를 주는 불꽃을 소환합니다."
		.. "#↓ {{ColorSilver}}눈물 발사 불가능"
		.. "#↑ {{DamageSmall}}{{ColorSilver}}공격력 배율 x16.0"
		.. "#!!! {{ColorYellow}}더 이상 액티브 아이템을 바꿀 수 없습니다{{ColorReset}}"
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.LEVIATHAN .. "," ..EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "흐름 느끼기",
	},
	[wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY] = {
		itemName = "마이지마 전설",
		description = ""
		.. "#임의의 책 효과 하나를 발동합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "데메테르 주문서",
	},
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		itemName = "아폴리온의 시련",
		description = ""
		.. "#사용 시 방 안의 아이템을 흡수합니다."
		.. "#액티브 흡수 시 아이템을 사용할 때 마다 흡수한 액티브의 효과가 발동됩니다."
		.. "#패시브 흡수 시 랜덤한 능력치가 2개 증가합니다."
		.. "#흡수한 아이템의 수만큼 특수한 아군 파리를 소환합니다"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "공허함을 받아들여라",
	},
	[wakaba.Enums.Collectibles.LIL_SHIVA] = {
		itemName = "리틀 시바",
		description = ""
		.. "#{{Collectible532}} 일정 주기로 눈물을 흡수하는 눈물을 일렬로 5발 발사합니다."
		.. "#최대 5번 흡수 시 파열되어 8방향으로 작은 눈물이 발사됩니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	queueDesc = "소원을 비는 친구",
	},
	[wakaba.Enums.Collectibles.NEKO_FIGURE] = {
		itemName = "고양이 피규어",
		description = ""
		.. "#↓ {{DamageSmall}}공격력 배율 x0.9"
		.. "#캐릭터의 공격이 적의 방어력을 무시합니다."
		.. "#↑ {{UltraSecretRoom}}특급 비밀방에서 반드시 {{Quality3}}/{{Quality4}} 아이템이 등장합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.GUPPY .. "",
	queueDesc = "약해졌다... 하지만 대가는?",
	},
	[wakaba.Enums.Collectibles.DEJA_VU] = {
		itemName = "데자뷰",
		description = ""
		.. "#아이템이 등장할 때 12.5%의 확률로 캐릭터가 이미 소지한 아이템이 다시 등장합니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.GUPPY .. "",
	queueDesc = "잊혀져 가는 느낌",
	},
	[wakaba.Enums.Collectibles.LIL_MAO] = {
		itemName = "리틀 마오",
		description = ""
		.. "#↑ {{SpeedSmall}}이동속도 +0.15"
		.. "#스스로 움직일 수 없으며 둥근 레이저가 그녀 주변을 둘러쌉니다."
		.. "#캐릭터와 접촉 후 공격 키로 던질 수 있습니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.CONJOINED .. "",
	queueDesc = "던질 수 있는 친구",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		itemName = "이세계 정의서",
		description = ""
		.. "#사용 시 캐릭터와 같이 이동하며 공격하는 방향으로 캐릭터의 공격과 같은 공격을 발사하는 꼬마 클롯을 소환합니다."
		.. "#소환된 모든 꼬마 클롯의 체력을 2 회복합니다."
		.. "#최대 10마리까지 소환할 수 있으며 이후 사용 시 꼬마 클롯의 체력을 전부 회복합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "슬라임 소환",
	},
	[wakaba.Enums.Collectibles.BALANCE] = {
		itemName = "미러 밸런스",
		description = ""
		.. "#↑ {{Coin}}동전 +10"
		.. "#동전 5개를 소모하여 폭탄과 열쇠를 각각 1개씩 획득합니다."
		.. "#!!! 동전이 부족한 상태에서 사용 시: "
		.. "#폭탄 혹은 열쇠 중 갯수가 많은 쪽을 1개 차감하여 다른 쪽 픽업을 1개 획득합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "소모품 교환소 + 동전 10개",
	},
	[wakaba.Enums.Collectibles.MOE_MUFFIN] = {
		itemName = "모에의 머핀",
		description = ""
		.. "↑ {{Heart}}최대 체력 +1"
		.. "#↑ {{Heart}}빨간하트 +1"
		.. "#↑ {{DamageSmall}}공격력 +1.5"
		.. "#↑ {{RangeSmall}}사거리 +1.5"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "공격력, 사거리 증가",
	},
	[wakaba.Enums.Collectibles.MURASAME] = {
		itemName = "무라사메",
		description = ""
		.. "#!!! 소지 시 : "
		.. "#{{AngelDevilChance}} 악마방/천사방이 반드시 등장합니다."
		.. "#{{AngelChance}} 악마 거래 이후에도 천사방이 등장할 수 있습니다."
		.. "#!!! 사용 시 : "
		.. "#↑ {{AngelChance}}천사방 확률 +20%."
		.. "#현재 게임에서 처치한 보스 방의 보스 중 하나를 아군으로 부활시킵니다. 부활한 보스의 체력은 320으로 고정됩니다."
		.. "#보스 방을 클리어한 적이 없을 경우 Monstro가 소환됩니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "신사 지킴이",
	},
	[wakaba.Enums.Collectibles.CLOVER_SHARD] = {
		itemName = "클로버 잎사귀",
		description = ""
		.. "↑ 최대 체력 +1"
		.. "#↑ {{Heart}}빨간하트 +1"
		.. "#↑ {{DamageSmall}}공격력 배율 x1.11"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "계속 모아보자",
	},
	[wakaba.Enums.Collectibles.NASA_LOVER] = {
		itemName = "나사 러버",
		description = ""
		.. "공격하는 방향으로 공격력 3.5의 눈물을 발사합니다."
		.. "#캐릭터와 패밀리어의 공격이 적에게 부딪힐 때 마다 1~2개의 짧은 유도 레이저가 발사됩니다."
		.. "#{{Collectible565}} Blood Puppy가 플레이어를 공격하지 않습니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "전류 텔레파시",
	},
	[wakaba.Enums.Collectibles.ARCANE_CRYSTAL] = {
		itemName = "아케인 크리스탈",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 배율 1.12x"
		.. "#공격에 유도 효과가 생깁니다."
		.. "#적들이 대미지를 받을 때 70%의 확률로 한 번 더 받습니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "공격력 증가",
	},
	[wakaba.Enums.Collectibles.ADVANCED_CRYSTAL] = {
		itemName = "어드밴스드 크리스탈",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 배율 1.14x"
		.. "#공격이 적을 관통합니다."
		.. "#적들이 대미지를 받을 때 25%의 확률로 적의 방어를 무시합니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "공격력 증가",
	},
	[wakaba.Enums.Collectibles.MYSTIC_CRYSTAL] = {
		itemName = "미스틱 크리스탈",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 배율 1.16x"
		.. "#눈물에 후광이 생깁니다."
		.. "#{{Card" .. Card.CARD_HOLY .."}} 하트가 꽉 찬 상태에서 소울 하트 픽업을 집을 경우 Holy Mantle 방어막을 지급합니다. (최대 5회)"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "공격력 증가",
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		itemName = "3D 프린터",
		description = ""
		.. "#현재 소지 중인 장신구를 복제하여 흡수합니다."
		--[[ .. "#소지 중인 장신구가 없을 경우 흡수했던 장신구 중 하나를 복제하여 흡수합니다." ]]
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "장신구 복제기",
	},
	[wakaba.Enums.Collectibles.SYRUP] = {
		itemName = "시럽",
		description = ""
		.. "#!!! 소지 시:"
		.. "#↓ {{SpeedSmall}}이동속도 배율 x0.9"
		.. "#↑ {{RangeSmall}}사거리 +3"
		.. "#↑ {{DamageSmall}}공격력 +1.25"
		.. "#비행 능력을 얻습니다."
		.. "#!!! (사용 효과는 없습니다)"
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "떠다니는 거북이",
	},
	[wakaba.Enums.Collectibles.PLASMA_BEAM] = {
		itemName = "플라즈마 빔",
		description = ""
		.. "#↑ {{RangeSmall}}사거리 +2"
		.. "#↓ {{DamageSmall}}공격력 배율 x0.6"
		.. "#{{Burning}} 공격이 적을 관통하며 화상을 입힙니다.",
		queueDesc = "초강력 관통 공격",
	},
	[wakaba.Enums.Collectibles.POWER_BOMB] = {
		itemName = "파워 봄",
		description = ""
		.. "#↑ {{Bomb}}폭탄 +10"
		.. "#!!! 소지 중일 때 폭탄 사용 불가"
		.. "#!!! 사용 시 현재 폭탄의 절반만큼 소모하며;"
		.. "#그 방의 모든 적에게 피해를 주며 모든 돌 오브젝트와 문을 파괴합니다."
		.. "#!!! 틱 당 폭발 공격력 : 사용한 폭탄 수 * 0.2"
		.. "#적 처치 시 8%의 확률로 1.5초 후 사라지는 폭탄을 드랍합니다."
		.. "#{{LuckSmall}} :8+({{LuckSmall}})%/최대10%"
		.. "{{CR}}",
		queueDesc = "압축식 폭발 공격",
	},
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = {
		itemName = "마그마 블레이드",
		description = ""
		.. "#{{Burning}} 공격 시 캐릭터의 공격방향으로 공격력 x3의 화염 검기를 추가로 발사합니다."
		.. "#눈물 공격이 아닌 경우 {{DamageSmall}}공격력 배율 x2."
		.. "{{CR}}",
		queueDesc = "마그마 스트림",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		itemName = "팬텀 클로크",
		description = ""
		.. "#짧은 시간동안 캐릭터의 모습을 숨겨 은폐 상태로 만듭니다."
		.. "#캐릭터가 숨어있는 동안 캐릭터를 향해 공격하던 적들은 혼란 상태이상에 걸립니다."
		.. "#!!! 은폐 상태에도 캐릭터는 무적이 아닙니다."
		.. "#움직이거나 공격 중일 때 시간을 더 빨리 소모합니다."
		.. "#완충 상태에서만 사용할 수 있으며 게이지는 공격 중이거나 움직일 때만 회복할 수 있습니다."
		.. "#캐릭터가 숨어있는 동안 도전방, 보스 도전방의 문이 열립니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "은신은 무적이 아니다",
	},
	[wakaba.Enums.Collectibles.RED_CORRUPTION] = {
		itemName = "적색 감염",
		description = "{{Collectible21}} 맵에 특수방의 위치를 표시합니다."
		.. "#보스방을 제외한 모든 특수 방이 빨간 방으로 바뀝니다."
		.. "#가능한 경우, 특수 방 주변에 새로운 방이 생성됩니다."
		.. "#!!! {{ErrorRoom}}오류방으로 향하는 문이 생성될 수 있습니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "감염된 지도",
	},
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		itemName = "물음표 블럭",
		description = ""
		.. "#사용시 25%의 확률로 아이템을 소환합니다."
		.. "#Magic Mushroom을 갖고 있지 않은 경우 반드시 해당 아이템이 소환됩니다."
		.. "#!!! 패널티 피격 시 Magic Mushroom 아이템이 사라집니다."
		.. "#!!! Magic Mushroom 아이템이 없는 상태에서 패널티 피격 시 The Lost 캐릭터로 변합니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "뭔가 익숙한 상자다",
	},
	[wakaba.Enums.Collectibles.CLENSING_FOAM] = {
		itemName = "클렌징 폼",
		description = ""
		.. "#{{Poison}} 캐릭터와 가까이 있는 적을 중독시킵니다."
		.. "#캐릭터와 가까이 있는 일반 몬스터의 챔피언 속성을 제거합니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "강화 해제",
	},
	[wakaba.Enums.Collectibles.BEETLEJUICE] = {
		itemName = "비틀쥬스",
		description = ""
		.. "#{{Pill}} 확인되지 않은 알약의 효과를 알 수 있습니다."
		.. "#{{Pill}} 사용 시 현재 게임의 알약 효과 중 8개를 랜덤으로 바꾸며 바뀐 알약 중 하나를 드랍합니다."
		.. "#{{Pill}} 소지한 상태에서 방 클리어 시 알약을 추가로 드랍합니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "알약 내용물을 바꾸는 능력",
	},
	[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] = {
		itemName = "탑의 저주 2",
		description = ""
		.. "#{{GoldenBomb}} 항상 황금폭탄을 가집니다."
		.. "#피격 시 황금 트롤폭탄 하나를 소환합니다."
		.. "#!!! 경고: 모든 트롤 폭탄이 황금 트롤폭탄으로 바뀝니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "이제 그만 혼돈을 받아들이자",
	},
	[wakaba.Enums.Collectibles.ANTI_BALANCE] = {
		itemName = "안티 밸런스",
		description = ""
		.. "#{{Pill}} 모든 알약을 거대 알약으로 바꿉니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.BOOKWORM .. "",
	queueDesc = "극과 극은 통한다",
	},
	[wakaba.Enums.Collectibles.VENOM_INCANTATION] = {
		itemName = "고독의 주법",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#{{Poison}} 독/화상 공격이 5%의 확률로 적을 즉사시킵니다.#{{Blank}} (일반 보스의 경우 1.36%)"
		.. "{{CR}}",
		queueDesc = "독에서 도망칠 수 없다",
	},
	[wakaba.Enums.Collectibles.FIREFLY_LIGHTER] = {
		itemName = "반딧불이 병",
		description = ""
		.. "#↑ {{RangeSmall}}사거리 +2"
		.. "#↑ {{LuckSmall}}행운 +1"
		.. "#{{WakabaAntiCurseDarkness}} Darkness 저주에 걸리지 않습니다."
		.. "#버튼으로 인한 함정이 발동되어도 방 클리어 보상을 소환합니다."
		.. "{{CR}}",
		transformations = EID.TRANSFORMATION.LORD_OF_THE_FLIES .. "",
		queueDesc = "사거리, 행운 증가 + 반딧불이의 도움",
	},
	[wakaba.Enums.Collectibles.DOUBLE_INVADER] = {
		itemName = "침략자",
		description = ""
		.. "#↓ 악마/천사방이 더 이상 등장하지 않습니다."
		.. "#↑ {{DamageSmall}}공격력 배율 x2.5#{{Blank}} (중첩 시 x1.0배 추가)"
		.. "{{CR}}",
		queueDesc = "공격력 대폭 증가... 그 대가는?",
	},
	[wakaba.Enums.Collectibles.SEE_DES_BISCHOFS] = {
		itemName = "비숍의 강물",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#{{Collectible584}} 4번째 방 진입 시마다 Book of Virtues의 불꽃을 소환합니다."
		.. "#{{Player"..wakaba.Enums.Players.TSUKASA_B.."}} 사망 시 전 방에서 Tainted Tsukasa로 부활합니다."
		.. "{{CR}}",
		queueDesc = "모든 비극의 시작",
	},
	[wakaba.Enums.Collectibles.JAR_OF_CLOVER] = {
		itemName = "클로버 씨앗 병",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#↑ 게임 시간 120초마다 {{LuckSmall}}행운 +1"
		.. "#{{Player"..wakaba.Enums.Players.WAKABA.."}} 사망 시 전 방에서 Wakaba로 부활합니다."
		.. "#{{Player"..wakaba.Enums.Players.WAKABA_B.."}} Tainted Wakaba의 경우 Wakaba 캐릭터로 변경되지 않습니다."
		.. "{{CR}}",
		queueDesc = "그녀가 태어날 때까지",
	},
	[wakaba.Enums.Collectibles.CRISIS_BOOST] = {
		itemName = "크라이시스 부스트",
		description = ""
		.. "#↑ {{TearsSmall}}연사 +1"
		.. "#↑ 전체 체력이 적을수록 {{DamageSmall}}공격력 배율 증가"
		.. "#{{Blank}} (체력 1칸일 때 최대 x2.5)"
		.. "{{CR}}",
		queueDesc = "위기에 빠질수록 강해지다",
	},
	[wakaba.Enums.Collectibles.PRESTIGE_PASS] = {
		itemName = "프리스티지 패스",
		description = ""
		.. "#{{BossRoom}}보스방 클리어 시 재입고 기계를 생성합니다."
		.. "#{{DevilRoom}}악마방/{{AngelRoom}}천사방, {{Planetarium}}천체관, {{SecretRoom}}비밀방, {{UltraSecretRoom}}특급비밀방, 블랙마켓에 재입고 기계를 생성합니다."
		.. "{{CR}}",
		queueDesc = "리셰쨩의 마법",
	},
	[wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		itemName = "카라멜로 팬케이크",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#{{Player"..wakaba.Enums.Players.RICHER.."}} 사망 시 전 방에서 Richer로 부활합니다."
		.. "#{{Player"..wakaba.Enums.Players.RICHER_B.."}} Tainted Richer의 경우 Richer 캐릭터로 변경되지 않습니다."
		.. "{{CR}}",
		queueDesc = "잊혀진 레시피",
	},
	[wakaba.Enums.Collectibles.EASTER_EGG] = {
		itemName = "이스터 에그",
		description = ""
		.. "#캐릭터 주위를 돌며 공격하는 방향으로 공격력 1의 유도 눈물을 발사합니다."
		.. "#이스터 코인을 모을 때마다 공격력과 공격 속도가 증가합니다."
		.. "{{CR}}",
		queueDesc = "수상한 달걀",
	},
	[wakaba.Enums.Collectibles.ONSEN_TOWEL] = {
		itemName = "온천 타월",
		description = ""
		.. "#↑ {{SoulHeart}}소울하트 +1"
		.. "#타이머가 1분 00초가 될 때마다 45%의 확률로 {{HalfSoulHeart}}소울하트 반 칸을 회복합니다."
		.. "{{CR}}",
		queueDesc = "영혼 재생 + 체력 증가",
	},
	[wakaba.Enums.Collectibles.SUCCUBUS_BLANKET] = {
		itemName = "서큐버스의 망토",
		description = ""
		.. "#↑ {{BlackHeart}}블랙하트 +1"
		.. "#타이머가 1분 00초가 될 때마다 45%의 확률로 {{HalfBlackHeart}}블랙하트 반 칸을 회복합니다."
		.. "{{CR}}",
		queueDesc = "타락한 영혼 재생 + 체력 증가",
	},
	[wakaba.Enums.Collectibles.CUNNING_PAPER] = {
		itemName = "커닝 페이퍼",
		description = ""
		.. "#{{Card}} 사용할 때마다 랜덤 카드의 효과를 발동합니다."
		.. "{{CR}}",
		queueDesc = "베끼는 건 안돼!",
	},
	[wakaba.Enums.Collectibles.TRIAL_STEW] = {
		itemName = "시련의 국",
		description = "!!! 캐릭터의 전체 체력이 반칸 + 보호막이 없을 때:#↑ {{TearsSmall}}연사(+상한) +8#↑ {{DamageSmall}}공격력 배율 x2",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		itemName = "와카바의 꿈꾸는 꿈",
		description = ""
		.. "#↓ 악마/천사방이 더 이상 등장하지 않습니다."
		.. "#사용 시 와카바의 꿈이 바뀝니다."
		.. "#아이템이 등장할 경우 해당 꿈에 해당되는 배열의 아이템이 등장합니다."
		.. "#방 클리어 시 8%의 확률로 {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}와카바의 꿈 카드를 드랍합니다."
		.. "{{CR}}",
	transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.LEVIATHAN .. "," .. EID.TRANSFORMATION.BOOKWORM,
	queueDesc = "영원한 꿈",
	},
	[wakaba.Enums.Collectibles.EDEN_STICKY_NOTE] = {
		itemName = "에덴의 접착제",
		description = ""
		.. "#!!! 알트 에덴 전용"
		.. "#!!! 일회용"
		.. "#사용 시 생득권을 획득하며 현재 소지 중인 첫번째 액티브 아이템을 픽업 슬롯으로 옮깁니다."
		.. "{{CR}}",
	--transformations = EID.TRANSFORMATION.ANGEL .. "," .. EID.TRANSFORMATION.LEVIATHAN .. "," .. EID.TRANSFORMATION.BOOKWORM,
	queueDesc = "붙이기 전에 생각하자",
	},
}

wakaba.descriptions[desclang].bingeeater = {
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		description = "↑ {{DamageSmall}}공격력 +1.0#↓ {{SpeedSmall}}이동속도 -0.04",
	},
	--[[ [wakaba.Enums.Collectibles.MOE_MUFFIN] = {
		description = "+1.0 Damage Up",
	}, ]]
	--[[ [wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		description = "+1.0 Damage Up",
	}, ]]
}
wakaba.descriptions[desclang].belial = {
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "뼈하트 대신 {{BlackHeart}}블랙하트 1개를 획득합니다.",
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		description = "교복에 담긴 알약/카드/룬의 갯수만큼 {{Card16}}XV - 악마 카드 효과를 같이 발동합니다.", 
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		description = "{{Card41}}블랙 룬을 획득할 확률이 50%로 증가합니다.#{{ColorWakabaNemesis}}10%의 확률로 {{Card41}}블랙 룬의 효과를 발동합니다.", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		description = "{{Collectible" .. CollectibleType.COLLECTIBLE_DARK_ARTS .. "}}흑마술의 효과 발동과 동시에 지운 투사체 수만큼 방 안의 모든 적들에게 대미지를 줍니다.", 
	},
	--[[ [wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		description = "블랙 하트 타입의 꼬마 클롯을 소환합니다.", 
	}, ]]
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		description = "(사용 시 부가효과 없음)#↑ {{ColorWakabaNemesis}} {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}와카바의 꿈 카드의 등장 확률 +4%", 
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		description = "은폐 상태일 때 {{DamageSmall}}공격력 배율 x1.25", 
	},
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		description = "아이템 소환 시 악마방 배열의 아이템이 소환됩니다.", 
	},
}
wakaba.descriptions[desclang].bookofvirtues = {

	--[[ Book of Virtues
		Ring position > count
		tearvariants
		effects
		when destroyed
	 ]]

	[wakaba.Enums.Collectibles.EATHEART] = {
		description = "{{ColorLime}}내부 링 1마리: {{CR}}#불꽃이 어떠한 피해도 입지 않습니다."
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "{{ColorYellow}}중앙 링 1마리: {{CR}}#불꽃이 꺼지면 {{BoneHeart}}뼈하트, 혹은 아군 Bony류 몬스터를 소환합니다."
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		description = "{{ColorRed}}!!!불꽃이 소환되지 않음 {{CR}}#소지한 상태에는 현재 켜져 있는 모든 불꽃이 어떠한 피해도 입지 않습니다.#소모성 픽업 사용 시 현재 켜져 있는 모든 불꽃에 대응되는 액티브 아이템을 전부 발동합니다."
	},
	[wakaba.Enums.Collectibles.COUNTER] = {
		description = "{{ColorOrange}}외부 링 1마리: {{CR}}사용한 방에서만 존재#카운터가 발동 중일 때 모든 불꽃이 무적이 됩니다."
	},
	[wakaba.Enums.Collectibles.D6_PLUS] = {
		description = "{{ColorLime}}내부 링 1마리: {{CR}}바꾼 아이템의 수만큼 불꽃을 추가로 소환합니다."
	},
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		description = "{{ColorLime}}내부 링 1마리: {{CR}}바꾼 아이템의 수만큼 불꽃을 추가로 소환합니다."
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		description = "{{ColorYellow}}중앙 링 1마리: {{CR}}#유도 눈물을 발사합니다."
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		description = "{{ColorYellow}}중앙 링 1마리: {{CR}}#{{Rune}}적을 처치할 때 15%의 확률로 룬을 드랍합니다.#{{Rune}}불꽃이 꺼지면 룬을 드랍합니다."
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "{{ColorOrange}}외부 링 1마리: {{CR}}#불꽃이 꺼지면 꼬마 아이작을 소환합니다."
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		description = "{{ColorOrange}}외부 링 1마리: {{CR}}#모든 탄막에 무적이며 불꽃 주변의 탄막을 지웁니다.#접촉 시 사라집니다."
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		description = "{{ColorOrange}}외부 링 1마리: {{CR}}#불꽃이 어떠한 피해도 입지 않습니다.#불꽃이 적에게 닿으면 해당 적을 아군으로 만드면서 불꽃이 꺼집니다."
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		description = "{{ColorLime}}내부 링 1마리: {{CR}}불꽃의 체력이 매우 높음#불꽃이 켜져있는 동안 사망 시 이 불꽃을 소모하여 부활합니다."
	},
	--[[ [wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		description = "{{ColorRed}}!!!링에 귀속되지 않는 불꽃 6마리: {{CR}}#이 아이템으로 부활한 이후 불꽃이 소환되며 불꽃이 적을 따라다니면서 피해를 줍니다.#불꽃이 어떠한 피해도 입지 않습니다."
	}, ]]
	[wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY] = {
		description = "{{ColorOrange}}외부 링 1마리: {{CR}}#불꽃이 꺼지면 Unknown Bookmark를 드랍합니다."
	},
	--[[ [wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		description = "{{ColorRed}}!!!불꽃이 소환되지 않음 {{CR}}#현재 켜져 있는 모든 불꽃을 흡수하며 능력치로 환산합니다."
	}, ]]
	--[[ [wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		description = "{{ColorLime}}내부 링 1마리: {{CR}}#캐릭터와 같은 공격력의 눈물을 발사합니다."
	}, ]]
	[wakaba.Enums.Collectibles.BALANCE] = {
		description = "{{ColorRed}}!!!불꽃이 소환되지 않음 {{CR}}#열쇠와 폭탄의 수가 같은 상태에서 현재 켜져 있는 모든 불꽃이 어떠한 피해도 입지 않습니다."
	},
	--[[ [wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		description = "{{ColorRed}}!!!불꽃이 소환되지 않음 {{CR}}#시프트 시 일정 시간동안 현재 켜져 있는 모든 불꽃이 어떠한 피해도 입지 않습니다."
	}, ]]
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		description = "{{ColorOrange}}내부 링 1마리: {{CR}}(최대 1)#불꽃이 어떠한 피해도 입지 않습니다.#불꽃이 켜져있는 동안 사망 시 이 불꽃을 소모하여 부활합니다."
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		description = "{{ColorYellow}}중앙 링 1마리: {{CR}}#불꽃이 꺼지면 장신구를 드랍합니다."
	},

	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		description = "{{ColorRed}}!!!효과 없음{{CR}}"
	},




	
}
wakaba.descriptions[desclang].abyss = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		description = "deals 7x faster than normal locust, double of Isaac's Damage, chases through enemies, and freezes on death"
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		description = "deals 5X of Isaac's Damage"
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		description = "deals 3.5x faster than normal locust, triple of Isaac's Damage, travels at double speed"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "deals 3.5x faster than normal locust, double of Isaac's Damage, travels at double speed"
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		description = "deals 1.2x faster than normal locust, double of Isaac's Damage"
	},
	[wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD] = {
		description = "deals 1.7x faster than normal locust, double of Isaac's Damage"
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		description = "3 Locusts that deal 1.7x faster than normal locust"
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		description = "2 yellow locust that deal 7x faster than normal locust, 0.8x Isaac's Damage, drops coins when dealing damage"
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		description = "Plumy Locust deals 2.3x faster than normal locust, 4x Isaac's Damage"
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		description = "4.2x 'slower' than normal locust, 16x Isaac's Damage, travels at 0.1x speed"
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		description = "5 Locusts that deal 2.3x faster than normal locust, drops card when killed by the locust"
	},
	[wakaba.Enums.Collectibles.LIL_WAKABA] = {
		description = "deals 1.3x faster than normal locust, travels 3x speed"
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "3 Locusts that deals 7x faster than normal locust, 0.9x Isaac's Damage, travels 3x speed"
	},
}
wakaba.descriptions[desclang].wakaba = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		description = "{{TearsSmall}}연사 배율 x1.25",
	},
	[CollectibleType.COLLECTIBLE_URANUS] = {
		description = "{{DamageSmall}}공격력 배율 x1.5#{{ColorWakabaBless}}와카바의 공격이 적의 방어력을 무시합니다.",
	},
	
}
wakaba.descriptions[desclang].wakaba_b = {
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		description = "{{DamageSmall}}공격력 +4#{{ColorWakabaNemesis}}모든 행운 증가 효과가 적용되지 않습니다.",
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		description = "{{DamageSmall}}알약 사용 시마다 공격력 +0.35#{{ColorWakabaNemesis}}모든 행운 증가 효과가 적용되지 않습니다.",
	},
}
wakaba.descriptions[desclang].shiori = {
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "작은 아이작 패밀리어를 3마리 소환합니다.",
	},
}
wakaba.descriptions[desclang].shiori_b = {
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "작은 아이작 패밀리어를 3마리 소환합니다.",
	},
}
wakaba.descriptions[desclang].tsukasa = {
	
}
wakaba.descriptions[desclang].tsukasa_b = {
	
}
wakaba.descriptions[desclang].richer = {
	
}
wakaba.descriptions[desclang].richer_b = {
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		description = ""
		.. "#{{WakabaAntiCurseBlind}} 소지 중일 때 Blind 저주에 걸리지 않습니다."
		.. "#사용 시 선택한 불꽃을 흡수하여 아이템으로 획득합니다."
		.. "#{{ButtonRT}}버튼으로 흡수할 불꽃을 선택할 수 있습니다."
		.. "{{CR}}",
	},
}
wakaba.descriptions[desclang].bless = {
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		description = "{{AngelDevilChance}}악마방/천사방이 Hush 스테이지를 제외한 모든 층에서 항상 등장합니다.#↑ {{ColorWakabaBless}}선택형 아이템을 모두 획득할 수 있습니다.",
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		description = "아이템을 2개 소환합니다.", 
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		description = "{{LuckSmall}}행운을 최소 10 이상으로 설정#↑ {{ColorWakabaBless}}행운에 영향을 주는 아이템의 갯수만큼 {{LuckSmall}}행운 + 0.5", 
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		description = "플럼이가 캐릭터의 눈물을 발사할 수 있게 됩니다.", 
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		description = "지우개 눈물 발사 확률 10x", 
	},
}
wakaba.descriptions[desclang].nemesis = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		description = "{{AngelDevilChance}}악마방/천사방이 Hush 스테이지를 제외한 모든 층에서 항상 등장합니다.#↑ {{ColorWakabaNemesis}}선택형 아이템을 모두 획득할 수 있습니다.",
	},
	[wakaba.Enums.Collectibles.REVENGE_FRUIT] = {
		description = "혈사포 발사확률 x2#{{ColorWakabaNemesis}}혈사포에 유도 기능이 생깁니다.", 
	},
}
wakaba.descriptions[desclang].bookofshiori = {
	[CollectibleType.COLLECTIBLE_BIBLE] = {
		description = "현재 방에서 {{DamageSmall}}공격력 배율 x1.2, {{HolyMantle}}1회의 피격을 막아주는 보호막이 제공됩니다.#{{ColorBookofShiori}}다음 책 사용 시까지 {{Collectible331}}눈물에 후광이 생깁니다.", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] = {
		description = "현재 방에서 {{DamageSmall}}추가 공격력 +1.5#{{ColorBookofShiori}}다음 책 사용 시까지 {{Collectible462}}벨리알의 눈효과가 적용됩니다.", 
	},
	[CollectibleType.COLLECTIBLE_NECRONOMICON] = {
		description = "캐릭터 공격력 64%의 위력의 검은 고리를 5개를 발사합니다.#{{ColorBookofShiori}}다음 책 사용 시까지 {{Collectible592}}눈물이 돌이 됩니다.", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS] = {
		description = "(부가효과 없음)#{{ColorBookofShiori}}다음 책 사용 시까지 {{Collectible213}}눈물이 적의 투사체를 막아줍니다.", 
	},
	[CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK] = {
		description = "현재 방에서 적들이 폭발 피해를 2배로 받으며 처치 시 낮은 확률로 {{BlackHeart}}블랙하트를 드랍합니다.#{{ColorBookofShiori}}다음 책 사용 시까지 폭발성 눈물을 발사하며 폭발에 면역이 됩니다.", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS] = {
		description = "현재 층에서 4기사 패밀리어 2마리 소환합니다.#{{ColorBookofShiori}}다음 책 사용 시까지 일정 확률로 적에게 맞으면 빛줄기가 내려오는{{Collectible374}} 눈물을 발사합니다.", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SIN] = {
		description = "(부가효과 없음)#{{ColorBookofShiori}}다음 책 사용 시까지 적 처치시 일정 확률로 픽업 아이템을 드랍합니다.", 
	},
	[CollectibleType.COLLECTIBLE_MONSTER_MANUAL] = {
		description = "(부가효과 없음)#{{ColorBookofShiori}}다음 책 사용 시까지 패밀리어의 공격력 x3", 
	},
	[CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] = {
		description = "현재 방에서 벽을 넘나드는{{Collectible369}} 눈물을 발사합니다.#{{ColorBookofShiori}}다음 책 사용 시까지 {{Collectible3}}유도 + {{Collectible494}}전기 눈물을 발사합니다.", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS] = {
		description = "Darkness 및 Lost 저주를 해제하며 3종류의 지도 효과를 전부 발동합니다.#{{ColorBookofShiori}}다음 책 사용 시까지 적에게 {{Collectible618}}표식을 박는 눈물을 발사합니다.", 
	},
	[CollectibleType.COLLECTIBLE_SATANIC_BIBLE] = {
		description = "현재 층에서 {{DamageSmall}}추가 공격력 +1.0#{{ColorBookofShiori}}다음 책 사용 시까지 적에게 {{Collectible259}}공포를 거는 눈물을 발사합니다.", 
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD] = {
		description = "아군 Bony를 추가로 소환합니다.#{{ColorBookofShiori}}다음 책 사용 시까지 {{Collectible237}}낫을 발사합니다.", 
	},
	[CollectibleType.COLLECTIBLE_LEMEGETON] = {
		description = "일정 확률로 켜져 있는 아이템 위습 하나를 흡수합니다.#{{ColorBookofShiori}}다음 책 사용 시까지 적 처치시 일정 확률로 {{Battery}}배터리류 픽업을 드랍합니다.", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		description = "아군으로 만들 적을 선택할 수 있습니다.#{{ColorBookofShiori}}일반 적은 {{Key}}열쇠를, 보스는 추가로 {{Bomb}}폭탄을 소모합니다.", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "(부가효과 없음)#{{ColorBookofShiori}}다음 책 사용 시까지 {{Collectible453}}뼈 눈물을 발사합니다.", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		description = "캐릭터가 움직이지 않을 경우 공격이 적의 방어력을 무시합니다.#!!! {{ColorBookofShiori}}시오리의 책 지속 효과를 초기화합니다.",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		description = "(부가효과 없음)#{{ColorBookofShiori}}다음 책 사용 시까지 적 처치시 일정 확률로 {{Rune}}룬을 드랍합니다.", 
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "작은 아이작 패밀리어가 받는 피해량이 매우 크게 줄어듭니다.#{{ColorBookofShiori}}다음 책 사용 시까지 작은 아이작 패밀리어가 캐릭터의 공격 일부분을 복사합니다.", 
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		description = "2초동안 추가로 투사체를 제거합니다.#!!! {{ColorBookofShiori}}시오리의 책 지속 효과를 초기화합니다.", 
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		description = "(부가효과 없음) #{{ColorBookofShiori}}다음 책 사용 시까지 {{Collectible579}}검은 영혼의 검을 사용할 수 있습니다.", 
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		description = "은폐 상태일 때 캐릭터를 향해 공격하던 적들은 추가로 둔화에 걸립니다.#{{ColorBookofShiori}}(이전 눈물 효과 유지)", 
	},
}
wakaba.descriptions[desclang].murasame = {
	
}
wakaba.descriptions[desclang].flashshift = {
	
}
wakaba.descriptions[desclang].flashmurasame = {
	
}


wakaba.descriptions[desclang].trinkets = {
	[wakaba.Enums.Trinkets.BRING_ME_THERE] = {
		itemName = "나를 데려다 줘",
		description = ""
		.. "#↑ {{TearsSmall}}연사 +1.5"
		.. "#이 장신구를 소지한 상태에서 Mausoleum/Gehenna II에 진입할 경우 엄마(Mom) 대신 아빠의 노트(Dad's Note)가 등장합니다."
		.. "#이 장신구는 Mines/Ashpit II, Mausoleum/Gehenna I 스테이지 시작방에서도 등장합니다."
		.. "#!!! {{ColorRed}}아빠의 노트로 교체된 경우 더 이상 Womb/Corpse 스테이지로 진입할 수 없습니다.{{ColorReset}}"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "들고 가는 거 잊지 마!",
	},
	[wakaba.Enums.Trinkets.BITCOIN] = {
		itemName = "비트코인 II",
		description = ""
		.. "#소모성 픽업의 갯수와 스탯을 랜덤하게 뒤섞습니다."
		.. "#방을 입장할 때마다 스탯을 랜덤하게 뒤섞습니다."
		.. "#각각의 픽업 소지 수는 0개부터 999개 까지 나올 수 있습니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "도박 중독",
	},
	[wakaba.Enums.Trinkets.CLOVER] = {
		itemName = "클로버",
		description = ""
		.. "↑ {{TearsSmall}}연사 +0.3"
		.. "#↑ {{LuckSmall}}행운 +2"
		.. "#↑ {{LuckSmall}}행운 배율 x2"
		.. "#↑ 행운이 0 이하인 경우 0 이상이 되도록 반전됩니다."
		.. "#행운 동전의 등장 확률이 증가합니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "행운 증가",
	},
	[wakaba.Enums.Trinkets.MAGNET_HEAVEN] = {
		itemName = "무한 자석",
		description = ""
		.. "#모든 소모성 동전/폭탄/열쇠를 자동으로 수집합니다."
		.. "#끈적한 니켈을 니켈로 바꿉니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "꿈꿔왔던 순간",
	},
	[wakaba.Enums.Trinkets.HARD_BOOK] = {
		itemName = "금이 간 책",
		description = ""
		.. "#피격 시 낮은 확률로 책 아이템 하나를 드랍합니다."
		.. "#{{SacrificeRoom}} 희생방에서 피격 시 100%의 확률로 책 아이템을 드랍합니다."
		.. "#!!! 책 아이템 드랍 시 장신구는 사라집니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "이 책, 연약해",
	},
	[wakaba.Enums.Trinkets.DETERMINATION_RIBBON] = {
		itemName = "결의의 리본",
		description = ""
		.. "#피격 대미지를 하트 반 칸으로 줄입니다."
		.. "#이 장신구를 들고 있는 동안에는 사망하지 않습니다."
		.. "#!!! {{ColorYellow}}희생 방 가시는 이 장신구의 효과를 무시합니다.{{ColorReset}}"
		.. "#!!! 피격 시 2%의 확률로 해당 장신구가 강제로 바닥에 놓여집니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "결의를 가져야 한다!",
	},
	[wakaba.Enums.Trinkets.BOOKMARK_BAG] = {
		itemName = "책갈피 가방",
		description = ""
		.. "#방에 처음으로 진입 할 때 랜덤 일회성 책 액티브 아이템을 획득합니다."
		.. "#시오리 캐릭터가 가질 수 있는 책이 나옵니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "뭔가 섞여있어...",
	},
	[wakaba.Enums.Trinkets.RING_OF_JUPITER] = {
		itemName = "유피테르의 유대",
		description = ""
		.. "↑ {{TearsSmall}}연사 +20%"
		.. "#↑ {{SpeedSmall}}이동속도 +10%"
		.. "#↑ {{DamageSmall}}공격력 +16%"
		.. "#↑ {{ShotspeedSmall}}탄속 +5%"
		.. "#↑ {{LuckSmall}}행운 +1"
		.. "#모든 플레이어가 해당 장신구의 스탯 증가량만큼 증가합니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "자매의 유대감",
	},
	[wakaba.Enums.Trinkets.DIMENSION_CUTTER] = {
		itemName = "차원검",
		description = ""
		.. "#클리어 하지 않은 방 진입 시 15%의 확률로 임의의 {{Collectible510}}델리리움의 모습을 한 보스가 등장합니다."
		.. "#{{GreedModeSmall}} Greed 모드의 경우 5%, {{LuckSmall}}행운 10+일 때 25%"
		.. "#↑ {{Card"..Card.CARD_CHAOS.."}}카오스 카드가 델리리움과 비스트에게 대미지를 줄 수 있습니다.(틱 당 339)"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "텅 비어 있는 기억",
	},
	[wakaba.Enums.Trinkets.DELIMITER] = {
		itemName = "구분자",
		description = ""
		.. "#!!! 새로운 방에 진입 시 다음 효과 발동:"
		.. "#색돌과 금광을 파괴합니다."
		.. "#기둥, 검은 블록, 가시돌을 일반 돌로 바꿉니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "약해진 지반",
	},
	[wakaba.Enums.Trinkets.RANGE_OS] = {
		itemName = "강습형 전투 시스템",
		description = ""
		.. "#↓ {{RangeSmall}}사거리 배율 x0.55"
		.. "#↑ {{DamageSmall}}공격력 배율 x2.25"
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "좀 더 가까이",
	},
	[wakaba.Enums.Trinkets.SIREN_BADGE] = {
		itemName = "사이렌 뱃지",
		description = ""
		.. "#캐릭터가 접촉 피해를 받지 않습니다."
		.. "{{CR}}",
		--transformations = EID.TRANSFORMATION.ANGEL .. "",
	queueDesc = "키스하는 건 무죄",
	},
	[wakaba.Enums.Trinkets.ISAAC_CARTRIDGE] = {
		itemName = "아이작 카트리지",
		description = ""
		.. "#아이작의 번제 오리지널 ~ 리버스의 아이템만 등장합니다."
		.. "#{{Collectible619}}Birthright 및 모드 아이템도 등장합니다."
		.. "{{CR}}",
		queueDesc = "그 때 그 시절로",
	},
	[wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE] = {
		itemName = "애프터버스 카트리지",
		description = ""
		.. "#아이작의 번제 오리지널 ~ 애프터버스+의 아이템만 등장합니다."
		.. "#{{Collectible619}}Birthright도 등장합니다."
		.. "{{CR}}",
		queueDesc = "그 때 그 시절로",
	},
	[wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE] = {
		itemName = "리펜턴스 카트리지",
		description = ""
		.. "#아이작의 번제 오리지널 ~ 리펜턴스의 아이템만 등장합니다."
		.. "{{CR}}",
		queueDesc = "그 때 그 시절로",
	},
	[wakaba.Enums.Trinkets.STAR_REVERSAL] = {
		itemName = "별빛 뒤집기",
		description = ""
		.. "#!!! 일회용"
		.. "#{{TreasureRoom}}보물방에서 장신구를 버리면 {{Planetarium}}천체관 아이템으로 바뀝니다."
		.. "{{CR}}",
		queueDesc = "황금빛 장소로 가져다줘",
	},
	[wakaba.Enums.Trinkets.AURORA_GEM] = {
		itemName = "오로라 보석",
		description = ""
		.. "#이스터 코인의 등장 확률이 6.66% 증가합니다."
		.. "#{{LuckSmall}} : 6.66 +(1*{{LuckSmall}})%"
		.. "{{CR}}",
		queueDesc = "황금빛 장소로 가져다줘",
	},
	[wakaba.Enums.Trinkets.MISTAKE] = {
		itemName = "실패한 요리",
		description = ""
		.. "#피격 시 그 방의 적 하나가 폭발하며 그 적 주변에 100의 피해를 줍니다."
		.. "{{CR}}",
		queueDesc = "리셰쨩이라도 실패할 때가 있다구",
	},
	
}
wakaba.descriptions[desclang].goldtrinkets = {
	[wakaba.Enums.Trinkets.CLOVER] = {
		mode = "prepend",
	},
	[wakaba.Enums.Trinkets.RING_OF_JUPITER] = {
		mode = "prepend",
	},
	[wakaba.Enums.Trinkets.BRING_ME_THERE] = {
		mode = "prepend",
	},
	[wakaba.Enums.Trinkets.HARD_BOOK] = {
		mode = "number",
		origin = "책 아이템 하나",
		double = "책 아이템 두개",
		triple = "책 아이템 세개",
	},
}
wakaba.descriptions[desclang].cards = {
	[wakaba.Enums.Cards.CARD_CRANE_CARD] = {
		itemName = "인형뽑기 카드",
		description = "{{CraneGame}} 인형뽑기(크레인 게임) 기계를 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = {
		itemName = "고해실 카드",
		description = "{{Confessional}} 고해실 부스를 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_BLACK_JOKER] = {
		itemName = "블랙 조커",
		description = "#{{DevilChance}} 카드를 소지하는 동안 천사방이 등장하지 않습니다. #사용 시 {{DevilRoom}}악마방으로 텔레포트합니다.",
	},
	[wakaba.Enums.Cards.CARD_WHITE_JOKER] = {
		itemName = "화이트 조커",
		description = "#{{AngelChance}} 카드를 소지하는 동안 악마방이 등장하지 않습니다. #사용 시 {{AngelRoom}}천사방으로 텔레포트합니다.",
	},
	[wakaba.Enums.Cards.CARD_COLOR_JOKER] = {
		itemName = "컬러 조커",
		description = "#{{BrokenHeart}} 부서진 하트의 갯수를 6개로 설정합니다. 와카바는 이 효과의 영향이 없습니다.#액티브/패시브 아이템 3개와 카드 혹은 룬 8개를 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = {
		itemName = "스페이드 Q",
		description = "#사용 시 3~26개의 {{Key}}열쇠를 드랍합니다.",
	},
	[wakaba.Enums.Cards.CARD_DREAM_CARD] = {
		itemName = "와카바의 꿈 카드",
		description = "#사용 시 현재 방 배열의 랜덤 아이템 하나를 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = {
		itemName = "미지의 책갈피",
		description = "#사용 시 임의의 책 효과를 발동합니다.",
	},
	[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = {
		itemName = "리턴 토큰",
		description = "{{Collectible636}} 사용 시 R 키 효과 발동:#소지중인 아이템과 능력치가 유지된 상태로 게임을 다시 시작합니다.#{{Timer}} 게임 시간이 초기화됩니다.#!!! {{ColorRed}}체력을 포함한{{CR}} 캐릭터의 모든 픽업 아이템을 지웁니다.",
	},
	[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = {
		itemName = "미네르바 티켓",
		description = "{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} 사용 시 그 방에서 오라를 발산합니다."
		.. "#오라 안에 있는 아군 몬스터는 최대 체력의 2배까지 지속적으로 회복합니다."
		.. "#!!! 오라 안에 있는 모든 플레이어에게 다음 효과 발동 :"
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#↑ {{TearsSmall}}연사(+상한) +1.5"
		.. "#유도 눈물을 발사합니다."
		.. "{{CR}}",
	},
	
	[wakaba.Enums.Cards.SOUL_WAKABA] = {
		itemName = "와카바의 영혼",
		description = "#{{SoulHeart}}소울하트 +1#현재 층에서 {{AngelRoom}}천사 상점을 생성합니다.#{{AngelRoom}} 생성할 수 없는 경우 구매가 필요한 천사방 아이템을 하나 소환합니다.",
	},
	[wakaba.Enums.Cards.SOUL_WAKABA2] = {
		itemName = "와카바의 영혼?",
		description = "#{{SoulHeart}}소울하트 +1#현재 층에서 {{DevilRoom}}악마방을 생성합니다.#{{DevilRoom}} 생성할 수 없는 경우 구매가 필요한 악마방 아이템을 하나 소환합니다.",
	},
	[wakaba.Enums.Cards.SOUL_SHIORI] = {
		itemName = "시오리의 영혼",
		description = "#{{Heart}}빨간하트 +2#임의의 시오리의 책 지속 효과를 발동합니다.#이 조합은 시오리의 영혼을 다시 사용하거나 시오리의 책을 소지한 상태에서 다른 책을 사용할 때까지 유지됩니다.",
	},
	[wakaba.Enums.Cards.SOUL_TSUKASA] = {
		itemName = "츠카사의 영혼",
		description = "#사용 시 캐릭터 머리 위에 칼이 소환되며 모든 방의 아이템이 2배로 나옵니다.#상자/판매 아이템은 영향을 받지 않습니다.#패널티 피격 시 그 이후부터 캐릭터가 바뀌며 소지 아이템의 절반이 사라질 확률이 생깁니다.#!!! 소멸확률: 4프레임 당 1/2500",
	},
	[wakaba.Enums.Cards.CARD_VALUT_RIFT] = {
		itemName = "창고의 틈새",
		description = "#시오리의 창고를 소환합니다.#창고는 아이템 하나가 담겨져 있으나 열쇠 12개를 소모합니다.",
	},
	[wakaba.Enums.Cards.CARD_TRIAL_STEW] = {
		itemName = "시련의 국",
		description = "#사용 시 체력과 보호막을 전부 제거하며 액티브 아이템을 전부 충전합니다.#사용 직후 해당 상태를 유지하는 동안 {{TearsSmall}}연사 +8, {{DamageSmall}}공격력 배율 x2",
	},
}
wakaba.descriptions[desclang].tarotcloth = {
	[wakaba.Enums.Cards.CARD_CRANE_CARD] = {
		description = "{{CraneGame}}인형뽑기(크레인 게임) 기계를 2대 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = {
		description = "{{Confessional}}고해실 부스를 2대 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = {
		description = "사용 시 임의의 책 효과 2개를 발동합니다.#같은 효과가 발동할 수 있습니다.",
	},
	[wakaba.Enums.Cards.CARD_VALUT_RIFT] = {
		description = "#시오리의 창고를 2대 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_TRIAL_STEW] = {
		description = "#{{TearsSmall}}추가 연사 +1, {{DamageSmall}}추가 공격력 +25%",
	},
}
wakaba.descriptions[desclang].runechalk = {
	
}
wakaba.descriptions[desclang].pills = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = {
		itemName = "공격력 배율 증가",
		description = "↑ {{DamageSmall}}공격력 배율 x1.08#이 알약의 배수 수치는 합연산으로 적용됩니다.",
	},
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = {
		itemName = "공격력 배율 감소",
		description = "↓ {{DamageSmall}}공격력 배율 x0.98#이 알약의 배수 수치는 합연산으로 적용됩니다.",
	},
	[wakaba.Enums.Pills.ALL_STATS_UP] = {
		itemName = "모든 능력치 증가",
		description = "↑ {{DamageSmall}}공격력 +0.25#↑ {{TearsSmall}}연사 +0.2#↑ {{SpeedSmall}}이동속도 +0.12#↑ {{RangeSmall}}사거리 +0.4#↑ {{ShotspeedSmall}}탄속 +0.04#↑ {{LuckSmall}}행운 +1#",
	},
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = {
		itemName = "모든 능력치 감소",
		description = "↓ {{DamageSmall}}공격력 -0.1#↓ {{TearsSmall}}연사 -0.08#↓ {{SpeedSmall}}이동속도 -0.09#↓ {{RangeSmall}}사거리 -0.25#↓ {{ShotspeedSmall}}탄속 -0.03#↓ {{LuckSmall}}행운 -1#",
	},
	[wakaba.Enums.Pills.TROLLED] = {
		itemName = "낚였구나아아아아아아",
		description = "{{ErrorRoom}} 오류방으로 텔레포트합니다.#{{Collectible721}} ???/Home 스테이지에서는 오류 아이템을 하나 소환합니다.",
	},
	[wakaba.Enums.Pills.TO_THE_START] = {
		itemName = "태초마을",
		description = "각 층의 시작 방으로 텔레포트합니다.",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = {
		itemName = "혈사 설사 2",
		description = "캐릭터의 위치에 십자 모양으로 발사되는 혈사 소용돌이를 두번 생성합니다.#두 혈사 소용돌이의 간격은 랜덤입니다.",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT] = {
		itemName = "혈사 설사 2?",
		description = "{{Card88}} Soul of Azazel 효과 발동:#7.5초 동안 초당 공격력 x15의 {{Collectible441}}대형 혈사포를 발사합니다.",
		mimiccharge = 6,
		class = "2+",
	},
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = {
		itemName = "사회적 거리두기",
		description = "현재 층에서 악마방/천사방의 등장을 막습니다.",
	},
	[wakaba.Enums.Pills.DUALITY_ORDERS] = {
		itemName = "이중 질서",
		description = "{{DevilRoom}}악마방/{{AngelRoom}}천사방 아이템을 하나씩 소환합니다.#둘 중 하나만 획득할 수 있습니다.",
	},
	[wakaba.Enums.Pills.FLAME_PRINCESS] = {
		itemName = "불꽃 공주",
		description = "소지 중인 레메게톤 위습을 흡수하여 아이템을 획득합니다.#흡수하지 못한 위습의 체력을 전부 회복합니다.#위습을 하나도 소지하지 않은 경우 위습을 하나 소환합니다.",
	},
	[wakaba.Enums.Pills.FIREY_TOUCH] = {
		itemName = "앗 뜨거!",
		description = "{{WakabaCurseFlames}} Curse of Flames!(불꽃의 저주)에 걸립니다.#위습의 체력을 전부 회복합니다.",
	},
	[wakaba.Enums.Pills.PRIEST_BLESSING] = {
		itemName = "성녀의 가호",
		description = "피격 시 피해를 1회 무시하는 {{HolyMantle}}방어막을 제공합니다.#이 방어막은 중첩되지 않으며 피격 시까지 유지됩니다.#{{Card51}} (Holy Card 효과와 동일)",
	},
	[wakaba.Enums.Pills.UNHOLY_CURSE] = {
		itemName = "빼앗긴 신앙",
		description = "Holy Mantle의 방어막을 1회 차감합니다.#{{Blank}} (방어막이 없을 경우 효과 없음)",
	},
}
wakaba.descriptions[desclang].horsepills = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP +1] = {
		tostring(wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP),
		"공격력 배율 증가",
		"↑ {{DamageSmall}}공격력 배율 {{ColorCyan}}x1.16{{CR}}#이 알약의 배수 수치는 합연산으로 적용됩니다.",
	},
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN +1] = {
		tostring(wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN),
		"공격력 배율 감소",
		"↓ {{DamageSmall}}공격력 배율 {{ColorYellow}}x0.96{{CR}}#이 알약의 배수 수치는 합연산으로 적용됩니다.",
	},
	[wakaba.Enums.Pills.ALL_STATS_UP +1] = {
		tostring(wakaba.Enums.Pills.ALL_STATS_UP),
		"모든 능력치 증가",
		"↑ {{DamageSmall}}공격력 +{{ColorCyan}}0.5{{CR}}#↑ {{TearsSmall}}연사 +{{ColorCyan}}0.4{{CR}}#↑ {{SpeedSmall}}이동속도 +{{ColorCyan}}0.24{{CR}}#↑ {{RangeSmall}}사거리 +{{ColorCyan}}0.8{{CR}}#↑ {{ShotspeedSmall}}탄속 +{{ColorCyan}}0.08{{CR}}#↑ {{LuckSmall}}행운 +{{ColorCyan}}2{{CR}}",
	},
	[wakaba.Enums.Pills.ALL_STATS_DOWN +1] = {
		tostring(wakaba.Enums.Pills.ALL_STATS_DOWN),
		"모든 능력치 감소",
		"↓ {{DamageSmall}}공격력 -{{ColorYellow}}0.2{{CR}}#↓ {{TearsSmall}}연사 -{{ColorYellow}}0.16{{CR}}#↓ {{SpeedSmall}}이동속도 -{{ColorYellow}}0.18{{CR}}#↓ {{RangeSmall}}사거리 -{{ColorYellow}}0.5{{CR}}#↓ {{ShotspeedSmall}}탄속 -{{ColorYellow}}0.06{{CR}}#↓ {{LuckSmall}}행운 -{{ColorYellow}}2{{CR}}",
	},
	[wakaba.Enums.Pills.TROLLED +1] = {
		tostring(wakaba.Enums.Pills.TROLLED),
		"낚였구나아아아아아아",
		"{{ErrorRoom}} 오류방으로 텔레포트합니다.#{{Collectible721}} ???/Home 스테이지에서는 오류 아이템을 하나 소환합니다.#↑ {{BrokenHeart}}{{ColorCyan}}소지 불가능 체력 -1{{CR}}",
	},
	[wakaba.Enums.Pills.TO_THE_START +1] = {
		tostring(wakaba.Enums.Pills.TO_THE_START),
		"태초마을",
		"각 층의 시작 방으로 텔레포트합니다.#↑ {{Heart}}하트 +1#↑ {{BrokenHeart}}{{ColorCyan}}소지 불가능 체력 -1{{CR}}",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2 +1] = {
		tostring(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2),
		"혈사 설사 2",
		"캐릭터의 위치에 십자 모양으로 발사되는 혈사 소용돌이를 두번 생성합니다.#두 혈사 소용돌이의 간격은 랜덤입니다.",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT +1] = {
		tostring(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT),
		"혈사 설사 2?",
		"{{Card88}}7.5초 동안 초당 공격력 x15의 {{Collectible441}}대형 혈사포를 발사합니다.",
	},
	[wakaba.Enums.Pills.SOCIAL_DISTANCE +1] = {
		tostring(wakaba.Enums.Pills.SOCIAL_DISTANCE),
		"사회적 거리두기",
		"현재 층에서 악마방/천사방의 등장을 막습니다.#↓ {{ColorYellow}}이후 층에서의 악마방/천사방 확률 감소{{CR}}",
	},
	[wakaba.Enums.Pills.DUALITY_ORDERS +1] = {
		tostring(wakaba.Enums.Pills.DUALITY_ORDERS),
		"이중 질서",
		"{{DevilRoom}}악마방/{{AngelRoom}}천사방 아이템을 하나씩 소환합니다.#{{ColorCyan}}두 아이템 모두 획득할 수 있습니다.{{CR}}",
	},
	[wakaba.Enums.Pills.FLAME_PRINCESS +1] = {
		tostring(wakaba.Enums.Pills.FLAME_PRINCESS),
		"불꽃 공주",
		"소지 중인 레메게톤 불꽃을 흡수하여 아이템을 {{ColorCyan}}2개씩{{CR}} 획득합니다.#흡수하지 못한 불꽃의 체력을 전부 회복합니다.#불꽃을 하나도 소지하지 않은 경우 불꽃을 하나 소환합니다.",
	},
	[wakaba.Enums.Pills.FIREY_TOUCH +1] = {
		tostring(wakaba.Enums.Pills.FIREY_TOUCH),
		"앗 뜨거!",
		"{{WakabaCurseFlames}} Curse of Flames!(불꽃의 저주)에 걸립니다.#위습의 체력을 전부 회복합니다.",
	},
	[wakaba.Enums.Pills.PRIEST_BLESSING +1] = {
		tostring(wakaba.Enums.Pills.PRIEST_BLESSING),
		"성녀의 가호",
		"피격 시 피해를 1회 무시하는 {{HolyMantle}}방어막을 제공합니다.#이 방어막은 중첩되지 않으며 피격 시까지 유지됩니다.#{{Card51}} (Holy Card 효과와 동일)",
	},
	[wakaba.Enums.Pills.UNHOLY_CURSE +1] = {
		tostring(wakaba.Enums.Pills.UNHOLY_CURSE),
		"빼앗긴 신앙",
		"Holy Mantle의 방어막을 1회 차감합니다.#{{Blank}} (방어막이 없을 경우 효과 없음)",
	},
}

wakaba.descriptions[desclang].sewnupgrade = {
	[wakaba.Enums.Familiars.LIL_WAKABA] = {
		super = ""
		.. "#리틀 와카바의 레이저가 유도성을 띕니다."
		.. "#원형 레이저의 공격력이 캐릭터의 공격력의 70%로 증가합니다."
		.. "{{CR}}",
		ultra = ""
		.. "#킹 베이비가 없어도 리틀 와카바가 자동으로 적을 향해 공격합니다."
		.. "#원형 레이저의 공격력이 캐릭터의 공격력으로 증가합니다."
		.. "{{CR}}",
		name = "리틀 와카바",
	},
	[wakaba.Enums.Familiars.LIL_MOE] = {
		super = ""
		.. "#눈물의 효과가 2개를 가집니다."
		.. "#눈물의 공격력이 캐릭터의 공격력의 150%로 증가합니다."
		.. "{{CR}}",
		ultra = ""
		.. "#눈물의 효과가 3개를 가집니다."
		.. "#눈물의 공격력이 캐릭터의 공격력의 200%로 증가합니다."
		.. "{{CR}}",
		name = "리틀 모에",
	},
	[wakaba.Enums.Familiars.LIL_SHIVA] = {
		super = ""
		.. "#눈물을 일렬로 7발 발사합니다."
		.. "#눈물의 공격력이 캐릭터의 공격력의 150%로 증가합니다."
		.. "{{CR}}",
		ultra = ""
		.. "#눈물을 일렬로 8발 발사합니다."
		.. "#눈물의 공격력이 캐릭터의 공격력의 200%로 증가합니다."
		.. "#눈물이 적을 통과하면 눈물이 빨간 눈처럼 바뀌며 유도 효과와 함께 공격력이 두 배가 됩니다."
		.. "{{CR}}",
		name = "리틀 시바",
	},
	[wakaba.Enums.Familiars.PLUMY] = {
		super = ""
		.. "#캐릭터의 눈물 효과가 적용됩니다."
		.. "#↑ 공격력 증가"
		.. "#↑ 회복 소요시간이 감소합니다."
		.. "{{CR}}",
		ultra = ""
		.. "#플럼이 무언가에 부딪힐 때 반대 각도로 튕겨져 나가는 눈물을 발사합니다."
		.. "#↑ 연사 및 정확도 증가"
		.. "#↑ 회복 소요시간이 더 감소합니다."
		.. "{{CR}}",
		name = "플럼이",
	},
}

wakaba.descriptions[desclang].extrastrings = {

}

wakaba.descriptions[desclang].uniform = {
	changeslot = "슬롯 변경",
	empty = "빈 슬롯",
	unknownpill = "감정되지 않은 알약",
	use = "현재 들고 있는 {{Pill}}/{{Card}}/{{Rune}} 사용 시 위에 있는 효과를 전부 발동합니다.",
	pushprefix = "액티브 아이템 사용 시 들고 있는 {{Pill}}/{{Card}}/{{Rune}}을 {{ColorGold}}",
	pushsubfix = "번 슬롯{{CR}}에 넣습니다.",
	pullprefix = "액티브 아이템 사용 시 {{ColorGold}}",
	pullsubfix = "번 슬롯{{CR}}에 있는 {{Pill}}/{{Card}}/{{Rune}}을 꺼냅니다.",
	useprefix = "액티브 아이템 사용 시 {{ColorGold}}",
	usesubfix = "번 슬롯{{CR}}과 들고 있는 {{Pill}}/{{Card}}/{{Rune}}을 서로 맞바꿉니다.",
}
wakaba.descriptions[desclang].bookofconquest = {
	selectstr = "선택",
	selectenemy = "현재 선택",
	selectreq = "필요",
	selectboss = "보스 선택됨 : #{{Blank}} {{ColorCyan}}게임 종료 시 사라집니다.",
	selectconq = "아이템 사용 시 해당 적을 함락시킵니다.",
	selecterr = "{{ColorError}}함락 불가 :#{{Blank}} {{ColorError}}{{Key}} 혹은 {{Bomb}}이 부족합니다.",
	selectexit = "공격 키를 눌러 취소할 수 있습니다.",
}

wakaba.descriptions[desclang].entities = {
	{
		type = EntityType.ENTITY_SLOT,
		variant = wakaba.Enums.Slots.SHIORI_VALUT,
		subtype = 0,
		name = "시오리의 점술기계",
		description = ""
		.. "{{Key}} 열쇠 5개를 소모하여 작동"
		.. "#{{Warning}} 작동 시 이하의 아이템 중 하나를 드랍합니다 :"
		.. "#{{BlendedHeart}} {{ColorSilver}}혼합 하트"
		.. "#{{Card}} {{ColorSilver}}카드"
		.. "#{{Card49}} {{ColorSilver}}주사위 파편"
		.. "#{{Card31}} {{ColorSilver}}조커"
		.. "#{{Rune}} {{ColorSilver}}룬"
		.. "#{{Trinket}} {{ColorSilver}}황금 장신구"
		.. "#{{PlanetariumChance}} {{ColorSilver}}별 관련 아이템"
		--.. "#{{Warning}} 5회 이상 작동 시 기계가 폭발할 확률이 크게 증가합니다."
	},
	{
		type = EntityType.ENTITY_PICKUP,
		variant = wakaba.Enums.Pickups.CLOVER_CHEST,
		subtype = wakaba.ChestSubType.CLOSED,
		name = "와카바의 클로버 상자",
		description = ""
		.. "{{Key}} 상자를 여는 데 열쇠 필요"
		.. "#{{Warning}} 상자에서 이하 아이템 중 하나를 드랍합니다 :"
		.. "#{{Coin}} {{ColorSilver}}황금 코인"
		.. "#{{Coin}} {{ColorSilver}}행운 코인 2개"
		.. "#{{LuckSmall}} {{ColorSilver}}운 관련 아이템"
	},
}



wakaba.descriptions[desclang].curses = {
	[-1] = {
		icon = "Blank",
		name = "<저주를 찾을 수 없음(혹은 모드로 추가된 저주)>",
	},
	[LevelCurse.CURSE_OF_DARKNESS] = {
		icon = "CurseDarkness",
		name = "어둠의 저주",
		description = "캐릭터 주변을 제외한 모든 부분이 매우 어두워집니다."
		.. "#일부 방에서는 반딧불이 나타나 방의 일부분을 밝혀줍니다."
		.. "#불, 폭발, 레이저, 장판은 발광 효과가 적용되어 주위를 밝혀줍니다."
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_DARKNESS,
	},
	[LevelCurse.CURSE_OF_LABYRINTH] = {
		icon = "CurseLabyrinth",
		name = "미궁의 저주",
		description = "!!! 챕터 1 ~ 4의 홀수 층에서만 발동"
		.. "#2개의 스테이지를 하나로 합쳐 하나의 XL 스테이지로 만듭니다."
		.. "#!!! 보스방/보물방의 갯수만 2개로 늘어나며 나머지 특수방은 스테이지 하나인 것으로 취급됩니다."
		.. "#Basement/Cellar/Burning Basement XL 스테이지에서는 두 보물방 모두 열쇠를 필요로 하지 않습니다."
		.. "#이 저주는 {{Collectible260}}Black Candle 아이템으로도 제거할 수 없습니다."
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_LABYRINTH,
	},
	[LevelCurse.CURSE_OF_THE_LOST] = {
		icon = "CurseLost",
		name = "길 잃은 자의 저주",
		description = "HUD상에서 지도가 표시되지 않습니다."
		.. "#맵의 크기가 한 단계 더 커집니다."
		.. "#{{Collectible260}}Black Candle 아이템 획득 시 지도만 다시 표시되며, 기존의 늘어난 방 갯수는 그대로 유지됩니다."
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_LOST,
	},
	[LevelCurse.CURSE_OF_THE_UNKNOWN] = {
		icon = "CurseUnknown",
		name = "미지의 저주",
		description = ""
		.. "#현재 체력, Holy Mantle 보호막 여부, 그리고 남은 목숨 수가 HUD상에서 표시되지 않습니다."
		.. "#실제 체력 자체는 보이지만 않을 뿐, 일반적인 상황과 동일하게 작동합니다."
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_UNKNOWN,
	},
	[LevelCurse.CURSE_OF_THE_CURSED] = {
		icon = "CurseCursed",
		name = "저주받은 자의 저주",
		description = "모든 일반 방의 문을 저주방의 문으로 바꿉니다."
		.. "#저주방의 문은 현재 저주방에서 나가는 판정이 적용되어 비행 상태에서도 피해를 받습니다."
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_CURSED,
	},
	[LevelCurse.CURSE_OF_MAZE] = {
		icon = "CurseMaze",
		name = "미로의 저주",
		description = "다른 방으로 이동하거나 텔레포트할 때 :#일정 확률로 화면이 흔들리면서 다른 방으로 이동하거나,"
		.. "#일정 확률로 이미 클리어한 일반 방 2개의 위치를 서로 뒤바꿉니다."
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_MAZE,
	},
	[LevelCurse.CURSE_OF_BLIND] = {
		icon = "CurseBlind",
		name = "눈 먼 자의 저주",
		description = "모든 아이템이 빨간색 물음표로 표시되며 아이템을 집기 전까지 확인할 수 없습니다."
		.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_BLIND,
	},
	[LevelCurse.CURSE_OF_GIANT] = {
		icon = "CurseGiant",
		name = "거대한 자의 저주",
		description = "일반 사이즈의 일반 방을 2x2, 1x2, 2x1 혹은 L자 방으로 합칩니다."
		.. "#좁은 방은 영향이 없습니다."
		.. "#이 저주는 {{Collectible260}}Black Candle 아이템으로도 제거할 수 없습니다."
		.. "",
	},
	[wakaba.curses.CURSE_OF_FLAMES] = {
		icon = "WakabaCurseFlames",
		name = "불꽃의 저주",
		description = "이 저주가 발동 중일 때 아이템을 획득할 수 없습니다."
		.. "#아이템 획득을 시도하면 아이템이 불꽃으로 변합니다."
		.. "#패시브: 레메게톤 불꽃으로 변합니다. 레메게톤으로 나올 수 없다면 일반 불꽃이 나옵니다."
		.. "#액티브: 각 아이템에 대응되는 미덕의 책 불꽃으로 변합니다. 대응되는 불꽃이 없다면 일반 불꽃이 나옵니다."
		.. "#루트 진행용 아이템, 사망 증명서 방에서는 아이템을 그대로 획득할 수 있습니다."
		.. "",
	},
	[wakaba.curses.CURSE_OF_SATYR] = {
		icon = "WakabaCurseSatyr",
		name = "사티로스의 저주",
		description = "!!! 시오리 캐릭터 중 'Curse of Satyr' 모드로 플레이할 때만 항상 걸립니다."
		.. "#시오리가 책을 자유롭게 선택할 수 없으며 현재 지니고 있는 단 하나의 책만 사용할 수 있습니다."
		.. "#픽업 슬롯에 있는 책을 사용할 때마다 다음에 사용할 수 있는 책이 랜덤하게 정해집니다."
		.. "#해당 책 사용 시에도 시오리의 책 눈물 보너스가 바뀝니다."
		.. "#이 저주는 {{Collectible260}}Black Candle 아이템으로도 제거할 수 없습니다."
		.. "",
	},
	[wakaba.curses.CURSE_OF_SNIPER] = {
		icon = "WakabaCurseSniper",
		name = "저격수의 저주",
		description = "!!! {{Player"..wakaba.Enums.Players.RICHER.."}}리셰 캐릭터, 혹은 {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon 소지 시에만 등장"
		.. "#{{CurseDarkness}} Darkness 저주를 교체하여 등장합니다."
		.. "#눈물 공격이 매우 가까이 있는 적에게 피해를 입히지 못하나;"
		.. "#멀리 있는 적에게 3배의 피해를 줍니다."
		.. "",
	},
	[wakaba.curses.CURSE_OF_FAIRY] = {
		icon = "WakabaCurseFairy",
		name = "요정의 저주",
		description = "!!! {{Player"..wakaba.Enums.Players.RICHER.."}}리셰 캐릭터, 혹은 {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon 소지 시에만 등장"
		.. "#{{CurseLost}} Lost 저주를 교체하여 등장합니다."
		.. "#현재 방 주변의 방 위치를 볼 수 있으나 더 멀리 있는 위치의 방은 지도에 표시되지 않습니다."
		.. "#{{SecretRoom}} 비밀방 및 일급비밀방의 위치가 표시됩니다."
		.. "",
	},
	[wakaba.curses.CURSE_OF_AMNESIA] = {
		icon = "WakabaCurseAmnesia",
		name = "망각의 저주",
		description = "!!! {{Player"..wakaba.Enums.Players.RICHER.."}}리셰 캐릭터, 혹은 {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon 소지 시에만 등장"
		.. "#{{CurseMaze}} Maze 저주를 교체하여 등장합니다."
		.. "#방 입장 시 클리어한 방이 낮은 확률로 클리어하지 않은 상태로 바뀝니다."
		.. "#다시 클리어할 경우 방 클리어 보상이 드랍되며 특수방은 적용되지 않습니다."
		.. "",
	},
	[wakaba.curses.CURSE_OF_MAGICAL_GIRL] = {
		icon = "WakabaCurseMagicalGirl",
		name = "마법소녀의 저주",
		description = "!!! {{Player"..wakaba.Enums.Players.RICHER.."}}리셰 캐릭터, 혹은 {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon 소지 시에만 등장"
		.. "#{{CurseUnknown}} Unknown 저주를 교체하여 등장합니다."
		.. "#{{Card91}} 저주에 걸린 동안 항상 Lost 상태가 됩니다."
		.. "#{{Collectible285}} 모든 적이 약화 형태로 등장합니다."
		.. "",
	},
}

wakaba.descriptions[desclang].cursesappend = {}
wakaba.descriptions[desclang].cursesappend.CURCOL = {
	[1 << (Isaac.GetCurseIdByName("Curse of Decay") - 1)] = {
		icon = "Blank",
		name = "부패의 저주",
		description = "픽업 아이템이 소환될 때 일정 확률로 시간 제한이 생깁니다."
		.. "#시간 제한이 있는 픽업 아이템은 일정 시간이 지나면 사라집니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Famine") - 1)] = {
		icon = "Blank",
		name = "기근의 저주",
		description = "모든 픽업의 등급이 한 단계 내려갑니다."
		.. "#하트류 픽업은 반칸으로 드랍됩니다."
		.. "#1+1 픽업은 1개의 픽업으로 드랍됩니다."
		.. "#배터리 픽업은 작은 마이크로 배터리로 드랍됩니다."
		.. "#!!! 고정 픽업은 이 저주의 영향을 받지 않습니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Blight") - 1)] = {
		icon = "CURCOL_blight",
		name = "황폐의 저주",
		description = "모든 아이템이 암흑의 실루엣으로 가려지며 아이템을 집기 전까지 확인할 수 없습니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Conquest") - 1)] = {
		icon = "Blank",
		name = "정복의 저주",
		description = "챔피언 몬스터의 등장 확률이 증가합니다."
		.. "#다른 몬스터가 소환한 몬스터도 일정 확률로 챔피언으로 변합니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Rebirth") - 1)] = {
		icon = "Blank",
		name = "부활의 저주",
		description = "적 처치 시 일정 확률로 부활합니다."
		.. "#챔피언 몬스터는 부활 시 같은 종류의 챔피언으로 부활합니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Creation") - 1)] = {
		icon = "CURCOL_crea",
		name = "창조의 저주",
		description = "장애물 파괴 시 일정 확률로 재생성합니다."
		.. "#캐릭터가 이 저주로 인해 갇힌 경우 전 방으로 텔레포트합니다."
		.. "",
	},
}
wakaba.descriptions[desclang].cursesappend.further = {
	[1 << (Isaac.GetCurseIdByName("Curse of Sorrow!") - 1)] = {
		icon = "Blank",
		name = "슬픔의 저주",
		description = "Tainted Leah 캐릭터의 연사 효율이 감소합니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Blessing of Light!") - 1)] = {
		icon = "Blank",
		name = "빛의 축복",
		description = "보물방, 책방, 천체관 입장시 빛줄기가 내려옵니다."
		.. "#빛줄기에 닿으면 체력 1칸이 회복되며 현재 층에서 공격력을, 영구적으로 이동속도를 소폭 증가시킵니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Blessing of Order!") - 1)] = {
		icon = "Blank",
		name = "질서의 축복",
		description = "보스방 클리어 시 보스방 아이템 이외에 최대 체력을 요구하는 악마방 아이템, 혹은 코인을 요구하는 천사방 아이템 중 하나를 선택할 수 있습니다."
		.. "#보스방 아이템은 거래와 무관하게 획득할 수 있습니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Blessing of Found!") - 1)] = {
		icon = "Blank",
		name = "발견자의 축복",
		description = "스테이지의 구조를 표시합니다."
		.. "#{{Blank}} (Treasure Map 아이템과 동일)"
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Blessing of Known!") - 1)] = {
		icon = "Blank",
		name = "지식의 축복",
		description = "모든 특수방의 위치가 표시됩니다."
		.. "#{{Blank}} (The Compass 아이템과 동일)"
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Blessing of Unhinged!") - 1)] = {
		icon = "Blank",
		name = "불굴의 축복",
		description = "모든 잠긴 문이 항상 열려 있습니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Blessing of Sighted!") - 1)] = {
		icon = "Blank",
		name = "눈 뜬자의 축복",
		description = "비밀방/일급 비밀방이 자동으로 열립니다."
		.. "#일급 비밀방에서 코인을 요구하는 비밀방 아이템이 소환됩니다."
		.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Blessing of Triumph!") - 1)] = {
		icon = "Blank",
		name = "승리의 축복",
		description = "보스방 클리어 시 낡은 상자 하나를 소환합니다."
		.. "",
	},
}
wakaba.descriptions[desclang].playernotes = {
	-- copy-paste this snippet
	[-50000] = {
		-- icon = "",
		name = "Isaac",
		description = ""
		.. "#"
		.. "",
	},
	-- copy-paste this snippet end
	[-666] = {
		icon = "Blank",
		name = "<플레이어를 찾을 수 없음(혹은 모드로 추가된 플레이어)>",
	},
	[PlayerType.PLAYER_ISAAC] = {
		-- icon = "",
		name = "아이작",
		description = "엄마에게서 도망치기 위해 지하실로 뛰어내린 {{ColorLime}}아이작의 번제{{CR}}의 기본 캐릭터입니다."
		.. "#평균적인 능력치를 가진 캐릭터입니다."
		.. "#{{Collectible105}} {{GoldenKey}}기본 소지 아이템 : 주사위({{Player4}}-> Isaac 처치)"
		.. "",
	},
	[PlayerType.PLAYER_MAGDALENE] = {
		-- icon = "",
		name = "막달레나",
		description = "아이작의 엄마를 모티브로 한 캐릭터입니다."
		.. "#{{Heart}} 체력이 많으나 기본 이동 속도가 매우 느립니다."
		.. "#{{Collectible45}} 기본 소지 아이템 : 맛있는 심장"
		.. "#{{Pill}} {{GoldenKey}}기본 소지 픽업 : 체력 회복 알약(32: 만우절 챌린지 클리어)"
		.. "",
	},
	[PlayerType.PLAYER_CAIN] = {
		-- icon = "",
		name = "카인",
		description = "인류 최초로 살인을 하였습니다."
		.. "#!!! 왼쪽 눈이 안대로 가려져 있어 오른쪽 눈으로만 눈물을 발사합니다. 한 쪽 눈에만 적용되는 눈물은 확률적으로 발사합니다."
		.. "#{{DamageSmall}} 체력이 낮으나 공격력이 높습니다."
		.. "#{{Collectible46}} 기본 소지 아이템 : 행운의 발"
		.. "#{{Trinket19}} {{GoldenKey}}기본 소지 장신구 : 종이 클립({{GreedMode}}: 68{{Coin}})"
		.. "#"
		.. "",
	},
	[PlayerType.PLAYER_JUDAS] = {
		-- icon = "",
		name = "유다",
		description = "예수를 3{{Coin}}에 팔아 버린 예수의 12 제자 중 한명입니다."
		.. "#{{DamageSmall}} 체력이 매우 낮으나 공격력이 매우 높습니다."
		.. "#{{Collectible34}} 기본 소지 아이템 : 벨리알의 책"
		.. "#!!! 유다의 모자는 성경과 무관합니다."
		.. "",
	},
	[PlayerType.PLAYER_BLUEBABY] = {
		-- icon = "",
		name = "???",
		description = "???의 ???입니다."
		.. "#???는 Edmund Mcmillen의 초기작 중 하나인 {{ColorCyan}}Dead Baby Dressup{{CR}}에서 등장하였습니다."
		.. "#{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받으며 빨간하트를 채울 수 없습니다."
		.. "#침대에서 자면 소울하트 3칸을 회복합니다."
		.. "#??? 캐릭터는 생김새로 인해 'Blue Baby'라는 별명으로도 불립니다."
		.. "#{{Collectible36}} 기본 소지 아이템 : 똥"
		.. "",
	},
	[PlayerType.PLAYER_EVE] = {
		-- icon = "",
		name = "이브",
		description = "성경 최초의 여성이며 원죄를 지어 저주를 받은 후 에덴동산에서 추방되었습니다."
		.. "#공격력이 매우 낮습니다."
		.. "#{{SoulHeart}}이브는 다른 캐릭터에 비해 소울하트 등장 확률이 더 높습니다."
		.. "#{{Collectible117}} 기본 소지 아이템 : 죽은 새"
		.. "#{{Collectible122}} 기본 소지 아이템 : 바빌론의 창녀"
		.. "#{{Blank}} 바빌론의 창녀가 빨간하트가 1칸이여도 발동됩니다."
		.. "#{{Collectible126}} {{GoldenKey}}기본 소지 아이템 : 면도날({{GreedMode}}: 439{{Coin}})"
		.. "",
	},
	[PlayerType.PLAYER_SAMSON] = {
		-- icon = "",
		name = "삼손",
		description = "복받은 영웅 같았지만 실상은 깡패였습니다."
		.. "#순간적 감정에 빡돌며 언제나 피에 굶주려 있습니다."
		.. "#{{Collectible157}} 기본 소지 아이템 : 피의 욕망"
		.. "#{{Trinket34}} {{GoldenKey}}기본 소지 장신구 : 아이의 심장(34: 엄청 어려워 클리어)"
		.. "",
	},
	[PlayerType.PLAYER_AZAZEL] = {
		-- icon = "",
		name = "아자젤",
		description = "인간세계에서 온갖 것들을 유혹한 타천사입니다."
		.. "#남자들에게는 싸우는 법을, 여자들에게는 화장하는 법을 가르쳐 주었습니다."
		.. "#{{DamageSmall}} 공격력이 매우 높습니다."
		.. "#{{Collectible118}} 검은 날개로 날 수 있으며 사거리가 매우 짧은 혈사포를 발사합니다."
		.. "",
	},
	[PlayerType.PLAYER_LAZARUS] = {
		-- icon = "",
		name = "나사로",
		description = "죽었다 되살아난 예수의 절친입니다."
		.. "#{{Collectible332}} 고유 능력 : 나사로의 누더기"
		.. "#{{DamageSmall}} 나사로의 누더기로 부활할 때마다 공격력 +0.5, 최대 체력 -1"
		.. "#부활 상태는 스테이지 진입 시 초기화됩니다."
		.. "#{{Collectible214}} {{GoldenKey}}기본 소지 아이템 : 빈혈증(31: 거꾸로 말해요 클리어)"
		.. "#{{Pill}} 기본 소지 픽업 : 랜덤 알약"
		.. "",
	},
	[PlayerType.PLAYER_EDEN] = {
		-- icon = "",
		name = "에덴",
		description = "그 동산과는 관련이 없습니다."
		.. "#모든 것이 랜덤으로 정해집니다."
		.. "#{{CurseBlind}} 기본 소지 아이템 : ???"
		.. "#{{CurseBlind}} 기본 소지 아이템 : ???"
	},
	[PlayerType.PLAYER_THELOST] = {
		-- icon = "",
		name = "로스트",
		description = "???의 ???입니다. 실종된 포스터와 관련 있을지도?"
		.. "#매우 섬세한 존재입니다. 조심히 다뤄주세요,"
		.. "#상급자용 캐릭터로 기획되어 있다보니 이 캐릭터로 하드 모드 체크리스트를 전부 달성하는 것이 하나의 밈이 되었습니다."
		.. "#{{ColorRed}}한 번이라도 피격 시 즉시 사망합니다.{{CR}} 악마 거지와 헌혈을 조심합시다."
		--.. "#본래 Mcmillen의 의도는 많은 플레이어들이 퍼즐을 풀어 존재를 밝혀내는 상급자용 캐릭터였으나, 데이터 마이닝으로 존재가 유출되었습니다."
		.. "#모든 체력 거래는 무료이나 단 하나만 획득할 수 있습니다."
		.. "#{{Collectible609}} 기본 소지 아이템 : 이터널 주사위"
		.. "#{{Collectible313}} {{GoldenKey}}고유 능력 : 신성한 망토({{GreedMode}}: 879{{Coin}})"
		.. "",
	},
	[PlayerType.PLAYER_LAZARUS2] = {
		-- icon = "",
		name = "나사로",
		description = "죽었다 되살아난 예수의 절친입니다."
		.. "#부활하였으나 이미 죽었던 탓에 피를 흘립니다."
		.. "#{{Collectible214}} 기본 소지 아이템 : 빈혈증"
		.. "#{{Collectible214}} {{GoldenKey}}고유 능력 : 빈혈증(31: 거꾸로 말해요 클리어)"
		.. "",
	},
	[PlayerType.PLAYER_BLACKJUDAS] = {
		-- icon = "",
		name = "검은 유다",
		description = "예수를 3{{Coin}}에 팔아 버린 예수의 12 제자 중 한명...의 그림자입니다."
		.. "#{{BlackHeart}} 최대 체력 = 블랙하트의 보정을 받으며 빨간하트를 채울 수 없습니다."
		.. "#침대에서 자면 소울하트 3칸을 회복합니다."
		.. "#{{DamageSmall}} 공격력이 매우 높습니다."
		.. "#!!! 이 캐릭터의 체크리스트는 유다의 체크리스트와 공유합니다."
		.. "",
	},
	[PlayerType.PLAYER_LILITH] = {
		-- icon = "",
		name = "릴리스",
		description = "어디서 왔는지 알 수 없지만 신에게 맞서 싸운 몽마입니다."
		.. "#눈을 가려 아무것도 볼 수 없지만 인큐버스가 그녀를 인도합니다."
		.. "#그녀의 힘은 그녀 자신이 아닌 그녀의 친구들로부터 나옵니다. 패밀리어들을 많이 모아줍시다."
		.. "#{{Collectible360}} 고유 능력 : 인큐버스"
		.. "#{{Collectible367}} 기본 소지 아이템 : 친구 상자"
		.. "#{{Collectible412}} 기본 소지 아이템 : 몽마의 자식들"
		.. "",
	},
	[PlayerType.PLAYER_KEEPER] = {
		-- icon = "",
		name = "키퍼",
		description = "???가 탐욕화된 시체입니다."
		.. "#여러 아이작 플레이어들이 탐욕의 비밀 통해 찾아낸 존재입니다."
		.. "#{{CoinHeart}} 체력이 하트가 아닌 코인으로 이루어져 있으며 3칸의 상한을 가집니다."
		.. "#한 번에 3발을 발사하지만 연사가 매우 낮습니다."
		.. "#모든 거래가 동전으로 이루어집니다. 최대체력 1개 당 15{{Coin}}으로 환산됩니다."
		.. "#{{Collectible349}} {{GoldenKey}}기본 소지 아이템 : 나무 동전({{Player14}}-> Isaac 처치)"
		.. "#{{Trinket83}} {{GoldenKey}}기본 소지 장신구 : 상점 열쇠({{Player14}}-> Satan 보스 처치)"
		.. "",
	},
	[PlayerType.PLAYER_APOLLYON] = {
		-- icon = "",
		name = "아폴리온",
		description = "무저갱에서 올라온 석상입니다."
		.. "#모든 것을 파괴하여 공허 속으로 빨아들입니다."
		.. "#천천히 성장하는 석상이므로 인내심을 가집시다."
		.. "#{{Collectible477}} 기본 소지 아이템 : 공허"
		.. "",
	},
	[PlayerType.PLAYER_THEFORGOTTEN] = {
		-- icon = "",
		name = "포가튼",
		description = "???의 무덤에 묻힌 ???의 ???입니다."
		.. "#{{Chargeable}} 공격 키로 뼈를 휘두르며 충전 시 충전 거리만큼 뼈다귀를 부메랑처럼 던질 수 있습니다."
		.. "#{{BoneHeart}} 최대 체력 = 뼈하트의 보정을 받으며 6칸의 상한을 가집니다."
		.. "#{{ColorRed}}뼈하트를 잃으면 패널티 여부 상관 없이 악마방 확률이 감소합니다.{{CR}}"
		.. "#소울하트를 소지할 수 없으며 획득한 소울하트는 영혼인 소울이 소지할 수 있습니다."
		.. "#Ctrl 키를 눌러 소울로 교체할 수 있습니다."
		.. "",
	},
	[PlayerType.PLAYER_THESOUL] = {
		-- icon = "",
		name = "소울",
		description = "???의 무덤에 묻힌 ???의 영혼입니다."
		.. "#본체와는 달리 평범한 눈물을 쏘며 본체의 위치에서 일정 간격 이상으로 벗어날 수 없습니다."
		.. "#활성화 상태에서는 본체는 무적이며 적의 탄환을 막아줄 수 있습니다."
		.. "#{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받으며 6칸의 상한을 가집니다."
		.. "#빨간하트와 뼈하트를 소지할 수 없으며 획득한 뼈하트는 본체인 포가튼이 소지할 수 있습니다."
		.. "#Ctrl 키를 눌러 포가튼으로 교체할 수 있습니다."
		.. "",
	},
	[PlayerType.PLAYER_BETHANY] = {
		-- icon = "",
		name = "베타니",
		description = "나사로의 여동생입니다."
		.. "#소울하트를 소지할 수 없으며 모든 소울하트는 액티브 아이템의 게이지로 사용할 수 있습니다."
		.. "#소울하트 반칸 당 1칸의 게이지로 환산됩니다."
		.. "#{{Collectible584}} 기본 소지 아이템 : 미덕의 책"
		.. "",
	},
	[PlayerType.PLAYER_JACOB] = {
		-- icon = "",
		name = "야곱",
		description = "아이작과 레베카의 둘째 아들입니다."
		.. "#에사우와는 반대로 내향적으로 레베카의 사랑을 받았으며 그의 스튜를 주는 조건으로 에사우의 장자권을 받았습니다."
		.. "#쌍둥이 형인 에사우와 같이 움직이며 둘 중 하나가 죽으면 같이 죽습니다."
		.. "#Ctrl 키를 누른 상태에서는 야곱 혼자만 움직입니다."
		.. "#액티브 아이템은 스페이스바를, 카드/알약은 Ctrl+스페이스바로 사용할 수 있습니다."
		.. "",
	},
	[PlayerType.PLAYER_ESAU] = {
		-- icon = "",
		name = "에사우",
		description = "아이작과 레베카의 첫째 아들입니다."
		.. "#야곱과는 반대로 외향적으로 아이작의 사랑을 받았으며 너무 배고픈 나머지 에사우에게 장자권을 주는 조건으로 스튜를 받았습니다."
		.. "#쌍둥이 동생인 야곱과 같이 움직이며 둘 중 하나가 죽으면 같이 죽습니다."
		.. "#Ctrl 키를 누른 상태에서는 야곱 혼자만 움직입니다."
		.. "#액티브 아이템은 Q를, 카드/알약은 Ctrl+Q로 사용할 수 있습니다."
		.. "",
	},

	-- Tainted
	[PlayerType.PLAYER_ISAAC_B] = {
		-- icon = "",
		name = "아이작(알트)",
		description = "The Broken: 마치 엄마에게 학대당해 망가진 듯한 모습을 하고 있습니다."
		.. "#{{Card81}} 모든 받침대 아이템이 2개의 선택지를 지닙니다."
		.. "#패시브 아이템은 8개까지만 소지할 수 있으며 8개를 전부 소지한 상태에서 아이템 획득 시 선택된 아이템과 교체합니다."
		.. "#교체할 아이템은 Ctrl키로 바꿀 수 있습니다."
		.. "#"
		.. "",
	},
	[PlayerType.PLAYER_MAGDALENE_B] = {
		-- icon = "",
		name = "막달레나(알트)",
		description = "The Dauntless: 머리가 뜯기고 아름다움이 사라져도 계속 적에게 부딪혀야 합니다."
		.. "#기본 체력 2칸을 제외한 모든 체력은 서서히 반칸씩 사라집니다. 사라지는 체력을 잃어도 악마방/천사방 확률에 영향이 없습니다."
		.. "#공격력이 약하지만 적과 접촉시 공격력 x6의 근접 공격을 합니다."
		.. "#체력을 직접적으로 회복시켜주는 아이템의 회복량이 2배가 됩니다."
		.. "#{{Collectible724}} 적을 처치하면 1.5초 후 사라지는 {{Heart}}빨간하트를 드랍합니다."
		.. "#{{Collectible45}} 고유 능력 : 맛있는 심장"
		.. "",
	},
	[PlayerType.PLAYER_CAIN_B] = {
		-- icon = "",
		name = "카인(알트)",
		description = "The Hoarder: 동생을 살해한 죄는 너무나 무거웠습니다."
		.. "#야훼의 저주를 받아 영원한 방랑자가 되었습니다."
		.. "#아이템을 획득할 수 없으며 획득을 시도하면 픽업 아이템으로 분해됩니다."
		.. "#특정 방에서 분해 시 특정 픽업 아이템이 반드시 하나 이상 등장합니다."
		.. "#{{Collectible710}} 고유 능력 : 조합 가방"
		.. "#{{Blank}} 조합 가방에 들어있는 픽업 상황을 볼 수 있습니다."
		.. "#{{Blank}} 완성 시 만들어지는 아이템을 미리 볼 수 있으며 Ctrl키를 누르면 교체할 픽업을 선택할 수 있습니다."
		.. "#{{Blank}} Ctrl키를 꾹 누르면 아이템을 즉시 획득할 수 있습니다."
		.. "",
	},
	[PlayerType.PLAYER_JUDAS_B] = {
		-- icon = "",
		name = "유다(알트)",
		description = "The Deceiver: 배신은 영원합니다."
		.. "#{{BlackHeart}} 최대 체력 = 블랙하트의 보정을 받으며 빨간하트를 채울 수 없습니다."
		.. "#침대에서 자면 소울하트 3칸을 회복합니다."
		.. "#{{Collectible705}} 고유 능력 : 흑마술"
		.. "#{{Blank}} 흑마술로 통과한 적과 탄환 수만큼 공격력이 일시적으로 대폭 증가합니다."
		.. "#"
		.. "",
	},
	[PlayerType.PLAYER_BLUEBABY_B] = {
		-- icon = "",-
		name = "???(알트)",
		description = "The Soiled: 이제 흙으로 돌아갈 시간입니다."
		.. "#{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받으며 빨간하트를 채울 수 없습니다."
		.. "#침대에서 자면 소울하트 3칸을 회복합니다."
		.. "#{{Collectible725}} 폭탄을 사용할 수 없으며 폭탄 대신 여러 종류의 똥을 사용합니다."
		.. "#{{PoopPickup}} 폭탄 픽업은 똥 픽업으로 바뀌며 폭탄을 지급하는 아이템은 그 갯수만큼 자폭 파리로 변환됩니다."
		.. "#똥은 반드시 순서대로만 사용할 수 잇습니다."
		.. "#가스를 많이 뿜으므로 불장난에 주의합시다."
		--[[ .. "#{{PoopPickup}} 평범한 똥입니다." -- 갈색
		.. "#{{PoopPickup}} 설치 시 자폭파리를 한번에 3마리까지 생성합니다." -- 옥수수
		.. "#{{PoopPickup}} 똥이 사라져도 Red Candle의 불을 남깁니다." -- 불
		.. "#{{PoopPickup}} 주변에 독가스와 가스를 내뿜습니다." -- 녹색
		.. "#{{PoopPickup}} " -- 검은색
		.. "#{{PoopPickup}} " -- 흰색
		.. "#{{PoopPickup}} " -- 돌
		.. "#{{PoopPickup}} 사용 시 1.5초 후 폭발하는 폭탄입니다." -- 폭탄
		.. "#{{PoopPickup}} Butter Bean 아이템 효과와 동일" -- 방귀
		.. "#{{PoopPickup}} Explosive Diarrhea 알약과 동일" -- 
		.. "#{{PoopPickup}} 바닥에 설사 장판을 깝니다. 설사 장판 위에서 {{DamageSmall}}공격력 +1.5 {{TearsSmall}}연사 +1" ]]
		.. "#{{Collectible715}} 고유 능력 : 고정"
		.. "",
	},
	[PlayerType.PLAYER_EVE_B] = {
		-- icon = "",
		name = "이브(알트)",
		description = "The Curdled: 원죄의 고통은 여전히 끝나지 않았습니다."
		.. "#{{Collectible713}} 고유 능력 : 섬토리움(패시브)"
		.. "#{{Blank}} 공격 키를 2.5초동안 누르고 있으면 체력 반칸을 소모해 클롯 패밀리어를 소환합니다."
		.. "#{{Blank}} 섬토리움 사용시 소환된 모든 클롯을 흡수해 체력으로 변환합니다. 초과된 클롯은 캐릭터의 위치로 옮겨집니다."
		.. "#!!! {{ColorRed}}경고: 섬토리움 사용 중 방을 이동하면 흡수하지 않은 클롯이 전부 증발합니다.{{CR}}"
		.. "#클롯이 없는 상태에서 전체 체력이 반칸 이하일 경우 섬토리움을 직접 들고 싸웁니다."
		.. "",
	},
	[PlayerType.PLAYER_SAMSON_B] = {
		-- icon = "",
		name = "삼손(알트)",
		description = "The Savage: 머리카락이 뽑힌 그는 분노의 학살을 하기 시작했습니다."
		.. "#{{Collectible704}} 고유 능력 : 폭주(패시브)"
		.. "#{{Blank}} 폭주 게이지를 확인할 수 없으며, 피격 시에도 충전됩니다."
		.. "#{{Blank}} 완충 시 강제로 폭주 모드로 돌입합니다."
		.. "",
	},
	[PlayerType.PLAYER_AZAZEL_B] = {
		-- icon = "",
		name = "아자젤(알트)",
		description = "The Benighted: 야훼의 벌을 받아 타천사의 날개는 갈갈이 찢어졌습니다."
		.. "#{{Collectible118}} 검은 날개로 날 수 없으며 굵기가 매우 얇은 혈사포를 발사합니다."
		.. "#혈사포는 적에게 공격력 x0.5의 피해를 입힙니다."
		.. "#{{Collectible704}} 고유 능력 : 각혈"
		.. "#{{Blank}} 재채기가 공격 키를 누르기 시작할 때 발동됩니다."
		.. "#{{Blank}} 재채기로 적을 명중시키면 혈사포의 절반을 충전시킵니다."
		.. "",
	},
	[PlayerType.PLAYER_LAZARUS_B] = {
		-- icon = "",
		name = "나사로(알트-삶)",
		description = "The Enigma: 기적은 언제나 수수께끼입니다."
		.. "#액티브 쿨타임이 채워지는 시점에 죽음 폼으로 강제 전환됩니다."
		.. "#삶/죽음 폼의 능력치 및 아이템은 따로 적용됩니다."
		.. "#{{Blank}} 일부 아이템은 양쪽 폼 모두 적용됨"
		.. "#{{Collectible711}} 고유 능력 : 뒤집기"
		.. "#!!! 뒤집기가 강제로 발동된 경우 받침대의 아이템이 전환되지 않습니다."
		.. "",
	},
	[PlayerType.PLAYER_EDEN_B] = {
		-- icon = "",
		name = "에덴(알트)",
		description = "The Capricious: 이제 그 동산은 오류투성이가 되었습니다."
		.. "#모든 것이 랜덤으로 정해집니다."
		.. "#{{Collectible721}} {{ColorRed}}패널티 피격 시 모든 것이 랜덤으로 정해집니다.{{CR}}"
		.. "#{{CurseBlind}} 기본 소지 아이템 : ???"
		.. "#{{CurseBlind}} 기본 소지 아이템 : ???"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.EDEN_STICKY_NOTE.."}} {{GoldenKey}}고유 능력 : 스티커 노트(와카바98: 하이퍼 랜덤 클리어)"
		.. "",
	},
	[PlayerType.PLAYER_THELOST_B] = {
		-- icon = "",
		name = "로스트(알트)",
		description = "The Baleful: 매우 섬세한 존재이지만 이젠 섬세함을 버릴 때입니다."
		.. "#{{Collectible691}} {{Quality2}} 이하의 아이템이 20%의 확률로 리롤되며 'offensive' 태그의 아이템만 등장합니다."
		.. "#{{Blank}} 쓸모없는 아이템이 등장하지 않지만 매우 소중한 방어형 아이템도 등장하지 않습니다."
		.. "#{{Card51}} 기본 소지 픽업 : 신성한 카드"
		.. "#{{Card51}} 카드 등장 시 10%의 확률로 신성한 카드로 교체됩니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.UNIFORM.."}} {{GoldenKey}}기본 소지 아이템 : 와카바의 교복(와카바9: 드로우 5 클리어)"
		.. "",
	},
	[PlayerType.PLAYER_LAZARUS2_B] = {
		-- icon = "",
		name = "나사로(알트-죽음)",
		description = "The Enigma: 기적은 언제나 수수께끼입니다."
		.. "#액티브 쿨타임이 채워지는 시점에 삶 폼으로 강제 전환됩니다."
		.. "#삶/죽음 폼의 능력치 및 아이템은 따로 적용됩니다."
		.. "#{{Blank}} 일부 아이템은 양쪽 폼 모두 적용됨"
		.. "#{{Collectible711}} 고유 능력 : 뒤집기"
		.. "#!!! 뒤집기가 강제로 발동된 경우 받침대의 아이템이 전환되지 않습니다."
		.. "",
	},
	[PlayerType.PLAYER_LILITH_B] = {
		-- icon = "",
		name = "릴리스(알트)",
		description = "The Harlot: 수많은 정기를 빨아들인 귀신의 사악한 아이가 세상에 나오게 되었습니다."
		.. "#눈이 없어 공격할 수 없지만 겔로가 그녀를 대신하여 공격합니다."
		.. "#{{Collectible728}} 고유 능력 : 겔로(패시브)"
		.. "#공격 키를 누르기 시작하면 태아를 발사하며, 공격 키를 떼면 발사한 태아가 다시 들어갑니다."
		.. "",
	},
	[PlayerType.PLAYER_KEEPER_B] = {
		-- icon = "",
		name = "키퍼(알트)",
		description = "The Miser: 탐욕은 더더욱 탐욕을 추구합니다."
		.. "#{{CoinHeart}} 체력이 하트가 아닌 코인으로 이루어져 있으며 2칸의 상한을 가집니다."
		.. "#한 번에 4발을 발사하지만 연사가 매우 낮습니다."
		.. "#적을 처치 시 3초 후 사라지는 동전을 뿌립니다."
		.. "#일부 경우를 제외한 모든 액티브/패시브 아이템이 동전을 요구합니다."
		.. "#전용 상점이 존재하며 전용 상점은 입장 시 열쇠를 소모하지 않으며 {{TreasureRoom}}/{{BossRoom}}/{{Shop}} 배열의 아이템을 추가로 판매합니다."
		.. "#모든 거래가 동전으로 이루어집니다. 최대체력 1개 당 15{{Coin}}으로 환산됩니다."
		.. "",
	},
	[PlayerType.PLAYER_APOLLYON_B] = {
		-- icon = "",
		name = "아폴리온(알트)",
		description = "The Empty: 무저갱의 깊이는 무한합니다."
		.. "#{{Collectible706}} 고유 능력 : 무저갱"
		.. "",
	},
	[PlayerType.PLAYER_THEFORGOTTEN_B] = {
		-- icon = "",
		name = "포가튼(알트)",
		description = "The Fettered: 이제는 모든 게 구속되어 있습니다."
		.. "#{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받으며 빨간하트를 채울 수 없습니다."
		.. "#침대에서 자면 소울하트 3칸을 회복합니다."
		.. "#움직일 수 없으며 다른 한 쪽인 영혼에게 모든 걸 맡겨야 합니다."
		.. "#본체는 무적이며 모든 액티브/카드/알약 사용 위치 기준은 본체를 기준으로 합니다."
		.. "",
	},
	[PlayerType.PLAYER_THESOUL_B] = {
		-- icon = "",
		name = "소울(알트)",
		description = "움직이지 못하는 뼈다귀를 보조해 줍니다."
		.. "#공격할 수 없으며 공격 키를 눌러 뼈다귀를 던지는 것으로 공격을 대신합니다."
		.. "#피격 판정은 소울에게만 있으며 적들도 소울을 향해 공격합니다."
		.. "#자유롭게 날 수 있습니다."
		.. "",
	},
	[PlayerType.PLAYER_BETHANY_B] = {
		-- icon = "",
		name = "베타니(알트)",
		description = "The Zealot: 기적은 믿음을 더욱 굳건하게 만듭니다."
		.. "#{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받으며 빨간하트를 채울 수 없습니다."
		.. "#침대에서 자면 소울하트 3칸을 회복합니다."
		.. "#모든 빨간하트는 액티브 아이템의 게이지로 사용할 수 있습니다."
		.. "#빨간하트 반칸 당 1칸의 게이지로 환산됩니다."
		.. "#아이템의 효과 및 효율이 75%로 감소합니다."
		.. "#{{Collectible712}} 고유 능력 : 마도서 레메게톤"
		.. "",
	},
	[PlayerType.PLAYER_JACOB_B] = {
		-- icon = "",
		name = "야곱(알트)",
		description = "The Deserter: 자신이 낚였다는 걸 깨달은 에사우에게 집요하게 쫒기는 신세가 되었습니다."
		.. "#검은 에사우에게 피격 시 유령 상태로 바뀝니다."
		.. "#검은 에사우는 야곱에게 다가오며 지나가는 자리의 적에게 초당 60의 피해를 줍니다."
		.. "#짧은 준비시간 후 야곱에게 돌진하며 지나가는 자리의 적에게 초당 300의 방어무시+화상 피해를 줍니다."
		.. "#{{Collectible722}} 고유 능력 : 아니마 솔라"
		.. "#{{Blank}} 다크 에사우가 없는 상태에서 사용 시 다크 에사우를 바로 소환합니다."
		.. "#{{Blank}} 아니마 솔라가 항상 다크 에사우만을 노립니다."
		.. "",
	},
	[PlayerType.PLAYER_JACOB2_B] = {
		-- icon = "",
		name = "야곱(알트)",
		description = "The Deserter: 자신이 낚였다는 걸 깨달은 에사우에게 집요하게 쫒기는 신세가 되었습니다."
		.. "#!!! 유령 상태: {{ColorRed}}한 번이라도 피격 시 즉시 사망합니다.{{CR}} 악마 거지와 헌혈을 조심합시다."
		.. "#새로운 스테이지 진입 시 유령 상태에서 회복됩니다."
		.. "#검은 에사우는 야곱에게 다가오며 지나가는 자리의 적에게 초당 60의 피해를 줍니다."
		.. "#짧은 준비시간 후 야곱에게 돌진하며 지나가는 자리의 적에게 초당 300의 방어무시+화상 피해를 줍니다."
		.. "#{{Collectible722}} 고유 능력 : 아니마 솔라"
		.. "#{{Blank}} 다크 에사우가 없는 상태에서 사용 시 다크 에사우를 바로 소환합니다."
		.. "#{{Blank}} 아니마 솔라가 항상 다크 에사우만을 노립니다."
		.. "",
	
	
	},


	
	-- wakaba
	[wakaba.Enums.Players.WAKABA] = {
		-- icon = "",
		name = "와카바",
		description = "와카바는 하라 유이 작품의 단편작 {{ColorLime}}와카바 걸{{CR}}의 주인공입니다."
		.. "#좋은 아이템이 등장하며 유도성 빙결 눈물을 발사합니다."
		.. "#{{AngelChance}} 와카바로 플레이 시 악마방이 등장하지 않습니다."
		.. "#{{BrokenHeart}} 그녀의 외로운 과거로 인해, 대부분의 체력이 소지 불가능 하트로 채워져 있습니다."
		.. "#{{Pill}} 와카바로 플레이 시 행운 감소, 이동 속도 증가 알약이 등장하지 않습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_BLESSING.."}} 고유 능력 : 와카바의 축복"
		--.. "#"
		.. "",
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		-- icon = "",
		name = "와카바(알트)",
		description = "The Fury: 알트 와카바는 와카바의 과거의 내면을 투영한 캐릭터입니다."
		.. "#{{ColorRed}}좋은 아이템이 등장하지 않으며{{CR}} 적과 지형을 관통하는 눈물을 발사합니다."
		.. "#{{DevilChance}} 알트 와카바로 플레이 시 천사방이 등장하지 않으며 악마방의 모든 아이템이 6코인으로 판매됩니다."
		.. "#{{DamageSmall}} 그녀의 메마른 애정으로 인해, 아이템 획득 시마다 서서히 감소하는 공격력이 +3.6 증가하나, 나머지 능력치가 영구적으로 감소합니다."
		.. "#{{Pill}} 알트 와카바로 플레이 시 행운 증가, 이동 속도 감소 알약이 등장하지 않습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_NEMESIS.."}} 고유 능력 : 와카바의 숙명"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.EATHEART.."}} 고유 능력 : 사랑먹이"
		--.. "#"
		.. "",
	},
	-- shiori
	[wakaba.Enums.Players.SHIORI] = {
		-- icon = "",
		name = "시오리",
		description = "시오리는 와카기 타마키 작품의 {{ColorBookofConquest}}신만의 아는 세계{{CR}}의 히로인 중 한명입니다."
		.. "#공격력이 매우 낮으나 직각 유도 눈물을 발사합니다."
		.. "#{{Key}} 시오리는 액티브 아이템 사용 시 열쇠를 소모합니다. 배터리 획득 시 열쇠 개수가 충전됩니다."
		.. "#{{GoldenKey}} 상점에서 판매 중인 배터리는 황금열쇠로 변환되며 황금열쇠 획득 시 열쇠 6개로 변환됩니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} 고유 능력 : 시오리의 책"
		--.. "#"
		.. "",
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		-- icon = "",
		name = "미네르바",
		description = "The Minerva: 미네르바는 시오리에 깃든 여신이며 유피테르 6자매 중 한명입니다."
		.. "#작지만 유피테르 자매의 날개로 날 수 있습니다."
		.. "#공격력이 매우 낮으나 직각 유도 눈물을 발사합니다."
		.. "#{{Key}} 미네르바는 액티브 아이템 사용 시 열쇠를 소모합니다. 배터리 획득 시 열쇠 개수가 충전됩니다."
		.. "#{{GoldenKey}} 상점에서 판매 중인 배터리는 황금열쇠로 변환되며 황금열쇠 획득 시 열쇠 6개로 변환됩니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} 고유 능력 : 시오리의 책"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} 고유 능력 : 미네르바의 오라"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_CONQUEST.."}} 고유 능력 : 함락의 책"
		--.. "#"
		.. "",
	},
	-- tsukasa
	[wakaba.Enums.Players.TSUKASA] = {
		-- icon = "",
		name = "츠카사",
		description = "츠카사는 하타 켄지로 작품의 {{ColorBookofConquest}}어쨌든 귀여워{{CR}}의 주인공입니다."
		.. "#사거리가 짧은 레이저를 발사합니다. 레이저는 지형을 관통합니다."
		.. "#영원과도 같은 시간을 보낸 츠카사는 고독한 추억을 보내왔습니다. 츠카사는 아이작의 번제:Rebirth까지의 아이템만 획득할 수 있습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.LUNAR_STONE.."}} 고유 능력 : 월석"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.CONCENTRATION.."}} 고유 능력 : 집중"
		--.. "#"
		.. "",
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		-- icon = "",
		name = "???",
		description = "The Phoenix: ???는 황제의 명을 거역하고 불사의 몸을 만들어주는 비약을 마신 이름 없는 소녀입니다."
		.. "#이 소녀와 같은 시간을 보내온 정령이 함께해 주기에 눈물을 발사할 수 없지만 정령이 대신 공격할 수 있습니다."
		.. "#생명의 비약을 마셨지만 부작용으로 {{ColorRed}}피격 무적 시간이 존재하지 않습니다.{{CR}}"
		.. "#생명의 비약의 효과로 그녀는 매우 빠른 속도로 체력을 회복할 수 있습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.ELIXIR_OF_LIFE.."}} 고유 능력 : 생명의 비약"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.MURASAME.."}} 고유 능력 : 무라사메(패시브)"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.FLASH_SHIFT.."}} 고유 능력 : 플래시 시프트"
		--.. "#"
		.. "",
	},
	-- richer
	[wakaba.Enums.Players.RICHER] = {
		-- icon = "",
		name = "리셰",
		description = "리셰는 미야자마 미유, 미야자카 나코 작품의 {{ColorLime}}Love's Sweet Garnish{{CR}}의 히로인입니다."
		.. "#그녀의 달콤한 걸 좋아하는 특성 덕분에 위기를 살짝 넘길 수 있게 되었습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} 고유 능력 : 토끼 리본"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} 기본 소지 아이템 : 달콤달콤 카탈로그"
		--.. "#"
		.. "",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		-- icon = "",
		name = "리셰(알트)",
		description = "The Miko: 무척이나 달콤한 몸을 가진 그녀는 결국 민감해지기 마련입니다."
		.. "#일반적인 방법으로 패시브 아이템을 획득할 수 없으며 획득을 시도할 경우 아이템이 불꽃으로 변합니다."
		.. "#액티브 아이템은 기존과 같은 방식으로 획득할 수 있습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} 고유 능력 : 토끼 리본"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WINTER_ALBIREO.."}} 고유 능력 : 겨울의 알비레오"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}} 고유 능력 : 워터 플레임"
		--.. "#"
		.. "",
	},

}





if EID then
	EID.descriptions[desclang].WakabaAchievementWarningTitle = "{{ColorYellow}}!!! 와카바 모드 아이템 해금 적용 여부 설정"
	EID.descriptions[desclang].WakabaAchievementWarningText = "Pudding & Wakaba(와카바 모드)는 해금 컨텐츠가 제공됩니다.#해금 컨텐츠를 적용하시겠습니까?#Yes:해금 컨텐츠 적용#No:모든 컨텐츠 해금"

	EID.descriptions[desclang].TaintedTsukasaWarningTitle = "{{ColorYellow}}!!! 잠김 !!!"
	EID.descriptions[desclang].TaintedTsukasaWarningText = "해당 캐릭터는 해금되지 않았습니다.#해금 이후에 사용하실 수 있습니다.#해금 방법 : Tsukasa 캐릭터로 Red Key를 갖고 Home 스테이지 돌입#우측 문으로 이동 시 게임 종료"
	
	EID.descriptions[desclang].SweetsChallenge = "사용 시 가장 가까이 있는 아이템의 예상 등급을 선택합니다.#선택한 등급과 아이템의 등급이 일치할 경우 해당 아이템을 획득하며 틀릴 경우 아이템이 사라집니다."
	EID.descriptions[desclang].SweetsFlipFlop = "아이템 사용 버튼으로 취소#{{ButtonY}}/{{ButtonX}}:{{Quality1}}or{{Quality3}}#{{ButtonA}}/{{ButtonB}}:{{Quality2}}or{{Quality4}}#선택한 등급과 아이템의 등급이 일치할 경우 해당 아이템을 획득하며 틀릴 경우 아이템이 사라집니다."

	EID.descriptions[desclang].SweetsChallengeFailed = "{{ColorOrange}}획득 실패 : "
	EID.descriptions[desclang].SweetsChallengeSuccess = "{{ColorCyan}}획득 성공 : "

end