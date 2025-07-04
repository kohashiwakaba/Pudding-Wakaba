local desclang = "ko_kr"
local u = wakaba.Enums.RicherUniformMode

wakaba.descriptions[desclang] = {}
wakaba.descriptions[desclang].birthright = {}
wakaba.descriptions[desclang].birthrightName = "생득권"
wakaba.descriptions[desclang].characters = {
	[wakaba.Enums.Players.WAKABA] = {
		playerName = "Wakaba",
		shortDesc = "유도 눈물을 발사합니다.",
		detailedDesc = "와카바는 하라 유이 작품의 단편작 {{ColorLime}}와카바 걸{{CR}}의 주인공입니다."
		.. "#좋은 아이템이 등장하며 유도성 눈물을 발사합니다."
		.. "#{{AngelChance}} 와카바로 플레이 시 악마방이 등장하지 않습니다."
		.. "#{{BrokenHeart}} 그녀의 외로운 과거로 인해, 최대 3칸의 체력까지 소지할 수 있습니다."
		.. "#{{Pill}} 와카바로 플레이 시 행운 감소, 이동 속도 증가 알약이 등장하지 않습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_BLESSING.."}} 고유 능력 : 와카바의 축복"
		--.. "#"
		.. "",
		birthright = "↑ 체력 상한 +1#{{AngelChance}} 천사방이 모든 층에서 항상 등장합니다.",
		queueDesc = "그녀의 순수함이 영원하기를...",
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		playerName = "Tainted Wakaba",
		shortDesc = "{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받습니다.#완전 관통 눈물을 발사합니다.",
		detailedDesc = "The Fury: 알트 와카바는 와카바의 과거의 내면을 투영한 캐릭터입니다."
		.. "#{{ColorRed}}좋은 아이템이 등장하지 않으며{{CR}} 적과 지형을 관통하는 눈물을 발사합니다."
		.. "#{{DevilChance}} 알트 와카바로 플레이 시 천사방이 등장하지 않으며 모든 판매 아이템이 소울하트를 요구하게 됩니다."
		.. "#{{DamageSmall}} 그녀의 메마른 애정으로 인해, 아이템 획득 시마다 증발성 공격력이 +3.6 증가하나, 나머지 능력치가 영구적으로 감소합니다."
		.. "#{{Pill}} 알트 와카바로 플레이 시 행운 증가, 이동 속도 감소 알약이 등장하지 않습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_NEMESIS.."}} 고유 능력 : 와카바의 숙명"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.EATHEART.."}} 고유 능력 : 사랑먹이"
		--.. "#"
		.. "",
		birthright = "{{Collectible"..wakaba.Enums.Collectibles.WAKABAS_NEMESIS.."}} Wakaba's Nemesis의 능력치 감소가 해제되며 공격력 감소 속도가 느려집니다.#폭발 및 지진파에 피해를 받지 않습니다.",
		queueDesc = "폭발 피해 면역 + 식지 않는 흥분",
	},
	[wakaba.Enums.Players.SHIORI] = {
		playerName = "Shiori",
		shortDesc = "직각 유도 눈물을 발사합니다.#액티브 아이템 사용에 열쇠를 소모합니다.#스테이지마다 랜덤 책을 부여받으며 {{ButtonRT}} 버튼으로 사용할 책을 교체할 수 있습니다.",
		detailedDesc = "시오리는 와카기 타마키 작품의 {{ColorBookofConquest}}신만이 아는 세계{{CR}}의 히로인 중 한명입니다."
		.. "#공격력이 매우 낮으나 직각 유도 눈물을 발사합니다."
		.. "#{{Key}} 시오리는 액티브 아이템 사용 시 열쇠를 소모합니다. 배터리 획득 시 열쇠 개수가 충전됩니다."
		.. "#{{GoldenKey}} 상점에서 판매 중인 배터리는 황금열쇠로 변환되며 황금열쇠 획득 시 열쇠 6개로 변환됩니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} 고유 능력 : 시오리의 책"
		--.. "#"
		.. "",
		birthright = "↑ 액티브 아이템 사용에 필요한 열쇠 개수가 절반으로 감소합니다. (최소 1)",
		queueDesc = "좀 더 똑똑해진 문학소녀",
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		playerName = "Minerva",
		shortDesc = "{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받습니다.#직각 유도 눈물을 발사합니다.#액티브 아이템 사용에 열쇠를 소모합니다.",
		detailedDesc = "The Minerva: 미네르바는 시오리에 깃든 여신이며 유피테르 6자매 중 한명입니다."
		.. "#작지만 유피테르 자매의 날개로 날 수 있습니다."
		.. "#공격력이 매우 낮으나 직각 유도 눈물을 발사합니다."
		.. "#{{Key}} 미네르바는 액티브 아이템 사용 시 열쇠를 소모합니다. 배터리 획득 시 열쇠 개수가 충전됩니다."
		.. "#{{GoldenKey}} 상점에서 판매 중인 배터리는 황금열쇠로 변환되며 황금열쇠 획득 시 열쇠 6개로 변환됩니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}} 고유 능력 : 시오리의 책"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} 고유 능력 : 미네르바의 오라"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_CONQUEST.."}} 고유 능력 : 함락의 책"
		--.. "#"
		.. "",
		birthright = "{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} 미네르바의 오라 효과 적용:"
		.. "#↓ {{DamageSmall}}공격력 -0.5 (중첩 불가)"
		.. "#↑ {{TearsSmall}}연사(+상한) +0.5"
		.. "#↑ {{TearsSmall}}연사 배율 x2.3 (중첩 불가)"
		.. "#유도 눈물을 발사합니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_CONQUEST.."}} Book of Conquest와 액티브 아이템 사용에 필요한 열쇠 개수가 일정량 감소합니다. (최소 1)#↑ 현재 함락된 적들의 코스트에 비례하여 모든 능력치가 상승합니다.",
		queueDesc = "문학소녀의 유대감",
	},
	[wakaba.Enums.Players.TSUKASA] = {
		playerName = "Tsukasa",
		shortDesc = "사거리가 짧은 레이저를 발사합니다.#무한정 부활할 수 있으나 푸른 게이지 소진 시 게임이 종료됩니다.",
		detailedDesc = "츠카사는 하타 켄지로 작품의 {{ColorBookofConquest}}어쨌든 귀여워{{CR}}의 주인공입니다."
		.. "#사거리가 짧은 레이저를 발사합니다. 레이저는 지형을 관통합니다."
		.. "#영원과도 같은 시간을 보낸 츠카사는 고독한 추억을 보내왔습니다. 츠카사는 아이작의 번제:Rebirth까지의 아이템만 획득할 수 있습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.LUNAR_STONE.."}} 고유 능력 : 월석"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.CONCENTRATION.."}} 고유 능력 : 집중"
		--.. "#"
		.. "",
		birthright = "Afterbirth ~ Repentance 아이템을 획득할 수 있습니다.#{{Collectible"..wakaba.Enums.Collectibles.LUNAR_STONE.."}} Lunar Stone 게이지 상한 +100%p",
		queueDesc = "역사와 달빛을 제대로 보다",
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		playerName = "Tainted Tsukasa",
		shortDesc = "{{Collectible"..wakaba.Enums.Collectibles.MURASAME.."}} 공격할 수 없으며 모든 공격을 무라사메가 대신해줍니다.",
		detailedDesc = "The Phoenix: ???는 황제의 명을 거역하고 불사의 몸을 만들어주는 비약을 마신 이름 없는 소녀입니다."
		.. "#이 소녀와 같은 시간을 보내온 정령이 함께해 주기에 눈물을 발사할 수 없지만 정령이 대신 공격할 수 있습니다."
		.. "#생명의 비약을 마셨지만 부작용으로 {{ColorRed}}피격 무적 시간이 존재하지 않습니다.{{CR}}"
		.. "#생명의 비약의 효과로 그녀는 매우 빠른 속도로 체력을 회복할 수 있습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.ELIXIR_OF_LIFE.."}} 고유 능력 : 생명의 비약"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.MURASAME.."}} 고유 능력 : 무라사메(패시브)"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.FLASH_SHIFT.."}} 고유 능력 : 플래시 시프트"
		--.. "#"
		.. "",
		birthright = "눈물 공격을 할 수 있게 됩니다.#{{Collectible"..wakaba.Enums.Collectibles.FLASH_SHIFT.."}} Flash Shift는 카드/알약 슬롯으로 이동되며 사용 시 이동방향으로 기존의 돌진 공격을 합니다.",
		queueDesc = "비극적 시련을 극복하다",
	},
	[wakaba.Enums.Players.RICHER] = {
		playerName = "Richer",
		shortDesc = "저주를 특별하게 바꿉니다.#피해량을 절반으로 줄여주며 장신구의 효과가 강화됩니다.",
		detailedDesc = "리셰는 미야자마 미유, 미야자카 나코 작품의 {{ColorLime}}Love's Sweet Garnish{{CR}}의 히로인입니다."
		.. "#그녀의 부드러움 덕분에 받는 피해를 절반으로 줄여주며, 장신구의 효과가 강화됩니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} 고유 능력 : 토끼 리본"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} 고유 능력 : 달콤달콤 카탈로그"
		--.. "#"
		.. "",
		birthright = "{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} Sweets Catalog의 효과가 다음 사용 전까지 유지됩니다.#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} Rabbit Ribbon의 특수 저주에서 발생하는 패널티가 제거됩니다. (Inventory Descriptions 참조)",
		queueDesc = "더욱 달콤한 향기",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		playerName = "Tainted Richer",
		shortDesc = "{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받습니다.#저주를 특별하게 바꿉니다.#패시브 아이템을 획득할 수 없으며 획득을 시도하면 아이템 불꽃으로 바뀝니다.#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}} Water-Flame 사용 시 선택한 아이템 불꽃을 흡수합니다. ({{ButtonRT}}로 흡수할 아이템 선택)",
		detailedDesc = "The Miko: 무척이나 달콤한 몸을 가진 그녀는 결국 민감해지기 마련입니다."
		.. "#일반적인 방법으로 패시브 아이템을 획득할 수 없으며 획득을 시도할 경우 아이템이 불꽃으로 변합니다."
		.. "#액티브 아이템은 기존과 같은 방식으로 획득할 수 있습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}} 고유 능력 : 토끼 리본"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WINTER_ALBIREO.."}} 고유 능력 : 겨울의 알비레오"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}} 고유 능력 : 워터 플레임"
		--.. "#"
		.. "",
		birthright = "#변환된 불꽃의 방어력이 2배로 증가합니다.#{{Collectible"..wakaba.Enums.Collectibles.WATER_FLAME.."}} Water-Flame으로 흡수 시 흡수한 아이템을 추가로 획득합니다.",
		queueDesc = "점점 따뜻해져가는 달콤함",
	},
	[wakaba.Enums.Players.RIRA] = {
		playerName = "Rira",
		shortDesc = "{{WakabaAqua}} 확률적으로 침수 공격을 합니다.#The Lost 상태일 때도 헌혈류 요소를 사용할 수 있습니다.",
		detailedDesc = "리라는 미야자마 미유, 미야자카 나코 작품의 {{ColorLime}}Love's Sweet Garnish{{CR}}의 히로인입니다."
		.. "#얌전하고 조숙해 보이지만, 말할 수 없는 또 다른 면모도 있습니다."
		.. "#{{WakabaAqua}} 확률적으로 침수 공격을 하며 침수된 적은 독/화상/빨간똥의 경우 x0.8배, 폭발/침수/레이저의 경우 x1.5배의 피해를 받습니다."
		.. "#{{WakabaAqua}} 침수 공격은 돌 타입의 적을 즉사시킵니다."
		.. "#The Lost(유령) 상태일 때도 헌혈류 요소를 사용할 수 있습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.CHIMAKI.."}} 고유 능력 : 치마키"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.NERF_GUN.."}} 고유 능력 : 너프 건"
		--.. "#"
		.. "",
		birthright = "#{{Collectible"..wakaba.Enums.Collectibles.NERF_GUN.."}} Nerf Gun의 약화효과가 더 오래 지속됩니다.#{{Collectible"..wakaba.Enums.Collectibles.CHIMAKI.."}} Chimaki의 공격이 더 강해지며 치마키의 눈물이 레이저로 대체됩니다.",
		queueDesc = "아주 살짝만 더 야릇하게?",
	},
	[wakaba.Enums.Players.RIRA_B] = {
		playerName = "Tainted Rira",
		shortDesc = "{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받습니다.#보물방의 아이템이 장신구로 바뀝니다.#{{ColorRira}}토끼 와드{{CR}}의 영향권 밖에 있으면 서서히 체력이 감소합니다.#클리어한 방 진입 시 토끼 와드의 충전량을 1칸 충전합니다.#The Lost 상태일 때도 헌혈류 요소를 사용할 수 있습니다.",
		detailedDesc = "The Aqua: 리라의 달콤한 기운은 그녀도 모르게 퍼져갑니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.AZURE_RIR.."}} {{ColorRira}}토끼 와드{{CR}}의 영향권 밖에 있으면 서서히 체력이 감소합니다."
		.. "#{{AquaTrinket}} 모든 보물방의 아이템이 {{ColorCyan}}아쿠아 장신구{{CR}}로 바뀝니다."
		.. "#The Lost(유령) 상태일 때도 헌혈류 요소를 사용할 수 있습니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.AZURE_RIR.."}} 고유 능력 : 아주르 리르"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.RABBEY_WARD.."}} 고유 능력 : 토끼 와드"
		--.. "#"
		.. "",
		birthright = "#토끼 와드 영향권 외부에 있어도 체력이 감소하지 않습니다.#{{Collectible"..wakaba.Enums.Collectibles.RABBEY_WARD.."}} Rabbey Ward 사용 시 추가로 그 방의 가장 가까운 아이템 하나를 복사합니다.#{{Collectible"..wakaba.Enums.Collectibles.RABBEY_WARD.."}} 토끼 와드가 적을 향해 레이저 공격을 합니다.",
		queueDesc = "리본 가르기",
	},
	[wakaba.Enums.Players.ANNA] = {
		playerName = "Anna",
		shortDesc = "",
		detailedDesc = "야마다 안나는 누리오 작품의 {{ColorLime}}내 마음의 위험한 녀석{{CR}}의 주인공입니다."
		.. "#{{Collectible402}} 신경쓰이던 남학생인 쿄타로와 무척이나 꽁냥거려 주위를 혼란에 빠트립니다."
		.. "#{{Collectible"..wakaba.Enums.Collectibles.KYOUTAROU_LOVER.."}} 고유 능력 : 쿄타로 러버"
		.. "#{{Collectible"..wakaba.Enums.Collectibles.KYOUTAROU_LOVER.."}} 지정된 등급의 아이템 획득 시 등급이 맞지 않는 다른 아이템은 등급이 일치하도록 바뀝니다."
		.. "#{{WakabaModLunatic}} 와카바 모드의 일부 아이템 효과가 하향됩니다."
		.. "",
		birthright = "{{Quality0}}등급 아이템이 등장하지 않습니다.#{{SpeedSmall}} 획득한 아이템 수만큼 이동속도 +0.003",
		queueDesc = "이음매",
	},
}
wakaba.descriptions[desclang].collectibles = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		itemName = "와카바의 축복",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{AngelChanceSmall}} 악마방이 등장하지 않습니다."
		.. "#{{Quality0}}/{{Quality1}}등급 아이템이 등장하지 않습니다."
		.. "#모든 피격에 대한 패널티에 면역"
		.. "#{{HolyMantleSmall}} 전체 체력이 1칸 이하일 때 방마다 피격을 1회 막아주는 보호막이 제공됩니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{AngelChanceSmall}} 악마방이 등장하지 않습니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Quality0}}등급 아이템이 등장하지 않습니다."
		.. "#{{HolyMantleSmall}} 전체 체력이 1칸 이하일 때 방마다 피격을 1회 막아주는 보호막이 제공됩니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 추가 보호막 +1",
		queueDesc = "악마 봉인 + 더 나아진 운명",
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		itemName = "와카바의 숙명",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{DevilChanceSmall}} 천사방이 등장하지 않습니다."
		.. "#↑ 공격이 적의 방어를 무시합니다."
		.. "#{{DamageSmall}} 아이템 획득 시 증발성 공격력 +3.6"
		.. "#!!! {{Quality4}}/{{Quality5}}/{{Quality6}}등급 아이템이 등장하지 않으며 {{Quality3}}등급의 아이템이 50%의 확률로 다른 아이템으로 변경됩니다."
		.. "#모든 피격에 대한 패널티에 면역"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{DevilChanceSmall}} 천사방이 등장하지 않습니다."
		.. "#{{WakabaModLunatic}} 적에게 +15%p 추가 피해"
		.. "#{{DamageSmall}} 아이템 획득 시 증발성 공격력 +3.6"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Quality3}}/{{Quality4}}/{{Quality5}}/{{Quality6}}등급 아이템이 등장하지 않습니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 추가 임시 공격력 +3.6",
		queueDesc = "천사 봉인 + 더 나빠진 운명",
	},
	[wakaba.Enums.Collectibles.WAKABA_DUALITY] = {
		itemName = "와카바 듀얼리티",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#↑ 공격이 적의 방어를 무시합니다."
		.. "#↓ 아이템 획득 시 증발성 {{DamageSmall}}공격력 +3.6"
		.. "#{{AngelDevilChance}}악마방/천사방이 모든 층에서 항상 등장합니다."
		.. "#↑ 선택형 아이템을 모두 획득할 수 있습니다."
		.. "#모든 피격에 대한 패널티에 면역"
		.. "#{{HolyMantleSmall}} 전체 체력이 1칸 이하일 때 방마다 피격을 1회 막아주는 보호막이 제공됩니다."
		.. "{{CR}}",
		queueDesc = "축복과 숙명 사이",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SHIORI] = {
		itemName = "시오리의 책",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{ShioriValut}} 가능한 경우 모든 스테이지에서 책방이 등장합니다."
		.. "#책 유형의 액티브 아이템 사용 시 {{ShioriPrimary}}1차 추가 효과와 {{ShioriSecondary}}2차 추가 효과가 발동됩니다."
		.. "#{{ShioriSecondary}} 2차 추가 효과는 다른 책을 사용하기 전까지 계속 유지됩니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{ShioriValut}} 가능한 경우 모든 스테이지에서 책방이 등장합니다."
		.. "#책 유형의 액티브 아이템 사용 시 {{ShioriPrimary}}1차 추가 효과와 {{ShioriSecondary}}2차 추가 효과가 발동됩니다."
		.. "#{{WakabaModLunatic}} {{ShioriSecondary}}{{ColorOrange}}2차 추가 효과는 다른 책 사용 및 스테이지 진입 시 변경 혹은 초기화됩니다."
		.. "{{CR}}",
		queueDesc = "문학소녀의 지식을 전수하다",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		itemName = "함락의 책",
		description = ""
		.. "#방 안에 있는 모든 일반 적들을 아군으로 만듭니다."
		.. "#!!! 아군 적의 수가 너무 많을 경우 아이템을 사용할 수 없습니다."
		.. "{{CR}}",
		carBattery = "{{BlinkYellowGreen}}그 방의 모든 일반 보스를 아군으로 만듭니다.",
		queueDesc = "길 잃은 어린 양의 공략집",
	},
	[wakaba.Enums.Collectibles.MINERVA_AURA] = {
		itemName = "미네르바의 오라",
		description = ""
		.. "#오라 안에 있는 아군 몬스터는 최대 체력의 2배까지 지속적으로 회복합니다."
		.. "#!!! 오라 안에 있는 모든 플레이어에게 다음 효과 발동 :"
		.. "#↓ {{DamageSmall}}공격력 -0.5 (중첩 불가)"
		.. "#↑ {{TearsSmall}}연사(+상한) +0.5"
		.. "#↑ {{TearsSmall}}연사 배율 x2.3 (중첩 불가)"
		.. "#유도 눈물을 발사합니다."
		.. "#모든 피격에 대한 패널티에 방어 + 25%의 확률로 피해 무시"
		.. "{{CR}}",
		lunatic = ""
		.. "#오라 안에 있는 아군 몬스터는 최대 체력의 2배까지 지속적으로 회복합니다."
		.. "#!!! 오라 안에 있는 모든 플레이어에게 다음 효과 발동 :"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{DamageSmall}}공격력 -2 (중첩 불가)"
		.. "#↑ {{TearsSmall}}연사(+상한) +0.5"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{TearsSmall}}연사 배율 x1.6 (중첩 불가)"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 연사 +0.5",
		queueDesc = "공격력, 연사 증가 + 동료를 치유해주자",
	},
	[wakaba.Enums.Collectibles.LUNAR_STONE] = {
		itemName = "월석",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#활성화 중일 때 {{DamageSmall}}x1.2/{{TearsSmall}}x1.2"
		.. "#피격 시, 월석이 비활성화 및 게이지가 감소하며 방 클리어 시 월석 게이지를 회복합니다."
		.. "#비활성화 중일 때 {{DamageSmall}}x0.85/{{TearsSmall}}x0.8, 주기적으로 독가스 생성"
		.. "#월석 소지 중 무제한 부활 가능"
		.. "#모든 피격에 대한 패널티에 면역"
		.. "#!!! 월석 게이지 소진 시 아이템이 사라집니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#활성화 중일 때 {{DamageSmall}}x1.2/{{TearsSmall}}x1.2"
		.. "#피격 시, 월석이 비활성화 및 게이지가 감소하며 방 클리어 시 월석 게이지를 회복합니다."
		.. "#비활성화 중일 때 {{DamageSmall}}x0.85/{{TearsSmall}}x0.8, 주기적으로 독가스 생성"
		.. "#월석 소지 중 무제한 부활 가능"
		.. "#!!! 월석 게이지 소진 시 아이템이 사라집니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 활성 중일 때 {{DamageSmall}}/{{TearsSmall}} 추가",
		queueDesc = "신성함을 유지시켜줘",
	},
	[wakaba.Enums.Collectibles.ELIXIR_OF_LIFE] = {
		itemName = "생명의 비약",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{WakabaAntiCurseUnknown}} Unknown 저주에 걸리지 않습니다."
		.. "#↓ {{ColorOrange}}피격 무적 시간이 2프레임으로 감소됩니다."
		.. "#짧은 시간동안 피격되지 않았을 경우 캐릭터의 체력 상태에 따라 체력을 회복합니다."
		.. "#!!! 헌혈류 4회 사용 및 소울하트 2회 피격 시마다 최대 체력 혹은 최대 소울하트 회복량 -1"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{WakabaAntiCurseUnknown}} Unknown 저주에 걸리지 않습니다."
		.. "#{{WakabaModLunatic}} {{ColorRed}}피격 무적 시간이 제거됩니다."
		.. "#짧은 시간동안 피격되지 않았을 경우 캐릭터의 체력 상태에 따라 체력을 회복합니다."
		.. "#!!! 헌혈류 4회 사용 및 소울하트 2회 피격 시마다 최대 체력 혹은 최대 소울하트 회복량 -1"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 피격 무적 시간 +1프레임",
		queueDesc = "무적 시간 제거 + 초고속 회복",
	},
	[wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		itemName = "플래시 시프트",
		description = ""
		.. "#4방향으로 빠르게 움직입니다."
		.. "#3회 사용 이후 재충전이 필요합니다."
		.. "#!!! 패밀리어는 빠르게 움직이지 않습니다."
		.. "{{CR}}",
		carBattery = "무효과",
		queueDesc = "#코멧걸",
	},
	[wakaba.Enums.Collectibles.CONCENTRATION] = {
		itemName = "집중",
		description = ""
		.. "#Ctrl 키를 꾹 눌러 집중 모드로 들어갑니다."
		.. "#집중 게이지가 전부 차면 액티브 게이지를 전부 회복합니다."
		.. "#!!! 집중 게이지 증가량은 반복 사용 시 점점 감소합니다. 이 패널티는 방 클리어 시 차감됩니다."
		.. "#!!! 패널티 카운터 300 이상일 때 집중 불가"
		.. "#!!! 집중 도중 행동이 불가능하며 피격 시 2배의 대미지를 받습니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#Ctrl 키를 꾹 눌러 집중 모드로 들어갑니다."
		.. "#집중 게이지가 전부 차면 액티브 게이지를 전부 회복합니다."
		.. "#!!! 집중 게이지 증가량은 반복 사용 시 점점 감소합니다. 이 패널티는 방 클리어 시 차감됩니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}연속 집중 시 방 클리어 필요, 패널티 카운터 60 이상일 때 집중 불가"
		.. "#!!! 집중 도중 행동이 불가능하며 피격 시 2배의 대미지를 받습니다."
		.. "{{CR}}",
		queueDesc = "명상하여 에너지 재충전",
	},
	[wakaba.Enums.Collectibles.RABBIT_RIBBON] = {
		itemName = "토끼 리본",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{CurseCursedSmall}} 기존 저주가 다른 저주로 변경됩니다."
		.. "#{{Battery}} 방 클리어 시 충전량을 하나 보존합니다. (최대 16)"
		.. "#액티브 아이템이 완충되지 않았을 경우 보존한 충전량을 자동으로 소모하여 해당 액티브 아이템을 충전시킵니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{CurseCursedSmall}} 기존 저주가 다른 저주로 변경됩니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}방 클리어 시 충전량을 하나 보존합니다. (최대 6)"
		.. "#액티브 아이템이 완충되지 않았을 경우 보존한 충전량을 자동으로 소모하여 해당 액티브 아이템을 충전시킵니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 최대 보존 +4",
		queueDesc = "메이드 소녀의 부적",
	},
	[wakaba.Enums.Collectibles.SWEETS_CATALOG] = {
		itemName = "달콤달콤 카탈로그",
		description = ""
		.. "#사용 시 그 방에서 아래 중 하나의 랜덤 무기 효과를 얻습니다:"
		.. "{{CR}}",
		carBattery = "무효과",
		queueDesc = "맛집은 못 참지",
	},
	[wakaba.Enums.Collectibles.WINTER_ALBIREO] = {
		itemName = "겨울의 알비레오",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{RicherPlanetarium}} 가능한 경우, 스테이지 진입 시 리셰의 전용 천체방이 등장합니다."
		.. "#{{RicherPlanetarium}} 전용 천체방에 진입 시 아래 중 하나 등장:"
		.. "#{{ArrowGrayRight}} 현재 스테이지에 따른 배열의 아이템"
		.. "#{{ArrowGrayRight}} 흰색 모닥불"
		.. "#{{ArrowGrayRight}} {{CrystalRestock}} 리셰의 재입고 기계(해금 무관)"
		.. "#{{ArrowGrayRight}} {{CrystalRestock}} 리셰의 재입고 기계는 폭발 및 5{{Coin}}을 소모하여 사용할 수 있으나 일정 횟수 사용 시 비활성화 됩니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{RicherPlanetarium}}리셰의 전용 천체방이 보물방을 대체하여 등장합니다."
		.. "#{{RicherPlanetarium}} 전용 천체방에 진입 시 아래 중 하나 등장:"
		.. "#{{ArrowGrayRight}} 현재 스테이지에 따른 배열의 아이템"
		.. "#{{ArrowGrayRight}} 흰색 모닥불"
		.. "#{{ArrowGrayRight}} {{CrystalRestock}} 리셰의 재입고 기계(해금 무관)"
		.. "#{{ArrowGrayRight}} {{CrystalRestock}} 리셰의 재입고 기계는 폭발 및 5{{Coin}}을 소모하여 사용할 수 있으나 일정 횟수 사용 시 비활성화 됩니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}{{RicherPlanetarium}}에서 추가 아이템 등장",
		queueDesc = "저 너머로 이어져 있어",
	},
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		itemName = "워터 플레임",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} 소지 중일 때 Blind 면역 + 대체 루트 아이템 공개"
		.. "#사용 시 가장 가까이에 있는 패시브 아이템을 아이템 불꽃 2개로 복제합니다."
		.. "#{{Collectible712}}Lemegeton으로 획득할 수 있는 아이템만 적용할 수 있습니다."
		.. "{{CR}}",
		carBattery = {2, 4},
		queueDesc = "역시 리셰쨩은 달콤해",
	},
	[wakaba.Enums.Collectibles.NERF_GUN] = {
		itemName = "너프 건",
		description = ""
		.. "#사용 시 공격하는 방향으로 너프 샷을 여러 발 발사합니다."
		.. "#{{Weakness}} 너프 샷에 맞은 적은 10초동안 속도가 느려지며 받는 피해량이 2배 증가합니다."
		.. "{{CR}}",
		carBattery = "너프 샷 발사 수 증가",
		queueDesc = "서로서로 담가요",
	},
	[wakaba.Enums.Collectibles.CHIMAKI] = {
		itemName = "치마키",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#방 안을 돌아다니며 이하를 포함한 여러 방면으로 캐릭터를 도와줍니다:"
		.. "#{{TearsizeSmall}} 눈물/불꽃 발사"
		.. "#{{Collectible374}} 적을 향해 점프"
		.. "#{{Collectible260}} 확률적으로 저주 해제"
		.. "#{{Blank}} {{ColorGray}}({{LuckSmall}} 40%, 8+일 때 100%)"
		.. "#{{Trinket63}} 트롤 폭탄 해체"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}치마키의 효과 강화#{{ColorKoron}}치마키는 복사되지 않음",
		bffs = "{{ColorRira}}치마키의 효과 강화",
		queueDesc = "리라의 소울메이트",
	},
	[wakaba.Enums.Collectibles.RABBEY_WARD] = {
		itemName = "토끼 와드",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} 소지 중일 때 Blind 면역 + 대체 루트 아이템 공개"
		.. "#사용 시 아래 효과를 지닌 토끼 와드를 설치:"
		.. "#{{HalfSoulHeart}} 설치 시 소울하트 +0.5"
		.. "#{{Collectible91}} 설치한 방에서 2칸 이내에 있는 스테이지 구조 및 특수방을 맵에 표시 및 영향권으로 만듭니다."
		.. "#영향권 내에서 {{DamageSmall}}공격력/{{TearsSmall}}연사 증가"
		.. "{{CR}}",
		carBattery = {"설치:", "2개{{CR}} 설치:"},
		queueDesc = "아쿠아 확장 장치",
	},
	[wakaba.Enums.Collectibles.AZURE_RIR] = {
		itemName = "아주르 리르",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
		.. "#{{AquaTrinket}} 모든 장신구가 획득 시 즉시 흡수되는 아쿠아 장신구로 바뀝니다."
		.. "#{{Blank}} (일부 장신구는 제외)"
		--.. "#방 클리어 보상이 더 일찍 등장합니다."
		.. "{{CR}}",
		queueDesc = "리라 액기스",
	},
	[wakaba.Enums.Collectibles.BROKEN_TOOLBOX] = {
		itemName = "망가진 도시락",
		description = ""
		.. "#{{WakabaAntiCurseBlind}} Blind 면역 + 대체 루트 아이템 공개"
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
		.. "#사용 시 {{Quality3}} 이상 등급의 아이템을 소환합니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#피격이나 적들에게 대미지를 입혔을 때만 충전됩니다."
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_BATTERY .."}}배터리 없이 초과 충전이 가능합니다."
		.. "#사용 시 {{Quality3}} 이상 등급의 아이템을 소환합니다."
		.. "{{CR}}",
		queueDesc = "푸딩을 맛보듯이",
		wisp = "{{InnerWisp}} {{ColorLime}}내부 x1{{CR}}/{{Heart}}:절대무적#일반 눈물을 발사합니다. ({{DamageSmall}}:3)",
		void = "흡수 시 더 이상 {{Quality3}}/{{Quality4}}등급을 보장하지 않음",
		carBattery = "무효과",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		itemName = "잊혀진 자의 책",
		description = ""
		.. "#!!! 사용 시 모든 플레이어에게;"
		.. "#>>> {{BoneHeart}}뼈하트 +1"
		.. "{{CR}}",
		queueDesc = "충전식 뼈",
		belial = "뼈하트 대신 {{BlackHeart}}블랙하트 1개를 획득합니다.",
		wisp = "{{MiddleWisp}} {{ColorYellow}}중앙 x1{CR}}/{{Heart}}:3{#일반 눈물을 발사합니다. ({{DamageSmall}}:3)#불꽃이 꺼지면 {{BoneHeart}}뼈하트, 혹은 아군 Bony류 몬스터를 소환합니다.",
		carBattery = {1, 2},
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		itemName = "D컵 아이스크림",
		description = ""
		.. "#↑ {{Heart}}최대 체력 +1"
		.. "#↑ {{HealingRed}}빨간하트 +1"
		.. "#↑ {{DamageSmall}}공격력 배율 +80%p"
		.. "{{CR}}",
		lunatic = ""
		.. "#↑ {{Heart}}최대 체력 +1"
		.. "#↑ {{HealingRed}}빨간하트 +1"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{DamageSmall}}공격력 배율 +36%p"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 추가 공격력 배율 +36%p",
		queueDesc = "공격력 증가 + 너가 생각한 그게 아니란다",
	},
	[wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM] = {
		itemName = "민트초코 아이스크림",
		description = ""
		.. "#↑ {{TearsSmall}}연사 배율 +100%p"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 추가 연사 배율 +16%p",
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
		.. "#{{ColorRainbow}}방 색상이 임의의 색상으로 바뀝니다."
		.. "{{CR}}",
		queueDesc = "모든 능력치 증가 + 뭔가 분위기가 이상해",
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		itemName = "와카바의 펜던트",
		description = ""
		.. "#↑ {{LuckSmall}}행운을 최소 7 이상으로 설정"
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#{{HealingRed}} 체력을 모두 회복합니다"
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{LuckSmall}}행운을 최소 3 이상으로 설정"
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#{{HealingRed}} 체력을 모두 회복합니다"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 추가 행운 하한 +0.25",
		queueDesc = "공격력 증가 + 엄청난 강운",
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		itemName = "와카바의 헤어핀",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#{{LuckSmall}} 알약 사용 시마다 행운 +0.35"
		.. "{{CR}}",
		queueDesc = "기분 좋은 느낌",
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		itemName = "극비 카드",
		description = ""
		.. "#{{Coin}} 방 클리어 시 동전이 1개씩 쌓입니다."
		.. "#{{Coin}} 그 스테이지에서 피격되지 않았을 경우 추가 동전 +1"
		.. "#{{Shop}} 상점에서 Greed/Super Greed 미니보스가 등장하지 않습니다."
		.. "{{CR}}",
		queueDesc = "동전 적립 + 우리 비밀친구 할래?",
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		itemName = "플럼이",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_PLUM_FLUTE.."}} 캐릭터를 따라다니며 탄환을 막아줍니다."
		.. "#캐릭터가 발사하는 방향 앞에서 눈물을 따라서 발사합니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_PLUM_FLUTE.."}} 캐릭터를 따라다니며 탄환을 막아줍니다."
		.. "#캐릭터가 발사하는 방향 앞에서 눈물을 따라서 발사합니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}너무 많이 피해를 입으면 잠시동안 활동할 수 없으며 10초동안의 휴식이 필요합니다."
		.. "{{CR}}",
		bffs = "피해량 x2",
		queueDesc = "잠깐만 뭐라고?",
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		itemName = "처형자",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_ERASER .."}} 0.75%의 확률로 적을 현재 게임에서 지우는 공격이 나갑니다."
		.. "#{{LuckSmall}} 행운 117+일 때 10%, 보스의 경우 100%"
		.. "#!!! {{ColorSilver}}(지웠을 때 진행에 문제가 생기는 보스의 경우 확률과 상관없이 적용되지 않음){{ColorReset}}"
		.. "{{CR}}",
		queueDesc = "???",
	},
	[wakaba.Enums.Collectibles.NEW_YEAR_BOMB] = {
		itemName = "새해 이브 폭탄",
		description = ""
		.. "#↑ {{Bomb}}폭탄 +9"
		.. "#모든 폭발이 적의 방어를 무시합니다."
		.. "#기존 방어 무시 폭발의 위력이 2배로 증가합니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#↑ {{Bomb}}폭탄 +9"
		.. "#{{WakabaModLunatic}} 폭발 피해가 적에게 +15%p 추가 피해"
		.. "#기존 방어 무시 폭발의 위력이 2배로 증가합니다."
		.. "{{CR}}",
		queueDesc = "공허해지는 폭탄 + 폭탄 9개",
	},
	[wakaba.Enums.Collectibles.REVENGE_FRUIT] = {
		itemName = "복수과",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_MAW_OF_THE_VOID .."}} 공격 시 5%의 확률로 검은 고리가 나갑니다."
		.. "#{{LuckSmall}} 행운 39+일 때 20%"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 검은 고리 지속시간 증가",
		queueDesc = "불닭맛",
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		itemName = "와카바의 교복",
		description = ""
		.. "#사용 시 현재 선택된 슬롯과 가장 가까운 알약/카드/룬을 서로 맞바꿉니다."
		.. "#{{Blank}} ({wakaba_extra_left} / {wakaba_extra_right} 키로 슬롯 선택)"
		.. "#알약/카드/룬 사용 시 교복의 내용물을 같이 사용합니다."
		.. "{{CR}}",
		queueDesc = "평안하세요!",
		belial = "교복의 내용물 수만큼 {{Card16}}XV - The Devil 효과를 같이 발동합니다.",
		wisp = "{{ColorRed}}!!!불꽃이 소환되지 않음 {{CR}}#소지한 상태에는 현재 켜져 있는 모든 불꽃이 어떠한 피해도 입지 않습니다.#소모성 픽업 사용 시 현재 켜져 있는 모든 불꽃에 대응되는 액티브 아이템을 전부 발동합니다.",
		void = "더 이상 내용물을 바꿀 수 없으며 내용물 사용도 액티브 사용으로 변경됩니다.",
		carBattery = "교복 사용 시 내용물도 같이 사용합니다.",
	},
	[wakaba.Enums.Collectibles.EYE_OF_CLOCK] = {
		itemName = "시간의 눈",
		description = ""
		.. "#공격키를 누르는 동안 캐릭터 주변을 도는 원형 레이저를 생성합니다.#{{Blank}} (레이저 피해량 : 공격력 x0.5)"
		.. "#각 원형 레이저에서 새로운 직선 레이저를 추가로 발사합니다.#{{Blank}} (레이저 피해량 : 공격력 x0.16)"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}레이저 공격력 강화#{{ColorRira}}추가 레이저 없음",
		queueDesc = "궤도 레이저",
	},
	[wakaba.Enums.Collectibles.LIL_WAKABA] = {
		itemName = "리틀 와카바",
		description = ""
		.. "#{{Collectible"..CollectibleType.COLLECTIBLE_TECH_X .."}} 공격하는 방향으로 캐릭터의 공격력 x0.4의 원형 레이저를 발사합니다."
		.. "{{CR}}",
		bffs = {0.4, 0.7},
		queueDesc = "행운의 삐비빅 친구",
	},
	[wakaba.Enums.Collectibles.COUNTER] = {
		itemName = "카운터",
		description = ""
		.. "#사용 시 캐릭터가 1초간 무적이 되며;"
		.. "#>>> 무적 상태에서 피격 시 캐릭터의 공격력 x1의 레이저로 반격합니다."
		.. "#완충 상태에서 피격 시 자동 발동"
		.. "#!!! 다른 보호막이 있을 때 발동 안함"
		.. "{{CR}}",
			queueDesc = "레이저 반사",
		wisp = "{{OuterWisp}} {{ColorOrange}}외부 x1{{CR}}/{{Heart}}:2#일반 눈물을 발사합니다. ({{DamageSmall}}:3)#방을 나가면 사라집니다.#카운터가 발동 중일 때 모든 불꽃이 무적이 됩니다.",
		void = "더 이상 자동으로 발동되지 않으며 사용 시 무적 시간이 20초로 증가",
	},
	[wakaba.Enums.Collectibles.RETURN_POSTAGE] = {
		itemName = "미니핀 시러시러",
		description = ""
		.. "#모든 Eternal Fly가 제거됩니다."
		.. "#모든 Needle, Pasty, Dust, Polty, Kineti, Mom's Hand 몬스터들이 항상 아군이 됩니다."
		.. "#!!! 유령 상자는 여전히 캐릭터에게 피해를 주지만 캐릭터가 아닌 다른 곳을 향해 던지게 됩니다."
		.. "{{CR}}",
		queueDesc = "이런 놈들 다시 만나기 싫어",
	},
	[wakaba.Enums.Collectibles.D6_PLUS] = {
		itemName = "향상된 6면 주사위",
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} 사용 시 그 방의 모든 아이템이 랜덤한 아이템과 1초마다 전환되며 두 아이템 중 하나를 선택할 수 있습니다."
		.. "#이미 전환되고 있는 아이템에 사용 시 하나의 선택지가 추가됩니다."
		.. "{{CR}}",
	carBattery = "추가 선택지 +1",
		queueDesc = "주사위 주문서",
	},
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		itemName = "혼돈의 6면 주사위",
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} 사용 시 그 방의 모든 아이템이 랜덤한 아이템과 매우 빠른 속도로 전환되며 9개의 아이템 중 하나를 선택할 수 있습니다."
		.. "{{CR}}",
	carBattery = "무효과",
		queueDesc = "자신의 운명을 믿는 자들을 위하여",
	},
	[wakaba.Enums.Collectibles.LIL_MOE] = {
		itemName = "리틀 모에",
		description = ""
		.. "#일정 주기로 모에 주변을 도는 유도 눈물을 발사합니다."
		.. "#눈물의 효과는 각각 랜덤이며 각각의 눈물은 적에게 최소 4의 피해를 줍니다."
		.. "#{{Blank}} (폭발성 눈물은 발사되지 않습니다)."
		.. "{{CR}}",
		bffs = {4, 8},
		queueDesc = "퓨전 친구",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		itemName = "집중의 책",
		description = ""
		.. "#{{Weakness}} 사용 시 그 방의 적을 약화시키며;"
		.. "#>>> 캐릭터가 움직이지 않을 시 {{DamageSmall}}+1.4/{{TearsSmall}} +1.0/{{Collectible3}}유도"
		.. "#!!! 캐릭터 역시 피격 시 최소 2칸의 피해를 받습니다."
		.. "{{CR}}",
		carBattery = "무효과",
		queueDesc = "취급주의",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		itemName = "룬 기록서",
		description = ""
		.. "#{{Rune}} 사용 시 임의의 룬 하나를 지급합니다."
		.. "{{CR}}",
		queueDesc = "충전식 룬 뽑기",
	belial = "{{Card41}}Black Rune을 획득할 확률이 50%로 증가합니다.#{{ColorWakabaNemesis}}10%의 확률로 {{Card41}}Black Rune의 효과를 발동합니다.",
	carBattery = {"하나", "2개"},
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		itemName = "마이크로 도플갱어",
		description = ""
		.. "#작은 아이작 패밀리어를 12마리 소환합니다."
		.. "#작은 아이작 패밀리어는 캐릭터와 함께 이동하며 적이 있는 방향으로 공격력 1.35의 눈물을 발사합니다."
		.. "{{CR}}",
		carBattery = {12, 24, 3, 6, 1, 2},
		queueDesc = "자기 자신을 인수분해",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		itemName = "침묵의 책",
		description = ""
		.. "#적의 모든 탄환을 지웁니다."
		.. "{{CR}}",
		queueDesc = "탄막 청소기",
		belial = "{{Collectible" .. CollectibleType.COLLECTIBLE_DARK_ARTS .. "}}Dark Arts의 효과 발동과 동시에 지운 투사체 수만큼 그 방의 모든 적들에게 대미지를 줍니다.",
		carBattery = "무효과",
	},
	[wakaba.Enums.Collectibles.VINTAGE_THREAT] = {
		itemName = "빈티지의 위협",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#{{Player"..wakaba.Enums.Players.SHIORI_B.."}} 사망 시 그 방에서 Tainted Shiori로 부활하며;"
		.. "#>>> 열쇠 개수가 0개로 초기화, 4개의 {{Collectible656}}Damocles의 검이 활성화됩니다."
		.. "#{{Warning}} {{ColorRed}}{{ColorBlink}}패널티 피격 즉시 검이 떨어지며 추가 목숨 개수 및 남은 플레이어와 관계없이 게임오버{{ColorReset}} !!!"
		.. "{{CR}}",
		queueDesc = "영원한 생명?",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_GOD] = {
		itemName = "신의 책",
		description = ""
		.. "#피격 시 체력이 없을 경우 천사 상태로 돌입하며 이하 효과 발동:"
		.. "#>>> {{DamageSmall}}공격력 배율 x0.5"
		.. "#>>> 눈물에 후광이 생기며 후광에 닿은 적은 초당 캐릭터의 공격력 x15의 피해를 받습니다."
		.. "#>>> {{BrokenHeart}}피격 시 부서진하트 +1"
		.. "{{CR}}",
		queueDesc = "더 강해져서 돌아오마",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		itemName = "사신의 대응책",
		description = ""
		.. "#사용 시 그 방에서 캐릭터의 사망을 1회 막으며 보호막을 1개 지급합니다."
		.. "#>>> 사망 방어 이전까지 빨간 하트 피격을 먼저 받으며 피격 시 발생하는 패널티를 막아줍니다."
		.. "{{CR}}",
		queueDesc = "생명 보호서",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_TRAUMA] = {
		itemName = "트라우마의 책",
		description = ""
		.. "#사용 시 최대 15개의 캐릭터의 눈물이 폭발하며"
		.. "#>>> 폭발 지점마다 혈사포를 4방향으로 발사합니다."
		.. "{{CR}}",
		carBattery = "폭발이 기가폭탄의 폭발로 바뀝니다.",
		queueDesc = "분노의 눈물 폭파기",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		itemName = "타천사의 책",
		description = ""
		.. "#사용 시 캐릭터의 공격력 x0.4의 연옥의 유령 3마리를 소환합니다."
		.. "#피격 시 체력이 없을 경우 타천사({{BlackHeart}}6) 상태로 돌입하며;"
		.. "#>>> {{ColorSilver}}사용 시 캐릭터의 공격력 +35의 적을 추적하는 유령 11마리를 소환합니다."
		.. "#>>> {{DamageSmall}}{{ColorSilver}}공격력 배율 x7"
		.. "#>>> !!!{{ColorYellow}}눈물 발사 및액티브 교체 불가{{ColorReset}}"
		.. "{{CR}}",
		queueDesc = "흐름 느끼기",
	},
	[wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY] = {
		itemName = "마이지마 전설",
		description = ""
		.. "#사용 시 아래 중 하나의 책 효과 하나를 발동합니다."
		.. "{{CR}}",
		carBattery = {"하나", "2개"},
		queueDesc = "데메테르 주문서",
	},
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		itemName = "아폴리온의 시련",
		description = ""
		.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON 전용{{CR}}#REPENTOGON을 실행중이지 않았을 때 이 아이템을 발견하면 모드 개발자에게 연락 바람"
		.. "{{CR}}",
		carBattery = "선택한 액티브를 한 번 더 발동하거나 심연의 파리를 하나 더 소환합니다.",
		queueDesc = "공허함을 받아들여라",
	},
	[wakaba.Enums.Collectibles.LIL_SHIVA] = {
		itemName = "리틀 시바",
		description = ""
		.. "#{{Collectible532}} 일정 주기로 눈물을 흡수하는 눈물을 일렬로 5발 발사합니다."
		.. "#최대 5번 흡수 시 파열되어 8방향으로 작은 눈물이 발사됩니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Collectible532}}일정 주기로 눈물을 흡수하는 눈물을 발사합니다."
		.. "#최대 5번 흡수 시 파열되어 8방향으로 작은 눈물이 발사됩니다."
		.. "{{CR}}",
		bffs = "피해량 x2",
		queueDesc = "소원을 비는 친구",
	},
	[wakaba.Enums.Collectibles.NEKO_FIGURE] = {
		itemName = "고양이 피규어",
		description = ""
		.. "#↓ {{DamageSmall}}공격력 배율 -10%p"
		.. "#폭발을 제외한 캐릭터의 공격이 적의 방어력을 무시합니다."
		.. "#↑ {{UltraSecretRoom}}특급 비밀방에서 반드시 {{Quality3}}/{{Quality4}} 아이템이 등장합니다."
		.. "{{CR}}",
		description = ""
		.. "#↓ {{DamageSmall}}공격력 배율 -60%p"
		.. "#폭발을 제외한 캐릭터의 공격이 적의 방어력을 무시합니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 공격력 배율 +10%p",
		queueDesc = "약해졌다... 하지만 대가는?",
	},
	[wakaba.Enums.Collectibles.DEJA_VU] = {
		itemName = "데자뷰",
		description = ""
		.. "#아이템 등장 시 12.5%의 확률로 캐릭터가 이미 소지한 아이템이 다시 등장합니다."
		.. "{{CR}}",
		queueDesc = "잊혀져 가는 느낌",
	},
	[wakaba.Enums.Collectibles.LIL_MAO] = {
		itemName = "리틀 마오",
		description = ""
		.. "#↑ {{SpeedSmall}}이동속도 +0.15"
		.. "#스스로 움직일 수 없으며 둥근 레이저가 그녀 주변을 둘러쌉니다."
		.. "#캐릭터와 접촉 후 공격 키로 던질 수 있습니다."
		.. "{{CR}}",
		bffs = "피해량 x2",
		queueDesc = "던질 수 있는 친구",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		itemName = "이세계 정의서",
		description = ""
		.. "#사용 시 캐릭터와 같이 이동하며 공격하는 방향으로 캐릭터의 공격과 같은 공격을 발사하는 꼬마 클롯을 소환합니다."
		.. "#소환된 모든 꼬마 클롯의 체력을 2 회복합니다."
		.. "#최대 10마리까지 소환할 수 있으며 이후 사용 시 꼬마 클롯의 체력을 전부 회복합니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#사용 시 캐릭터와 같이 이동하며 공격하는 방향으로 캐릭터의 공격과 같은 공격을 발사하는 꼬마 클롯을 소환합니다."
		.. "#소환된 모든 꼬마 클롯의 체력을 2 회복합니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}최대 4마리까지 소환할 수 있으며 이후 사용 시 꼬마 클롯의 체력을 전부 회복합니다."
		.. "{{CR}}",
		carBattery = {"소환합니다", "2마리{{CR}} 소환합니다", 2, 4},
		queueDesc = "슬라임 소환",
	},
	[wakaba.Enums.Collectibles.BALANCE] = {
		itemName = "미러 밸런스",
		description = ""
		.. "#동전 5개를 소모하여 폭탄과 열쇠를 각각 1개씩 획득합니다."
		.. "#!!! 동전이 부족한 상태에서 사용 시: "
		.. "#>>> 폭탄 혹은 열쇠 중 개수가 많은 쪽을 1개 차감하여 다른 쪽 픽업을 1개 획득합니다."
		.. "{{CR}}",
		carBattery = "무효과",
		queueDesc = "소모품 교환소 + 동전 10개",
	},
	[wakaba.Enums.Collectibles.RICHERS_FLIPPER] = {
		itemName = "리셰의 뒤집개",
		description = ""
		.. "#↑ {{Bomb}}폭탄 +1"
		.. "#↑ {{Key}}열쇠 +1"
		.. "#사용 시 {{Bomb}}/{{Key}} 및 {{Card}}/{{Pill}} 픽업을 각각 반대 타입으로 바꿉니다."
		.. "{{CR}}",
		carBattery = "무효과",
		queueDesc = "소모품 뒤집기",
	},
	[wakaba.Enums.Collectibles.RICHERS_NECKLACE] = {
		itemName = "리셰의 목걸이",
		description = ""
		.. "#적을 놓친 눈물에 도그마 레이저가 생깁니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 도그마 레이저 빈도 증가",
		queueDesc = "따끔!",
	},
	[wakaba.Enums.Collectibles.MOE_MUFFIN] = {
		itemName = "모에의 머핀",
		description = ""
		.. "↑ {{Heart}}최대 체력 +1"
		.. "#↑ {{HealingRed}}빨간하트 +1"
		.. "#↑ {{DamageSmall}}공격력 +1.5"
		.. "#↑ {{RangeSmall}}사거리 +1.5"
		.. "{{CR}}",
		queueDesc = "공격력, 사거리 증가",
	},
	[wakaba.Enums.Collectibles.MURASAME] = {
		itemName = "무라사메",
		description = ""
		.. "{{Collectible215}} {{AngelDevilChanceSmall}}악마방/천사방 확률이 100%로 고정됩니다."
		.. "#{{Collectible498}} {{AngelDevilChanceSmall}}악마방과 천사방이 함께 등장하며 두 방 중 한곳을 선택할 수 있습니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 악마방 아이템 무료화 +1#{{ColorRira}}중첩 당 천사방 아이템 선택형 제거 +1",
		queueDesc = "신사 지킴이",
	},
	[wakaba.Enums.Collectibles.CLOVER_SHARD] = {
		itemName = "클로버 잎사귀",
		description = ""
		.. "↑ {{Heart}}최대 체력 +1"
		.. "#↑ {{HealingRed}}빨간하트 +1"
		.. "#↑ {{DamageSmall}}공격력 배율 x1.11"
		.. "{{CR}}",
		queueDesc = "계속 모아보자",
	},
	[wakaba.Enums.Collectibles.NASA_LOVER] = {
		itemName = "나사 러버",
		description = ""
		.. "공격하는 방향으로 공격력 3.5의 눈물을 발사합니다."
		.. "#다른 패밀리어의 공격이 적에게 부딪힐 때 마다 1~2개의 짧은 유도 레이저가 발사됩니다."
		.. "{{CR}}",
		bffs = {3.5, 7},
		queueDesc = "전류 텔레파시",
	},
	[wakaba.Enums.Collectibles.ARCANE_CRYSTAL] = {
		itemName = "아케인 크리스탈",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 배율 +12%p"
		.. "#공격에 유도 효과가 생깁니다."
		.. "#공격이 적 명중 시 20%의 확률로 한 번 더 받습니다."
		.. "#{{LuckSmall}} 행운 43+일 때 60%"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 공격력 배율 +12%p",
		queueDesc = "공격력 증가",
	},
	[wakaba.Enums.Collectibles.ADVANCED_CRYSTAL] = {
		itemName = "어드밴스드 크리스탈",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 배율 +14%p"
		.. "#공격이 적을 관통합니다."
		.. "#공격이 적 명중 시 5%의 확률로 적의 방어를 무시합니다."
		.. "#{{LuckSmall}} 행운 55+일 때 43%"
		.. "{{CR}}",
		lunatic = ""
		.. "#↑ {{DamageSmall}}공격력 배율 +14%p"
		.. "#공격이 적을 관통합니다."
		.. "#{{WakabaModLunatic}} 공격이 적 명중 시 5%의 확률로 적에게 +15%의 추가 피해를 줍니다."
		.. "#{{LuckSmall}} 행운 55+일 때 43%"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 공격력 배율 +14%p",
		queueDesc = "공격력 증가",
	},
	[wakaba.Enums.Collectibles.MYSTIC_CRYSTAL] = {
		itemName = "미스틱 크리스탈",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 배율 +16%p"
		.. "#눈물에 후광이 생깁니다."
		.. "#{{Card" .. Card.CARD_HOLY .."}} 방 8개 클리어 시마다 Holy Mantle 방어막을 지급합니다. (최대 2개)"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 공격력 배율 +16%p#{{ColorRira}}중첩 당 보호막에 필요한 방 클리어 수 -1",
		queueDesc = "공격력 증가",
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		itemName = "3D 프린터",
		description = ""
		.. "#현재 소지 중인 장신구를 복제하여 흡수합니다."
		.. "{{CR}}",
		carBattery = {"흡수합니다.", "2번{{CR}} 흡수합니다."},
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
		.. "#!!! (사용 효과 없음)"
		.. "{{CR}}",
		queueDesc = "떠다니는 거북이",
	},
	[wakaba.Enums.Collectibles.PLASMA_BEAM] = {
		itemName = "플라즈마 빔",
		description = ""
		.. "#캐릭터의 모든 공격이 적에게 1.25배의 레이저 피해를 줍니다."
		.. "#기존 레이저 공격은 적의 방어를 무시합니다."
		.. "#적 명중 시 2초간 최대 66의 피해를 주는 플라즈마 공을 소환합니다.",
		lunatic = ""
		.. "#캐릭터의 모든 공격이 적에게 1.25배의 레이저 피해를 줍니다."
		.. "#기존 레이저 공격은 적에게 1.4배의 피해를 줍니다.",
		queueDesc = "초강력 정전기 공격",
	},
	[wakaba.Enums.Collectibles.POWER_BOMB] = {
		itemName = "파워 봄",
		description = ""
		.. "#사용 시 그 방의 적에게 초당 30의 피해를 주며 모든 장애물과 문을 파괴합니다."
		.. "#>>> 폭발 소멸 시 그 방의 픽업을 폭발 지점으로 끌어들입니다."
		.. "{{CR}}",
		carBattery = "폭발 공격력 2배",
		queueDesc = "압축식 폭발 공격",
	},
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = {
		itemName = "마그마 블레이드",
		description = ""
		.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON 전용{{CR}}#REPENTOGON을 실행중이지 않았을 때 이 아이템을 발견하면 모드 개발자에게 연락 바람"
		.. "{{CR}}",
		queueDesc = "마그마 스트림",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		itemName = "팬텀 클로크",
		description = ""
		.. "#{{Confusion}} 짧은 시간동안 캐릭터를 은폐, 그 방의 적에게 혼란을 겁니다."
		.. "#>>> 움직이거나 공격 중일 때 지속시간 감소"
		.. "#>>> {{ChallengeRoom}}은폐 중 도전방, 보스 도전방의 문이 열립니다."
		.. "{{CR}}",
		queueDesc = "은신은 무적이 아니다",
		belial = "은폐 상태일 때 {{DamageSmall}}공격력 배율 x1.25",
		carBattery = "무효과",
	},
	[wakaba.Enums.Collectibles.RED_CORRUPTION] = {
		itemName = "적색 감염",
		description = "{{Collectible21}} 맵에 특수방의 위치를 표시합니다."
		.. "#모든 특수 방이 빨간 방으로 바뀝니다."
		.. "#가능한 경우, 스테이지 진입 시 46%의 확률로 특수 방 주변에 새로운 방이 생성됩니다."
		.. "#{{LuckSmall}} 행운 29+일 때 100%"
		.. "#!!! {{ErrorRoom}}오류방으로 향하는 문이 생성될 수 있습니다."
		.. "#!!!{{BossRoom}}/{{UltraSecretRoom}}에는 영향 없음"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 확률 증가",
		queueDesc = "감염된 지도",
	},
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		itemName = "물음표 블럭",
		description = ""
		.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON 전용{{CR}}#REPENTOGON을 실행중이지 않았을 때 이 아이템을 발견하면 모드 개발자에게 연락 바람"
		.. "{{CR}}",
		queueDesc = "뭔가 익숙한 상자다",
	},
	[wakaba.Enums.Collectibles.CLENSING_FOAM] = {
		itemName = "클렌징 폼",
		description = ""
		.. "#{{Poison}} 캐릭터와 가까이 있는 적을 중독시킵니다."
		.. "#캐릭터와 가까이 있는 일반 몬스터의 챔피언 속성을 제거합니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 중독 지속시간 증가",
		queueDesc = "강화 해제",
	},
	[wakaba.Enums.Collectibles.BEETLEJUICE] = {
		itemName = "비틀쥬스",
		description = ""
		.. "#{{Pill}} 확인되지 않은 알약의 효과를 알 수 있습니다."
		.. "#{{Pill}} 사용 시 현재 게임의 알약 효과 중 1개를 랜덤으로 바꾸며 바뀐 알약을 드랍합니다."
		.. "#{{Pill}} 소지한 상태에서 방 클리어 시 알약을 추가로 드랍합니다."
		.. "{{CR}}",
		queueDesc = "알약 내용물을 바꾸는 능력",
		carBattery = "무효과",
	},
	[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] = {
		itemName = "탑의 저주 2",
		description = ""
		.. "#{{GoldenBomb}} 항상 황금폭탄을 가집니다."
		.. "#피격 시 및 Holy Mantle 보호막 소모 시 황금 트롤폭탄을 6개 소환합니다."
		.. "#!!! 모든 트롤 폭탄이 황금 트롤폭탄으로 바뀝니다."
		.. "{{CR}}",
		queueDesc = "이제 그만 혼돈을 받아들이자",
	},
	[wakaba.Enums.Collectibles.ANTI_BALANCE] = {
		itemName = "안티 밸런스",
		description = ""
		.. "#{{Pill}} 확인되지 않은 알약의 효과를 알 수 있습니다.#{{Pill}} 모든 알약을 거대 알약으로 바꿉니다."
		.. "{{CR}}",
		queueDesc = "극과 극은 통한다",
	},
	[wakaba.Enums.Collectibles.VENOM_INCANTATION] = {
		itemName = "고독의 주법",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#{{Poison}} 독/화상 공격이 5%의 확률로 적을 즉사시킵니다.#>>> (일반 보스의 경우 최대 1.36%)"
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
		queueDesc = "사거리, 행운 증가 + 반딧불이의 도움",
	},
	[wakaba.Enums.Collectibles.DOUBLE_INVADER] = {
		itemName = "침략자",
		description = ""
		.. "#↓ 악마/천사방이 더 이상 등장하지 않습니다."
		.. "#↑ {{DamageSmall}}공격력 배율 +320%p"
		.. "#↓ 메이저 보스방의 속도가 빨라집니다."
		.. "#{{WakabaModHidden}} {{ColorKoron}}???"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 공격력 배율 +100%p#{{WakabaModHidden}} {{ColorKoron}}중첩 당 부정 효과 개체 +1",
		queueDesc = "공격력 대폭 증가... 그 대가는?",
	},
	[wakaba.Enums.Collectibles.SEE_DES_BISCHOFS] = {
		itemName = "비숍의 강물",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#{{Collectible584}} 4번째 방 진입 시마다 Book of Virtues의 불꽃을 소환합니다."
		.. "#{{Player"..wakaba.Enums.Players.TSUKASA_B.."}} 사망 시 전 방에서 Tainted Tsukasa로 부활합니다. (부활 시에도 위 효과 유지)"
		.. "{{CR}}",
		queueDesc = "모든 비극의 시작",
	},
	[wakaba.Enums.Collectibles.JAR_OF_CLOVER] = {
		itemName = "클로버 씨앗 병",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#↑ 게임 시간 240초마다 {{LuckSmall}}행운 +1"
		.. "#{{Player"..wakaba.Enums.Players.WAKABA.."}} 사망 시 전 방에서 Wakaba로 부활합니다. (부활 시에도 위 효과 유지)"
		.. "{{CR}}",
		queueDesc = "그녀가 태어날 때까지",
	},
	[wakaba.Enums.Collectibles.CRISIS_BOOST] = {
		itemName = "크라이시스 부스트",
		description = ""
		.. "#↑ {{TearsSmall}}연사 +1"
		.. "#↑ 전체 체력 및 {{HolyMantleSmall}}보호막의 수가 적을수록 {{DamageSmall}}공격력 배율 증가"
		.. "#>>> 체력 1칸일 때 최대 x1.45/{{HalfHeart}}일 때 x2.0"
		.. "{{CR}}",
		lunatic = ""
		.. "#↑ {{TearsSmall}}연사 +1"
		.. "#↑ 전체 체력 및 {{HolyMantleSmall}}보호막의 수가 적을수록 {{DamageSmall}}공격력 배율 증가"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}체력 1칸일 때 최대 x1.16/{{HalfHeart}}일 때 x2.0"
		.. "{{CR}}",
		queueDesc = "위기에 빠질수록 강해지다",
	},
	[wakaba.Enums.Collectibles.PRESTIGE_PASS] = {
		itemName = "프리스티지 패스",
		description = ""
		.. "#{{CrystalRestock}} {{BossRoom}}보스방 클리어 시 리셰의 크리스탈 리스톡을 생성합니다."
		.. "#{{CrystalRestock}} {{DevilRoom}}{{AngelRoom}}/{{Planetarium}}/{{SecretRoom}}/{{UltraSecretRoom}}/블랙마켓에 리셰의 크리스탈 리스톡을 소환합니다."
		.. "#{{CrystalRestock}} 리셰의 크리스탈 리스톡은 {{Bomb}}폭발 및 5{{Coin}}을 소모하여 사용할 수 있으나 2회 사용 시 비활성화 됩니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#{{CrystalRestock}} {{BossRoom}}보스방 클리어 시 리셰의 크리스탈 리스톡을 생성합니다."
		.. "#{{CrystalRestock}} {{DevilRoom}}{{AngelRoom}}/{{Planetarium}}/{{SecretRoom}}/{{UltraSecretRoom}}/블랙마켓에 리셰의 크리스탈 리스톡을 소환합니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{CrystalRestock}}리셰의 크리스탈 리스톡은 {{Bomb}}폭발 및 5{{Coin}}을 소모하여 사용할 수 있으나 1회 사용 시 비활성화 됩니다."
		.. "{{CR}}",
		queueDesc = "리셰쨩의 마법",
	},
	[wakaba.Enums.Collectibles.BUNNY_PARFAIT] = {
		itemName = "토끼 파르페",
		description = ""
		.. "#!!! 방 번호의 일의 자리에 따라 랜덤 아이템 효과를 얻습니다:"
		.. "#>>> 0/5 : {{Collectible3}}"
		.. "#{{Blank}} 1/6 : {{Collectible224}}"
		.. "#{{Blank}} 2/7 : {{Collectible618}}"
		.. "#{{Blank}} 3/8 : {{Collectible374}}"
		.. "#{{Blank}} 4/9 : {{Collectible494}}"
		.. "#{{Player"..wakaba.Enums.Players.RIRA.."}} 사망 시 전 방에서 Rira로 부활합니다. (부활 시에도 위 효과 유지)"
		.. "{{CR}}",
		queueDesc = "잊혀진 레시피",
	},
	[wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		itemName = "카라멜로 팬케이크",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#↑ {{DamageSmall}}공격력 +1"
		.. "#↑ {{LuckSmall}}행운 +1"
		.. "#공격이 카라멜로 파리로 바뀌거나 추가로 소환됩니다."
		.. "#>>> 파리 색상에 따라 적에게 {{ColorRicher}}3x(리셰){{CR}}/{{WakabaAqua}}{{ColorRira}}1x+침수(리라){{CR}}/{{ColorCiel}}5x+폭발(시엘){{CR}}/{{ColorKoron}}1.5x+석화(코론){{CR}} 피해를 줍니다."
		.. "#{{Player"..wakaba.Enums.Players.RICHER.."}} 사망 시 전 방에서 Richer로 부활합니다. (부활 시에도 위 효과 유지)"
		.. "{{CR}}",
		queueDesc = "잊혀진 레시피",
	},
	[wakaba.Enums.Collectibles.EASTER_EGG] = {
		itemName = "이스터 에그",
		description = ""
		.. "#캐릭터 주위를 돌며 공격하는 방향으로 공격력 1의 유도 눈물을 발사합니다."
		.. "#이스터 코인을 모을 때마다 공격력과 공격 속도가 증가합니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}5개 이상일 때 중첩 당 공격력, 공격 속도 대폭 증가",
		queueDesc = "수상한 달걀",
	},
	[wakaba.Enums.Collectibles.ONSEN_TOWEL] = {
		itemName = "온천 타월",
		description = ""
		.. "#↑ {{SoulHeart}}소울하트 +1"
		.. "#타이머가 1분 00초가 될 때마다 45%의 확률로 {{HalfSoulHeart}}소울하트 반 칸을 회복합니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#↑ {{SoulHeart}}소울하트 +1"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}타이머가 1분 00초가 될 때마다 10%의 확률로 {{HalfSoulHeart}}소울하트 반 칸을 회복합니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 확률 증가",
		queueDesc = "영혼 재생 + 체력 증가",
	},
	[wakaba.Enums.Collectibles.SUCCUBUS_BLANKET] = {
		itemName = "서큐버스의 망토",
		description = ""
		.. "#↑ {{BlackHeart}}블랙하트 +1"
		.. "#{{DamageSmall}} 블랙하트 1칸 당 공격력 +0.5"
		.. "{{CR}}",
		queueDesc = "타락한 영혼 공명",
	},
	[wakaba.Enums.Collectibles.RICHERS_UNIFORM] = {
		itemName = "리셰의 제복",
		description = ""
		.. "#사용 시 그 방의 종류에 따라 다른 효과를 발동합니다."
		.. "#>>> {{ColorGray}}(Inventory Descriptions에서 확인 가능)"
		.. "{{CR}}",
		queueDesc = "귀여운 건 최고!",
	},
	[wakaba.Enums.Collectibles.LIL_RICHER] = {
		itemName = "리틀 리셰",
		description = ""
		.. "#공격하는 방향으로 초당 8의 피해를 주는 추적 눈물을 발사합니다."
		.. "#{{Battery}} 방 클리어 시 충전량을 하나 보존합니다. (최대 12)"
		.. "#액티브 아이템 미완충 시 보존량을 자동으로 소모하여 해당 액티브를 충전시킵니다."
		.. "{{CR}}",
		lunatic = ""
		.. "#공격하는 방향으로 초당 8의 피해를 주는 추적 눈물을 발사합니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}방 클리어 시 충전량을 하나 보존합니다. (최대 4)"
		.. "#액티브 아이템 미완충 시 보존량을 자동으로 소모하여 해당 액티브를 충전시킵니다."
		.. "{{CR}}",
		bffs = {8, 16},
		duplicate = "{{ColorRira}}중첩 당 최대 보존 +4#{{ColorKoron}}리셰는 복사되지 않음",
		queueDesc = "이거 떼면 곤란해요...",
	},
	[wakaba.Enums.Collectibles.CUNNING_PAPER] = {
		itemName = "커닝 페이퍼",
		description = ""
		.. "#{{Card}} 사용할 때마다 랜덤 카드의 효과를 발동합니다."
		.. "{{CR}}",
		carBattery = {"랜덤 카드", "2종류의{{CR}} 랜덤 카드"},
		queueDesc = "베끼는 건 안돼!",
	},
	[wakaba.Enums.Collectibles.TRIAL_STEW] = {
		itemName = "시련의 국",
		description = "!!! 효과 유지 중일 때:#↑ {{TearsSmall}}1스택 당 연사(+상한) +1#↑ {{DamageSmall}}공격력 배율 x2#↑ {{DamageSmall}}1스택 당 추가 공격력 +25%#방 클리어 시 액티브 아이템을 완충, 스택 1개가 제거됨",
	},
	[wakaba.Enums.Collectibles.SELF_BURNING] = {
		itemName = "셀프 버닝",
		description = "{{Burning}} 사용 시 캐릭터가 뜨거워집니다.(버닝)"
		.. "#{{Burning}} 버닝 상태일 때 탄환 피격을 제외한 적에 의한 피해를 받지 않으나;"
		.. ">>> 20초마다 체력 반칸이 깎이며 탄환 피격 시 효과가 사라집니다."
		.. "#>>> 체력 소모 아이템, 헌혈기, 희생방 피격은 그대로 적용됩니다."
		.. "#!!! 스테이지 당 한번 사용할수 있으며 배터리나 방 클리어로 충전되지 않습니다."
		.. "{{CR}}",
		queueDesc = "달아오르기 시작",
		carBattery = "무효과",
	},
	[wakaba.Enums.Collectibles.POW_BLOCK] = {
		itemName = "POW 블럭",
		description = "↑ {{Bomb}}폭탄 +6#사용 시 폭탄 2개를 소모하여 지상의 적에게 275 분산 피해를 줍니다.",
		carBattery = "무효과",
		queueDesc = "지면 터트리기",
	},
	[wakaba.Enums.Collectibles.MOD_BLOCK] = {
		itemName = "MOd 블럭",
		description = "↑ {{Bomb}}폭탄 +6#사용 시 폭탄 2개를 소모하여 공중의 적에게 333 분산 피해를 줍니다.",
		carBattery = "무효과",
		queueDesc = "공기 터트리기",
	},
	[wakaba.Enums.Collectibles.RIRAS_BRA] = {
		itemName = "리라의 속옷",
		description = "{{Collectible191}} 사용 시 그 방에서 랜덤 눈물 효과를 얻으며;#>>> 상태이상의 걸린 적에게 25%p의 추가 피해를 줍니다.",
		carBattery = {25, 50},
		queueDesc = "일시적 눈물 효과 + 치명타 소스",
	},
	[wakaba.Enums.Collectibles.RIRAS_COAT] = {
		itemName = "리라의 코트",
		description = "사용 시 The Lost(영혼) 상태가 되며 캐릭터의 위치에 흰색 모닥불을 설치합니다."
		.. "#{{Blank}} (Downpour/Dross 2 스테이지의 흰색 불에 닿은 효과와 동일)"
		.. "#방 클리어 후 다른 방 진입 시 상태가 복원됩니다.",
		carBattery = {"설치합니다", "2개 {{CR}}설치합니다"},
		queueDesc = "그렇게 뚫어지게 쳐다보시면 부끄러워요...",
	},
	[wakaba.Enums.Collectibles.RIRAS_SWIMSUIT] = {
		itemName = "리라의 수영복",
		description = "{{WakabaAqua}} 10%의 확률로 맞은 적을 침수시키는 공격이 나갑니다."
		.. "#{{LuckSmall}} 행운 38+일 때 100%"
		.. "#{{WakabaAqua}} 침수된 적은 독/화상/빨간똥의 경우 x0.8배, 폭발/침수/레이저의 경우 x1.5배의 피해를 받습니다."
		.. "#{{WakabaAqua}} 침수 공격은 돌 타입의 적을 즉사시킵니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 확률 증가",
		queueDesc = "이거, 살짝 부끄러울지도...?",
	},
	[wakaba.Enums.Collectibles.RIRAS_BANDAGE] = {
		itemName = "리라의 반창고",
		description = "!!! 스테이지 진입 시:#>>> {{Collectible486}}피격 시 효과를 6회 발동하며;#>>> {{Collectible479}}소지 중인 장신구를 흡수합니다.",
		duplicate = "{{ColorRira}}중첩 당 피격 효과 +2",
		queueDesc = "그녀의 기운이 느껴져",
	},
	[wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI] = {
		itemName = "검은콩 모찌",
		description = "{{WakabaZip}} 10% 확률로 적을 6초동안 '압박'시키는 공격이 나갑니다."
		.. "#{{LuckSmall}} 행운 16+일 때 100%"
		.. "#{{WakabaZip}} 압박 상태의 적 처치 시 폭발하며 주변의 적에게 15의 피해를 줍니다."
		.. "{{CR}}",
		lunatic = "{{WakabaZip}} 10% 확률로 적을 6초동안 '압박'시키는 공격이 나갑니다."
		.. "#{{LuckSmall}} 행운 16+일 때 100%"
		.. "#{{WakabaZip}} 압박 상태의 적 처치 시 폭발하며 주변의 적에게 15의 피해를 줍니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 확률 증가",
		queueDesc = "리라의 추억은 누군가에겐 악몽",
	},
	[wakaba.Enums.Collectibles.SAKURA_MONT_BLANC] = {
		itemName = "사쿠라 몽블랑",
		description = "{{WakabaAqua}} 적 처치 시 그 방에서 {{DamageSmall}}공격력 +0.16, {{TearsSmall}}연사 +0.67 증가하며(최대 6회) 주변의 적을 침수시킵니다."
		.. "#{{WakabaAqua}} 침수된 적은 독/화상/빨간똥의 경우 x0.8배, 폭발/침수/레이저의 경우 x1.5배의 피해를 받습니다."
		.. "#{{WakabaAqua}} 침수 공격은 돌 타입의 적을 즉사시킵니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 적 처치 카운트 상한 +6",
		queueDesc = "페로몬에 젖어",
	},
	[wakaba.Enums.Collectibles.KANAE_LENS] = {
		itemName = "카나에 렌즈",
		description = "↑ {{DamageSmall}}공격력 배율 x1.65#왼쪽 눈에서 유도 공격이 나갑니다.",
		lunatic = "{{WakabaModLunatic}} {{ColorOrange}}{{DamageSmall}}공격력 배율 x1.15#왼쪽 눈에서 유도 공격이 나갑니다.",
		queueDesc = "지켜보는 소녀의 눈동자",
	},
	[wakaba.Enums.Collectibles.RIRAS_BENTO] = {
		itemName = "리라의 도시락",
		description = ""
		.. "#↑ {{Heart}}최대 체력 +1"
		.. "#↑ {{HealingRed}}빨간하트 +1"
		.. "#↑ {{SpeedSmall}}이동속도 +0.02"
		.. "#↑ {{TearsSmall}}연사 +0.2"
		.. "#↑ {{DamageSmall}}하트 1칸당 공격력 +0.1"
		.. "#↑ {{DamageSmall}}공격력 배율 +4%p"
		.. "#↑ {{RangeSmall}}사거리 +0.25"
		.. "#↑ {{LuckSmall}}행운 +0.2"
		.. "#!!! 이후 등장하는 모든 아이템이 {{Collectible"..wakaba.Enums.Collectibles.RIRAS_BENTO.."}}Rira's Bento로 등장합니다."
		.. "{{CR}}",
		queueDesc = "더 먹고 싶어",
	},
	[wakaba.Enums.Collectibles.SAKURA_CAPSULE] = {
		itemName = "사쿠라 캡슐",
		description = ""
		.. "#↑ 목숨 +1"
		.. "#부활 전까지 스테이지 진입 시 모든 종류의 픽업을 하나씩 드랍합니다."
		.. "#{{Collectible127}} 사망 시 4{{Heart}}로 부활하며 그 스테이지를 재시작합니다."
		.. "{{CR}}",
		queueDesc = "잊혀졌던 기억",
	},
	[wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE] = {
		itemName = "츄잉 롤케이크",
		description = "!!! 피격 시 그 방에서:"
		.. "#>>> {{SpeedSmall}}이동속도 +0.3"
		.. "#>>> 주변의 탄환을 제거합니다."
		.. "#>>> {{Slow}}그 방의 적을 영구적으로 둔화시킵니다."
		.. "{{CR}}",
		duplicate = "{{ColorRira}}중첩 당 발동 중 이동속도 +0.1",
		queueDesc = "휘몰아치는 그 맛",
	},
	[wakaba.Enums.Collectibles.LIL_RIRA] = {
		itemName = "리틀 리라",
		description = ""
		.. "#공격하는 방향으로 초당 6의 피해를 주는 추적 눈물을 발사합니다."
		.. "#{{DamageSmall}} 액티브 사용 시 소모한 충전량 당 공격력 +0.05"
		.. "{{CR}}",
		lunatic = ""
		.. "#공격하는 방향으로 초당 6의 피해를 주는 추적 눈물을 발사합니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{DamageSmall}} 액티브 사용 시 소모한 충전량 당 공격력 +0.01"
		.. "{{CR}}",
		bffs = {6, 12},
		duplicate = "{{ColorRira}}중첩 당 {{DamageSmall}} 증가#{{ColorKoron}}리라는 복사되지 않음",
		queueDesc = "핑크빛을 위한 리본",
	},
	[wakaba.Enums.Collectibles.MAID_DUET] = {
		itemName = "메이드 듀엣",
		description = ""
		.. "#{wakaba_md1} 버튼으로 소지 중인 액티브와 픽업 슬롯 액티브를 교체합니다."
		.. "#카드/알약 액티브가 비어있을 경우 액티브를 픽업 슬롯으로 옮깁니다."
		.. "#한 번 옮기면 방 클리어 시 다시 옮길 수 있습니다."
		.. "#!!! (일부 아이템은 픽업 슬롯으로 옮길 수 없음)"
		.. "{{CR}}",
		duplicate = "{{ColorRira}}액티브 교체 시 충전량 중첩 당 +1칸#{{ColorKoron}}리셰, 리라는 복사되지 않음",
		queueDesc = "액티브 교체 요정",
	},
	[wakaba.Enums.Collectibles.SECRET_DOOR] = {
		itemName = "어디로든 문",
		description = "사용 시 시작 방으로 이동합니다."
		.. "#>>> 특정 조건에서 사용 시 다른 효과가 발동됩니다."
		.. "{{CR}}",
		lunatic = "사용 시 시작 방으로 이동합니다."
		.. "{{CR}}",
		carBattery = "무효과",
		queueDesc = "긴급 탈출구",
	},
	[wakaba.Enums.Collectibles.RICHERS_BRA] = {
		itemName = "리셰의 속옷",
		description = "피격 시 발생하는 패널티를 막아줍니다."
		.. "#>>> {{Trinket145}}/{{Collectible577}}/{{Collectible567}}..."
		.. "#은색 버튼이 자동으로 눌려집니다."
		.. "{{CR}}",
		queueDesc = "포근해...",
	},
	[wakaba.Enums.Collectibles.RIRAS_UNIFORM] = {
		itemName = "리라의 제복",
		description = "사용 시 피격 시 효과를 2회 발동, 2초간 게임 속도가 느려진 뒤;"
		.. "#>>> 2초간 캐릭터의 {{SpeedSmall}}/{{DamageSmall}}/{{TearsSmall}}를 크게 증가시킵니다."
		.. "{{CR}}",
		carBattery = "능력치 증폭 2배",
		queueDesc = "홍당무처럼 달려가 달려가",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE] = {
		itemName = "증폭의 책",
		description = ">>> 소지 중일 때 아래 중 하나 적용:"
		.. "#{{DamageSmall}} {{ColorRed}}공격력 +2"
		.. "#{{TearsSmall}} {{ColorBlue}}연사 +1"
		.. "#{{RangeSmall}} {{ColorYellow}}이동속도 + 0.15"
		.. "#{{LuckSmall}} {{ColorLime}}행운 +2"
		.. "#방 입장 시 혹은 사용 시 위의 4개 중 하나가 번갈아가며 변경됩니다."
		.. "{{CR}}",
		carBattery = "무효과",
		queueDesc = "충전식 증폭기",
	},
	[wakaba.Enums.Collectibles.BUBBLE_BOMBS] = {
		itemName = "방울방울 폭탄",
		description = "↑ {{Bomb}}폭탄 +5"
		.. "#{{WakabaAqua}} 폭탄이 터질 때 주변의 적을 침수시킵니다."
		.. "#{{WakabaAqua}} 침수된 적은 독/화상/빨간똥의 경우 x0.8배, 폭발/침수/레이저의 경우 x1.5배의 피해를 받습니다."
		.. "#{{WakabaAqua}} 침수 공격은 돌 타입의 적을 즉사시킵니다."
		.. "{{CR}}",
		queueDesc = "씻겨나가는 폭발 + 폭탄 5개",
	},
	[wakaba.Enums.Collectibles.CROSS_BOMB] = {
		itemName = "크로스 봄",
		description = "↑ {{Bomb}}폭탄 +5"
		.. "#폭탄이 상하좌우에 추가로 폭발합니다."
		.. "#>>> 추가 폭발은 적에게 10의 피해를 주며 캐릭터에게 피해를 주지 않습니다."
		.. "{{CR}}",
		queueDesc = "곡괭이 폭발 + 폭탄 5개",
	},
	[wakaba.Enums.Collectibles.CLEAR_FILE] = {
		itemName = "클리어 파일",
		description = ""
		.. "#사용 시 가장 가까운 패시브 아이템과 캐릭터가 소지한 패시브 아이템 하나를 선택하여 맞바꿉니다."
		.. "{{CR}}",
		queueDesc = "운명을 뒤틀다",
	},
	[wakaba.Enums.Collectibles.KYOUTAROU_LOVER] = {
		itemName = "쿄타로 러버",
		description = ""
		.. "#{{BleedingOut}} 공격하는 방향으로 3.5의 출혈 피해를 주는 눈물을 발사합니다."
		.. "#{{Collectible402}} 등장 아이템의 방 배열 구분이 사라집니다."
		.. "#특정 등급의 아이템만 등장하며 아이템 획득 시 등장하는 아이템의 등급이 바뀝니다."
		.. "#{{Blank}} ({{Quality0}} > {{Quality1}} > {{Quality2}} > {{Quality3}} > {{Quality4}} > {{Quality0}} ...)"
		.. "{{CR}}",
		queueDesc = "보기보다 믿음직",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_0] = {
		itemName = "안나 리본",
		description = ""
		.. "#↑ {{RangeSmall}}사거리 +0.5"
		.. "#!!! 랜덤 부정 효과를 발동합니다."
		.. "{{CR}}",
		queueDesc = "쿄타로의 맛이 나",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_1] = {
		itemName = "안나 리본",
		description = ""
		.. "#↑ {{SpeedSmall}}이동속도 +0.1"
		.. "{{CR}}",
		queueDesc = "쿄타로의 맛이 나",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_2] = {
		itemName = "안나 리본",
		description = ""
		.. "#↑ {{LuckSmall}}행운 +1"
		.. "{{CR}}",
		queueDesc = "쿄타로의 맛이 나",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_3] = {
		itemName = "안나 리본",
		description = ""
		.. "#↑ {{TearsSmall}}연사 +0.7"
		.. "{{CR}}",
		queueDesc = "쿄타로의 맛이 나",
	},
	[wakaba.Enums.Collectibles.ANNA_RIBBON_4] = {
		itemName = "안나 리본",
		description = ""
		.. "#↑ {{DamageSmall}}공격력 +3"
		.. "{{CR}}",
		queueDesc = "쿄타로의 맛이 나",
	},
	[wakaba.Enums.Collectibles.PURIFIER] = {
		itemName = "정화 장치",
		description = ""
		.. "#{{Key}} 사용 시 그 방의 아이템을 열쇠로 분해합니다."
		.. "{{CR}}",
		queueDesc = "도서위원 전용 - 재활용을 생활화합시다",
	},
	[wakaba.Enums.Collectibles.SHIFTER] = {
		itemName = "시프트 장치",
		description = ""
		.. "#!!! 소지 중일 때 바뀌지 않은 아이템 획득 불가"
		.. "#{wakaba_extra_dleft} / {wakaba_extra_dright} 버튼을 누르면 가장 가까운 아이템을 랜덤 수량의 코드 앞/뒷번호의 아이템으로 바꿉니다."
		.. "{{CR}}",
		queueDesc = "메이드 전용 - 운명 옮기기",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		itemName = "와카바의 꿈꾸는 꿈",
		description = ""
		.. "#↓ 악마/천사방이 더 이상 등장하지 않습니다."
		.. "#사용 시 와카바의 꿈이 바뀌며;"
		.. "#>>> 아이템 등장 시 해당 꿈에 해당되는 배열의 아이템이 등장합니다."
		.. "#방 클리어 시 8%의 확률로 {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}와카바의 꿈 카드를 드랍합니다. (천장 13회)"
		.. "{{CR}}",
		lunatic = ""
		.. "#↓ 악마/천사방이 더 이상 등장하지 않습니다."
		.. "#사용 시 와카바의 꿈이 바뀌며;"
		.. "#>>> 아이템 등장 시 해당 꿈에 해당되는 배열의 아이템이 등장합니다."
		.. "#{{WakabaModLunatic}} {{ColorOrange}}방 클리어 시 1%의 확률로 {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}와카바의 꿈 카드를 드랍합니다. (천장 15회)"
		.. "{{CR}}",
		queueDesc = "영원한 꿈",
		belial = "(사용 시 부가효과 없음)#↑ {{ColorWakabaNemesis}} {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}와카바의 꿈 카드의 등장 확률 +4%",
		void = "흡수 시 {{Card"..wakaba.Enums.Cards.CARD_DREAM_CARD.."}}Wakaba's Dream Card를 대신 소환",
		carBattery = "무효과",
	},
	[wakaba.Enums.Collectibles.STICKY_NOTE] = {
		itemName = "에덴의 접착제",
		description = ""
		.. "#!!! Tainted Eden 전용"
		.. "#!!! 일회용"
		.. "#사용 시 생득권을 획득하며 현재 소지 중인 첫번째 액티브 아이템을 픽업 슬롯으로 옮깁니다."
		.. "{{CR}}",
		queueDesc = "붙이기 전에 생각하자",
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

wakaba.descriptions[desclang].bookofshiori = {
	[CollectibleType.COLLECTIBLE_BIBLE] = {
		primary = "그 방에서 {{DamageSmall}}공격력 배율 x1.2, {{HolyMantle}}1회의 피격을 막아주는 보호막이 제공됩니다",
		secondary = "{{Collectible331}}눈물에 후광이 생깁니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] = {
		primary = "그 방에서 {{DamageSmall}}추가 공격력 +1.5",
		secondary = "{{Collectible462}}Eye of Belial 눈물효과가 적용됩니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_NECRONOMICON] = {
		primary = "{{Collectible356}}추가 피해량 +40",
		secondary = "공격 시 확률적으로 연옥의 유령이 나갑니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS] = {
		primary = "{{Collectible356}}지속시간 +10초",
		secondary = "{{Collectible213}}공격이 적의 투사체를 막아줍니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK] = {
		primary = "그 방에서 적이 폭발 피해를 받습니다.",
		secondary = "폭발성 눈물을 발사하며 폭발에 면역이 됩니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS] = {
		primary = "{{Collectible526}}그 스테이지에서 7 Seals 패밀리어 2마리 소환합니다.",
		secondary = "{{Collectible374}}확률적으로 명중 시 빛줄기가 내려오는 공격을 합니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SIN] = {
		primary = "50%의 확률로 픽업을 추가로 드랍하거나 아군 7대죄악 미니보스를 소환합니다.",
		secondary = "적 처치시 확률적으로 픽업 아이템을 드랍합니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_MONSTER_MANUAL] = {
		primary = "{{Collectible356}}그 층에서 패밀리어를 추가로 소환합니다.",
		secondary = "패밀리어 피해량 x3",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] = {
		primary = "{{Collectible369}}그 방에서 공격이 벽을 넘나듭니다.",
		secondary = "{{Collectible3}}공격이 적에게 유도됩니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS] = {
		primary = "Darkness 및 Lost 저주를 해제하며 3종류의 지도 효과를 전부 발동합니다.",
		secondary = "{{Collectible618}}명중 시 표식을 박는 공격을 합니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_SATANIC_BIBLE] = {
		primary = "그 층에서 추가 공격력 +1",
		secondary = "{{Collectible259}}적에게 공포를 거는 공격을 합니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD] = {
		primary = "아군 Bony를 추가로 소환합니다.",
		secondary = "{{Collectible237}}낫을 발사합니다.",
		description = "",
	},
	[CollectibleType.COLLECTIBLE_LEMEGETON] = {
		primary = "일정 확률로 켜져 있는 아이템 불꽃 하나를 흡수합니다.",
		secondary = "적 처치 시 확률적으로 아이템 불꽃을 회복합니다.",
		description = "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		primary = "아군으로 만들 적을 선택할 수 있습니다.#>>> 일반 적은 {{Key}}열쇠를, 보스는 추가로 {{Bomb}}폭탄을 소모합니다.",
		secondary = "",
		description = "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		primary = "",
		secondary = "{{Collectible453}}뼈 눈물을 발사합니다.",
		description = "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		primary = "캐릭터가 움직이지 않을 경우 공격이 적의 방어를 무시합니다.",
		secondary = "",
		description = "{{ShioriSecDel}} !!! 시오리의 책 지속 효과를 초기화합니다.",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		primary = "{{Collectible356}}룬을 추가로 지급합니다.",
		secondary = "{{Rune}}적 처치시 확률적으로 룬을 드랍합니다.",
		description = "",
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		primary = "작은 아이작 패밀리어가 받는 피해량이 매우 크게 줄어듭니다.",
		secondary = "작은 아이작 패밀리어가 캐릭터의 공격 일부분을 복사합니다.",
		description = "",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		primary = "2초동안 추가로 투사체를 제거합니다.",
		secondary = "",
		description = "{{ShioriSecDel}} !!! 시오리의 책 지속 효과를 초기화합니다.",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		primary = "{{Collectible356}}추가 사망 방지 횟수 +1",
		secondary = "{{Collectible579}}검은 영혼의 검으로 공격합니다.",
		description = "",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		primary = "은폐 상태일 때 캐릭터를 향해 공격하던 적들은 추가로 둔화에 걸립니다.",
		secondary = "",
		description = "",
	},
}
wakaba.descriptions[desclang].epiphany_golden = {
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		isReplace = true,
		description = ""
		.. "#{{Card"..Card.CARD_SOUL_ISAAC.."}} 사용 시 그 방의 모든 아이템이 랜덤한 아이템과 {{ColorGold}}빠른 속도{{CR}}로 전환되며 4개의 아이템 중 하나를 선택할 수 있습니다."
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.SYRUP] = {
		isReplace = true,
		description = ""
		.. "#!!! 소지 시:"
		.. "#↑ {{SpeedSmall}}{{ColorGold}}이동속도 배율 x1.1"
		.. "#↑ {{RangeSmall}}사거리 +{{ColorGold}}6"
		.. "#↑ {{DamageSmall}}공격력 +{{ColorGold}}3"
		.. "#비행 능력을 얻으며, {{ColorGold}}공격이 장애물을 관통합니다."
		.. "#!!! (사용 효과 없음)"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		isReplace = true,
		description = ""
		.. "#교복 아이템 사용 시 현재 선택된 슬롯과 들고 있는 알약/카드/룬을 서로 맞바꿉니다."
		.. "#{{Blank}} (Ctrl 키로 슬롯 선택 가능)"
		.. "#알약/카드/룬 사용 시 교복의 담긴 알약/카드/룬도 같이 사용합니다."
		.. "#교복에 담긴 알약/카드/룬은 Tab 키를 누른 상태에서 확인할 수 있습니다."
		.. "#{{ColorGold}}충전량을 소모하지 않습니다.{{CR}}"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		isReplace = false,
		description = "{{ColorGold}}충전량 2배",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		isReplace = false,
		description = "{{Card14}} {{ColorGold}}그 방의 적에게 40의 피해를 줍니다.",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_TRAUMA] = {
		isReplace = true,
		description = ""
		.. "#사용 시 최대 15개의 캐릭터의 눈물이 폭발합니다."
		.. "#폭발 지점마다 {{ColorGold}}기가 폭발을 일으킵니다."
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		isReplace = true,
		description = ""
		.. "#{{ColorGold}}사용 시 캐릭터의 공격력의 적을 추적하는 유령 11마리를 소환합니다."
		.. "#피격 시 하트가 없을 경우 타천사로 변신하며 블랙하트 6개를 획득합니다."
		.. "#!!! {{ColorSilver}}타천사 상태로 돌입 시 이하 효과 발동:"
		.. "#↓ {{ColorGold}}눈물 발사 상태 유지"
		.. "#↑ {{DamageSmall}}{{ColorGold}}공격력 배율 2.0"
		.. "#!!! {{ColorYellow}}더 이상 액티브 아이템을 바꿀 수 없습니다{{ColorReset}}"
		.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		isReplace = false,
		description = "{{ColorGold}}지운 탄환 수만큼 점점 사라지는 {{TearsSmall}}연사 추가 증가",
	},
	[wakaba.Enums.Collectibles.BEETLEJUICE] = {
		isReplace = false,
		description = "{{ColorGold}}황금 알약을 대신 소환합니다.",
	},
	[wakaba.Enums.Collectibles.POWER_BOMB] = {
		isReplace = false,
		description = "{{ColorGold}}그 방 전체를 황금으로 만들며, 피해랑 증가, 그 방의 선택형 아이템 및 픽업을 전부 획득할 수 있습니다.",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		isReplace = false,
		description = "{{ColorGold}}루트 진행 관련 문을 추가로 엽니다.",
	},
	[wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		isReplace = false,
		description = "{{ColorGold}}시프트 중 적과 닿으면 {{Collectible202}}적을 황금화 시킵니다.",
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		isReplace = false,
		description = "{{ColorGold}}흡수한 장신구가 황금 형태로 흡수됩니다.",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		isReplace = false,
		description = "{{ColorGold}}황금 클롯을 대신 소환합니다.",
	},
	[wakaba.Enums.Collectibles.BALANCE] = {
		isReplace = false,
		description = "{{Collectible555}} {{ColorGold}}동전을 소모한 경우 그 방에서 {{DamageSmall}}공격력 +1.2",
	},
	[wakaba.Enums.Collectibles.RICHERS_FLIPPER] = {
		isReplace = false,
		description = "{{ColorGold}}그 방의 액티브/패시브 아이템을 황금화 시킵니다.",
	},
	[wakaba.Enums.Collectibles.CLEAR_FILE] = {
		isReplace = false,
		description = "{{ColorGold}}교체 이후의 아이템 받침대를 황금화 시킵니다.",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		isReplace = false,
		description = "{{ColorGold}}{{Quality0}}등급인 아이템이 등장하지 않습니다.",
	},
}

wakaba.descriptions[desclang].conditionals = {}
wakaba.descriptions[desclang].conditionals.collectibles = {
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		desc = "{{Player"..wakaba.Enums.Players.WAKABA_B.."}} ↑ {{Damage}}공격력 +4#{{Player"..wakaba.Enums.Players.WAKABA_B.."}} ↓ {{ColorWakabaNemesis}}모든 행운 증가 효과가 적용되지 않습니다.",
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		{
			desc = {"랜덤한 개수", "1개"},
			modifierText = "Hard Mode",
		},
	},
	[wakaba.Enums.Collectibles.NEW_YEAR_BOMB] = {
		desc = "#{{Player25}} Hold 사용 시 {{PoopPickup}}똥 3개를 소모하여 폭탄을 대신 사용합니다."
		.. "#!!! 똥이 3개 이하인 경우에만 Hold 사용 가능",
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		desc = "{{Player"..wakaba.Enums.Players.WAKABA_B.."}} ↑ {{Damage}}알약 사용 시마다 공격력 +0.35#{{Player"..wakaba.Enums.Players.WAKABA_B.."}} ↓ {{ColorWakabaNemesis}}모든 행운 증가 효과가 적용되지 않습니다.",
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		desc = "{{Player"..wakaba.Enums.Players.SHIORI.."}} 작은 아이작 패밀리어를 3마리 소환합니다.",
	},
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		{
			desc = "{{Player"..wakaba.Enums.Players.WAKABA.."}} ↑ {{Tears}}연사 배율 x1.25",
			modifierText = "Wakaba",
		},
		{
			desc = "{{Player31}} Tainted Lost: 보호막이 지급되지 않음",
			modifierText = "Tainted Lost",
		},
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		{
			desc = "{{Collectible116}} 사용 시 충전량 8% 보존",
			modifierText = "9 Bolt",
		},
		{
			desc = "{{Collectible63}} 사용 시 충전량 25% 보존",
			modifierText = "Battery",
		},
		{
			desc = "{{Collectible156}} 피격 시 충전량 +50%",
			modifierText = "Habit",
		},
		{
			desc = "{{Collectible520}} 적 명중 시 충전량 +20%",
			modifierText = "Jumper Cables",
		},
		{
			desc = "{{Collectible647}} 적 명중 시 충전량 +100%",
			modifierText = "4.5 Bolt",
		},
	},
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		{
			desc = "{{Player"..wakaba.Enums.Players.RICHER_B.."}} 사용 시 선택한 불꽃을 흡수하여 아이템으로 획득합니다.#{{Player"..wakaba.Enums.Players.RICHER_B.."}} {{ButtonRT}}버튼으로 흡수할 불꽃을 선택할 수 있습니다.",
			modifierText = "Tainted Richer",
		},
	},
	[wakaba.Enums.Collectibles.CONCENTRATION] = {
		desc = "{{Player"..wakaba.Enums.Players.TSUKASA.."}} 연속 집중 시 방 클리어 필요, 패널티 카운터 60 이상일 때 집중 불가",
	},
	[wakaba.Enums.Collectibles.JAR_OF_CLOVER] = {
		desc = "{{Player"..wakaba.Enums.Players.WAKABA_B.."}} Tainted Wakaba의 경우 변경되지 않습니다.",
	},
	[wakaba.Enums.Collectibles.BUNNY_PARFAIT] = {
		desc = "{{Player"..wakaba.Enums.Players.RIRA_B.."}} Tainted Rira의 경우 변경되지 않습니다.",
	},
	[wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER_B.."}} Tainted Richer의 경우 변경되지 않습니다.",
	},
	[wakaba.Enums.Collectibles.SWEETS_CATALOG] = {
		desc = "{{WakabaMod}} 가장 가까운 아이템의 등급을 체크합니다.#{{WakabaMod}} 등급을 맞추면 아이템 획득, 실패 시 소멸합니다.",
	},
	-- HIDDEN DESCRIPTIONS
	[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] = {
		desc = "{{WakabaModHidden}} {{ColorGray}}폭탄 픽업이 다른 픽업으로 대체됩니다.",
	},
	[wakaba.Enums.Collectibles.MINERVA_AURA] = {
		desc = "{{WakabaModHidden}} {{ColorGray}}25%의 확률로 피해를 막습니다.",
	},
	[wakaba.Enums.Collectibles.NASA_LOVER] = {
		desc = "{{WakabaModHidden}} {{Collectible565}}{{ColorGray}}Blood Puppy가 플레이어를 공격하지 않습니다.",
	},
	[wakaba.Enums.Collectibles.DOUBLE_INVADER] = {
		desc = "{{WakabaModHidden}} !!! {{ColorOrange}}메이저 보스방에 Death's head 여러 마리가 등장합니다.",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		desc = "{{WakabaModHidden}} {{Collectible628}}{{ColorGray}}0.5%의 확률로 사망 증명서 방으로 이동, {{Collectible"..wakaba.Enums.Collectibles.BOOK_OF_SHIORI.."}}시오리의 책 소지 시 확률 4.5%",
	},
	[wakaba.Enums.Collectibles.SAKURA_CAPSULE] = {
		desc = "{{WakabaModHidden}} {{ColorGray}}최초 획득 시 'Gulp!' 알약을 강제로 할당합니다.",
	},
	-- REPENTOGON ADDITIONS
	[wakaba.Enums.Collectibles.RICHERS_BRA] = {
		desc = "{{WakabaModRgon}} ↑{{DevilChanceSmall}}{{ColorRicher}}악마방 확률 +10%",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE] = {
		desc = "{{WakabaModRgon}} ↑{{DevilChanceSmall}}{{ColorRicher}}소지 중일 때 악마방 확률 +20%",
	},
	[wakaba.Enums.Collectibles.MAID_DUET] = {
		desc = "{{WakabaModRgon}} {{Battery}}{{ColorRicher}}액티브 아이템의 최대 충전량을 1~2칸 감소시킵니다.",
	},
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = {
		desc = {"{{WakabaModRgon}} ↑{{DamageSmall}}공격력 +1#{{WakabaModRgon}} 폭발 피해를 받지 않습니다.#{{WakabaModRgon}} 눈물을 20번 발사할 때마다 화염 검을 휘두릅니다."},
	},
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		desc = {
			"{{WakabaModRgon}} 방 입장 시 돌 오브젝트가 15%의 확률로 '물음표 블럭'으로 바뀝니다."
		.. "#물음표 블럭 명중 시 랜덤 픽업이 등장합니다."
		.. "#!!! 폭발로 부수면 내용물이 사라집니다."
		},
	},
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		desc = {
			"사용 시 {{Collectible477}}Void 및 {{Collectible706}}Abyss의 효과를 모두 발동합니다."
		.. "#위 효과 대신 흡수한 아이템 중 원하는 액티브를 골라 사용할 수도 있습니다."
		.. "#({wakaba_extra_left} / {wakaba_extra_right} 버튼으로 전환 가능, 미선택 시 기존 효과)"
		},
	},
	[wakaba.Enums.Collectibles.AZURE_RIR] = {
		desc = "{{WakabaModRgon}} {{TearsSmall}} {{ColorRicher}}흡수한 장신구 당 연사 +0.2#{{WakabaModRgon}} {{Heart}}{{ColorRicher}}체력 상한 +6",
	},
	[wakaba.Enums.Collectibles.PRESTIGE_PASS] = {
		desc = "{{WakabaModRgon}} {{DevilChanceSmall}} {{ColorRicher}}악마방 확률 +50%#{{WakabaModRgon}} {{CrystalRestock}} {{ColorRicher}}모든 크리스탈 리스톡이 동전을 소모하지 않습니다.",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		desc = "{{WakabaModRgon}} 카드 소환 천장 게이지가 액티브 충전량을 통해 보여집니다.",
	},
}

wakaba.descriptions[desclang].trinkets = {
	[wakaba.Enums.Trinkets.BRING_ME_THERE] = {
		itemName = "나를 데려다 줘",
		description = ""
		.. "#↑ {{TearsSmall}}연사 +1.5"
		.. "#소지 중일 때 Mausoleum/Gehenna II의 보스방 진입 시 Mom 대신 Dad's Note가 등장합니다."
		.. "{{CR}}",
			queueDesc = "들고 가는 거 잊지 마!",
	},
	[wakaba.Enums.Trinkets.BITCOIN] = {
		itemName = "비트코인 II",
		description = ""
		.. "#소모성 픽업의 개수와 스탯을 랜덤하게 뒤섞습니다."
		.. "#각각의 픽업 소지 수는 0개부터 999개 까지 나올 수 있습니다."
		.. "#!!! 교체, 버리기 시 사라지며 흡수 시 픽업의 개수가 유지됩니다."
		.. "{{CR}}",
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
			queueDesc = "행운 증가",
	},
	[wakaba.Enums.Trinkets.MAGNET_HEAVEN] = {
		itemName = "무한 자석",
		description = ""
		.. "#모든 소모성 동전/폭탄/열쇠를 자동으로 수집합니다."
		.. "#끈적한 니켈을 니켈로 바꿉니다."
		.. "{{CR}}",
			queueDesc = "꿈꿔왔던 순간",
	},
	[wakaba.Enums.Trinkets.HARD_BOOK] = {
		itemName = "금이 간 책",
		description = ""
		.. "#!!! 일회용"
		.. "#피격 시 낮은 확률로 책 아이템 하나를 드랍합니다."
		.. "#{{SacrificeRoom}} 희생방에서 피격 시 100%의 확률로 책 아이템을 드랍합니다."
		.. "{{CR}}",
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
			queueDesc = "결의를 가져야 한다!",
	},
	[wakaba.Enums.Trinkets.BOOKMARK_BAG] = {
		itemName = "책갈피 가방",
		description = ""
		.. "#방 최초 진입 시 랜덤 일회성 책 액티브 아이템을 획득합니다."
		.. "#{{Player"..wakaba.Enums.Players.SHIORI.."}} Shiori가 가질 수 있는 책이 나옵니다."
		.. "{{CR}}",
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
		.. "#모든 플레이어가 해당 장신구의 능력치 증가량만큼 증가합니다."
		.. "{{CR}}",
			queueDesc = "자매의 유대감",
	},
	[wakaba.Enums.Trinkets.DIMENSION_CUTTER] = {
		itemName = "차원검",
		description = ""
		.. "#{{Collectible510}} 클리어 하지 않은 방 진입 시 15%의 확률로 임의의 델리리움의 모습을 한 보스가 등장합니다."
		.. "#{{GreedModeSmall}} Greed 모드의 경우 5%, {{LuckSmall}}행운 10+일 때 25%"
		.. "#{{Card"..Card.CARD_CHAOS.."}} Chaos Card가 Delirium과 The Beast에게 초당 캐릭터의 공격력 x150의 피해를 줍니다.(최소 5085)"
		.. "{{CR}}",
			queueDesc = "텅 비어 있는 기억",
	},
	[wakaba.Enums.Trinkets.DELIMITER] = {
		itemName = "구분자",
		description = ""
		.. "#!!! 새로운 방에 진입 시 다음 효과 발동:"
		.. "#>>> 색돌과 금광을 파괴합니다."
		.. "#>>> 기둥, 검은 블록, 가시돌을 일반 돌로 바꿉니다."
		.. "{{CR}}",
			queueDesc = "약해진 지반",
	},
	[wakaba.Enums.Trinkets.RANGE_OS] = {
		itemName = "강습형 전투 시스템",
		description = ""
		.. "#↓ {{RangeSmall}}사거리 배율 x0.4"
		.. "#!!! {{RangeSmall}}사거리 상한이 6.5로 감소합니다."
		.. "#↑ {{DamageSmall}}공격력 배율 x2.25"
		.. "{{CR}}",
			queueDesc = "좀 더 가까이",
	},
	[wakaba.Enums.Trinkets.SIREN_BADGE] = {
		itemName = "사이렌 뱃지",
		description = ""
		.. "#캐릭터가 접촉 피해를 받지 않습니다."
		.. "{{CR}}",
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
		.. "#{{Blank}} (흡수한 상태에서도 교체 버튼을 통해 사용 가능)"
		.. "{{CR}}",
		queueDesc = "황금빛 장소로 가져다줘",
	},
	[wakaba.Enums.Trinkets.AURORA_GEM] = {
		itemName = "오로라 보석",
		description = ""
		.. "#{{Coin}} 이스터 동전 등장 확률 +6.66%p"
		.. "#{{Luck}} 행운 69+일 때 100%"
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
	[wakaba.Enums.Trinkets.KUROMI_CARD] = {
		itemName = "쿠로미 카드",
		description = ""
		.. "#액티브 아이템 사용 시 충전량 및 해당 아이템을 소모하지 않습니다."
		.. "#!!! 90%의 확률로 장신구가 사라집니다."
		.. "{{CR}}",
		queueDesc = "그녀가 만들어줬어",
	},
	[wakaba.Enums.Trinkets.ETERNITY_COOKIE] = {
		itemName = "이터니티 쿠키",
		description = ""
		.. "#일정 시간 후 사라지는 픽업이 더 이상 사라지지 않습니다."
		.. "{{CR}}",
		queueDesc = "영원한 기초",
	},
	[wakaba.Enums.Trinkets.REPORT_CARD] = {
		itemName = "리셰의 성적표",
		description = ""
		.. "#↑ {{LuckSmall}}행운 +5"
		.. "#↓ 패널티 피격 시 {{LuckSmall}}증가한 행운 -0.5"
		.. "#스테이지 진입 시 감소된 행운이 돌아옵니다."
		.. "{{CR}}",
		queueDesc = "맞으면 점수 깎인다",
	},
	[wakaba.Enums.Trinkets.RABBIT_PILLOW] = {
		itemName = "토끼 배게",
		description = ""
		.. "유령(Lost) 상태에서도 헌헐류 요소를 사용할 수 있습니다."
		.. "{{CR}}",
		queueDesc = "푹신푹신해...",
	},
	[wakaba.Enums.Trinkets.CARAMELLA_CANDY_BAG] = {
		itemName = "카라멜라 사탕주머니",
		description = ""
		.. "방 입장 시 아래 중 하나를 소환합니다:"
		.. "#{{Trinket"..wakaba.Enums.Trinkets.CANDY_OF_RICHER.."}} 공격력 x3의 피해를 주는 파란 아군 파리"
		.. "#{{Trinket"..wakaba.Enums.Trinkets.CANDY_OF_RIRA.."}} 공격력 x1의 침수 피해를 주는 분홍 아군 파리"
		.. "#{{Trinket"..wakaba.Enums.Trinkets.CANDY_OF_CIEL.."}} 공격력 x5의 폭발 피해를 주는 노란 아군 파리"
		.. "#{{Trinket"..wakaba.Enums.Trinkets.CANDY_OF_KORON.."}} 공격력 x1.5의 석화 피해를 주는 회색 아군 파리"
		.. "{{CR}}",
		queueDesc = "달콤한 냄새",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_RICHER] = {
		itemName = "리셰 사탕",
		description = ""
		.. "방 입장 시 적과 접촉 시 공격력 x3의 피해를 주는 파란 아군 파리를 2마리 소환합니다."
		.. "{{CR}}",
		queueDesc = "조화의 향기",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_RIRA] = {
		itemName = "리라 사탕",
		description = ""
		.. "{{WakabaAqua}} 방 입장 시 적과 접촉 시 공격력 x1의 침수 피해를 주는 분홍 아군 파리를 2마리 소환합니다."
		.. "{{CR}}",
		queueDesc = "아쿠아의 향기",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_CIEL] = {
		itemName = "시엘 사탕",
		description = ""
		.. "방 입장 시 적과 접촉 시 공격력 x5의 폭발 피해를 주는 노란 아군 파리를 하나 소환합니다."
		.. "{{CR}}",
		queueDesc = "별빛의 향기",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_KORON] = {
		itemName = "코론 사탕",
		description = ""
		.. "방 입장 시 적과 접촉 시 공격력 x1.5의 석화 피해를 주는 회색 아군 파리를 2마리 소환합니다."
		.. "{{CR}}",
		queueDesc = "눈꽃의 향기",
	},
	[wakaba.Enums.Trinkets.PINK_FORK] = {
		itemName = "핑크빛 포크",
		description = ""
		.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON 전용{{CR}}#REPENTOGON을 실행중이지 않았을 때 이 아이템을 발견하면 모드 개발자에게 연락 바람"
		.. "{{CR}}",
		queueDesc = "방울방울",
	},
	[wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA] = {
		itemName = "카구야의 인장",
		description = ""
		.. "{{Collectible160}} 15초마다 16% 확률로 Crack the Sky 효과를 발동합니다."
		.. "#{{Luck}} 행운 34+일 때 100%"
		.. "#클리어하지 않은 방인 경우 발동을 보류합니다."
		.. "{{CR}}",
		queueDesc = "파괴 월광선",
	},


	---------------------
	-- Cursed Trinkets --
	---------------------
	[wakaba.Enums.Trinkets.CORRUPTED_CLOVER] = {
		itemName = "타락한 클로버",
		description = ""
		.. "방 입장 시 캐릭터의 바로 가까이 4방향으로 빛줄기가 떨어집니다."
		.. "{{CR}}",
		queueDesc = "배신의 빛줄기",
	},
	[wakaba.Enums.Trinkets.DARK_PENDANT] = {
		itemName = "어둠의 펜던트",
		description = ""
		.. "#↓ {{LuckSmall}}행운 -1"
		.. "#↓ {{LuckSmall}}행운이 0 이상인 경우 0 이하가 되도록 반전됩니다."
		.. "{{CR}}",
		queueDesc = "반전된 행운",
	},
	[wakaba.Enums.Trinkets.BROKEN_NECKLACE] = {
		itemName = "망가진 목걸이",
		description = ""
		.. "적의 탄환이 Dogma의 레이저 탄환으로 바뀝니다."
		.. "{{CR}}",
		queueDesc = "따끔한 기억",
	},
	[wakaba.Enums.Trinkets.LEAF_NEEDLE] = {
		itemName = "잎사귀 바늘",
		description = ""
		.. "{{BrokenHeart}} 액티브 아이템 사용 시 체력 반칸의 헌혈 피해를 받습니다."
		.. "{{CR}}",
		queueDesc = "피묻은 액티브",
	},
	[wakaba.Enums.Trinkets.RICHERS_HAIR] = {
		itemName = "리셰의 머리카락",
		description = ""
		.. "↓ 방 입장 시 캐릭터의 바로 가까이에 보라색 모닥불을 하나 소환합니다."
		.. "{{CR}}",
		queueDesc = "바로 앞의 오컬트",
	},
	[wakaba.Enums.Trinkets.RIRAS_HAIR] = {
		itemName = "리라의 머리카락",
		description = ""
		.. "↓ 방 입장 시 캐릭터의 바로 가까이에 흰색 모닥불을 하나 소환합니다."
		.. "{{CR}}",
		queueDesc = "바로 앞의 유령",
	},
	[wakaba.Enums.Trinkets.SPY_EYE] = {
		itemName = "감시자의 눈",
		description = ""
		.. "{{BrokenHeart}} 공격키를 누른 상태에서 방 입장 시 체력 반칸의 헌혈 피해를 받습니다."
		.. "{{CR}}",
		queueDesc = "무궁화 꽃이 피었습니다!",
	},
	[wakaba.Enums.Trinkets.FADED_MARK] = {
		itemName = "흐려진 조준점",
		description = ""
		.. "{{WakabaCurseSniper}} 획득 시 및 스테이지 진입 시 Sniper 저주에 걸립니다."
		.. "{{CR}}",
		queueDesc = "스나이퍼의 저주",
	},
	[wakaba.Enums.Trinkets.NEVERLASTING_BUNNY] = {
		itemName = "사라지는 토끼",
		description = ""
		.. "{{WakabaCurseAmnesia}} 획득 시 및 스테이지 진입 시 Amnesia 저주에 걸립니다."
		.. "{{CR}}",
		queueDesc = "망각의 저주",
	},
	[wakaba.Enums.Trinkets.RIBBON_CAGE] = {
		itemName = "리본 감옥",
		description = ""
		.. "{{WakabaCurseFairy}} 획득 시 및 스테이지 진입 시 Fairy 저주에 걸립니다."
		.. "{{CR}}",
		queueDesc = "요정의 저주",
	},
	[wakaba.Enums.Trinkets.RIRAS_WORST_NIGHTMARE] = {
		itemName = "리라의 악몽",
		description = ""
		.. "모든 Host류 적이 Floating Host로 바뀝니다."
		.. "{{CR}}",
		queueDesc = "우..움직여!",
	},
	[wakaba.Enums.Trinkets.MASKED_SHOVEL] = {
		itemName = "가면 씌인 삽",
		description = ""
		.. "피격 시 캐릭터의 위치에 트랩도어를 생성합니다."
		.. "{{CR}}",
		queueDesc = "치명적인 구멍",
	},
	[wakaba.Enums.Trinkets.BROKEN_WATCH_2] = {
		itemName = "부서진 시계 2",
		description = ""
		.. "게임 속도가 실시간으로 빨라졌다가 느려집니다."
		.. "{{CR}}",
		queueDesc = "고장난 타임 머신",
	},
	[wakaba.Enums.Trinkets.ROUND_AND_ROUND] = {
		itemName = "둥글게 둥글게",
		description = ""
		.. "방 중앙에 Stone Eye가 생깁니다."
		.. "{{CR}}",
		queueDesc = "영원한 돌림노래",
	},
	[wakaba.Enums.Trinkets.GEHENNA_ROCK] = {
		itemName = "게헨나 돌덩이",
		description = ""
		.. "모든 Poky류 장애물이 Grudge로 바뀝니다."
		.. "{{CR}}",
		queueDesc = "전부 눈을 달고 있어",
	},
	[wakaba.Enums.Trinkets.BROKEN_MURASAME] = {
		itemName = "부서진 무라사메",
		description = ""
		.. "{{AngelDevilChanceSmall}} 획득 시 그 스테이지에서 악마방을 닫습니다."
		.. "{{CR}}",
		queueDesc = "악마방 차단",
	},
	[wakaba.Enums.Trinkets.LUNATIC_CRYSTAL] = {
		itemName = "루나틱 크리스탈",
		description = ""
		.. "{{HolyMantleSmall}} 모든 Holy Mantle 보호막을 제거합니다."
		.. "{{CR}}",
		queueDesc = "빼앗긴 신앙",
	},
	[wakaba.Enums.Trinkets.TORN_PAPER_2] = {
		itemName = "찢어진 종이 2",
		description = ""
		.. "!!! 모든 트롤 폭탄이 황금 슈퍼트롤폭탄으로 바뀝니다."
		.. "{{CR}}",
		queueDesc = "저것들 이제 너 따라온다?",
	},
	[wakaba.Enums.Trinkets.MINI_TORIZO] = {
		itemName = "미니 토리조",
		description = ""
		.. "적의 탄환이 캐릭터의 무적 시간을 무시하고 관통합니다."
		.. "{{CR}}",
		queueDesc = "관통 눈물..?",
	},
	[wakaba.Enums.Trinkets.GRENADE_D20] = {
		itemName = "D20 수류탄",
		description = ""
		.. "픽업({{Coin}}/{{Bomb}}/{{Key}}/{{Heart}})이 때때로 폭발합니다."
		.. "{{CR}}",
		queueDesc = "폭발하는 픽업",
	},
	[wakaba.Enums.Trinkets.WAKABA_SIREN] = {
		itemName = "와카바 사이렌",
		description = ""
		.. "화면이 항상 흔들립니다."
		.. "{{CR}}",
		queueDesc = "! 경고 !",
	},
	[wakaba.Enums.Trinkets.STEALTH_BOND] = {
		itemName = "보이지 않는 유대감",
		description = ""
		.. "#방 입장 시 보이지 않는 Camillo Jr.가 등장합니다."
		.. "#소환된 Camillo Jr.는 무적이며 방 클리어 시 사라집니다."
		.. "{{CR}}",
		queueDesc = "내 속삭임이 들려?",
	},
	--[[ [wakaba.Enums.Trinkets.SHIELD_KILLER] = {
		itemName = "보호막 제거기",
		description = ""
		.. "Book of Shadows 계열의 보호막을 제거합니다."
		.. "{{CR}}",
		queueDesc = "튜닝의 끝은 순정",
	}, ]]

}
wakaba.descriptions[desclang].goldtrinkets = {
	[wakaba.Enums.Trinkets.CLOVER] = { "↑ 행운의 동전 등장 확률 추가 증가" },
	[wakaba.Enums.Trinkets.HARD_BOOK] = { "책 아이템 하나", "책 아이템 2개", "책 아이템 3개" },
	[wakaba.Enums.Trinkets.STAR_REVERSAL] = { "{{Planetarium}}천체관 아이템", "{{Planetarium}}천체관 아이템 2개" },
	[wakaba.Enums.Trinkets.ETERNITY_COOKIE] = { "↑ 선택형 아이템 및 픽업을 모두 획득할 수 있습니다." },
	[wakaba.Enums.Trinkets.MAGNET_HEAVEN] = { "{{Magnetize}} 방 입장 시 5초동안 그 방의 적에게 자력 효과를 부여합니다." },
	[wakaba.Enums.Trinkets.CANDY_OF_RICHER] = { "2마리", "3마리", "4마리" },
	[wakaba.Enums.Trinkets.CANDY_OF_RIRA] = { "2마리", "3마리", "4마리" },
	[wakaba.Enums.Trinkets.CANDY_OF_CIEL] = { "하나", "2마리", "3마리" },
	[wakaba.Enums.Trinkets.CANDY_OF_KORON] = { "2마리", "3마리", "4마리" },
}
wakaba.descriptions[desclang].cards = {
	[wakaba.Enums.Cards.CARD_CRANE_CARD] = {
		itemName = "인형뽑기 카드",
		queueDesc = "가챠할 시간!",
		description = "{{CraneGame}} 인형뽑기(크레인 게임) 기계를 소환합니다.",
		tarot = {"{{CraneGame}} 인형뽑기(크레인 게임) 기계를 {{ColorShinyPurple}}2개{{CR}} 소환합니다."},
	},
	[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = {
		itemName = "고해실 카드",
		queueDesc = "회개",
		description = "{{Confessional}} 고해실 부스를 소환합니다.",
		tarot = {"{{Confessional}} 고해실 부스를 {{ColorShinyPurple}}2개{{CR}} 소환합니다."},
	},
	[wakaba.Enums.Cards.CARD_BLACK_JOKER] = {
		itemName = "블랙 조커",
		queueDesc = "당신은 죄악이 등을 타고 오르는 것을 느꼈다",
		description = "{{DevilChanceSmall}} 카드를 소지하는 동안 천사방이 등장하지 않습니다. #사용 시 {{DevilRoom}}악마방으로 텔레포트합니다.",
	},
	[wakaba.Enums.Cards.CARD_WHITE_JOKER] = {
		itemName = "화이트 조커",
		queueDesc = "당신은 죄악이 등을 타고 오르는 것을 느꼈다",
		description = "{{AngelChanceSmall}} 카드를 소지하는 동안 악마방이 등장하지 않습니다. #사용 시 {{AngelRoom}}천사방으로 텔레포트합니다.",
	},
	[wakaba.Enums.Cards.CARD_COLOR_JOKER] = {
		itemName = "컬러 조커",
		queueDesc = "당신은 이 결과를 원하지 않을 것이다",
		description = "{{BrokenHeart}} 부서진하트의 개수를 체력 상한의 50%로 설정하며;#>>> 액티브/패시브 아이템 3개를 소환합니다.",
		lunatic = "{{WakabaModLunatic}} {{BrokenHeart}}  {{ColorOrange}}부서진하트를 체력 상한의 50%만큼 추가하며;#>>> 액티브/패시브 아이템 3개를 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = {
		itemName = "스페이드 Q",
		description = "{{Key}}사용 시 2~11개의 열쇠를 드랍합니다.",
		lunatic = "{{WakabaModLunatic}} {{ColorOrange}}{{Key}}사용 시 1~4개의 열쇠를 드랍합니다.",
	},
	[wakaba.Enums.Cards.CARD_DREAM_CARD] = {
		itemName = "와카바의 꿈 카드",
		queueDesc = "소원이 이루어지는 순간",
		description = "사용 시 그 방에 아이템 하나를 소환합니다.",
	},
	[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = {
		itemName = "미지의 책갈피",
		queueDesc = "정보가 흩어졌을 때",
		description = "사용 시 아래 중 하나의 랜덤 책 효과를 발동합니다.",
		tarot = "임의의 책 효과를 2개 발동합니다.(중복 가능)",
	},
	[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = {
		itemName = "리턴 토큰",
		queueDesc = "역사는 반복된다",
		description = "{{Collectible636}} 사용 시 소지중인 아이템과 능력치가 유지된 상태로 게임을 다시 시작하며;#>>> {{Timer}}게임 시간을 초기화합니다.#!!! {{ColorRed}}체력을 포함한{{CR}} 캐릭터의 모든 픽업 아이템을 지웁니다.",
	},
	[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = {
		itemName = "미네르바 티켓",
		queueDesc = "여신의 시험",
		description = "{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} 사용 시 그 방에서 오라를 발산합니다."
		.. "#오라 안에 있는 아군 몬스터는 최대 체력의 2배까지 지속적으로 회복합니다."
		.. "#!!! 오라 안에 있는 모든 플레이어에게 다음 효과 발동 :"
		.. "#>>> {{DamageSmall}}공격력 -0.5 (중첩 불가)"
		.. "#>>> {{TearsSmall}}연사(+상한) +0.5"
		.. "#>>> {{TearsSmall}}연사 배율 x2.3 (중첩 불가)"
		.. "#>>> 유도 눈물을 발사합니다."
		.. "{{CR}}",
		tarot = {1, 2, 1.5, 3},
	},

	[wakaba.Enums.Cards.SOUL_WAKABA] = {
		itemName = "와카바의 영혼",
		queueDesc = "축복의 결정",
		description = "{{SoulHeart}}소울하트 +1#그 스테이지에서 {{AngelRoom}}천사방을 생성합니다.#{{AngelRoom}} 생성할 수 없는 경우 천사방 아이템을 하나 소환합니다.",
	},
	[wakaba.Enums.Cards.SOUL_WAKABA2] = {
		itemName = "와카바의 영혼?",
		queueDesc = "숙명의 결정",
		description = "{{SoulHeart}}소울하트 +1#그 스테이지에서 {{DevilRoom}}악마방을 생성합니다.#{{DevilRoom}} 생성할 수 없는 경우 악마방 아이템을 하나 소환합니다.",
	},
	[wakaba.Enums.Cards.SOUL_SHIORI] = {
		itemName = "시오리의 영혼",
		queueDesc = "운명의 윤회",
		description = "{{HealingRed}}빨간하트 +2#임의의 시오리의 책 지속 효과를 발동합니다.#>>> 이 조합은 시오리의 영혼을 다시 사용하거나 시오리의 책을 소지한 상태에서 다른 책을 사용할 때까지 유지됩니다.",
	},
	[wakaba.Enums.Cards.SOUL_TSUKASA] = {
		itemName = "츠카사의 영혼",
		queueDesc = "하프 라이프",
		description = "사용 시 캐릭터 머리 위에 칼이 소환되며 모든 방의 아이템이 2배로 나옵니다.#판매 아이템은 영향을 받지 않습니다.#패널티 피격 시 그 이후부터 소지 아이템의 절반이 사라질 확률이 생깁니다.#!!! 소멸확률: 4프레임 당 1/2500",
	},
	[wakaba.Enums.Cards.SOUL_RICHER] = {
		itemName = "리셰의 영혼",
		queueDesc = "마녀의 불꽃",
		description = "{{Collectible712}} 캐릭터가 소지 중인 아이템의 아이템 위습을 최대 6개({{Collectible263}} : 3개) 소환합니다.#{{Collectible"..wakaba.Enums.Collectibles.ANNA_RIBBON_4.."}} {{DamageSmall}}유효한 아이템이 없는 경우 공격력 +3 효과의 아이템 불꽃 소환",
	},
	[wakaba.Enums.Cards.CARD_VALUT_RIFT] = {
		itemName = "창고의 틈새",
		queueDesc = "시오리의 창고",
		description = "{{ShioriValut}} 시오리의 창고를 소환합니다.#{{ShioriValut}} 창고는 파란색 아이템 하나가 담겨져 있으나 열쇠를 여러개 소모합니다.#낮은 확률로 다른 아이템이 든 창고가 소환됩니다.",
		tarot = {"{{ShioriValut}} 시오리의 창고를 {{ColorShinyPurple}}2개{{CR}} 소환합니다.#{{ShioriValut}} 창고는 파란색 아이템 하나가 담겨져 있으나 열쇠를 여러개 소모합니다.#낮은 확률로 다른 아이템이 든 창고가 소환됩니다."},
	},
	[wakaba.Enums.Cards.CARD_TRIAL_STEW] = {
		itemName = "시련의 국",
		description = "사용 시 체력과 보호막을 전부 제거하며 시련 스택을 8개 충전합니다.#↑ {{TearsSmall}}1스택 당 연사(+상한) +1#↑ {{DamageSmall}}공격력 배율 x2#↑ {{DamageSmall}}1스택 당 추가 공격력 +25%#방 클리어 시 액티브 아이템을 완충하며 시련 스택을 1개 제거합니다.",
		tarot = {8, 11},
	},
	[wakaba.Enums.Cards.CARD_RICHER_TICKET] = {
		itemName = "리셰 티켓",
		queueDesc = "간식 시간이예요!",
		description = "{{Collectible"..wakaba.Enums.Collectibles.SWEETS_CATALOG.."}} 사용 시 그 방에서 아래 중 하나의 랜덤 조합 효과를 얻습니다:{{CR}}",
		mimiccharge = 4,
	},
	[wakaba.Enums.Cards.CARD_RIRA_TICKET] = {
		itemName = "리라 티켓",
		queueDesc = "야릇한 반창고",
		description = "{{BrokenHeart}}부서진하트 1개를 {{EmptyBoneHeart}} 혹은 {{SoulHeart}}로 복구하며;#>>> {{Collectible479}}소지 중인 장신구를 흡수합니다.#>>> {{HealingRed}}부서진하트 혹은 장신구가 없을 경우 빨간하트 +1",
		tarot = {"{{BrokenHeart}}부서진하트 1개를 {{ColorShinyPurple}}{{BoneHeart}} 혹은 {{SoulHeart}}+{{Heart}}{{CR}}로 복구하며;>>> #{{Collectible479}} 소지 중인 장신구를 흡수합니다.#>>> {{Heart}} 부서진하트 혹은 장신구가 없을 경우 빨간하트 {{ColorShinyPurple}}+2{{CR}}"},
		mimiccharge = 6,
	},
	[wakaba.Enums.Cards.CARD_FLIP] = {
		itemName = "뒤집기 카드",
		description = "{{Collectible711}} 소지 중일 때 일부 아이템의 뒤쪽에 숨겨진 아이템이 흐리게 표시됩니다.#사용 시 원래 아이템을 숨겨진 아이템으로 뒤집거나, 생성합니다.",
		queueDesc = "리라의 뒷모습?",
	},
	[wakaba.Enums.Cards.SOUL_RIRA] = {
		itemName = "리라의 영혼",
		description = "{{AquaTrinket}} 아쿠아 장신구를 3개({{Collectible263}} : 1개) 소환합니다.#{{Blank}} (해금 여부 무관)",
		queueDesc = "쫀득쫀득한 추억",
	},
}
wakaba.descriptions[desclang].runechalk = {

}
wakaba.descriptions[desclang].pills = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = {
		itemName = "공격력 배율 증가",
		description = "↑ {{DamageSmall}}공격력 배율 +8%p",
		horse = "↑ {{DamageSmall}}공격력 배율 {{ColorCyan}}+16%p{{CR}}",
	},
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = {
		itemName = "공격력 배율 감소",
		description = "↓ {{DamageSmall}}공격력 배율 -6%p",
		horse = "↓ {{DamageSmall}}공격력 배율 {{ColorYellow}}-12%p{{CR}}",
	},
	[wakaba.Enums.Pills.ALL_STATS_UP] = {
		itemName = "모든 능력치 증가",
		description = "↑ {{DamageSmall}}공격력 +0.25#↑ {{TearsSmall}}연사 +0.2#↑ {{SpeedSmall}}이동속도 +0.12#↑ {{RangeSmall}}사거리 +0.4#↑ {{ShotspeedSmall}}탄속 +0.04#↑ {{LuckSmall}}행운 +1#",
		horse = "↑ {{DamageSmall}}공격력 +{{ColorCyan}}0.5{{CR}}#↑ {{TearsSmall}}연사 +{{ColorCyan}}0.4{{CR}}#↑ {{SpeedSmall}}이동속도 +{{ColorCyan}}0.24{{CR}}#↑ {{RangeSmall}}사거리 +{{ColorCyan}}0.8{{CR}}#↑ {{ShotspeedSmall}}탄속 +{{ColorCyan}}0.08{{CR}}#↑ {{LuckSmall}}행운 +{{ColorCyan}}2{{CR}}",
	},
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = {
		itemName = "모든 능력치 감소",
		description = "↓ {{DamageSmall}}공격력 -0.1#↓ {{TearsSmall}}연사 -0.08#↓ {{SpeedSmall}}이동속도 -0.09#↓ {{RangeSmall}}사거리 -0.25#↓ {{ShotspeedSmall}}탄속 -0.03#↓ {{LuckSmall}}행운 -1#",
		horse = "↓ {{DamageSmall}}공격력 -{{ColorYellow}}0.2{{CR}}#↓ {{TearsSmall}}연사 -{{ColorYellow}}0.16{{CR}}#↓ {{SpeedSmall}}이동속도 -{{ColorYellow}}0.18{{CR}}#↓ {{RangeSmall}}사거리 -{{ColorYellow}}0.5{{CR}}#↓ {{ShotspeedSmall}}탄속 -{{ColorYellow}}0.06{{CR}}#↓ {{LuckSmall}}행운 -{{ColorYellow}}2{{CR}}",
	},
	[wakaba.Enums.Pills.TROLLED] = {
		itemName = "낚였구나아아아아아아",
		itemNameAfter = "낚시용 알약",
		description = "{{ErrorRoom}} 오류방으로 텔레포트합니다.#{{Collectible721}} ???/Home 스테이지에서는 오류 아이템을 하나 소환합니다.",
		horse = "{{ErrorRoom}} 오류방으로 텔레포트합니다.#{{Collectible721}} ???/Home 스테이지에서는 오류 아이템을 하나 소환합니다.#↑ {{BrokenHeart}}{{ColorCyan}}부서진하트 -1{{CR}}",
	},
	[wakaba.Enums.Pills.TO_THE_START] = {
		itemName = "태초마을",
		description = "각 층의 시작 방으로 텔레포트합니다.",
		horse = "각 층의 시작 방으로 텔레포트합니다.#↑ {{Heart}}하트 +1#↑ {{BrokenHeart}}{{ColorCyan}}부서진하트 -1{{CR}}",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = {
		itemName = "혈사 설사 2",
		description = "캐릭터의 위치에 십자 모양으로 발사되는 혈사 소용돌이를 두번 생성합니다.#두 혈사 소용돌이의 간격은 랜덤입니다.",
		horse = "캐릭터의 위치에 십자 모양으로 발사되는 혈사 소용돌이를 두번 생성합니다.#두 혈사 소용돌이의 간격은 랜덤입니다.#{{Collectible293}} {{ColorCyan}}사용 시 대각선 또는 십자 방향으로 최대 190의 피해를 주는 혈사포를 발사합니다.{{CR}}",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT] = {
		itemName = "혈사 설사 2?",
		description = "{{Collectible556}} 그 방에서 공격이 {{Collectible118}}충전형 혈사포 공격으로 변경됩니다.",
		horse = "{{Card88}} {{ColorCyan}}7.5초 동안 초당 공격력 x15의 {{Collectible441}}대형 혈사포를 발사합니다.{{CR}}",
	},
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = {
		itemName = "사회적 거리두기",
		description = "그 층에서 악마방/천사방의 등장을 막습니다.",
		horse = "그 층에서 악마방/천사방의 등장을 막습니다.#↓ {{ColorYellow}}이후 층에서의 악마방/천사방 확률 감소{{CR}}",
	},
	[wakaba.Enums.Pills.DUALITY_ORDERS] = {
		itemName = "이중 질서",
		description = "{{Collectible498}} 가능한 경우, 현재 층에서 악마방/천사방이 반드시 등장합니다.",
		horse = "{{Collectible498}} 가능한 경우, 현재 층에서 악마방/천사방이 반드시 등장합니다.#{{DevilRoom}}악마방/{{AngelRoom}}천사방 아이템을 하나씩 소환하며 {{ColorCyan}}두 아이템 모두 획득할 수 있습니다.{{CR}}",
	},
	[wakaba.Enums.Pills.PRIEST_BLESSING] = {
		itemName = "성녀의 가호",
		description = "{{Card51}} 피격 시 피해를 1회 무시하는 {{HolyMantle}}방어막을 제공합니다.#이 방어막은 중첩되지 않으며 피격 시까지 유지됩니다.",
		horse = "{{Card51}} 피격 시 피해를 1회 무시하는 {{HolyMantle}}방어막을 {{ColorCyan}}최대 2회{{CR}} 제공합니다.#이 방어막은 피격 시까지 유지됩니다.",
	},
	[wakaba.Enums.Pills.UNHOLY_CURSE] = {
		itemName = "빼앗긴 신앙",
		description = "{{HolyMantle}}Holy Mantle의 방어막을 1회 차감합니다.#{{Blank}} (방어막이 없을 경우 효과 없음)",
		horse = "{{HolyMantle}}Holy Mantle의 방어막을 {{ColorYellow}}2회{{CR}} 차감합니다.#{{Blank}} (방어막이 없을 경우 효과 없음)",
	},
	[wakaba.Enums.Pills.HEAVY_MASCARA] = {
		itemName = "무거운 마스카라",
		description = "{{CurseBlindSmall}} Blind 저주에 걸리며 아이템이 보이지 않습니다.#{{Timer}} 30초 후 해제",
		horse = "{{CurseBlindSmall}} Blind 저주에 걸리며 아이템이 보이지 않습니다.#{{Timer}} {{ColorYellow}60초{{CR}} 후 해제",
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
	pickupprefix = "와카바의 교복 사용 시 {{ColorGold}}",
	pickupmidfix = "의 교복 슬롯 ",
	pickupsubfix = "번{{CR}}에 해당 픽업을 보관 및 교체합니다.",
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
wakaba.descriptions[desclang].waterflame = {
	taintedricher = "사용 시 현재 선택된 아이템 불꽃을 흡수합니다.#{{ButtonRT}}버튼으로 선택할 수 있습니다.",
	titleprefix = "흡수할 아이템",
	supersensitiveprefix = "남은 흡수 횟수 : ",
	supersensitivesubfix = "",
	supersensitivefinal = "횟수 소진, 더 이상 사용할 수 없음",
}

wakaba.descriptions[desclang].doubledreams = {
	lastpool = "획득 시 배열",
	currenttitle = "와카바의 현재 꿈",
	Default = "기본",
	Treasure = "보물방",
	Shop = "상점",
	Boss = "보스방",
	Devil = "악마방",
	Angel = "천사방",
	Secret = "비밀방",
	Library = "책방",
	ShellGame = "야바위꾼",
	GoldenChest = "황금상자",
	RedChest = "빨간상자",
	Beggar = "거지",
	DemonBeggar = "악마거지",
	Curse = "저주방",
	KeyMaster = "열쇠거지",
	BatteryBum = "배터리거지",
	MomChest = "엄마상자",
	GreedTreasure = "그리드-보물방",
	GreedBoss = "그리드-보스방",
	GreedShop = "그리드-상점",
	GreedDevil = "그리드-악마방",
	GreedAngel = "그리드-천사방",
	GreedCurse = "그리드-저주방",
	GreedSecret = "그리드-비밀방",
	CraneGame = "크레인 게임",
	UltraSecret = "특급비밀방",
	BombBum = "폭탄거지",
	Planetarium = "천체관",
	OldChest = "낡은상자",
	BabyShop = "패밀리어 상점",
	WoodenChest = "나무상자",
	RottenBeggar = "썩은거지",
}

wakaba.descriptions[desclang].entities = {
	{
		type = EntityType.ENTITY_SLOT,
		variant = wakaba.Enums.Slots.SHIORI_VALUT,
		subtype = 1,
		name = "시오리의 창고",
		description = ""
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
		.. "#{{Coin}} {{ColorSilver}}행운 코인, 니켈, 혹은 다임"
		.. "#{{LuckSmall}} {{ColorSilver}}클로버 상자 배열 아이템"
	},
}
wakaba.descriptions[desclang].richeruniform = {
	default = "#{{Room}} {{ColorCyan}}기본#사용 시 재입고 기계 효과를 1회 발동합니다.",
	[u.DEFAULT] = "#{{Room}} {{ColorCyan}}일반방#{{Collectible285}} 사용 시 그 방의 적을 2회 약화시킵니다.#보스의 경우 최대 체력 20%의 방어 무시 피해를 줍니다.",
	[u.SHOP] = "#{{Shop}} {{ColorCyan}}상점#{{Collectible64}} 사용 시 그 방에서 판매하는 물품의 가격을 75% 할인합니다.",
	[u.ERROR] = "#{{ErrorRoom}} {{ColorCyan}}I AM ERROR#사용 시 그 방의 모든 아이템 및 픽업과 함께 시작방으로 이동합니다.",
	[u.TREASURE] = "#{{TreasureRoom}} {{ColorCyan}}보물방#{{Card90}} 그 방의 모든 아이템과 픽업을 다른 아이템으로 바꿉니다.#바뀐 아이템의 배열은 랜덤으로 결정됩니다.",
	[u.BOSS] = "#{{BossRoom}} {{ColorCyan}}보스방#{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} 사용 시 그 방에서 {{DamageSmall}}-0.5/{{TearsSmall}}+0.5x2.3/공격이 적에게 유도됩니다.",
	[u.MINIBOSS] = "#{{BossRoom}} {{ColorCyan}}미니보스방#{{Collectible"..wakaba.Enums.Collectibles.MINERVA_AURA.."}} 사용 시 그 방에서 {{DamageSmall}}-0.5/{{TearsSmall}}+0.5x2.3/공격이 적에게 유도됩니다.",
	[u.SECRET] = "#{{SecretRoom}} {{ColorCyan}}비밀방#{{Collectible609}} 사용 시 그 방의 모든 아이템을 다른 아이템으로 바꾸며 25% 확률로 아이템이 사라집니다.",
	[u.SUPERSECRET] = "#{{SuperSecretRoom}} {{ColorCyan}}일급비밀방#{{Collectible609}} 사용 시 그 방의 모든 아이템을 다른 아이템으로 바꾸며 25% 확률로 아이템이 사라집니다.",
	[u.ARCADE] = "#{{ArcadeRoom}} {{ColorCyan}}오락실#사용 시 {{Slotmachine}}도박기계 혹은 {{FortuneTeller}}운세기계를 소환하며;#{{Collectible46}} 그 방에서 야바위와 도박기계의 성공 확률이 증가합니다.",
	[u.CURSE] = "#{{CursedRoom}} {{ColorCyan}}저주방#{{RedChest}}	빨간하트 1칸을 소모하여 빨간상자 2개를 소환합니다.",
	[u.CHALLENGE] = "#{{ChallengeRoom}} {{ColorCyan}}도전방#{{Collectible347}} 사용 시 50%의 확률로 그 방의 모든 아이템과 픽업을 2배로 복사합니다.",
	[u.LIBRARY] = "#{{Library}} {{ColorCyan}}책방#{{Card53}} 사용 시 카드를 3장 소환합니다.",
	[u.SACRIFICE] = "#{{SacrificeRoom}} {{ColorCyan}}희생방#사용 시 그 방의 희생 카운터를 6번째({{AngelChance}}33%/{{Chest}}67%)로 설정합니다.#!!! 카운터가 6 미만인 경우 빨간하트 1칸의 피해를 받습니다.",
	[u.DEVIL] = "#{{DevilRoom}} {{ColorCyan}}악마방#사용 시 최대 체력 2칸 혹은 소울하트 3칸을 요구하는 최소 {{Quality3}}등급의 아이템을 하나 소환합니다.#소환된 아이템은 방을 나가면 사라집니다.",
	[u.ANGEL] = "#{{AngelRoom}} {{ColorCyan}}천사방#사용 시 {{HalfHeart}} + {{HalfSoulHeart}}를 회복하며;#{{CurseCursed}} 이후 등장하는 저주를 1회 방어합니다.",
	--[u.DUNGEON] = "#{{AngelRoom}} {{ColorCyan}}천사방#사용 시 {{HalfHeart}} + {{HalfSoulHeart}}를 회복하며;#{{CurseCursed}} 이후 등장하는 저주를 1회 방어합니다.",
	[u.BOSSRUSH] = "#{{BossRushRoom}} {{ColorCyan}}보스러시#사용 시 그 방의 모든 선택형 상태를 제거합니다.#{{DamageSmall}} 연속 사용 시 그 방에서 공격력 +2",
	[u.ISAACS] = "#{{IsaacsRoom}} {{ColorCyan}}침대방#{{Card92}} 사용 시 랜덤 패밀리어를 하나 획득합니다.",
	[u.BARREN] = "#{{BarrenRoom}} {{ColorCyan}}침대방#{{Collectible"..wakaba.Enums.Collectibles.MICRO_DOPPELGANGER.."}} 사용 시 작은 아이작 패밀리어를 12마리 소환합니다.",
	[u.CHEST] = "#{{ChestRoom}} {{ColorCyan}}금고방#{{EternalChest}} 사용 시 이터널상자 1개와 황금상자 3개를 소환합니다.",
	[u.DICE] = "#{{DiceRoom}} {{ColorCyan}}주사위방#{{Card78}} 사용 시 Cracked Key를 하나 소환합니다.",
	[u.BLACK_MARKET] = "#{{LadderRoom}} {{ColorCyan}}블랙마켓#{{Collectible521}} 사용 시 그 방의 판매 항목 중 하나를 무료로 바꿉니다.",
	[u.GREED_EXIT] = "#{{MinecartRoom}} {{ColorCyan}}Greed Mode 출구#{{Coin}} 사용 시 캐릭터의 동전 +50%",
	[u.PLANETARIUM] = "#{{Planetarium}} {{ColorCyan}}천체관#{{Collectible105}} 사용 시 그 방의 모든 아이템을 다른 아이템으로 바꾸며;#{{Collectible589}} 달빛을 소환합니다.",

	[u.START_ROOM] = "#{{RedRoom}} {{ColorCyan}}시작방#사용 시 색상에 따라 특정한 장소로 이동할 수 있는 포탈이 하나 생성됩니다.",
	[u.BEAST] = "#{{BeastSmall}} {{ColorCyan}}비스트#!!! 일회용#{{Collectible633}} 사용 시 Dogma 아이템을 한 번 더 획득합니다. ({{Heart}}최소6/{{Damage}}+2/{{HolyMantle}})",
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
		.. "#!!! 보스방/보물방의 개수만 2개로 늘어나며 나머지 특수방은 스테이지 하나인 것으로 취급됩니다."
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
		.. "#{{Collectible260}}Black Candle 아이템 획득 시 지도만 다시 표시되며, 기존의 늘어난 방 개수는 그대로 유지됩니다."
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
		.. "#공격의 모습이 사라지며 공격이 매우 가까이 있는 적에게 피해를 입히지 못하나;"
		.. "#멀리 있는 적에게 2배의 피해를 줍니다."
		.. "",
	},
	[wakaba.curses.CURSE_OF_FAIRY] = {
		icon = "WakabaCurseFairy",
		name = "요정의 저주",
		description = "!!! {{Player"..wakaba.Enums.Players.RICHER.."}}리셰 캐릭터, 혹은 {{Collectible"..wakaba.Enums.Collectibles.RABBIT_RIBBON.."}}Rabbit Ribbon 소지 시에만 등장"
		.. "#{{CurseLost}} Lost 저주를 교체하여 등장합니다."
		.. "#그 방 주변의 방 위치를 볼 수 있으나 더 멀리 있는 위치의 방은 지도에 표시되지 않습니다."
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
		.. "#Lost 상태일 때도 헌혈류 요소를 사용할 수 있습니다."
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
		.. "#{{Collectible357}} 기본 소지 아이템 : 친구 상자"
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
		.. "#{{PoopPickup}} 폭탄 픽업은 똥 픽업으로 바뀌며 폭탄을 지급하는 아이템은 그 개수만큼 자폭 파리로 변환됩니다."
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
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		_fromCharDesc = true,
	},
	-- shiori
	[wakaba.Enums.Players.SHIORI] = {
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		_fromCharDesc = true,
	},
	-- tsukasa
	[wakaba.Enums.Players.TSUKASA] = {
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		_fromCharDesc = true,
	},
	-- richer
	[wakaba.Enums.Players.RICHER] = {
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.RICHER_B] = {
		_fromCharDesc = true,
	},
	-- rira
	[wakaba.Enums.Players.RIRA] = {
		_fromCharDesc = true,
	},
	[wakaba.Enums.Players.RIRA_B] = {
		_fromCharDesc = true,
	},

}
wakaba.descriptions[desclang].extrabirthright = {}
wakaba.descriptions[desclang].extracollectibles = {}
wakaba.descriptions[desclang].extratrinkets = {}

wakaba.descriptions[desclang].conditionals.trinkets = {
	[wakaba.Enums.Trinkets.PINK_FORK] = {
		desc = {"{{WakabaModRgon}} 소울하트 회복이 1칸 이상일 때 회복 효율이 반칸만큼 감소합니다.#{{WakabaModRgon}} 감소된 효율 당 {{DamageSmall}}공격력 +0.2"},
	},
}
wakaba.descriptions[desclang].conditionals.cards = {}
wakaba.descriptions[desclang].conditionals.entities = {
	["-998.-1."..LevelCurse.CURSE_OF_LABYRINTH] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}일부 특수방을 추가로 생성합니다.",
	},
	["-998.-1."..wakaba.curses.CURSE_OF_SNIPER] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}공격이 다시 보이며 가까이 있는 적에게 일반적인 피해를 줍니다.",
	},
	["-998.-1."..wakaba.curses.CURSE_OF_FAIRY] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}멀리 있는 방의 위치가 사라지지 않습니다.",
	},
	["-998.-1."..wakaba.curses.CURSE_OF_AMNESIA] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}방이 더 이상 클리어하지 않은 상태로 바뀌지 않으나 방 클리어 보상을 소환합니다.",
	},
	["-998.-1."..wakaba.curses.CURSE_OF_MAGICAL_GIRL] = {
		desc = "{{Player"..wakaba.Enums.Players.RICHER.."}} +{{Collectible619}} {{ColorRicher}}모든 피격이 일반 피격으로 대체됩니다.",
	},
}


wakaba.descriptions[desclang].bossdest = {
	title_boss			= "보스 설정",
	title_health		= "체력 설정",
	title_damo			= "Damocles 여부",
	title_lunatic		= "루나틱 모드 여부",
	title_lock			= "클리어 전까지 해당 옵션 유지",
	title_roll			= "ROLL!!",
	title_clear			= "도전 중단",

	desc_boss			= "{{ArrowGrayRight}} 도전할 보스를 설정해 주세요.#아래 중 하나 선택 가능:#{{Blank}} #{{CustomTransformation}} 랜덤#{{BlueBaby}} Isaac/???#{{TheLamb}} Satan/Lamb#{{MegaSatan}} Mega Satan#{{Delirium}} Hush/Delirium#{{Mother}} Mother#{{Beast}} Dogma/Beast",
	desc_health		= "{{ArrowGrayRight}} 도전할 보스의 총합 체력을 늘립니다.#늘어난 체력은 각 루트의 메이저 보스에게 배분됩니다.#아래 중 하나 선택 가능:#{{Blank}} #{{EmptyHeart}} 기본 (선택 안함)#{{ArrowUpDown}} Dynamic: 캐릭터의 상황에 따라 자동#{{Heart}} 500,000#{{SoulHeart}} 1,000,000#{{BlackHeart}} 10,000,000#{{BoneHeart}} 100,000,000#{{EmptyBoneHeart}} 1,000,000,000#{{UnknownHeart}} 10,000,000,000",
	desc_damo			= "{{ArrowGrayRight}} {{Collectible656}}Damocles 시작 여부를 결정합니다.#!!! 이 옵션은 시작 방에서만 영향을 받습니다.#아래 중 하나 선택 가능:#{{Blank}} #{{EmptyHeart}} 기본 (선택 안함)#{{Collectible656}} {{ColorSilver}}Vanilla{{CR}}: 기본형#{{Collectible"..wakaba.Enums.Collectibles.LUNAR_DAMOCLES.."}} {{ColorYellow}}Lunar{{CR}}: 떨어질 확률 증가, 떨어질 때 사망이 아닌 소지 아이템 절반 제거#{{Collectible"..wakaba.Enums.Collectibles.VINTAGE_THREAT.."}} {{ColorRed}}Vintage{{CR}}: 효과 4배, 패널티 피격 시 즉시 종료, 부활 및 패널티 방어 무효",
	desc_lunatic	= "{{WakabaModLunatic}} 와카바 모드의 루나틱 모드 여부를 결정합니다.#{{WakabaModLunatic}} {{ColorOrange}}와카바 모드의 일부 아이템 효과가 크게 약화됩니다.#{{WakabaModRgon}} REPENTOGON 미적용 시 일부 아이템은 루나틱 모드에서 등장하지 않습니다.",
	desc_lock			= "{{ArrowGrayRight}} 게임 클리어 이전까지 해당 옵션을 유지합니다.",
	desc_roll			= "{{ArrowGrayRight}} Are you ready?",
	desc_clear		= "{{ArrowGrayRight}} 현재 설정한 보스 챌린지를 중단합니다.#추가된 Damocles는 제거되지 않습니다.",
}



if EID then
	if EID.descriptions[desclang].ItemReminder and EID.descriptions[desclang].ItemReminder.CategoryNames then
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Character = "캐릭터"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Starting = "시작 아이템"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_WakabaUniform = "와카바의 교복"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Curse = "저주"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_ShioriFlags = "시오리 눈물 효과"
	end

	EID.descriptions[desclang].WakabaGlobalWarningTitle = "{{ColorOrange}}!!!와카바의 주의사항!!!"
	EID.descriptions[desclang].WakabaRGONWarningText = "{{WakabaMod}} {{ColorYellow}}REPENTOGON이 설치되지 않았습니다.{{CR}} Pudding & Wakaba 모드는 REPENTOGON 모드 설치를 권장하며, 해당 모드 없이 대부분의 요소가 작동하나 일부 아이템 효과 및 요소가 제거됩니다."
	EID.descriptions[desclang].WakabaDamoclesWarningText = "{{Collectible656}} {{ColorYellow}}Damocles API가 비활성화 되었습니다.{{CR}} Damocles API가 필요한 아이템이 등장하지 않습니다."

	EID.descriptions[desclang].WakabaAchievementWarningTitle = "{{ColorYellow}}!!! 와카바 모드 아이템 해금 적용 여부 설정"
	EID.descriptions[desclang].WakabaAchievementWarningText = "Pudding & Wakaba(와카바 모드)는 해금 컨텐츠가 제공됩니다.#해금 컨텐츠를 적용하시겠습니까?#Yes:해금 컨텐츠 적용#No:모든 컨텐츠 해금"

	EID.descriptions[desclang].TaintedTsukasaWarningTitle = "{{ColorYellow}}!!! 잠김 !!!"
	EID.descriptions[desclang].TaintedTsukasaWarningText = "해당 캐릭터는 해금되지 않았습니다.#해금 이후에 사용하실 수 있습니다.#해금 방법 : Tsukasa 캐릭터로 Red Key를 갖고 Home 스테이지 돌입#우측 문으로 이동 시 게임 종료"
	EID.descriptions[desclang].TaintedRicherWarningText = "해당 캐릭터는 해금되지 않았습니다.#해금 이후에 사용하실 수 있습니다.#해금 방법 : Richer 캐릭터로 Red Key를 갖고 Home 스테이지 돌입#우측 문으로 이동 시 게임 종료"

	EID.descriptions[desclang].SweetsChallenge = "사용 시 가장 가까이 있는 아이템의 예상 등급을 선택합니다.#선택한 등급과 아이템의 등급이 일치할 경우 해당 아이템을 획득하며 틀릴 경우 아이템이 사라집니다."
	EID.descriptions[desclang].SweetsFlipFlop = "아이템 사용 버튼으로 취소#{{ButtonY}}/{{ButtonX}}:{{Quality1}}or{{Quality3}}#{{ButtonA}}/{{ButtonB}}:{{Quality2}}or{{Quality4}}#선택한 등급과 아이템의 등급이 일치할 경우 해당 아이템을 획득하며 틀릴 경우 아이템이 사라집니다."

	EID.descriptions[desclang].SweetsChallengeFailed = "{{ColorOrange}}획득 실패 : "
	EID.descriptions[desclang].SweetsChallengeSuccess = "{{ColorCyan}}획득 성공 : "

	EID.descriptions[desclang].WakabaVintageHotkey = "#!!! {1} 버튼을 누르면 즉시 발동"

	EID.descriptions[desclang].CaramellaFlyRicher = "!!! {{ColorRicher}}리셰: 파리가 캐릭터의 공격력 x4의 피해를 줍니다."
	EID.descriptions[desclang].CaramellaFlyRira = "!!! {{ColorRira}}리라: 파리가 캐릭터의 공격력 x3의 침수 피해를 줍니다."
	EID.descriptions[desclang].CaramellaFlyCiel = "!!! {{ColorCiel}}시엘: 파리가 캐릭터의 공격력 x10의 폭발 피해를 줍니다. (캐릭터 피해 없음)"
	EID.descriptions[desclang].CaramellaFlyKoron = "!!! {{ColorKoron}}코론: 파리가 캐릭터의 공격력 x4의 석화 피해를 줍니다."

	EID.descriptions[desclang].MaidDuetBlacklisted = "!!! {{Collectible"..wakaba.Enums.Collectibles.MAID_DUET.."}}{{ColorRicher}}리셰{{CR}} & {{ColorRira}}리라{{CR}} 듀엣으로 교체 불가"

	EID.descriptions[desclang].AquaTrinketText = "{{AquaTrinket}} {{ColorCyan}}아쿠아 장신구 : 획득 시 자동으로 흡수됩니다.{{CR}}"

	EID.descriptions[desclang].AlbireoPool = "{{RicherPlanetarium}} 현재 스테이지에서의 배열 : "

	EID.descriptions[desclang].ClearFileSelection = "Clear File 선택 항목"

	EID.descriptions[desclang].LilRiraEntryNormal = "{{ColorRira}}{{DamageSmall}}사용 당 공격력 +{1} ({2}칸)"
	EID.descriptions[desclang].LilRiraEntryTimed = "{{ColorRira}}{{DamageSmall}}사용 당 공격력 +{1} ({2}초)"
	EID.descriptions[desclang].LilRiraEntryInvalid = "{{ColorCiel}}!!! 공격력이 증가되지 않음"

	EID.descriptions[desclang].WakabaDmgProtectionInvalid = "{{NoLB}}{{ColorOrange}}피격 패널티 보호 무효화됨:"

	EID.descriptions[desclang].ConditionalDescs.WakabaWardSynergy = "{{ColorRira}}토끼 와드 범위 증가"
	EID.descriptions[desclang].ConditionalDescs.WakabaWardSynergyFrom = "{1}로 범위 증가됨"

	EID.descriptions[desclang].ConditionalDescs.WakabaVintageInvalidated = "부활 이후 피격 패널티 보호가 {1}에 의해 무력화됨"
	EID.descriptions[desclang].ConditionalDescs.WakabaVintageInvalidates = "부활 이후 {1}의 피격 패널티 보호가 무력화됨"

end