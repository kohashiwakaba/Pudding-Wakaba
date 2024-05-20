local desclang = "zh_cn"

wakaba.descriptions[desclang] = {}
wakaba.descriptions[desclang].birthright = {
	[wakaba.Enums.Players.WAKABA] = {
		playerName = "{{ColorWakabaBless}}若叶",
		description =
		"↑ {{Heart}}增加一个心上限#{{AngelChance}} 100%打开天使房",
		queueDesc = "真正纯洁",
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		playerName = "{{ColorWakabaNemesis}}里若叶",
		description = "↑ {{Collectible" ..
			wakaba.Enums.Collectibles.WAKABAS_NEMESIS ..
			"}}若叶的宿敌不再降低所有的属性，并且减少伤害衰减的速度#免疫爆炸和碰撞的影响",
		queueDesc = "免疫爆炸+可控狂暴",
	},
	[wakaba.Enums.Players.SHIORI] = {
		playerName = "{{ColorBookofShiori}}汐宫",
		description = "↑ 钥匙被消耗时触发主动道具(最小为 1)",
		queueDesc = "追求知识",
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		playerName = "{{ColorCyan}}密涅瓦{{CR}}(Tainted 汐宫)",
		description = "{{Collectible" ..
			wakaba.Enums.Collectibles.MINERVA_AURA ..
			"}} 一直激活光环# {{Collectible" ..
			wakaba.Enums.Collectibles.BOOK_OF_CONQUEST ..
			"}}征服之书和主动物品所需的钥匙数量减少（最少1）#↑ 根据当前征服的敌人数量提升全属性",
		queueDesc = "闪亮链接",
	},
	[wakaba.Enums.Players.TSUKASA] = {
		playerName = "{{ColorPink}}司",
		description = "让司找到胎衣 ~ 忏悔的物品#↑ 延长 {{Collectible" ..
			wakaba.Enums.Collectibles.LUNAR_STONE .. "}}月亮石能量的最大上限",
		queueDesc = "明亮的月光",
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		playerName = "???(Tainted 司)",
		description = "让里司能够发射眼泪#{{Collectible" ..
			wakaba.Enums.Collectibles.FLASH_SHIFT .. "}} 闪移能力现在被移动到口袋物品槽.",
		queueDesc = "克服悲痛审判",
	},
	[wakaba.Enums.Players.RICHER] = {
		playerName = "璃贝",
		description = "#{{Collectible" ..
			wakaba.Enums.Collectibles.SWEETS_CATALOG ..
			"}} 甜品目录的效果现在会持续到下一次使用目录为止"
			..
			"#{{Collectible" ..
			wakaba.Enums.Collectibles.RABBIT_RIBBON ..
			"}} 从兔子丝带的诅咒中移除惩罚或给予奖励 (可以使用F5检查)",
		queueDesc = "美妙交易,优质菜单",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		playerName = "Tainted 璃贝",
		description = "#更耐用的火焰#{{Collectible" ..
			wakaba.Enums.Collectibles.WATER_FLAME .. "}} 水中焰每吸收一个火焰就会给予额外的被动效果",
		queueDesc = "双倍火力",
	},
	[wakaba.Enums.Players.RIRA] = {
		playerName = "莉良",
		description = "#{{Collectible" ..
			wakaba.Enums.Collectibles.NERF_GUN ..
			"}}热火枪的弱化持续时间更长#{{Collectible" ..
			wakaba.Enums.Collectibles.CHIMAKI .. "}} 小棕会变得更强",
		queueDesc = "有一点更H了",
	},
}
wakaba.descriptions[desclang].collectibles = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		itemName = "若叶的庇佑",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#↑阻止{{Quality0}}/{{Quality1}}物品出现"
			.. "#所有受到的伤害都不会有惩罚"
			.. "#每个房间都会给予{{Collectible313}}圣衣的护盾（除了里罗）"
			.. "{{CR}}",
		lunatic = "" -- TODO
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}阻止{{Quality0}}物品出现"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}NO LONGER Prevents penalties from all damage taken"
			.. "#每个房间都会给予{{Collectible313}}圣衣的护盾（除了里罗）"
			.. "{{CR}}",
		queueDesc = "信仰上升 + 更好的道具",
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		itemName = "若叶的宿敌",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#↑ 穿透眼泪"
			.. "#↓ 拾取物品时，暂时增加3.6点伤害，但永久降低所有属性"
			.. "#↓ 阻止 {{Quality4}} 道具生成, 也降低 {{Quality3}}道具出现几率"
			.. "#{{SoulHeart}}所有道具交易都改为魂心"
			.. "#所有受到的伤害都不会被视为惩罚性的伤害"
			.. "#!!! 无论以何种方式获得这个物品，都会被视为接受了恶魔交易."
			.. "{{CR}}",
		lunatic = "" -- TODO
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}NO LONGER gives Armor-piercing tears"
			.. "#↓ 拾取物品时，暂时增加3.6点伤害，但永久降低所有属性"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}阻止 {{Quality3}}/{{Quality4}} 道具生成"
			.. "#{{SoulHeart}}所有道具交易都改为魂心"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}NO LONGER Prevents penalties from all damage taken"
			.. "#!!! 无论以何种方式获得这个物品，都会被视为接受了恶魔交易."
			.. "{{CR}}",
		queueDesc = "邪恶&射程上升 + 更糟的道具",
	},
	[wakaba.Enums.Collectibles.WAKABA_DUALITY] = {
		itemName = "若叶二相性",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#↑ 穿透眼泪"
			.. "#↓ 拾取物品时获得临时 {{Damage}} +3.6 伤害提升和永久 全属性下降"
			.. "#{{AngelDevilChance}} 100% 几率在除了蓝子宫以外的所有楼层找到恶魔/天使房"
			.. "#↑ 可以拿取所有道具"
			.. "#{{SoulHeart}} 所有道具交易都改为魂心"
			.. "#所有受到的伤害都是非惩罚性的伤害"
			.. "{{CR}}",
		queueDesc = "游离在幸运与愤怒之间",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SHIORI] = {
		itemName = "汐宫之书",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{Library}} Guarantees Library every floor if possible"
			.. "#使用书籍类主动道具时激活额外效果"
			.. "#在使用书籍类主动道具时获得额外的眼泪效果"
			.. "#额外的眼泪效果会在下次使用书籍时改变"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{Library}} Guarantees Library every floor if possible"
			.. "#使用书籍类主动道具时激活额外效果"
			.. "#在使用书籍类主动道具时获得额外的眼泪效果"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}Extra tear effect changes on next book usage, or resets on entering new floor" -- TODO
			.. "{{CR}}",
		queueDesc = "知识就是力量",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		itemName = "征服之书",
		description = ""
			.. "#永久魅惑当前房间内的非boss敌人."
			.. "#魅惑的敌人的生命值被设定为他们最大生命值的10倍"
			.. "#!!! 如果有太多友好的敌人，就不能使用这个物品 !"
			.. "{{CR}}",
		queueDesc = "迷途羔羊指南",
	},
	[wakaba.Enums.Collectibles.MINERVA_AURA] = { -- TODO
		itemName = "密涅瓦的领域",
		description = ""
			.. "#玩家在范围内时:"
			.. "#↓ {{Damage}} -0.5 攻击"
			.. "#↑ {{Tears}} +0.5 Fire rate up"
			.. "#↑ {{Tears}} x2.3 Fire rate multiplier"
			.. "#↑ 跟踪眼泪"
			.. "#友方小怪或宝宝在范围内持续恢复生命"
			.. "{{CR}}",
		lunatic = ""
			.. "#玩家在范围内时:"
			.. "#{{WakabaModLunatic}} {{Damage}} {{ColorOrange}}-2 攻击"
			.. "#↑ {{Tears}} +0.5 Fire rate up"
			.. "#{{WakabaModLunatic}} {{Tears}} {{ColorOrange}}x1.6 Fire rate multiplier"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}(NO LONGER gives homing tears)"
			.. "#友方小怪或宝宝在范围内持续恢复生命"
			.. "{{CR}}",
		queueDesc = "互帮互助",
	},
	[wakaba.Enums.Collectibles.LUNAR_STONE] = { -- TODO
		itemName = "月石",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#↑ 获得额外的月相表，根据月相表的数值提高{{Damage}}伤害和{{Tears}}射速"
			.. "#如果受到伤害，月石失效，月相表开始消耗"
			.. "#Clearing rooms recover lunar gauge"
			.. "#↑ 只要以撒拥有月石，就拥有无限的生命"
			.. "#!!! 当月相表耗尽时，月石会消失"
			.. "#所有受到的伤害都是非惩罚性的伤害"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#↑ 获得额外的月相表，根据月相表的数值提高{{Damage}}伤害和{{Tears}}射速"
			.. "#如果受到伤害，月石失效，月相表开始消耗"
			.. "#Clearing rooms recover lunar gauge"
			.. "#↑ 只要以撒拥有月石，就拥有无限的生命"
			.. "#!!! 当月相表耗尽时，月石会消失"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}NO LONGER Prevents penalties from all damage taken"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}Faster lunar gauge reduction speed"
			.. "{{CR}}",
		queueDesc = "保持圣洁",
	},
	[wakaba.Enums.Collectibles.ELIXIR_OF_LIFE] = {
		itemName = "长生不老药",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{WakabaAntiCurseUnknown}} 免疫未知诅咒"
			.. "#↓ {{ColorOrange}}Significantly reduces invincibility frames" -- TODO
			.. "#在短时间内未受伤快速恢复任何类型生命值"
			.. "#恢复4次减少一颗心"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{WakabaAntiCurseUnknown}} 免疫未知诅咒"
			.. "#{{WakabaModLunatic}} {{ColorRed}}移除无敌帧"
			.. "#在短时间内未受伤快速恢复任何类型生命值"
			.. "#恢复4次减少一颗心"
			.. "{{CR}}",
		queueDesc = "辉夜魔药",
	},
	[wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		itemName = "闪光位移",
		description = ""
			.. "向四个方向快速冲锋"
			.. "#满充能前最多可使用3次"
			.. "#!!! 宝宝不会移动, 灵火或魂火可以"
			.. "{{CR}}",
		queueDesc = "彗星女孩",
	},
	[wakaba.Enums.Collectibles.CONCENTRATION] = { -- TODO
		itemName = "专注",
		description = ""
			.. "#按住丢弃按钮(通常是ctrl)进入专注模式"
			.. "#3秒钟可以完全充能主动道具"
			.. "#↑ +1.5 {{Range}} 射程,在专注时（每次使用额外增加0.25）"
			.. "#!!! 专注时间会随着使用次数增加。这个计数可以在清理房间时减少"
			.. "#!!! Can't concentrate on 300+ counts"
			.. "#!!! 在专注模式下不能移动，并且受到的伤害加倍"
			.. "{{CR}}",
		lunatic = ""
			.. "#按住丢弃按钮(通常是ctrl)进入专注模式"
			.. "#3秒钟可以完全充能主动道具"
			.. "#↑ +1.5 {{Range}} 射程,在专注时（每次使用额外增加0.25）"
			.. "#!!! 专注时间会随着使用次数增加。这个计数可以在清理房间时减少"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}Repeating concentration reqires room clears, can't concentrate on 60+ counts"
			.. "#!!! 在专注模式下不能移动，并且受到的伤害加倍"
			.. "{{CR}}",
		queueDesc = "可重复使用的充电器",
	},
	[wakaba.Enums.Collectibles.RABBIT_RIBBON] = {
		itemName = "兔子丝带",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{CurseCursed}} 改变其他诅咒"
			.. "#{{Battery}} 清理房间后储存额外的能量（最多16个）"
			.. "#为未充满的主动道具自动消耗储存的能量"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{CurseCursed}} 改变其他诅咒"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}清理房间后储存额外的能量（最多6个）"
			.. "#为未充满的主动道具自动消耗储存的能量"
			.. "{{CR}}",
		queueDesc = "甜蜜诅咒，不再盲目",
	},
	[wakaba.Enums.Collectibles.SWEETS_CATALOG] = {
		itemName = "甜品目录",
		description = ""
			.. "#为当前房间授予以下随机组合道具"
			.. "{{CR}}",
		queueDesc = "随意试吃",
	},
	[wakaba.Enums.Collectibles.WINTER_ALBIREO] = { -- TODO
		itemName = "辇道增七",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{RicherPlanetarium}}璃贝的特殊天文馆在每个楼层都会出现，其中包含:"
			.. "#取决于楼层的随机道具"
			.. "#白色壁炉"
			.. "#水晶补货机"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}{{RicherPlanetarium}}Richer's special Planetariums replace treasure rooms that contains:"
			.. "#取决于楼层的随机道具"
			.. "#白色壁炉"
			.. "#水晶补货机"
			.. "{{CR}}",
		queueDesc = "连接",
	},
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		itemName = "水中焰",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#使用生成最近道具的两个灵火复制"
			.. "#{{Collectible712}}只能生成所罗门之书可以生成的道具"
			.. "{{CR}}",
		queueDesc = "璃贝酱很美味",
	},
	[wakaba.Enums.Collectibles.NERF_GUN] = {
		itemName = "热火枪",
		description = ""
			.. "#使用道具后朝一个方向射出多发nerf眼泪"
			.. "#{{Weakness}} 被击中的敌人{{Slow}}减速并受到双倍伤害10秒"
			.. "{{CR}}",
		queueDesc = "Tea-bagging shots",
	},
	[wakaba.Enums.Collectibles.CHIMAKI] = {
		itemName = "小粽宝宝",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#四处游荡并帮助玩家，但不限于:"
			.. "#发射眼泪或者火焰"
			.. "#{{Collectible374}} 跳向敌人"
			.. "#{{Collectible260}} 有概率移除诅咒"
			.. "#{{Trinket63}} 转换巨魔炸弹"
			.. "{{CR}}",
		queueDesc = "莉良的灵魂伴侣",
	},
	[wakaba.Enums.Collectibles.BROKEN_TOOLBOX] = {
		itemName = "破损工具箱",
		description = ""
			.. "#{{WakabaAntiCurseBlind}} 免疫致盲诅咒"
			.. "#在未清理的房间里，每秒生成一个拾取物"
			.. "#如果房间里有15个或更多的拾取物，它们就会爆炸."
			.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.EATHEART] = { -- TODO
		itemName = "食心",
		description = ""
			.. "#只能通过伤害敌人或自我伤害来充能."
			.. "#即使没有 {{Collectible" ..
			CollectibleType.COLLECTIBLE_BATTERY .. "}}大电池也可以超额充能. 最大充能15000点伤害"
			.. "#生成一个来自当前物品池的随机物品"
			.. "#只会生成{{Quality3}}/{{Quality4}}道具"
			.. "{{CR}}",
		lunatic = ""
			.. "#只能通过伤害敌人或自我伤害来充能."
			.. "#即使没有 {{Collectible" ..
			CollectibleType.COLLECTIBLE_BATTERY .. "}}大电池也可以超额充能. 最大充能15000点伤害"
			.. "#生成一个来自当前物品池的随机物品"
			.. "#只会生成{{Quality3}}/{{Quality4}}道具"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}Decreased charge rate by half"
			.. "{{CR}}",
		queueDesc = "就像布丁",
		wisp = "{{ColorLime}}内环 x1: {{CR}}#无敌 灵火#不能发射眼泪",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		itemName = "遗忘之书",
		description = ""
			.. "#对所有玩家使用:"
			.. "#↑ {{BoneHeart}} +1 骨心"
			.. "#{{Heart}} 恢复所有红心"
			.. "{{CR}}",
		queueDesc = "可回收死灵",
		belial = "{{BlackHeart}}给出一个黑心，而不是是骨心。恢复所有红心的效果仍然有效",
		wisp = "{{ColorYellow}}中环 x1: {{CR}}#{{BoneHeart}}被摧毁时生成一个 骨心",
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		itemName = "D-杯冰淇淋",
		description = ""
			.. "#↑ {{Heart}} +1 心之容器"
			.. "#↑ {{Heart}} 治疗1红心"
			.. "#↑ {{Damage}} +0.3攻击力"
			.. "#↑ {{Damage}} +80% 攻击倍率 (不叠加)"
			.. "{{CR}}",
		lunatic = ""
			.. "#↑ {{Heart}} +1 心之容器"
			.. "#↑ {{Heart}} 治疗1红心"
			.. "#↑ {{Damage}} +0.3攻击力"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Damage}} +36% 攻击倍率 (不叠加)"
			.. "{{CR}}",
		queueDesc = "攻击力上升 + 不是你想的那样!",
		binge = "↑ {{Damage}} +1.0攻击力#↓ {{Speed}} -0.04速度",
	},
	[wakaba.Enums.Collectibles.MINT_CHOCO_ICECREAM] = {
		itemName = "薄荷巧克力冰淇淋",
		description = ""
			.. "#↑ {{Tears}} +100% 射速倍率 (不叠加)"
			.. "#↑ {{Tears}} +0.2 额外射速修正(叠加)"
			.. "{{CR}}",
		queueDesc = "泪流满面",
	},
	[wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD] = {
		itemName = "神秘游戏光盘",
		description = ""
			.. "#↑ {{Heart}} +1 心之容器"
			.. "#↑ {{Speed}} +0.16速度"
			.. "#↑ {{Tears}} +0.7 射速"
			.. "#↑ {{Shotspeed}} +0.1 弹速"
			.. "#↑ {{Range}} +0.85攻击距离"
			.. "#↑ {{Damage}} +0.5攻击力"
			.. "#房间会随机地稍微上色"
			.. "{{CR}}",
		queueDesc = "全属性上升! + 你感觉很下流",
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = { -- TODO
		itemName = "若叶的挂坠",
		description = ""
			.. "#{{Luck}}如果幸运少于7则提升到7"
			.. "#↑ {{Luck}} 每有一个幸运相关道具+0.35幸运"
			.. "#↑ {{Damage}} +1攻击力"
			.. "#{{Heart}} 恢复所有红心"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Luck}}如果幸运少于3则提升到3"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}(No additional luck)"
			.. "#↑ {{Damage}} +1攻击力"
			.. "#{{Heart}} 恢复所有红心"
			.. "{{CR}}",
		queueDesc = "你感觉超级幸运!",
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		itemName = "若叶的发夹 ",
		description = ""
			.. "#↑ {{Luck}} 每粒药丸增加+0.25的运气"
			.. "#↑ {{Damage}} +1攻击力"
			.. "{{CR}}",
		queueDesc = "感觉不错!",
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		itemName = "秘密卡",
		description = ""
			.. "#↑ {{Coin}} +22 硬币"
			.. "#每清理一个房间就会生成{{Coin}} 硬币"
			.. "#{{Shop}} 阻止贪婪/超级贪婪出现在商店里"
			.. "{{CR}}",
		queueDesc = "堆叠硬币&成为秘密朋友",
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		itemName = "大可爱",
		description = ""
			.. "#{{Collectible" .. CollectibleType.COLLECTIBLE_PLUM_FLUTE ..
			"}} 一个跟随以撒的小梅子宠物."
			.. "#在以撒前方射出眼泪并且阻挡弹幕"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{Collectible" .. CollectibleType.COLLECTIBLE_PLUM_FLUTE ..
			"}} 一个跟随以撒的小梅子宠物."
			.. "#在以撒前方射出眼泪并且阻挡弹幕"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}当小可爱受到太多伤害时，无法移动并且需要10秒恢复"
			.. "{{CR}}",
		queueDesc = "啥?",
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		itemName = "处刑者",
		description = ""
			.. "#{{Collectible" .. CollectibleType.COLLECTIBLE_ERASER .. "}} 0.75%的几率 '擦除' 非Boss敌人"
			.. "#{{Luck}} 10% 的几率 在 117 幸运时, 100% 对Boss有效"
			.. "#!!! {{ColorSilver}}由于潜在的软锁定，一些Boss不会受到影响，比如教条和妈妈{{ColorReset}}"
			.. "{{CR}}",
		queueDesc = "???",
	},
	[wakaba.Enums.Collectibles.NEW_YEAR_BOMB] = {
		itemName = "除夕爆竹",
		description = ""
			.. "#↑ {{Bomb}} +9 炸弹"
			.. "#所有的爆炸都无视敌人的护甲"
			.. "#已经无视护甲的爆炸造成2倍伤害"
			.. "#{{Player25}} 作为里蓝人使用Hold时消耗3个{{PoopPickup}}便便并且握住一个炸弹"
			.. "#!!! 只有在少于3个便便时才能使用Hold"
			.. "{{CR}}",
		queueDesc = "空包弹",
	},
	[wakaba.Enums.Collectibles.REVENGE_FRUIT] = {
		itemName = "复仇之果",
		description = ""
			..
			"#{{Collectible" ..
			CollectibleType.COLLECTIBLE_BRIMSTONE .. "}} 增加一定几率用硫磺火代替泪弹射击"
			.. "#每当以撒在当前楼层受到伤害，几率就会增加"
			--.. "#{{Collectible"..CollectibleType.COLLECTIBLE_BRIMSTONE .."}} 1.5x攻击力 multiplier"
			.. "{{CR}}",
		queueDesc = "极限热泪",
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		itemName = "若叶的制服",
		description = ""
			.. "#使用时，存储/交换当前的卡牌、药丸或符文"
			.. "#放下按钮改变要存储/交换的槽位"
			.. "#使用卡牌/药丸/符文时，他也会使用wakaba制服中存储的卡牌/药丸/符文的复制"
			.. "#按住Tab键/地图按钮显示当前的槽位"
			.. "{{CR}}",
		queueDesc = "贵安!",
		belial = "每次使用制服内的卡片/药丸/符文时，会召唤出XV - The Devil的卡牌效果",
		wisp = "{{ColorRed}}!!!没有 灵火 {{CR}}#所有 灵火在持有时变得无敌",
	},
	[wakaba.Enums.Collectibles.EYE_OF_CLOCK] = {
		itemName = "时钟之眼",
		description = ""
			.."不断射击逐渐生成环绕玩家的X激光"
			.."#轨道激光器也会发射额外的激光"
			.."#激光造成0.3倍玩家的伤害"
			.. "{{CR}}",
		queueDesc = "轨道激光",
	},
	[wakaba.Enums.Collectibles.LIL_WAKABA] = {
		itemName = "若叶宝宝",
		description = ""
			.. "#发射小型的科技X激光"
			.. "#造成玩家40%的伤害"
			.. "#射速取决于玩家的射速"
			.. "{{CR}}",
		queueDesc = "幸运密友",
	},
	[wakaba.Enums.Collectibles.COUNTER] = {
		itemName = "异议",
		description = ""
			.. "#获得一秒无敌"
			.. "#在无敌时向敌人发射激光"
			..
			"#!!!  这个物品在受到伤害时自动激活。这样激活物品也会防止以撒受到伤害"
			.. "#当其他盾牌激活时不会激活"
			.. "{{CR}}",
		queueDesc = "反驳激光",
		wisp = "{{ColorOrange}}外环 x1: {{CR}}仅对当前房间有效#所有 灵火在反击盾激活时变得无敌"
	},
	[wakaba.Enums.Collectibles.RETURN_POSTAGE] = {
		itemName = "退货邮费",
		description = ""
			.. "#以下敌人永久魅惑"
			.. "#{{Blank}}小钉虫, 白骨虫, 尘鬼, 捣蛋小鬼, 灵能小鬼, 妈手"
			.. "#!!! 闹鬼的箱子仍然会伤害以撒，但会试图把他扔开"
			.. "#移除所有永恒苍蝇"
			.. "{{CR}}",
		queueDesc = "再也别来了",
	},
	[wakaba.Enums.Collectibles.D6_PLUS] = {
		itemName = "D6 Plus",
		description = ""
			.. "#{{Card" .. Card.CARD_SOUL_ISAAC .. "}} 触发以撒魂石的效果"
			.. "#重置房间内的物品"
			.. "#在一秒后恢复原来的形态"
			.. "#效果重复"
			.. "{{CR}}",
		queueDesc = "重重置置你的命运",
		wisp = "{{ColorLime}}内环 x1: {{CR}}没有特殊效果"
	},
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		itemName = "混沌D6",
		description = ""
			.. "#{{Card" .. Card.CARD_SOUL_ISAAC .. "}} 触发以撒的魂石 {{ColorRed}}9 次{{CR}}"
			.. "#疯狂的速度循环重置的物品"
			.. "{{CR}}",
		queueDesc = "你可以改变命运吗?",
		wisp = "{{ColorLime}}内环 x1: {{CR}}没有特殊效果"
	},
	[wakaba.Enums.Collectibles.LIL_MOE] = {
		itemName = "Moe宝宝",
		description = ""
			.. "#发射环绕和跟踪眼泪"
			.. "#每颗眼泪都有随机的眼泪效果，最少造成4点伤害"
			.. "{{Blank}} (不包括爆炸效果)"
			.. "#射速取决于玩家射速"
			.. "{{CR}}",
		queueDesc = "料理密友",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		itemName = "专注之书",
		description = ""
			.. "#{{Weakness}} 使当前房间内的所有敌人虚弱"
			..
			"#如果以撒不手动移动，以撒会发射追踪和穿透的眼泪#  +1.4 {{Damage}}伤害 和 +1.0 {{Tears}}射速"
			.. "#!!! 在当前房间内也会至少受到2颗满心的伤害"
			.. "{{CR}}",
		queueDesc = "慎用",
		wisp = "{{ColorYellow}}中环 x1: {{CR}}#跟踪眼泪"
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		itemName = "汐宫的符文瓶",
		description = ""
			.. "#{{Rune}} 给一个随机符文"
			.. "{{CR}}",
		queueDesc = "复用魔法石头",
		belial = "有50%的几率率获得黑色符文，而不是随机的#{{ColorWakabaNemesis}}召唤出黑色符文的效果，有10%的几率",
		wisp = "{{ColorYellow}}中环 x1: {{CR}}#{{Rune}}敌人杀死时有 15% 的几率掉落一个 灵火#{{Rune}}被摧毁时生成一个 灵火",
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		itemName = "迷你二重身",
		description = ""
			.. "#生成12个小以撒"
			.. "#自动追踪敌人射击"
			.. "{{CR}}",
		queueDesc = "自我分裂",
		wisp = "{{ColorOrange}}外环 x1: {{CR}}#被摧毁时生成迷你以撒"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		itemName = "沉默之书",
		description = ""
			.. "#消除所有敌人的弹幕"
			.. "{{CR}}",
		queueDesc = "清除",
		beilal = "召唤{{Collectible" .. CollectibleType.COLLECTIBLE_DARK_ARTS .. "}}黑暗艺术效果，并对所有敌人造成每次擦除的敌弹伤害",
		wisp = "{{ColorOrange}}外环 x1: {{CR}}#对射击无效#清除附近的敌弹"
	},
	[wakaba.Enums.Collectibles.VINTAGE_THREAT] = {
		itemName = "复古威胁",
		description = ""
			.. "#{{Player" .. wakaba.Enums.Players.SHIORI_B .. "}} 死亡时, 在当前房间重生为里汐宫"
			.. "#复活后,重置钥匙为0, 获得4把 {{Collectible656}}达摩剑"
			..
			"#!!! {{ColorBlink}}{{ColorRed}}受到任何惩罚伤害都会使达摩克利斯之剑掉落，并立即结束本局，无论玩家是否有复活！{{ColorReset}}"
			.. "{{CR}}",
		queueDesc = "永生?",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_GOD] = {
		itemName = "上帝之书",
		description = ""
			.. "#持有时死亡变成天使复活"
			.. "#!!! 复活后:"
			.. "#↓ -50% {{Damage}}攻击倍率"
			.. "#眼泪获得一个能造成与攻击力相同伤害的光环"
			.. "#{{BrokenHeart}} 受到任何伤害会让以撒获得碎心"
			.. "#!!! 变成天使后不能通过献祭房进入天使房"
			.. "{{CR}}",
		queueDesc = "杀死我的会让我更强大",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		itemName = "死神守护者",
		description = ""
			.. "#防止死亡，所有受到的伤害减少到半颗心"
			.. "#同时，所有的伤害都先扣红心，并且防止惩罚伤害"
			.. "#!!! {{ColorYellow}}这本书的效果不会在献祭房间的尖刺上起作用{{ColorReset}}"
			.. "{{CR}}",
		queueDesc = "人生保险",
		wisp = "{{ColorLime}}内环 x1: {{CR}}高耐久度#死亡时复活 Isaac 和 灵火被消耗"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_TRAUMA] = {
		itemName = "创伤之书",
		description = ""
			.. "#引爆屏幕上当前存在的玩家的泪弹，使每一颗都爆炸（最多15颗）."
			.. "#爆炸的泪弹向四个方向发射硫磺火激光."
			.. "{{CR}}",
		queueDesc = "眼泪雷管",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		itemName = "堕落之书",
		description = ""
			--.. "#!!! This item cannot be used before reviving into Fallen Angel"
			.. "#产生3个炼狱幽灵 造成0.4倍攻击力伤害"
			.. "# 如果持有时死亡，重生为堕落天使，并给予6颗黑心"
			.. "#!!! {{ColorSilver}}重生为堕落天使后:"
			.. "#{{ColorSilver}}使用时，产生11个饥饿的灵魂，造成1倍攻击力伤害"
			.. "#↓ {{ColorSilver}}不能发射眼泪"
			.. "#↑ {{Damage}} {{ColorSilver}}+600% 攻击倍率"
			.. "#!!! {{ColorYellow}}不能更换主动{{ColorReset}}"
			.. "{{CR}}",
		queueDesc = "感受海浪",
	},
	[wakaba.Enums.Collectibles.MAIJIMA_MYTHOLOGY] = {
		itemName = "舞岛神话",
		description = ""
			.. "#随机书籍效果"
			--[[ .. "#!!! Following books can be activated:" ]]
			.. "{{CR}}",
		queueDesc = "德墨忒尔传说",
		wisp = "{{ColorOrange}}外环 x1: {{CR}}#被摧毁时生成一个 未知的书签"
	},
	[wakaba.Enums.Collectibles.APOLLYON_CRISIS] = {
		itemName = "亚波伦的危机",
		description = ""
			.. "#同时触发{{Collectible477}}虚空和{{Collectible706}}深渊的效果:"
			.. "#!!!使用时，消耗房间内的全部道具"
			.. "#主动物品：其效果将被添加到虚空的效果中（叠加效果"
			.. "#↑ 被动物品：随机属性小幅提升"
			.. "#为每个消耗的道具生成一个攻击苍蝇跟班"
			.. "{{CR}}",
		queueDesc = "拥抱虚无",
	},
	[wakaba.Enums.Collectibles.LIL_SHIVA] = {
		itemName = "湿婆宝宝",
		description = ""
			.. "#{{Collectible532}} 噬泪跟班"
			.. "#射出带电的波浪眼泪"
			.. "#T眼泪在飞行过程中减速"
			.. "#停止时，它们会爆炸成8个小眼泪"
			.. "#眼泪可以被射入其他眼泪，使它们变大"
			.. "#玩家的眼泪可以被吞噬"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{Collectible532}} 噬泪跟班"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}Shoots single tear" -- TODO
			.. "#T眼泪在飞行过程中减速"
			.. "#停止时，它们会爆炸成8个小眼泪"
			.. "#眼泪可以被射入其他眼泪，使它们变大"
			.. "#玩家的眼泪可以被吞噬"
			.. "{{CR}}",
		queueDesc = "水之密友",
	},
	[wakaba.Enums.Collectibles.NEKO_FIGURE] = {
		itemName = "猫娘手办",
		description = ""
			.. "#↓ {{Damage}} -10%攻击力"
			.. "#Isaac的非爆炸性攻击现在忽略护甲"
			.. "#↑ 保证在{{UltraSecretRoom}}红隐里出现{{Quality3}}/{{Quality4}}的道具"
			.. "{{CR}}",
		queueDesc = "伤害下降n... 但代价是什么?",
	},
	[wakaba.Enums.Collectibles.DEJA_VU] = {
		itemName = "既视感",
		description = ""
			.. "#12.5%的几率将道具重置为已经拥有的道具"
			.. "{{CR}}",
		queueDesc = "你感觉被遗忘了",
	},
	[wakaba.Enums.Collectibles.LIL_MAO] = {
		itemName = "Mao宝宝",
		description = ""
			.. "#↑ {{Speed}} +0.15速度"
			.. "#发射环型硫磺火,无法自行移动"
			.. "#可以通过触摸它来拾起和扔掉它"
			.. "{{CR}}",
		queueDesc = "裂隙密友",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		itemName = "异世界定义",
		description = ""
			.. "#生成一个小血块（最多10个）"
			.. "#恢复所有生成的小血块的生命值2点"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{WakabaModLunatic}} {{ColorOrange}}生成一个小血块（最多4个）"
			.. "#恢复所有生成的小血块的生命值2点"
			.. "{{CR}}",
		queueDesc = "史莱姆分裂",
	},
	[wakaba.Enums.Collectibles.BALANCE] = {
		itemName = "平衡 恒平",
		description = ""
			.. "#↑ {{Coin}} +10 硬币"
			.. "#将5个{{Coin}}硬币转换为1个{{Key}}钥匙和1个{{Bomb}}炸弹."
			.. "#如果硬币不够: "
			.. "#将1个钥匙/炸弹转换为以撒更少拥有的另一个."
			.. "{{CR}}",
		queueDesc = "耗材转换器",
		wisp = "{{ColorRed}}!!!没有 灵火 {{CR}}#当拥有相同数量的钥匙和炸弹时，所有 灵火变得无敌",
	},
	[wakaba.Enums.Collectibles.RICHERS_FLIPPER] = {
		itemName = "璃贝的脚蹼",
		description = ""
			.. "#将{{Bomb}}/{{Key}} 和 {{Card}}/{{Pill}} 互相转换"
			.. "{{CR}}",
		queueDesc = "翻转掉落物",
	},
	[wakaba.Enums.Collectibles.RICHERS_NECKLACE] = {
		itemName = "璃贝的项链",
		description = ""
			.. "#未命中的眼泪会产生教条的激光"
			.. "{{CR}}",
		queueDesc = "麻麻的",
	},
	[wakaba.Enums.Collectibles.MOE_MUFFIN] = {
		itemName = "Moe的松饼",
		description = ""
			.. "↑ {{Heart}} +1 心之容器"
			.. "#↑ {{Heart}} 治疗一红心"
			.. "#↑ {{Damage}} +1.5攻击力"
			.. "#↑ {{Range}} +1.5 射程"
			.. "{{CR}}",
		queueDesc = "生命, 伤害, 射程 上升",
	},
	[wakaba.Enums.Collectibles.MURASAME] = {
		itemName = "村雨",
		description = ""
			.. "#100% 几率生成一个天使房和一个恶魔房#进入其中一个会使另一个消失"
			.. "{{CR}}",
		queueDesc = "神社守护者",
	},
	[wakaba.Enums.Collectibles.CLOVER_SHARD] = {
		itemName = "三叶草碎片",
		description = ""
			.. "↑ {{Heart}} +1 心之容器"
			.. "#↑ {{Heart}} 治疗一红心"
			.. "#↑ {{Damage}} +11% 攻击倍率"
			.. "{{CR}}",
		queueDesc = "继续收集",
	},
	[wakaba.Enums.Collectibles.NASA_LOVER] = {
		itemName = "宇航爱好者",
		description = ""
			.. "#{{Collectible494}} 电泪宝宝"
			.. "#{{Collectible494}} 所有玩家的宝宝也获得电泪"
			.. "{{CR}}",
		queueDesc = "电动卡拉",
	},
	[wakaba.Enums.Collectibles.ARCANE_CRYSTAL] = {
		itemName = "神秘水晶",
		description = ""
			.. "#↑ {{Damage}} +12% 攻击倍率"
			.. "#跟踪眼泪"
			.. "#20% 几率造成额外伤害"
			.. "#{{Luck}} 在43点幸运时有60%的几率"
			.. "{{CR}}",
		queueDesc = "伤害上升",
	},
	[wakaba.Enums.Collectibles.ADVANCED_CRYSTAL] = {
		itemName = "高级晶体",
		description = ""
			.. "#↑ {{Damage}} +14% 攻击倍率"
			.. "#穿透眼泪"
			.. "#敌人有5%的几率受到穿甲伤害"
			.. "#{{Luck}} 在55点幸运时有43%的几率"
			.. "{{CR}}",
		queueDesc = "伤害上升",
	},
	[wakaba.Enums.Collectibles.MYSTIC_CRYSTAL] = {
		itemName = "神秘晶体",
		description = ""
			.. "#↑ {{Damage}} +16% 攻击倍率"
			.. "#神性眼泪"
			.. "#{{Card" .. Card.CARD_HOLY .. "}} 每清理8个房间(最多2个)获得神圣卡效果"
			.. "{{CR}}",
		queueDesc = "伤害上升",
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		itemName = "3D打印",
		description = ""
			.. "#复制并吞下当前持有的饰品"
			.. "{{CR}}",
		queueDesc = "多倍饰品",
		wisp = "{{ColorYellow}}中环 x1: {{CR}}#被摧毁时生成一个 饰品",
	},
	[wakaba.Enums.Collectibles.SYRUP] = {
		itemName = "糖浆",
		description = ""
			.. "#!!! 持有时:"
			.. "#↓ {{Speed}} -10%速度"
			.. "#↑ {{Range}} +3攻击距离"
			.. "#↑ {{Damage}} +1.25攻击力"
			.. "#飞行"
			.. "#!!! 使用没有效果"
			.. "{{CR}}",
		queueDesc = "会飞的乌龟!",
	},
	[wakaba.Enums.Collectibles.PLASMA_BEAM] = {
		itemName = "电浆炮",
		description = ""
			.. "#↑ 所有攻击现在造成1.25倍的激光伤害"
			.. "#↑ 之前的激光伤害现在无视敌人的护甲"
			.. "{{CR}}",
		queueDesc = "高科技穿刺眼泪",
	},
	[wakaba.Enums.Collectibles.POWER_BOMB] = {
		itemName = "力量炸弹",
		description = ""
			.. "#制造一个巨大的爆炸，摧毁当前房间内的所有物体，打开所有门，伤害所有敌人"
			.. "#在爆炸消失时，将所有掉落物吸引到爆炸点"
			.. "{{CR}}",
		queueDesc = "复用巨型炸弹",
	},
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = {
		itemName = "岩浆之刃",
		description = ""
			.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON ONLY!{{CR}} REPORT TO DEV IF YOU FOUND THIS ITEM OUTSIDE FROM RGON" -- TODO
			.. "#{{Burning}} 在眼泪攻击时挥舞火焰之刃"
			.. "#{{DamageSmall}} 对非眼泪攻击的攻击力乘数+100%"
			.. "{{CR}}",
		queueDesc = "烧成灰烬!",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		itemName = "幻影斗篷",
		description = ""
			.. "#短时间内变得隐形"
			.. "#所有瞄准以撒的敌人在以撒隐形时会感到困惑"
			.. "#!!! 即使隐形也会受到伤害"
			.. "#移动或发射泪水会加快时间的消耗"
			.. "计时器只能通过移动或发射泪水来充能。充满后才能使用"
			.. "#隐形时可以打开挑战房间的门"
			.. "{{CR}}",
		queueDesc = "寂静无声",
		belial = "↑ {{Damage}} +25% 攻击力倍数，在隐身状态下使用",
	},
	[wakaba.Enums.Collectibles.RED_CORRUPTION] = {
		itemName = "红色侵蚀",
		description = "{{Collectible21}} 显示地图上的图标"
			.. "#除Boss房外的所有特殊房间都将变成红房版本"
			.. "#如果可能的话，进入新楼层有46%的机会在特殊房间附近生成新房间"
			.. "#{{Luck}} 29幸运是100%"
			.. "#!!! 一些房间可能通向 {{ErrorRoom}}错误房!"
			.. "{{CR}}",
		queueDesc = "受感染的指南针",
	},
	[wakaba.Enums.Collectibles.QUESTION_BLOCK] = {
		itemName = "问号方块",
		description = ""
			.. "#{{WakabaModRgon}} {{ColorOrange}}REPENTOGON ONLY!{{CR}} REPORT TO DEV IF YOU FOUND THIS ITEM OUTSIDE FROM RGON" -- TODO
			.. "{{CR}}",
		queueDesc = "盒子里是什么?",
	},
	[wakaba.Enums.Collectibles.CLENSING_FOAM] = {
		itemName = "清洁泡沫",
		description = ""
			.. "#{{Poison}} 使周围的小范围内敌人中毒"
			.. "#周围的小范围内移除敌人的变体属性"
			.. "{{CR}}",
		queueDesc = "一扫而光",
	},
	[wakaba.Enums.Collectibles.BEETLEJUICE] = {
		itemName = "哗鬼家族",
		description = "{{Pill}} 识别所有药丸"
			.. "#{{Pill}} 使用时，随机化当前游戏中的6种药丸效果，并生成其中一种改变的药丸"
			.. "#{{Pill}} 在清理房间时可以生成额外的药丸"
			.. "{{CR}}",
		queueDesc = "更新药丸的内在",
	},
	[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] = {
		itemName = "塔之诅咒2",
		description = ""
			.. "#{{GoldenBomb}} 无限炸弹"
			.. "#到伤害时，在房间周围生成6个金色的巨魔炸弹"
			.. "#!!! 小心：所有的巨魔炸弹都会尽可能地转化为金色的巨魔炸弹"
			.. "{{CR}}",
		queueDesc = "拥抱混乱",
	},
	[wakaba.Enums.Collectibles.ANTI_BALANCE] = {
		itemName = "不平衡",
		description = ""
			.. "#{{Pill}} 所有药丸变成大药丸"
			.. "{{CR}}",
		queueDesc = "不再适量",
	},
	[wakaba.Enums.Collectibles.VENOM_INCANTATION] = {
		itemName = "毒液咒文",
		description = ""
			.. "#↑ {{Damage}} +1攻击力"
			.. "#{{Poison}} 中毒/燃烧伤害有5%的几率立即杀死普通敌人#{{Blank}} (对非主线boss的几率为1.36%)"
			.. "{{CR}}",
		queueDesc = "无法逃脱",
	},
	[wakaba.Enums.Collectibles.FIREFLY_LIGHTER] = {
		itemName = "萤火虫提灯",
		description = ""
			.. "#↑ {{Range}} +2攻击距离"
			.. "#↑ {{Luck}} +1 幸运"
			.. "#{{WakabaAntiCurseDarkness}} 免疫黑暗诅咒"
			.. "#通过奖励板可以为陷阱生成清理房间的奖励"
			.. "{{CR}}",
		queueDesc = "仙子们的帮助",
	},
	[wakaba.Enums.Collectibles.DOUBLE_INVADER] = {
		itemName = "双重入侵者",
		description = ""
			.. "#↓ 恶魔/天使房不再出现"
			.. "#↑ {{Damage}} +250% 攻击倍率#{{Blank}} （每多一层增加100%)"
			.. "{{CR}}",
		queueDesc = "伤害很高，但代价是什么?",
	},
	[wakaba.Enums.Collectibles.SEE_DES_BISCHOFS] = {
		itemName = "主教之海",
		description = ""
			.. "#{{Collectible584}} 每四个房间生成一个美德之书的灵火"
			.. "#{{Player" .. wakaba.Enums.Players.TSUKASA_B .. "}} 死亡后重生为里司"
			.. "{{CR}}",
		queueDesc = "悲剧的开始",
	},
	[wakaba.Enums.Collectibles.JAR_OF_CLOVER] = {
		itemName = "四叶草罐",
		description = ""
			.. "#↑ {{Luck}} 每一分钟游戏时间增加0.25运气"
			.. "#{{Player" .. wakaba.Enums.Players.WAKABA .. "}} 死亡后重生为若叶"
			.. "{{CR}}",
		queueDesc = "等待她的降生",
	},
	[wakaba.Enums.Collectibles.CRISIS_BOOST] = {
		itemName = "危机提升",
		description = ""
			.. "#↑ {{Damage}}血量越低，攻击力乘数越高（最高+45%）"
			.. "#!!! {{HolyMantle}} 神圣斗篷防御也算血量"
			.. "#↑ {{Tears}} +1射速修正"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Damage}}血量越低，攻击力乘数越高（最高+16%）"
			.. "#!!! {{HolyMantle}} 神圣斗篷防御也算血量"
			.. "#↑ {{Tears}} +1射速修正"
			.. "{{CR}}",
		queueDesc = "更少的血量，更多的力量",
	},
	[wakaba.Enums.Collectibles.PRESTIGE_PASS] = {
		itemName = "声望通行证",
		description = ""
			.. "#{{BossRoom}} 在击败Boss房间后生成璃贝的ROLL机"
			..
			"# {{DevilRoom}}恶魔/{{AngelRoom}}天使房, {{Planetarium}}星象房, {{SecretRoom}}隐藏/{{UltraSecretRoom}}红隐,黑市也会生成"
			.. "#璃贝的ROLL机可以用炸弹或支付5{{Coin}}来重置，但重置两次后会损坏"
			.. "{{CR}}",
		lunatic = ""
			.. "#{{BossRoom}} 在击败Boss房间后生成璃贝的ROLL机"
			..
			"# {{DevilRoom}}恶魔/{{AngelRoom}}天使房, {{Planetarium}}星象房, {{SecretRoom}}隐藏/{{UltraSecretRoom}}红隐,黑市也会生成"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}璃贝的ROLL机可以用炸弹或支付5{{Coin}}来重置，但重置两1后会损坏" -- TODO
			.. "{{CR}}",
		queueDesc = "璃贝酱的魔法",
	},
	[wakaba.Enums.Collectibles.BUNNY_PARFAIT] = {
		itemName = "兔子芭菲",
		description = ""
			.. "#!!!  根据房间号的最后一位给予不同的泪水效果.:"
			.. "#0/5 : {{Collectible3}}"
			.. "#{{Blank}} 1/6 : {{Collectible224}}"
			.. "#{{Blank}} 2/7 : {{Collectible618}}"
			.. "#{{Blank}} 3/8 : {{Collectible374}}"
			.. "#{{Blank}} 4/9 : {{Collectible494}}"
			.. "#{{Player" .. wakaba.Enums.Players.RIRA .. "}} 死后复活为莉良"
			.. "{{CR}}",
		queueDesc = "神秘配方",
	},
	[wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		itemName = "焦糖煎饼",
		description = ""
			.. "#↑ {{Damage}} +1 伤害"
			.. "#↑ {{Luck}} +1 幸运"
			.. "#根据Isaac的武器为生成苍蝇"
			.. "#{wakaba_cp1}" -- do not translate this
			.. "#{{Player" .. wakaba.Enums.Players.RICHER .. "}} 死亡后重生为璃贝"
			.. "{{CR}}",
		queueDesc = "被遗忘的朗诵",
	},
	[wakaba.Enums.Collectibles.EASTER_EGG] = {
		itemName = "复活节彩蛋",
		description = ""
			.. "#环绕物，发射跟踪眼泪，每颗造成1点伤害"
			.. "#拾取复活节硬币会提高伤害和射速修正"
			.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.ONSEN_TOWEL] = {
		itemName = "酒店毛巾",
		description = ""
			.. "#↑ {{SoulHeart}} +1 魂心"
			.. "#{{HalfSoulHeart}} 每分钟45%恢复半魂心"
			.. "{{CR}}",
		lunatic = ""
			.. "#↑ {{SoulHeart}} +1 魂心"
			.. "#{{WakabaModLunatic}} {{ColorOrange}} {{HalfSoulHeart}}每分钟10%恢复半魂心"
			.. "{{CR}}",
		queueDesc = "再生 + 生命提升",
	},
	[wakaba.Enums.Collectibles.SUCCUBUS_BLANKET] = {
		itemName = "魅魔毯子",
		description = ""
			.. "#↑ {{BlackHeart}} +1 黑心"
			.. "#{{HalfBlackHeart}} 每分钟有45%的几率恢复半个黑心"
			.. "{{CR}}",
		queueDesc = "再生 + 生命提升",
	},
	[wakaba.Enums.Collectibles.RICHERS_UNIFORM] = {
		itemName = "璃贝的制服",
		description = ""
			.. "#不同的房间有不同的效果"
			.. "{{CR}}",
		queueDesc = "房间延展",
	},
	[wakaba.Enums.Collectibles.LIL_RICHER] = {
		itemName = "璃贝宝宝",
		description = ""
			.. "#发射追踪子弹"
			.. "#每一帧造成2点伤害"
			.. "#{{Battery}} 清理房间后储存额外的充能（最多12个）"
			.. "#自动消耗储存的能量为未充满的主动道具"
			.. "{{CR}}",
		lunatic = ""
			.. "#发射追踪子弹"
			.. "#每一帧造成2点伤害"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}清理房间后储存额外的充能（最多4个）"
			.. "#自动消耗储存的能量为未充满的主动道具"
			.. "{{CR}}",
		queueDesc = "我想要这个兔耳",
	},
	[wakaba.Enums.Collectibles.CUNNING_PAPER] = {
		itemName = "灵巧纸片",
		description = ""
			.. "#{{Card}} 每次使用触发一个随机的卡牌效果"
			.. "{{CR}}",
		queueDesc = "别作弊!",
	},
	[wakaba.Enums.Collectibles.TRIAL_STEW] = {
		itemName = "试炼炖汤",
		description =
		"!!! 激活时:#↑ {{Tears}}每层增加1射速修正#↑ {{Damage}}+100% 攻击倍率#↑ {{Damage}}每层增加25%额外攻击力#所有主动道具在清理房间后完全充能",
		queueDesc = "???",
	},
	[wakaba.Enums.Collectibles.SELF_BURNING] = {
		itemName = "自焚",
		description = "{{Burning}}使用时烧伤自己"
			..
			"#{{Burning}} 着火时，对除了弹幕以外的敌人伤害免疫，但每20秒流失半颗心#被弹幕击中会取消着火效果"
			.. "#献血机（或类似物品），或者献祭房正常工作"
			.. "#每层只能使用一次"
			.. "{{CR}}",
		queueDesc = "燃起来!",
	},
	[wakaba.Enums.Collectibles.POW_BLOCK] = {
		itemName = "POW方块",
		description = "对所有地面的敌人造成275点分裂伤害#{{Bomb}} 消耗2个炸弹",
		queueDesc = "摧毁地面",
	},
	[wakaba.Enums.Collectibles.MOD_BLOCK] = {
		itemName = "模块方块",
		description = "对所有漂浮的敌人造成333点分裂伤害#{{Bomb}} 消耗2个炸弹",
		queueDesc = "摧毁天空",
	},
	[wakaba.Enums.Collectibles.SECRET_DOOR] = {
		itemName = "秘密通道",
		description = "传送到初始房间"
			.. "#!!!在某些情况下可能会出现其他效果"
			.. "{{CR}}",
		lunatic = "传送到初始房间"
			.. "#{{WakabaModLunatic}} {{ColorOrange}}Other effects won't occur" -- TODO
			.. "{{CR}}",
		queueDesc = "紧急逃生",
	},
	[wakaba.Enums.Collectibles.RIRAS_BRA] = {
		itemName = "莉良的胸罩",
		description =
		"{{Collectible191}}在当前房间给予随机的泪水效果#带有状态效果的敌人在当前房间受到的伤害增加25%",
		queueDesc = "临时随机眼泪+挑剔口味",
	},
	[wakaba.Enums.Collectibles.RIRAS_COAT] = {
		itemName = "莉良的外套",
		description = "激活白色火焰效果",
		queueDesc = "别那样盯着我看，太尴尬了...",
	},
	[wakaba.Enums.Collectibles.RIRAS_SWIMSUIT] = {
		itemName = "莉良的泳衣",
		description =
		"??% 的几率发射能液化敌人的泪水#{{Luck}} 在?? 运气时有100% 的几率#液化的敌人会向随机方向发射泪水，死亡时掉落半个灵魂之心，对毒素/火焰的伤害减少，但对激光、爆炸和水的伤害增加",
		queueDesc = "H泪水射击",
	},
	[wakaba.Enums.Collectibles.RIRAS_BANDAGE] = {
		itemName = "莉良的绷带",
		description =
		"!!! 在楼层开始时:#{{Collectible486}} 激活6次受伤效果#{{Collectible479}} 熔炼饰品",
		queueDesc = "感受她的感觉",
	},
	------------ RIRA ITEMS START HERE ------------
	[wakaba.Enums.Collectibles.BLACK_BEAN_MOCHI] = {
		itemName = "黑豆麻糬",
		description =
		"10% 几率射击“压缩”敌人"
		.. "#{{Luck}}16幸运时100%触发"
		.. "#压缩敌人死亡后爆炸"
		.. "#压缩爆炸不会伤害艾萨克"
		.. "{{CR}}",
		lunatic =
		"10% 几率射击“压缩”敌人"
		.. "#{{Luck}}16幸运时100%触发"
		.. "#压缩敌人死亡后爆炸"
		.. "#压缩爆炸不会伤害艾萨克"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}Zip explosions no longer inherit Isaac's bomb synergies" -- TODO
		.. "{{CR}}",
		queueDesc = "浓缩的记忆",
	},
	[wakaba.Enums.Collectibles.SAKURA_MONT_BLANC] = {
		itemName = "樱花蒙布朗",
		description =
		"在房间里杀死一个敌人:"
		.. "#↑ {{Damage}} +0.5 伤害"
		.. "#↑ {{Tears}} +1 射速"
		.. "#超过6次"
		.. "#被杀死的敌人使附近的敌人潮湿"
		.. "#潮湿的敌人受到红色粪便/火焰/燃烧/位移的伤害较小，但受到激光/爆炸/水伤害的伤害较大"
		.. "#水攻击可以击杀石头敌人"
		.. "{{CR}}",
		lunatic =
		"在房间里杀死一个敌人:"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Damage}} +0.25 伤害"
		.. "#{{WakabaModLunatic}} {{ColorOrange}}{{Tears}} +0.1 射速"
		.. "#超过6次"
		.. "#被杀死的敌人使附近的敌人潮湿"
		.. "#潮湿的敌人受到红色粪便/火焰/燃烧/位移的伤害较小，但受到激光/爆炸/水伤害的伤害较大"
		.. "#水攻击可以击杀石头敌人"
		.. "{{CR}}",
		queueDesc = "潮湿费洛蒙",
	},
	[wakaba.Enums.Collectibles.KANAE_LENS] = {
		itemName = "透镜",
		description = "↑ {{Damage}} x1.65 伤害倍率#左眼流泪",
		lunatic = "{{WakabaModLunatic}} {{ColorOrange}}{{Damage}} x1.15 伤害倍率#左眼流泪",
		queueDesc = "守护者之眼",
	},
	[wakaba.Enums.Collectibles.RIRAS_BENTO] = {
		itemName = "莉良的便当",
		description =
			"↑ {{Heart}} +1 心之容器#{{Heart}}治疗一红心#↑ {{Speed}} +0.02 速度#↑ {{Tears}} +0.2 射速修正#↑ {{Damage}} +0.1 伤害 {{HalfHeart}}在每次受到半红心伤害时#↑ {{Damage}} +4% 伤害倍率#↑ {{Range}} +0.25 射程#↑ {{Luck}} +0.2 幸运#!!! 所有的道具都会变成 {{Collectible" ..
			wakaba.Enums.Collectibles.RIRAS_BENTO .. "}}莉良的便当",
		queueDesc = "超级面筋",
	},
	[wakaba.Enums.Collectibles.SAKURA_CAPSULE] = {
		itemName = "樱花胶囊",
		description = ""
			.. "#↑ +1 额外生命"
			.. "#{{Collectible127}} 在死亡时以4个{{Heart}} 重生 并重启动整个楼层"
			.. "#!!! 不会每层恢复:"
			.. "#补充额外生命"
			.. "#每种掉落物类型产生1个"
			.. "{{CR}}",
		queueDesc = "褪色的记忆",
	},
	[wakaba.Enums.Collectibles.CHEWY_ROLLY_CAKE] = {
		itemName = "瑞士卷",
		description = "!!! 受伤后:"
			.. "#↑ {{Speed}} +0.3 速度在此房间"
			.. "#清除附近的子弹"
			.. "#{{Slow}} 永久减缓房间内所有敌人的速度"
			.. "{{CR}}",
		queueDesc = "回旋风味",
	},
	[wakaba.Enums.Collectibles.LIL_RIRA] = {
		itemName = "莉良宝宝",
		description = ""
			.. "#追踪眼泪"
			.. "#每一帧造成2点伤害"
			.. "#↓ {{Battery}}{{BlinkYellowRed}}偷取充能{{CR}}"
			.. "#↑ {{Damage}} +0.05 伤害每次偷取充能"
			.. "{{CR}}",
		queueDesc = "红丝带",
	},
	[wakaba.Enums.Collectibles.MAID_DUET] = {
		itemName = "女仆组合",
		description = ""
			.. "#按下 {wakaba_md1} 可将当前主动道具与副位主动位置进行切换"
			.. "#如果副主动为空，将插入"
			.. "#每个房间只能交换一次"
			.. "#!!! 某些主动无法放入副位"
			.. "{{CR}}",
		queueDesc = "左右横跳",
	},
	[wakaba.Enums.Collectibles.RICHERS_BRA] = {
		itemName = "璃贝的胸罩",
		description = "↑ 所有受到的伤害都不会有惩罚"
			.. "#自动激活银色按钮"
			.. "{{CR}}",
		queueDesc = "软软香香",
	},
	[wakaba.Enums.Collectibles.RIRAS_UNIFORM] = {
		itemName = "莉良的制服",
		description = "{{Timer}} 使用时:"
			.. "#时停2秒"
			.. "#大幅提高移动速度和射速2秒"
			.. "{{CR}}",
		queueDesc = "脸颊绯红",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE] = {
		itemName = "振幅书",
		description = "{{ArrowGrayRight}} 持有时触发一个效果:"
			.. "#↑ {{Damage}}伤害+2"
			.. "#↑ {{Tears}}射速+1"
			.. "#↑ {{Range}}速度+ 0.15"
			.. "#↑ {{Luck}}运气+2"
			.. "#在使用时，或进入新房间时分别更改为下一个效果"
			.. "#伤害>眼泪>范围>运气>伤害(这样循环)"
			.. "{{CR}}",
		queueDesc = "Reusable Amplifier",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		itemName = "若叶的双重梦境",
		description = ""
			.. "#↓ 恶魔/天使房不再出现"
			.. "#使用时，改变若叶的梦境的形式"
			.. "#如果出现可收集物品，将会从若叶的梦境的池子中选择，而不是默认的池子"
			.. "#{{Card" ..
			wakaba.Enums.Cards.CARD_DREAM_CARD .. "}} 在清理房间后有8% 的几率生成若叶的梦境卡"
			.. "{{CR}}",
		queueDesc = "永恒梦境...",
		belial = "↑ +4% 的的概率掉落{{Card" .. wakaba.Enums.Cards.CARD_DREAM_CARD .. "}}若叶拥有时。当使用物品时，没有额外的效果",
	},
	[wakaba.Enums.Collectibles.EDEN_STICKY_NOTE] = {
		itemName = "伊甸的便利贴",
		description = ""
			.. "#!!! 一次性使用"
			.. "#使用时，给予长子权"
			.. "#将当前的主动道具移动到口袋栏"
			.. "#口袋栏的主动道具不会在受击时被重置"
			.. "{{CR}}",
		queueDesc = "三思而后行...",
	},
}

wakaba.descriptions[desclang].abyss = {
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		description =
		"比普通蝗虫快7倍，伤害是玩家的2倍，穿过敌人追击，死亡时冻结"
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
		description = "伤害是玩家的5倍"
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		description = "比普通蝗虫快3.5倍，伤害是玩家的3倍，速度是2倍"
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description = "比普通蝗虫快3.5倍，伤害是玩家的2倍，速度是2倍"
	},
	[wakaba.Enums.Collectibles.D_CUP_ICECREAM] = {
		description = "比普通蝗虫快1.2倍，伤害是玩家的2倍"
	},
	[wakaba.Enums.Collectibles.MYSTERIOUS_GAME_CD] = {
		description = "比普通蝗虫快1.7倍，伤害是玩家的2倍"
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		description = "3只蝗虫，比普通蝗虫快1.7倍"
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		description =
		"2只黄色蝗虫，比普通蝗虫快7倍，伤害是玩家的0.8倍，造成伤害时掉落硬币"
	},
	[wakaba.Enums.Collectibles.PLUMY] = {
		description = "大可爱蝗虫比普通蝗虫快2.3倍，伤害是玩家的4倍"
	},
	[wakaba.Enums.Collectibles.EXECUTIONER] = {
		description = "比普通蝗虫'慢'4.2倍，伤害是玩家的16倍，速度是0.1倍"
	},
	[wakaba.Enums.Collectibles.UNIFORM] = {
		description = "5只蝗虫，比普通蝗虫快2.3倍，被蝗虫杀死时掉落卡牌"
	},
	[wakaba.Enums.Collectibles.LIL_WAKABA] = {
		description = "比普通蝗虫快1.3倍，速度是3倍"
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description = "3只蝗虫，比普通蝗虫快7倍，伤害是玩家的0.9倍，速度是3倍"
	},

}
wakaba.descriptions[desclang].bookofshiori = {
	[CollectibleType.COLLECTIBLE_BIBLE] = {
		description =
		"赋予汐宫 {{Damage}} 1.2x攻击力倍率，并在当前房间给予神圣斗篷({{Collectible313}})护盾#{{ColorBookofShiori}}在下次使用书籍之前，发射神性之泪({{Collectible331}})",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] = {
		description =
		"在当前房间增加额外的 {{Damage}} +1.5攻击力加成#{{ColorBookofShiori}}在下次使用书籍之前，发射贝利亚之眼泪({{Collectible462}})",
	},
	[CollectibleType.COLLECTIBLE_NECRONOMICON] = {
		description =
		"生成 5 个虚空之口激光，每一跳造成汐宫的攻击力的 64% 的伤害#{{ColorBookofShiori}}在下次使用书籍之前，发射岩石泪({{Collectible592}})",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS] = {
		description =
		"没有额外的临时效果#{{ColorBookofShiori}}在下次使用书籍之前，发射护盾泪({{Collectible213}})",
	},
	[CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK] = {
		description =
		"巨魔炸弹和爆炸对敌人造成双倍伤害，在当前房间#{{ColorBookofShiori}}在下次使用书籍之前，发射爆炸泪，并且汐宫对爆炸免疫",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS] = {
		description =
		"在当前楼层生成 2 个小天启骑士#{{ColorBookofShiori}}在下次使用书籍之前，有几率发射圣光泪({{Collectible374}})",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SIN] = {
		description =
		"没有额外的临时效果#{{ColorBookofShiori}}在下次使用书籍之前，杀死敌人时有几率掉落一个随机物品",
	},
	[CollectibleType.COLLECTIBLE_MONSTER_MANUAL] = {
		description = "没有额外的临时效果#↑ {{ColorBookofShiori}}在下次使用书籍之前，宝宝造成 3x攻击力",
	},
	[CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] = {
		description =
		"在当前房间赋予幽灵和无限泪({{Collectible369}})#{{ColorBookofShiori}}在下次使用书籍之前，发射追踪和电击泪({{Collectible494}})",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS] = {
		description =
		"完全揭示地图并移除{{WakabaAntiCurseDarkness}}黑暗诅咒和{{WakabaAntiCurseLost}}迷失诅咒#{{ColorBookofShiori}}在下次使用书籍之前，发射印记泪({{Collectible618}})",
	},
	[CollectibleType.COLLECTIBLE_SATANIC_BIBLE] = {
		description =
		"在当前楼层增加额外的 {{Damage}} +1.0攻击力加成#{{ColorBookofShiori}}在下次使用书籍之前，发射黑暗物质泪({{Collectible259}})",
	},
	[CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD] = {
		description =
		"生成额外的友好的骨头人#{{ColorBookofShiori}}在下次使用书籍之前，发射死亡之触泪({{Collectible237}})",
	},
	[CollectibleType.COLLECTIBLE_LEMEGETON] = {
		description =
		"有几率吸收随机的灵火到道具中#{{ColorBookofShiori}}在下次使用书籍之前，杀死敌人时有几率恢复道具的灵火",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_CONQUEST] = {
		description =
		"选择敌人永久魅惑#{{ColorBookofShiori}}需要钥匙{{Key}} (+ 炸弹{{Bomb}} 对于boss)来魅惑",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN] = {
		description =
		"没有额外的临时效果#{{ColorBookofShiori}}在下次使用书籍之前，发射骨头泪({{Collectible453}})",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_FOCUS] = {
		description =
		"不移动时无视敌人的护甲#{{ColorBookofShiori}}重置当前的汐宫之书泪珠加成",
	},
	[wakaba.Enums.Collectibles.DECK_OF_RUNES] = {
		description =
		"没有额外的临时效果#{{Rune}} {{ColorBookofShiori}}在下次使用书籍之前，杀死敌人时有几率掉落一个符文",
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		description =
		"Minissac 承受的伤害大幅度降低#{{ColorBookofShiori}}在下次使用书籍之前，Minissac 复制以撒的大部分泪珠效果",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		description =
		"阻止所有敌人的弹幕额外 2 秒#{{ColorBookofShiori}}重置当前的汐宫之书泪珠加成",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		description =
		"没有额外的临时效果 #{{Collectible579}} {{ColorBookofShiori}}赋予临时的黑暗灵剑。镰刀泪珠会代替剑的弹射物发射",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		description =
		"所有瞄准以撒的敌人也会在以撒隐身时减速.#{{ColorBookofShiori}}(当前的汐宫之书泪珠加成没有变化)",
	},
}
wakaba.descriptions[desclang].epiphany_golden = {
	[wakaba.Enums.Collectibles.D6_CHAOS] = {
		isReplace = true,
		description = ""
			.. "#{{Card" .. Card.CARD_SOUL_ISAAC .. "}} 为 {{ColorGold}}4 次{{CR}}触发以撒之魂的效果"
			.. "#重置的物品以 {{ColorGold}}中等{{CR}}速度循环"
			.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.SYRUP] = {
		isReplace = true,
		description = ""
			.. "#!!! 持有时:"
			.. "#↑ {{Speed}} {{ColorGold}}+10%{{CR}}速度"
			.. "#↑ {{Range}} +{{ColorGold}}6{{CR}}攻击距离"
			.. "#↑ {{Damage}} +{{ColorGold}}3{{CR}}攻击力"
			.. "#飞行, {{ColorGold}}穿透泪{{CR}}"
			.. "#!!! 使用没有效果"
	},
	[wakaba.Enums.Collectibles.EATHEART] = {
		isReplace = false,
		description = "{{ColorGold}}充能速度加倍",
	},
	[wakaba.Enums.Collectibles.GRIMREAPER_DEFENDER] = {
		isReplace = false,
		description = "{{Card14}} {{ColorGold}}同时对所有敌人造成 40 点伤害",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_TRAUMA] = {
		isReplace = true,
		description = ""
			.. "#引爆屏幕上当前的以撒的泪珠，使每一个泪珠爆炸 (最多 15 个)"
			.. "#爆炸的泪珠 {{ColorGold}}造成超级炸弹的爆炸"
			.. "{{CR}}",
	},

	[wakaba.Enums.Collectibles.BOOK_OF_THE_FALLEN] = {
		isReplace = true,
		description = ""
			.. "#{{ColorGold}}使用时，生成 11 个饥饿的灵魂，造成以撒的攻击力的伤害"
			.. "#如果受到致命伤害时持有，以撒变成堕落天使，并获得 6 个黑心"
			.. "#!!! {{ColorSilver}}在以撒变成堕落天使后:"
			.. "#{{ColorGold}}复活后仍然可以射击泪珠"
			.. "#↑ {{Damage}} {{ColorGold}}+100% 攻击倍率"
			.. "#!!! {{ColorYellow}}以撒不能再更换主动道具{{ColorReset}}"
			.. "{{CR}}",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_SILENCE] = {
		isReplace = false,
		description = "{{ColorGold}}每消除一个弹幕，就获得 {{Tears}}小幅度的射速修正加成，这个加成会慢慢消失",
	},
	[wakaba.Enums.Collectibles.BEETLEJUICE] = {
		isReplace = false,
		description = "{{ColorGold}}生成金色药丸代替",
	},
	[wakaba.Enums.Collectibles.POWER_BOMB] = {
		isReplace = false,
		description =
		"{{ColorGold}}将房间变成金色，伤害翻倍，并使所有的掉落物不再有选项",
	},
	[wakaba.Enums.Collectibles.PHANTOM_CLOAK] = {
		isReplace = false,
		description = "{{ColorGold}}也可以打开与任务相关的门",
	},

	[wakaba.Enums.Collectibles.FLASH_SHIFT] = {
		isReplace = false,
		description = "{{ColorGold}}在移动时，{{Collectible202}}触碰敌人会将他们变成金色",
	},
	[wakaba.Enums.Collectibles._3D_PRINTER] = {
		isReplace = false,
		description = "{{ColorGold}}熔化的饰品都是金色的",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		isReplace = false,
		description = "{{ColorGold}}生成金色的凝块代替",
	},
	[wakaba.Enums.Collectibles.BALANCE] = {
		isReplace = false,
		description = "{{Collectible555}} {{ColorGold}}如果花费硬币，就在当前房间获得 +1.2 攻击力加成",
	},
	[wakaba.Enums.Collectibles.RICHERS_FLIPPER] = {
		isReplace = false,
		description = "{{ColorGold}}将道具基座转换成金色的变体",
	},
	[wakaba.Enums.Collectibles.DOUBLE_DREAMS] = {
		isReplace = false,
		description = "{{ColorGold}}阻止品质{{Quality0}}的物品生成",
	},

}

wakaba.descriptions[desclang].trinkets = {
	[wakaba.Enums.Trinkets.BRING_ME_THERE] = {
		itemName = "带我走",
		description = ""
			.. "#↑ {{Tears}} +1.5射速修正"
			..
			"#拿着这个小饰品进入马腿层的Boss房，让爸爸的纸条代替妈妈出现"
			.. "{{CR}}",
		queueDesc = "别忘了!",
	},
	[wakaba.Enums.Trinkets.BITCOIN] = {
		itemName = "比特币 II",
		description = ""
			.. "#随机化掉落物数量和属性"
			.. "#掉落物的范围可以从0到999"
			.. "#!!! 掉下时就会消失!"
			.. "#!!! 不再随机吞下饰品"
			.. "{{CR}}",
		queueDesc = "真正的赌博",
	},
	[wakaba.Enums.Trinkets.CLOVER] = {
		itemName = "四叶草",
		description = ""
			.. "#↑ {{Tears}} +0.3 射速修正"
			.. "#↑ {{Luck}} +2 幸运"
			.. "#↑ {{Luck}} +100% 幸运倍率"
			.. "#↑ 幸运属性总是正数"
			.. "#↑ 增加幸运硬币的出现几率"
			.. "{{CR}}",
		queueDesc = "你感觉很幸运",
	},
	[wakaba.Enums.Trinkets.MAGNET_HEAVEN] = {
		itemName = "磁铁天堂",
		description = ""
			.. "#立即将炸弹，钥匙，和硬币传送到以撒身边"
			.. "#将粘性镍币转换为普通镍币"
			.. "{{CR}}",
		queueDesc = "梦想的时刻",
	},
	[wakaba.Enums.Trinkets.HARD_BOOK] = {
		itemName = "硬化书",
		description = ""
			.. "#被击中时有机会掉落随机的书道具"
			.. "#{{SacrificeRoom}} 在献祭房有100%的机会掉落一本书"
			.. "#!!! 当道具掉落时，饰品会消失"
			.. "{{CR}}",
		queueDesc = "它很脆弱...",
	},
	[wakaba.Enums.Trinkets.DETERMINATION_RIBBON] = {
		itemName = "决心丝带",
		description = ""
			.. "#受到的所有伤害都会减少到半颗心"
			.. "#只要持有饰品，就不会死亡。"
			.. "#!!! {{ColorYellow}}饰品的效果在献祭房的尖刺上不起作用！{{ColorReset}}"
			.. "#!!! 受到攻击时有2%的几率掉落饰品"
			.. "{{CR}}",
		queueDesc = "保持决心!",
	},
	[wakaba.Enums.Trinkets.BOOKMARK_BAG] = {
		itemName = "书签袋",
		description = ""
			.. "#当进入新房间时，给予随机的一次性使用的书籍物品"
			.. "#包含的书籍和汐宫在'所有书籍'模式下的初始书籍相同"
			.. "{{CR}}",
		queueDesc = "它似乎被打乱了...",
	},
	[wakaba.Enums.Trinkets.RING_OF_JUPITER] = {
		itemName = "木星之戒",
		description = ""
			.. "#对所有玩家有效:"
			.. "#↑ {{Tears}} -20% 射速"
			.. "#↑ {{Speed}} +10%速度"
			.. "#↑ {{Damage}} +16%攻击力"
			.. "#↑ {{Shotspeed}} +5% 弹速"
			.. "#↑ {{Luck}} +1 幸运"
			.. "{{CR}}",
		queueDesc = "我们合而为一",
	},
	[wakaba.Enums.Trinkets.DIMENSION_CUTTER] = {
		itemName = "维度切割器",
		description = ""
			.. "#{{Collectible510}} 进入未清理的房间时有15%的几率生成随机的百变怪boss"
			.. "#{{GreedMode}} 贪婪模式下有5%的几率，{{Luck}}幸运值超过10时最高可达25%"
			.. "#↑ {{Card" .. Card.CARD_CHAOS .. "}}混沌卡可以对百变怪和三眼霍恩造成伤害（每次339点）"
			.. "{{CR}}",
		queueDesc = "无效记忆",
	},
	[wakaba.Enums.Trinkets.DELIMITER] = {
		itemName = "分隔符",
		description = ""
			.. "#!!! 进入新房间时："
			.. "#摧毁宝藏石和愚人金"
			.. "#将柱子，金属块，尖刺岩石变成普通岩石"
			.. "{{CR}}",
		queueDesc = "较弱的岩石",
	},
	[wakaba.Enums.Trinkets.RANGE_OS] = {
		itemName = "火控系统",
		description = ""
			.. "#↓ {{Range}} -60% 攻击距离倍率"
			.. "#↑ {{Damage}} +125% 伤害倍率"
			.. "{{CR}}",
		queueDesc = "向他们深入",
	},
	[wakaba.Enums.Trinkets.SIREN_BADGE] = {
		itemName = "海妖徽章",
		description = ""
			.. "#防止接触伤害"
			.. "{{CR}}",
		queueDesc = "亲吻无罪",
	},
	[wakaba.Enums.Trinkets.ISAAC_CARTRIDGE] = {
		itemName = "以撒游戏卡",
		description = ""
			.. "#只会生成游戏本体的道具"
			.. "#{{Collectible619}}长子权，修改后的物品也会出现"
			.. "{{CR}}",
		queueDesc = "只有重生",
	},
	[wakaba.Enums.Trinkets.AFTERBIRTH_CARTRIDGE] = {
		itemName = "胎衣游戏卡",
		description = ""
			.. "#只会生成AB/AB+ DLC 的道具"
			.. "#{{Collectible619}}长子权会出现"
			.. "{{CR}}",
		queueDesc = "只有胎衣",
	},
	[wakaba.Enums.Trinkets.REPENTANCE_CARTRIDGE] = {
		itemName = "忏悔游戏卡",
		description = ""
			.. "#只会生成忏悔 DLC 的道具"
			.. "{{CR}}",
		queueDesc = "只有忏悔",
	},
	[wakaba.Enums.Trinkets.STAR_REVERSAL] = {
		itemName = "星星逆转",
		description = ""
			.. "#在{{TreasureRoom}}道具房里丢弃饰品可以将其换成{{Planetarium}}星象房道具"
			.. "#吞下后也有效"
			.. "{{CR}}",
		queueDesc = "带到道具房",
	},
	[wakaba.Enums.Trinkets.AURORA_GEM] = {
		itemName = "极光宝石",
		description = ""
			.. "#增加复活节硬币的出现几率"
			.. "{{CR}}",
		queueDesc = "它在发光",
	},
	[wakaba.Enums.Trinkets.MISTAKE] = {
		itemName = "错误",
		description = ""
			.. "#受到伤害时会在随机敌人身上引发爆炸。"
			.. "{{CR}}",
		queueDesc = "即使是璃贝也不完美",
	},
	[wakaba.Enums.Trinkets.KUROMI_CARD] = {
		itemName = "库洛米卡",
		description = ""
			.. "#使用主动道具不会消耗其充能或道具。#!!! 使用后有90%的几率移除饰品！"
			.. "{{CR}}",
		queueDesc = "她为我们做的",
	},

	[wakaba.Enums.Trinkets.ETERNITY_COOKIE] = {
		itemName = "永恒饼干",
		description = ""
			.. "#有时间限制的物品不再消失"
			.. "{{CR}}",
		queueDesc = "持久的基础",
	},
	[wakaba.Enums.Trinkets.REPORT_CARD] = {
		itemName = "璃贝的成绩单",
		description = ""
			.. "#↑ {{Luck}} +5 幸运"
			.. "#↓ 受到伤害会减少 {{Luck}} -0.5 幸运（不会低于最小值）"
			.. "#降低的幸运会在新的楼层恢复"
			.. "{{CR}}",
		queueDesc = "更少的失误，更少的处罚",
	},
	[wakaba.Enums.Trinkets.RABBIT_PILLOW] = {
		itemName = "兔子枕头 ",
		description = ""
			.. "允许在白火状态下使用献血机."
			.. "{{CR}}",
		queueDesc = "柔软舒心",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_RICHER] = { -- TODO
		itemName = "Candy of Richer",
		description = ""
		.. "Entering a hostile room spawns 2 attack flies"
		.. "#The fly deals 4x Isaac's damage"
		.. "{{CR}}",
		queueDesc = "I bring harmony",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_RIRA] = { -- TODO
		itemName = "Candy of Rira",
		description = ""
		.. "Entering a hostile room spawns 2 attack flies"
		.. "#The fly deals 4x Isaac's aqua damage"
		.. "{{CR}}",
		queueDesc = "I bring aqua",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_CIEL] = { -- TODO
		itemName = "Candy of Ciel",
		description = ""
		.. "Entering a hostile room spawns an exploding attack fly"
		.. "#The fly deals 10x Isaac's explosive damage"
		.. "{{CR}}",
		queueDesc = "I bring star",
	},
	[wakaba.Enums.Trinkets.CANDY_OF_KORON] = { -- TODO
		itemName = "Candy of Koron",
		description = ""
		.. "Entering a hostile room spawns 2 attack flies"
		.. "#The fly deals 4x Isaac's freezing damage"
		.. "{{CR}}",
		queueDesc = "I bring ice",
	},
	[wakaba.Enums.Trinkets.SIGIL_OF_KAGUYA] = {
		itemName = "辉夜的叹息",
		description = ""
			.. "{{Collectible160}} 每15秒有16%的几率触发撕裂苍穹效果"
			.. "#{{Luck}} 在34幸运时100%触发"
			.. "#已清空的房间将延迟触发"
			.. "{{CR}}",
	},

}
wakaba.descriptions[desclang].goldtrinkets = {
	[wakaba.Enums.Trinkets.CLOVER] = { "↑ 进一步增加幸运硬币的出现几率" },
	[wakaba.Enums.Trinkets.HARD_BOOK] = { "掉落随机的书", "掉落两本书" },
	[wakaba.Enums.Trinkets.STAR_REVERSAL] = { "{{Planetarium}}星象房道具", "2个{{Planetarium}}星象房道具" },
	[wakaba.Enums.Trinkets.ETERNITY_COOKIE] = { "↑ 移除所有掉落物的选择" },
	[wakaba.Enums.Trinkets.MAGNET_HEAVEN] = { "{{Magnetize}} 使所有敌人在进入新房间时被磁化5秒" },
	[wakaba.Enums.Trinkets.CANDY_OF_RICHER] = { "2 attack flies", "3 attack flies", "4 attack flies" }, -- TODO
	[wakaba.Enums.Trinkets.CANDY_OF_RIRA] = { "2 attack flies", "3 attack flies", "4 attack flies" },
	[wakaba.Enums.Trinkets.CANDY_OF_CIEL] = { "an exploding attack fly", "2 exploding attack flies", "3 exploding attack flies" },
	[wakaba.Enums.Trinkets.CANDY_OF_KORON] = { "2 attack flies", "3 attack flies", "4 attack flies" },

}
wakaba.descriptions[desclang].cards = {
	[wakaba.Enums.Cards.CARD_CRANE_CARD] = {
		itemName = "娃娃机卡",
		description = "{{CraneGame}} 生成一个抓娃娃机",
		tarot = { "{{CraneGame}} 生成 {{ColorShinyPurple}}2{{CR}}抓娃娃机" },
		queueDesc = "抽卡!",
	},
	[wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD] = {
		itemName = "忏悔卡",
		description = "{{Confessional}} 生成一个忏悔室",
		tarot = { "{{Confessional}} 生成 {{ColorShinyPurple}}2{{CR}} 个忏悔室" },
		queueDesc = "忏悔",
	},
	[wakaba.Enums.Cards.CARD_BLACK_JOKER] = {
		itemName = "黑 Joker",
		description =
		"{{DevilChance}} 持有时,阻止天使房出现. #{{DevilRoom}} 使用时，传送到恶魔房",
		queueDesc = "你感到罪孽",
	},
	[wakaba.Enums.Cards.CARD_WHITE_JOKER] = {
		itemName = "白 Joker",
		description = "{{AngelChance}} 持有时, 阻止恶魔房出现. #{{AngelRoom}} 使用时，传送到天使房",
		queueDesc = "你感到圣洁",
	},
	[wakaba.Enums.Cards.CARD_COLOR_JOKER] = {
		itemName = "彩 Joker",
		description = "{{BrokenHeart}} 设置碎心数量到6 #生成3个道具8个卡牌/符文/魂石",
		queueDesc = "你不会想要的",
	},
	[wakaba.Enums.Cards.CARD_QUEEN_OF_SPADES] = {
		itemName = "黑桃皇后",
		description = "{{Key}} 生成3~26把钥匙",
		lunatic = "{{WakabaModLunatic}} {{ColorOrange}}{{Key}}生成1~6把钥匙",
		queueDesc = ";P",
	},
	[wakaba.Enums.Cards.CARD_DREAM_CARD] = {
		itemName = "若叶的梦幻卡",
		description = "生成一个随机的道具",
		queueDesc = "梦想成真",
	},
	[wakaba.Enums.Cards.CARD_UNKNOWN_BOOKMARK] = {
		itemName = "未知书签",
		description = "随机触发以下书籍效果其一:",
		tarot = "激活2个以下随机书籍效果",
		queueDesc = "无信息",
	},
	[wakaba.Enums.Cards.CARD_RETURN_TOKEN] = {
		itemName = "返回代币",
		description =
		"{{Collectible636}} 触发R键效果#将你带回新的游戏的第一层#物品，属性提升和掉落物保持不变#{{Timer}} 重置游戏计时器#移除的所有消耗品 {{ColorRed}}包括生命值{{CR}}",
		queueDesc = "历史重演",
	},
	[wakaba.Enums.Cards.CARD_MINERVA_TICKET] = {
		itemName = "密涅瓦 体验券",
		description = "{{Collectible" .. wakaba.Enums.Collectibles.MINERVA_AURA .. "}}在这个房间激活密涅瓦的领域",
		tarot = "触发两次",
		queueDesc = "女神审判",
	},
	[wakaba.Enums.Cards.SOUL_WAKABA] = {
		itemName = "若叶的魂石",
		description =
		"{{SoulHeart}} +1 魂心#{{AngelRoom}} 在当前层生成一个天使房#{{AngelRoom}} 如果无法生成,则生成一个交易道具",
		isrune = true,
		queueDesc = "祝福的意义",
	},
	[wakaba.Enums.Cards.SOUL_WAKABA2] = {
		itemName = "若叶?的魂石",
		description =
		"{{SoulHeart}} +1 魂心#{{DevilRoom}} 在当前层生成一个恶魔房#{{AngelRoom}} 如果无法生成,则生成一个交易道具",
		isrune = true,
		queueDesc = "无名的意义",
	},
	[wakaba.Enums.Cards.SOUL_SHIORI] = {
		itemName = "汐宫的魂石",
		description = "{{Heart}} 治愈2红心#激活汐宫书籍的随机眼泪效果",
		isrune = true,
		queueDesc = "循环你的命运",
	},
	[wakaba.Enums.Cards.SOUL_TSUKASA] = {
		itemName = "司的魂石",
		description =
		"在以撒的头上悬挂一把剑，它可以使所有的基座物品翻倍#不会使商店、箱子或恶魔交易的物品翻倍#{{Warning}} 受到任何伤害后，剑有几率移除以撒的一半物品，并在每一帧变成随机的角色e",
		isrune = true,
		queueDesc = "半衰期",
	},
	[wakaba.Enums.Cards.SOUL_RICHER] = {
		itemName = "璃贝魂石",
		description =
		"{{Collectible712}} 随机生成1-6个道具灵火 ({{Collectible263}} : 1 ~ 3)#灵火的品质至少是{{Quality2}}+",
		isrune = true,
		queueDesc = "魔法施放",
	},
	[wakaba.Enums.Cards.CARD_VALUT_RIFT] = {
		itemName = "裂缝宝库",
		description =
		"生成汐宫的裂缝#裂缝包含一个蓝色的道具,需要几个钥匙解锁.#低概率生成包含其他道具的随机裂缝",
		tarot = { "生成 {{ColorShinyPurple}}2{{CR}} 个汐宫的裂缝#裂缝包含一个蓝色的道具,需要几个钥匙解锁.#低概率生成包含其他道具的随机裂缝" },
		queueDesc = "汐宫的宝物",
	},
	[wakaba.Enums.Cards.CARD_TRIAL_STEW] = {
		itemName = "试炼炖汤",
		description =
		"移除所有心与神圣斗篷防御#增加8层效果:#↑ {{Tears}}+1 射速修正#↑ {{Damage}}+100% 攻击倍率#↑ {{Damage}}+25% 攻击力#主动道具满充能#清空房间减少一次效果.",
		tarot = { 8, 11 },
		queueDesc = "???",
	},
	[wakaba.Enums.Cards.CARD_RICHER_TICKET] = {
		itemName = "璃贝奖券",
		description = "{{Collectible" ..
			wakaba.Enums.Collectibles.SWEETS_CATALOG .. "}} 为当前房间授予随机组合道具",
		queueDesc = "午餐时间!",
	},
	[wakaba.Enums.Cards.CARD_RIRA_TICKET] = {
		itemName = "莉良奖券",
		description =
		"{{BrokenHeart}}将一颗碎心恢复为 {{EmptyBoneHeart}}或{{SoulHeart}}#{{Collectible479}} 吞下持有的饰品#{{Heart}}治愈一红心,如果没有碎心或饰品",
		tarot = { "{{BrokenHeart}}将一颗碎心恢复为 {{ColorShinyPurple}}({{EmptyBoneHeart}}或{{SoulHeart}}+{{Heart}})#{{Collectible479}} 吞下持有的饰品#{{Heart}} 治愈 {{ColorShinyPurple}}2{{CR}} 红心 如果没有碎心或饰品" },
		queueDesc = "H补丁",
	},
	[wakaba.Enums.Cards.CARD_FLIP] = { -- TODO
		itemName = "Flip Card",
		description = "{{Collectible711}} Holding, or using the card grants Flip effect#Entering a room with item pedestals displays a ghostly second item on the pedestals#Using the item flips the real and ghostly item",
		queueDesc = "Rira's Backside",
	},
}
wakaba.descriptions[desclang].pills = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = {
		itemName = "攻击倍率上升",
		description = "↑ {{Damage}} +8% 攻击倍率",
		mimiccharge = 12,
		class = "3+",
	},
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = {
		itemName = "攻击倍率下降",
		description = "↓ {{Damage}} -2% 攻击倍率",
		mimiccharge = 4,
		class = "3-",
	},
	[wakaba.Enums.Pills.ALL_STATS_UP] = {
		itemName = "全属性上升",
		description =
		"↑ {{Damage}} +0.25攻击力#↑ {{Tears}} +0.2 射速#↑ {{Speed}} +0.12速度#↑ {{Range}} +0.4攻击距离#↑ {{Shotspeed}} +0.04 弹速#↑ {{Luck}} +1 幸运#",
		mimiccharge = 8,
		class = "3+",
	},
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = {
		itemName = "全属性下降",
		description =
		"↓ {{Damage}} -0.1攻击力#↓ {{Tears}} -0.08 射速#↓ {{Speed}} -0.09速度#↓ {{Range}} -0.25攻击距离#↓ {{Shotspeed}} -0.03 弹速#↓ {{Luck}} -1 幸运#",
		mimiccharge = 4,
		class = "3-",
	},
	[wakaba.Enums.Pills.TROLLED] = {
		itemName = "鬼畜!",
		description = "{{ErrorRoom}} 传送到错误房#{{Collectible721}} 在???/家里生成故障物品",
		mimiccharge = 4,
		class = "3-",
	},
	[wakaba.Enums.Pills.TO_THE_START] = {
		itemName = "回到起点!",
		description = "传送到本层初始房间",
		mimiccharge = 2,
		class = "0+",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = {
		itemName = "喷射战士!",
		description = "在以撒的位置生成两个敌对硫磺漩涡",
		mimiccharge = 3,
		class = "2-",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT] = {
		itemName = "喷射战士?",
		description = "{{Collectible118}} 在当前房间获得硫磺火",
		mimiccharge = 6,
		class = "2+",
	},
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = {
		itemName = "社交距离",
		description = "关闭当前楼层的恶魔/天使房间",
		mimiccharge = 4,
		class = "2-",
	},
	[wakaba.Enums.Pills.DUALITY_ORDERS] = {
		itemName = "二元命令",
		description =
		"{{Collectible498}} 保证当前楼层同时出现恶魔和天使房间#进入其中一个会使另一个消失",
		mimiccharge = 6,
		class = "3+",
	},
	[wakaba.Enums.Pills.PRIEST_BLESSING] = {
		itemName = "Priest的祝福",
		description =
		"给予一层神圣斗篷#{{Card51}} 效果与神圣卡相同",
		mimiccharge = 4,
		class = "3+",
	},
	[wakaba.Enums.Pills.UNHOLY_CURSE] = {
		itemName = "不洁诅咒",
		description = "打破一层神圣斗篷#如果没有神圣斗篷，则无效",
		mimiccharge = 4,
		class = "3-",
	},
}
wakaba.descriptions[desclang].horsepills = {
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP] = {
		tostring(wakaba.Enums.Pills.DAMAGE_MULTIPLIER_UP),
		"攻击倍率 上升",
		"↑ {{Damage}} +16% 攻击倍率",
	},
	[wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN] = {
		tostring(wakaba.Enums.Pills.DAMAGE_MULTIPLIER_DOWN),
		"攻击倍率 下降",
		"↓ {{Damage}} -4% 攻击倍率",
	},
	[wakaba.Enums.Pills.ALL_STATS_UP] = {
		tostring(wakaba.Enums.Pills.ALL_STATS_UP),
		"全属性上升",
		"↑ {{Damage}} +0.5攻击力#↑ {{Tears}} +0.4 射速#↑ {{Speed}} +0.24速度#↑ {{Range}} +0.8攻击距离#↑ {{Shotspeed}} +0.08 弹速#↑ {{Luck}} +2 幸运#",
	},
	[wakaba.Enums.Pills.ALL_STATS_DOWN] = {
		tostring(wakaba.Enums.Pills.ALL_STATS_DOWN),
		"全属性下降",
		"↓ {{Damage}} -0.2攻击力#↓ {{Tears}} -0.16 射速#↓ {{Speed}} -0.18速度#↓ {{Range}} -0.5攻击距离#↓ {{Shotspeed}} -0.06 弹速#↓ {{Luck}} -2 幸运#",
	},
	[wakaba.Enums.Pills.TROLLED] = {
		tostring(wakaba.Enums.Pills.TROLLED),
		"鬼畜!",
		"{{ErrorRoom}} 传送到错误房#{{Collectible721}} 在???/家里生成故障物品#移除一个碎心",
	},
	[wakaba.Enums.Pills.TO_THE_START] = {
		tostring(wakaba.Enums.Pills.TO_THE_START),
		"回到起点!",
		"传送到本层初始房间#治愈一红心#移除一碎心",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2] = {
		tostring(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2),
		"喷射战士!",
		"在以撒的位置生成两个敌对硫磺漩涡#{{Collectible293}} 向四个方向射出硫磺火",
	},
	[wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT] = {
		tostring(wakaba.Enums.Pills.EXPLOSIVE_DIARRHEA_2_NOT),
		"喷射战士?",
		"{{Card88}}{{Collectible441}}连续喷射7.5秒巨型硫磺火",
	},
	[wakaba.Enums.Pills.SOCIAL_DISTANCE] = {
		tostring(wakaba.Enums.Pills.SOCIAL_DISTANCE),
		"社交距离",
		"关闭当前楼层的恶魔/天使房间#↓ {{AngelDevilChance}} 减少之后楼层恶魔/天使房的机会",
	},
	[wakaba.Enums.Pills.DUALITY_ORDERS] = {
		tostring(wakaba.Enums.Pills.DUALITY_ORDERS),
		"二元命令",
		"{{Collectible498}} 保证当前楼层同时出现恶魔和天使房间#进入其中一个会使另一个消失#房间内多产生一个道具#可以双拿",
	},
	[wakaba.Enums.Pills.PRIEST_BLESSING] = {
		tostring(wakaba.Enums.Pills.PRIEST_BLESSING),
		"Priest的祝福",
		"给予一层神圣斗篷#{{Card51}} 效果与神圣卡相同",
	},
	[wakaba.Enums.Pills.UNHOLY_CURSE] = {
		tostring(wakaba.Enums.Pills.UNHOLY_CURSE),
		"不洁诅咒",
		"打破二层神圣斗篷#如果没有神圣斗篷，则无效",
	},
}

wakaba.descriptions[desclang].sewnupgrade = {
	[wakaba.Enums.Familiars.LIL_WAKABA] = {
		super = ""
			.. "#给激光赋予追踪属性"
			.. "#造成 70%的伤害"
			.. "{{CR}}",
		ultra = ""
			.. "#即使没有国王宝宝也能自动瞄准敌人"
			.. "#造成100%的伤害"
			.. "{{CR}}",
		name = "小若叶",
	},
	[wakaba.Enums.Familiars.LIL_MOE] = {
		super = ""
			.. "#两种效果可以组合"
			.. "#造成150%的伤害"
			.. "{{CR}}",
		ultra = ""
			.. "#三种效果可以组合"
			.. "#造成200%的伤害"
			.. "{{CR}}",
		name = "小若叶",
	},
	[wakaba.Enums.Familiars.LIL_SHIVA] = {
		super = ""
			.. "#发射7个充能的波浪眼泪"
			.. "#造成你的150%的伤害"
			.. "{{CR}}",
		ultra = ""
			.. "#伤害x2"
			.. "#发射8个充能的波浪眼泪"
			.. "#击中第一个敌人后，眼泪造成双倍伤害并获得追踪效果"
			.. "{{CR}}",
		name = "小Shiva",
	},
	[wakaba.Enums.Familiars.PLUMY] = {
		super = ""
			.. "#允许射出玩家的眼泪"
			.. "#↑攻击力上升"
			.. "#↑ 减少恢复时间"
			.. "{{CR}}",
		ultra = ""
			.. "#↑ 眼泪和精准度上升"
			.. "#弹跳眼泪"
			.. "#↑ 减少恢复时间"
			.. "{{CR}}",
		name = "Plumy",
	},

}
wakaba.descriptions[desclang].uniform = {
	changeslot = "更换槽位",
	empty = "空",
	unknownpill = "未知药丸",
	use = "使用当前持有的{{Pill}}/{{Card}}/{{Rune}}会激活上面的所有物品",
	pushprefix = "使用这个物品会将持有的{{Pill}}/{{Card}}/{{Rune}}推入{{ColorGold}}槽位 ",
	pushsubfix = "{{CR}}",
	pullprefix = "使用这个物品会从{{ColorGold}}槽位 ",
	pullsubfix = "{{CR}}拉出{{Pill}}/{{Card}}/{{Rune}}",
	useprefix = "使用这个物品会交换{{ColorGold}}槽位 ",
	usesubfix = "{{CR}}和当前持有的{{Pill}}/{{Card}}/{{Rune}}",
	pickupprefix = "使用制服会将这个物品存入/交换到{{ColorGold}}",
	pickupmidfix = "的制服槽位 ",
	pickupsubfix = ".{{CR}}",
}
wakaba.descriptions[desclang].bookofconquest = {
	selectstr = "选择",
	selectenemy = "选中的敌人",
	selectreq = "需要",
	selectboss = "Boss实体：#{{Blank}} {{ColorCyan}} 继续后会消失",
	selectconq = "再次使用物品来征服",
	selecterr = "{{ColorError}}无法征服：#{{Blank}} {{ColorError}}没有足够的{{Key}}或{{Bomb}}",
	selectexit = "按攻击键退出选择",

}
wakaba.descriptions[desclang].waterflame = {
	taintedricher = "吸收选中的物品灵火，并作为被动收藏品赋予#可以用{{ButtonRT}}来选择",
	titleprefix = "选择",
	supersensitiveprefix = "剩余次数：",
	supersensitivesubfix = "",
	supersensitivefinal = "无法再使用",
}
wakaba.descriptions[desclang].doubledreams = {
	lastpool = "物品池",
	currenttitle = "若叶的当前梦境物品池",
	Default = "默认",
	Treasure = "宝藏",
	Shop = "商店",
	Boss = "Boss",
	Devil = "恶魔",
	Angel = "天使",
	Secret = "隐藏",
	Library = "图书馆",
	ShellGame = "赌博游戏",
	GoldenChest = "金色箱子",
	RedChest = "红色箱子",
	Beggar = "乞丐",
	DemonBeggar = "恶魔乞丐",
	Curse = "诅咒",
	KeyMaster = "钥匙大师",
	BatteryBum = "电池乞丐",
	MomChest = "妈妈的箱子",
	GreedTreasure = "贪婪宝藏",
	GreedBoss = "贪婪Boss",
	GreedShop = "贪婪商店",
	GreedDevil = "贪婪恶魔",
	GreedAngel = "贪婪天使",
	GreedCurse = "贪婪诅咒",
	GreedSecret = "贪婪隐藏",
	CraneGame = "娃娃机",
	UltraSecret = "红隐藏",
	BombBum = "炸弹乞丐",
	Planetarium = "星象房",
	OldChest = "旧箱子",
	BabyShop = "婴儿商店",
	WoodenChest = "木箱子",
	RottenBeggar = "腐烂乞丐",
}

wakaba.descriptions[desclang].entities = {
	{
		type = EntityType.ENTITY_SLOT,
		variant = wakaba.Enums.Slots.SHIORI_VALUT,
		subtype = 0,
		name = "汐宫的宝库",
		description = ""
	},
	{
		type = EntityType.ENTITY_PICKUP,
		variant = wakaba.Enums.Pickups.CLOVER_CHEST,
		subtype = wakaba.ChestSubType.CLOSED,
		name = "若叶的四叶草箱子",
		description = ""
			.. "{{Key}} 需要一把钥匙才能打开"
			.. "#{{Warning}} 打开箱子可能包含以下物品之一："
			.. "#{{Coin}} {{ColorSilver}}幸运金币、五分镍币或一角硬币"
			.. "#{{Luck}} {{ColorSilver}}四叶草道具"
	},
}
wakaba.descriptions[desclang].richeruniform = {
	default = "#{{Room}} {{ColorCyan}}默认#激活一次补货机",
	beast = "#{{Room}} {{ColorCyan}}三眼房#!!! 仅限一次使用#{{Collectible633}} 再次获得教条 ({{Heart}}最少6/{{Damage}}+2/{{HolyMantle}})",
	startroom = "#{{RedRoom}} {{ColorCyan}}起始房#生成牌意解读的一个传送门",
	regular = "#{{Room}} {{ColorCyan}}普通房#{{Collectible285}} 使房间内的所有敌人退化2次",
	shop = "#{{Shop}} {{ColorCyan}}商店#{{Collectible64}} 房内的商店物品价格减半",
	error = "#{{ErrorRoom}} {{ColorCyan}}错误房#把房间内的所有物品和掉落物带到起始房",
	treasure = "#{{TreasureRoom}} {{ColorCyan}}道具房#{{Card90}} 重置房间内的所有物品和掉落物#重置后的物品来自随机物品池",
	planetarium = "#{{Planetarium}} {{ColorCyan}}星象房#{{Collectible105}} 重置房间内的所有物品",
	boss = "#{{BossRoom}} {{ColorCyan}}Boss房#{{Collectible" ..
		wakaba.Enums.Collectibles.MINERVA_AURA .. "}} {{Damage}}-0.5/{{Tears}}+0.5x2.3/跟踪眼泪 在当前房间有效",
	devil = "#{{DevilRoom}} {{ColorCyan}}恶魔房#生成品质 {{Quality3}} 的物品，需要2个心之容器",
	angel = "#{{AngelRoom}} {{ColorCyan}}天使房#获得 {{HalfHeart}} + {{HalfSoulHeart}}#{{CurseCursed}} 防止一次诅咒的生效",
	sacrifice =
	"#{{SacrificeRoom}} {{ColorCyan}}献祭房#把下一次献祭的计数器设为第6次 ({{AngelChance}}33%/{{Chest}}67%)#!!! 如果计数器小于6，会受到1个心的伤害",
	arcade =
	"#{{ArcadeRoom}} {{ColorCyan}}游戏房#生成一个 {{Slotmachine}} 老虎机或 {{FortuneTeller}} 占卜机#{{Collectible46}} 在当前房间赌博的胜率提高",
	curse = "#{{CursedRoom}} {{ColorCyan}}诅咒房#{{RedChest}} 生成2个红色箱子#!!! 受到1个心的伤害",
	challenge = "#{{ChallengeRoom}} {{ColorCyan}}挑战房#{{Collectible347}} 复制房间内的所有物品和掉落物",
	bossrush = "#{{BossRushRoom}} {{ColorCyan}}Boss Rush#移除所有的选项，使所有道具都可以拾取",
	chestroom = "#{{ChestRoom}} {{ColorCyan}}宝箱房#{{GoldenChest}} 生成3个金色箱子"
}


wakaba.descriptions[desclang].curses = {
	[-1] = {
		icon = "Blank",
		name = "<Curse not found(or modded curse)>",
	},
	[LevelCurse.CURSE_OF_DARKNESS] = {
		icon = "CurseDarkness",
		name = "黑暗诅咒",
		description = "楼层变得更加黑暗，只有以撒的自然光环能勉强照亮"
			.. "#偶尔会有房间充满了像萤火虫或发光的尘埃一样的漩涡云"
			.. "#火焰，爆炸和激光都会像正常一样发光，红色的蠕动物也是如此"
			.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_DARKNESS,
	},
	[LevelCurse.CURSE_OF_LABYRINTH] = {
		icon = "CurseLabyrinth",
		name = "超大诅咒",
		description = "只会出现在章节的第一层"
			.. "#使楼层变成一个XL层，包含两个Boss房，两个物品房，并且算作两层"
			.. "#!!! 只有Boss/宝藏房会被加倍。其他特殊房间仍然和单层一样"
			.. "#第一层的两个宝藏房门都会是开着的"
			.. "#这个诅咒不能被{{Collectible260}}黑蜡烛移除"
			..
			"#{{Collectible" ..
			wakaba.Enums.Collectibles.RABBIT_RIBBON ..
			"}} 如果玩的是璃贝，或者持有兔子丝带，会在可能的情况下创建额外的特殊房间"
			.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_LABYRINTH,
	},
	[LevelCurse.CURSE_OF_THE_LOST] = {
		icon = "CurseLost",
		name = "迷失诅咒",
		description = "从HUD上移除地图"
			.. "#和失忆药丸有相同的效果"
			.. "#还会增加当前楼层的可能的房间总数，使其达到下一层的大小"
			.. "#可以被{{Collectible260}}黑蜡烛移除，但是增加的房间不会消失"
			.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_LOST,
	},
	[LevelCurse.CURSE_OF_THE_UNKNOWN] = {
		icon = "CurseUnknown",
		name = "未知诅咒",
		description = ""
			.. "#从HUD上移除以撒的生命值，让玩家无法看到任何类型的心剩余多少"
			.. "#生命值仍然会像正常一样被跟踪，包括魂/黑/永恒之心，神圣斗篷，和额外的生命"
			.. "#当以撒只剩下半颗心时，进入房间时仍然会被尿液标记"
			.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_UNKNOWN,
	},

	[LevelCurse.CURSE_OF_THE_CURSED] = {
		icon = "CurseCursed",
		name = "诅咒诅咒",
		description = "将普通的门变成刺房门"
			.. "#由于刺房门的机制，以撒无论是否飞行都会受到伤害"
			.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_CURSED,
	},
	[LevelCurse.CURSE_OF_MAZE] = {
		icon = "CurseMaze",
		name = "迷宫之诅咒",
		description = "进入一个新的房间（包括传送）时，偶尔会把以撒带到错误的房间"
			.. "，屏幕会震动并有声音效果来表示跳跃"
			.. "#偶尔，已经发现的房间会交换内容，没有屏幕震动或声音效果"
			.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_MAZE,
	},
	[LevelCurse.CURSE_OF_BLIND] = {
		icon = "CurseBlind",
		name = "盲目之诅咒",
		description = "所有的物品都被替换成一个问号，直到被拾取才会揭示"
			.. "",
		seedeffect = SeedEffect.SEED_PERMANENT_CURSE_BLIND,
	},
	[LevelCurse.CURSE_OF_GIANT] = {
		icon = "CurseGiant",
		name = "巨人之诅咒",
		description = "将正常大小的房间合并成2x2，1x2，2x1或L形的房间"
			.. "#窄的房间不受影响"
			.. "#这个诅咒不能被{{Collectible260}}黑蜡烛移除"
			.. "",
	},

	[wakaba.curses.CURSE_OF_FLAMES] = {
		icon = "WakabaCurseFlames",
		name = "火焰诅咒",
		description = "当诅咒激活时，Isaac无法获得任何物品"
			.. "#尝试从基座上拿走物品会将其变成拥有巨大生命值的灵火"
			.. "#被动：变成道具灵火。如果不可能，就变成美德书灵火"
			.. "#主动：变成美德书灵火。如果物品没有对应的灵火，就变成普通的灵火"
			.. "#剧情关键的物品和死亡证明房间是这个诅咒的例外"
			.. "",
	},
	[wakaba.curses.CURSE_OF_SATYR] = {
		icon = "WakabaCurseSatyr",
		name = "半人羊诅咒",
		description = "!!! 只有在汐宫使用'半人羊诅咒'模式时才会出现"
			.. "#汐宫无法切换书籍"
			.. "#使用口袋里的书会使书变成另一本"
			.. "#不像未知书签或Maijima Mythology，这样使用书会改变汐宫的眼泪加成"
			.. "#这个诅咒无法被{{Collectible260}}黑蜡烛移除"
			.. "",
	},
	[wakaba.curses.CURSE_OF_SNIPER] = {
		icon = "WakabaCurseSniper",
		name = "狙击手诅咒",
		description = "!!! 只有在{{Player" ..
			wakaba.Enums.Players.RICHER ..
			"}}璃贝，或者持有{{Collectible" .. wakaba.Enums.Collectibles.RABBIT_RIBBON .. "}}兔子丝带时才会出现"
			.. "#{{CurseDarkness}} 替代黑暗诅咒"
			.. "#眼泪是隐形的，并且在短时间内对敌人造成更少的伤害"
			.. "#在4个瓷砖之后对敌人造成2倍的伤害"
			..
			"#{{Player" ..
			wakaba.Enums.Players.RICHER ..
			"}} +{{Collectible619}} {{ColorRicher}}武器是可见的，可以对附近的敌人造成正常伤害"
			.. "",
	},

	[wakaba.curses.CURSE_OF_FAIRY] = {
		icon = "WakabaCurseFairy",
		name = "仙女诅咒",
		description = "!!! 只有在{{Player" ..
			wakaba.Enums.Players.RICHER ..
			"}}璃贝，或者持有{{Collectible" .. wakaba.Enums.Collectibles.RABBIT_RIBBON .. "}}兔子丝带时才会出现"
			.. "#{{CurseLost}} 替代迷失诅咒"
			.. "#无法看到远处的地图"
			.. "#{{SecretRoom}} 可以揭示秘密房间和超级秘密房间"
			.. "#{{Player" ..
			wakaba.Enums.Players.RICHER .. "}} +{{Collectible619}} {{ColorRicher}}地图没有丢失"
			.. "",
	},
	[wakaba.curses.CURSE_OF_AMNESIA] = {
		icon = "WakabaCurseAmnesia",
		name = "失忆诅咒",
		description = "!!! 只有在{{Player" ..
			wakaba.Enums.Players.RICHER ..
			"}}璃贝，或者持有{{Collectible" .. wakaba.Enums.Collectibles.RABBIT_RIBBON .. "}}兔子丝带时才会出现"
			.. "#{{CurseMaze}} 替代迷宫诅咒"
			.. "#有时候已经清理过的房间会随机变成未清理的"
			.. "#特殊房间不包括在内"
			..
			"#{{Player" ..
			wakaba.Enums.Players.RICHER ..
			"}} +{{Collectible619}} {{ColorRicher}}已清除的房间不再被清除，房间清除奖励仍然产生"
			.. "",
	},
	[wakaba.curses.CURSE_OF_MAGICAL_GIRL] = {
		icon = "WakabaCurseMagicalGirl",
		name = "魔法少女诅咒",
		description = "!!! 只有在{{Player" ..
			wakaba.Enums.Players.RICHER ..
			"}}璃贝，或者持有{{Collectible" .. wakaba.Enums.Collectibles.RABBIT_RIBBON .. "}}兔子丝带时才会出现"
			.. "#{{CurseUnknown}} 替代未知诅咒"
			.. "#{{Card91}} 当前楼层永久失落诅咒状态"
			..
			"#即使在失去诅咒状态下也可以使用献血机"
			.. "#{{Collectible285}} 所有敌人都会退化（如果可能的话）"
			..
			"#{{Player" ..
			wakaba.Enums.Players.RICHER ..
			"}} +{{Collectible619}} {{ColorRicher}}璃贝会正常的造成伤害"
			.. "",
	},

}
wakaba.descriptions[desclang].cursesappend = {}
wakaba.descriptions[desclang].cursesappend.CURCOL = {
	[1 << (Isaac.GetCurseIdByName("Curse of Decay") - 1)] = {
		icon = "Blank",
		name = "腐烂诅咒",
		description = "掉落物有一定几率会带有倒计时"
			.. "#腐烂的掉落物会在几秒钟后消失"
			.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Famine") - 1)] = {
		icon = "Blank",
		name = "饥饿诅咒",
		description = "所有的掉落物都会被降级"
			.. "#心会被生成为半颗"
			.. "#1+1的掉落物会被生成为单个"
			.. "#小电池会被生成为半个"
			.. "#!!! 只对随机选择的掉落物有效。不影响固定的掉落物"
			.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Blight") - 1)] = {
		icon = "CURCOL_blight",
		name = "暗黑诅咒",
		description = "所有的物品都会被黑暗的面纱遮盖，直到被拾取才会揭示"
			.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Conquest") - 1)] = {
		icon = "Blank",
		name = "征服诅咒",
		description = "更多的敌人会变成变体"
			.. "#这包括由其他敌人生成的敌人"
			.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Rebirth") - 1)] = {
		icon = "Blank",
		name = "回生诅咒",
		description = "敌人有几率在死后重生"
			.. "#变体会在重生后保持变体状态"
			.. "",
	},
	[1 << (Isaac.GetCurseIdByName("Curse of Creation") - 1)] = {
		icon = "CURCOL_crea",
		name = "创造诅咒",
		description = "障碍物有几率在被破坏后重新生成为岩石"
			.. "#如果被这个诅咒困住，以撒会被传送到上一个房间"
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
		name = "<Player not found(or modded player)>",
	},
	-- wakaba
	[wakaba.Enums.Players.WAKABA] = {
		-- icon = "",
		name = "若叶",
		description = "若叶很可爱很幸运的，来自原由纪的动漫{{ColorLime}}若叶女孩{{CR}}"
			.. "#她更容易得到高品质道具，发射追踪和冰冻的眼泪"
			.. "#{{AngelChance}} 她只能开启天使房间"
			.. "#{{BrokenHeart}} 由于她孤独的过去，她的心大部分都是碎心"
			.. "#{{Pill}} 若叶无法得到速度上升，运气下降的药丸"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.WAKABAS_BLESSING ..
			"}} 若叶开始时拥有若叶的祝福"
			--.. "#"
			.. "",
	},
	[wakaba.Enums.Players.WAKABA_B] = {
		-- icon = "",
		name = "里若叶",
		description = "里若叶是她孤独而不幸的过去版本"
			.. "#她{{ColorRed}}不能{{CR}}得到好的物品，发射幽灵和穿透的眼泪"
			.. "#{{DevilChance}} 她只能看到恶魔房间。所有的恶魔交易的价格都是6个硬币"
			..
			"#{{Damage}} 由于她缺乏爱，她每得到一个收集品就会暂时获得+3.6攻击力上升，但其他属性会永久降低"
			.. "#{{Pill}} 里若叶无法看到速度下降，运气上升的药丸"
			.. "#{{Collectible" ..
			wakaba.Enums.Collectibles.WAKABAS_BLESSING .. "}} 里若叶开始时拥有若叶的仇敌"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.EATHEART .. "}} 里若叶开始时拥有食心"
			--.. "#"
			.. "",
	},
	-- shiori
	[wakaba.Enums.Players.SHIORI] = {
		-- icon = "",
		name = "汐宫",
		description =
			"汐宫是来自{{ColorBookofConquest}}只有神知道的世界{{CR}}的图书管理员，作者是若木民喜"
			.. "#伤害低，但可以发射定向眼泪"
			.. "#{{Key}} 汐宫需要钥匙才能使用主动道具。小电池可以恢复汐宫的钥匙"
			.. "#{{GoldenKey}} 商店里的电池会自动转换为金钥匙。获得金钥匙会自动转换为6个钥匙"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.BOOK_OF_SHIORI .. "}} 汐宫从Book of 汐宫开始"
			.. "",
	},
	[wakaba.Enums.Players.SHIORI_B] = {
		-- icon = "",
		name = "密涅瓦",
		description = "密涅瓦是木星女神，是汐宫的女神" ..
			"#她是一个小女孩，但她的翅膀使她能够飞行" ..
			"#伤害低，但可以发射定向眼泪" ..
			"#{{Key}} 密涅瓦需要钥匙才能使用主动道具。小电池可以恢复密涅瓦的钥匙" ..
			"#{{GoldenKey}} 商店里的电池会自动转换为金钥匙。获得金钥匙会自动转换为6个钥匙" ..
			"#{{Collectible" ..
			wakaba.Enums.Collectibles.BOOK_OF_SHIORI ..
			"}} 密涅瓦从汐宫之书开始" ..
			"#{{Collectible" ..
			wakaba.Enums.Collectibles.MINERVA_AURA ..
			"}} 密涅瓦从密涅瓦的光环开始" ..
			"#{{Collectible" .. wakaba.Enums.Collectibles.BOOK_OF_CONQUEST .. "}} 密涅瓦从Book of Conquest开始"
			--.. "#"
			.. "",
	},
	-- tsukasa
	[wakaba.Enums.Players.TSUKASA] = {
		-- icon = "",
		name = "司",
		description = "司是一个神秘的女孩，来自畑健二郎的漫画{{ColorBookofConquest}}总之就是非常可爱{{CR}}"
			.. "#发射短程，幽灵激光"
			.. "#由于她的永恒，司只能看到~Rebirth和修改过的物品"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.LUNAR_STONE .. "}} 司开始时拥有月亮石"
			.. "#!!! 当月亮石消失时，司死亡"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.CONCENTRATION .. "}} 司开始时拥有专注"
			--.. "#"
			.. "",
	},
	[wakaba.Enums.Players.TSUKASA_B] = {
		-- icon = "",
		name = "里司",
		description = "???"
			.. "#不能发射眼泪，但她初始携带仙女，村雨 "
			.. "#由于不老药的副作用，她{{ColorRed}}没有无敌帧{{CR}}"
			.. "#由于不老药，她以快速的速度恢复生命"
			.. "#{{Collectible" ..
			wakaba.Enums.Collectibles.ELIXIR_OF_LIFE .. "}} 里司开始时拥有不老药"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.MURASAME .. "}} 里司开始时拥有村雨"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.FLASH_SHIFT .. "}} 里司开始时拥有闪移"
			--.. "#"
			.. "",
	},

	-- richer
	[wakaba.Enums.Players.RICHER] = {
		-- icon = "",
		name = "璃贝",
		description =
			"璃贝是一位可爱的女仆，来自{{ColorLime}}尚有佳蜜伴恋心{{CR}}，作者是宫坂姐妹"
			.. "#她可以通过她的丝带改善她的命运"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.RABBIT_RIBBON .. "}} 璃贝从兔子丝带开始"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.SWEETS_CATALOG .. "}} 璃贝从甜品目录开始"
			--.. "#"
			.. "",
	},
	[wakaba.Enums.Players.RICHER_B] = {
		-- icon = "",
		name = "里璃贝",
		description = "里璃贝有一副甜美的身体，但太过娇嫩"
			.. "#她不能正常常获得任何被动道具，任何尝试获取它们都会将它们变成道具灵火"
			.. "#主动道具可以正常收集"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.RABBIT_RIBBON ..
			"}} 里璃贝从兔子丝带开始"
			.. "#{{Collectible" ..
			wakaba.Enums.Collectibles.WINTER_ALBIREO .. "}} 里璃贝从辇道增七开始"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.WATER_FLAME .. "}} 里璃贝从水中焰开始"
			--.. "#"
			.. "",
	},
	-- rira
	[wakaba.Enums.Players.RIRA] = {
		-- icon = "",
		name = "莉良",
		description =
			"莉良是一位可爱的女仆,来自{{ColorLime}}尚有佳蜜伴恋心{{CR}}，作者是宫坂姐妹"
			.. "#她看起来很害羞，但实际上，她真的很H"
			.. "#她射出水之泪，使敌人潮湿并从某些来源受到更多伤害"
			.. "#即使处于游魂状态，她也可以使用献血机"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.CHIMAKI .. "}} 莉良开始持有小棕"
			.. "#{{Collectible" .. wakaba.Enums.Collectibles.NERF_GUN .. "}} 莉良开始持有热火枪"
			--.. "#"
			.. "",
	},
}

wakaba.descriptions[desclang].conditionals = {}
wakaba.descriptions[desclang].conditionals.collectibles = {
	[CollectibleType.COLLECTIBLE_URANUS] = {
		desc = "{{Player" ..
			wakaba.Enums.Players.WAKABA ..
			"}} ↑ {{Damage}} +50% 攻击倍率#{{{Player" .. wakaba.Enums.Players.WAKABA .. "}} {ColorWakabaBless}}穿甲眼泪",
	},
	[wakaba.Enums.Collectibles.WAKABAS_PENDANT] = {
		desc = "{{Player" ..
			wakaba.Enums.Players.WAKABA_B ..
			"}} ↑ {{Damage}} +4攻击力上升#{{Player" .. wakaba.Enums.Players.WAKABA_B .. "}} ↓ {{ColorWakabaNemesis}}幸运奖励不适用",
	},
	[wakaba.Enums.Collectibles.SECRET_CARD] = {
		{
			desc = { "硬币", "1 硬币" },
			modifierText = "Hard Mode", -- do NOT translate this
		},
	},
	[wakaba.Enums.Collectibles.WAKABAS_HAIRPIN] = {
		desc = "{{Player" ..
			wakaba.Enums.Players.WAKABA_B ..
			"}} ↑ {{Damage}} 使用药丸时+0.35攻击力#{{Player" ..
			wakaba.Enums.Players.WAKABA_B .. "}} ↓ {{ColorWakabaNemesis}}幸运奖励不适用",
	},
	[wakaba.Enums.Collectibles.MICRO_DOPPELGANGER] = {
		desc = "{{Player" .. wakaba.Enums.Players.SHIORI .. "}} 生成3个迷你以撒",
	},
	[wakaba.Enums.Collectibles.WAKABAS_BLESSING] = {
		{
			desc = "{{Player" .. wakaba.Enums.Players.WAKABA .. "}} ↑{{Tears}} -25% 射速",
			modifierText = "Wakaba",
		},
	},
	[wakaba.Enums.Collectibles.WAKABAS_NEMESIS] = {
	},
	[wakaba.Enums.Collectibles.WATER_FLAME] = {
		{
			desc = "{{Player" ..
				wakaba.Enums.Players.RICHER_B ..
				"}} 使用时，吸收选定的灵火#{{Player" .. wakaba.Enums.Players.RICHER_B .. "}} 可以通过更改选择{{ButtonRT}}",
			modifierText = "Tainted Richer", -- do NOT translate this
		},
		{
			desc = "{{Player"..wakaba.Enums.Players.RIRA.."}} Aquafies all trinkets in the room", -- Turns all trinkets in the room into aqua trinkets
			modifierText = "Aqua Trinkets",-- do NOT translate this
		},
	},
	[wakaba.Enums.Collectibles.JAR_OF_CLOVER] = {
		desc = "{{Player" .. wakaba.Enums.Players.WAKABA_B .. "}} 里若叶只是复活",
	},
	[wakaba.Enums.Collectibles.BUNNY_PARFAIT] = {
		desc = "{{Player" .. wakaba.Enums.Players.RIRA_B .. "}} 里莉良只是复活",
	},
	[wakaba.Enums.Collectibles.CARAMELLA_PANCAKE] = {
		desc = "{{Player" .. wakaba.Enums.Players.RICHER_B .. "}} 里璃贝只是复活",
	},
	[wakaba.Enums.Collectibles.SWEETS_CATALOG] = {
		desc =
		"{{WakabaMod}} 检测附近的道具的质量#{{WakabaMod}}如果匹配，拿走它，否则，它会消失",
	},
	-- HIDDEN DESCRIPTIONS
	[wakaba.Enums.Collectibles.CURSE_OF_THE_TOWER_2] = {
		desc =
		"{{WakabaModHidden}} {{ColorGray}}所有的炸弹替换为{Coin}}/{{GrabBag}}/{{Heart}}/{{Key}}/{{Battery}}/{{Pill}}/{{Card}}/{{Trinket}}",  -- can change to 'other pickups'
	},
	[wakaba.Enums.Collectibles.MINERVA_AURA] = {
		desc =
		"{{WakabaModHidden}} {{ColorGray}}25%的几率阻挡伤害#{{WakabaModHidden}} {{ColorGray}}阻止所有惩罚伤害",
	},
	[wakaba.Enums.Collectibles.NASA_LOVER] = {
		desc = "{{WakabaModHidden}} {{Collectible565}}{{ColorGray}}血狗变得友好",
	},
	[wakaba.Enums.Collectibles.DOUBLE_INVADER] = {
		desc = "{{WakabaModHidden}} {{ColorGray}}多个死人头出现在主线的boss房间里",
	},
	[wakaba.Enums.Collectibles.ISEKAI_DEFINITION] = {
		desc =
			"{{WakabaModHidden}} {{Collectible628}} {{ColorGray}}0.5%的几率传送玩家到死亡证明区域"
			..
			"#{{WakabaModHidden}} {{Collectible" ..
			wakaba.Enums.Collectibles.BOOK_OF_SHIORI .. "}}{{ColorGray}}4.5%是汐宫之书",
	},
	-- REPENTOGON ADDITIONS
	[wakaba.Enums.Collectibles.RICHERS_BRA] = {
		desc = "{{WakabaModRgon}} {{AngelDevilChance}} {{ColorRicher}}+10%恶魔/天使房间几率",
	},
	[wakaba.Enums.Collectibles.BOOK_OF_AMPLITUDE] = {
		desc = "{{WakabaModRgon}} {{AngelDevilChance}} {{ColorRicher}}持有时增加20%恶魔/天使房间几率",
	},
	[wakaba.Enums.Collectibles.MAID_DUET] = {
		desc = "{{WakabaModRgon}} {{Battery}} {{ColorRicher}}减少道具1~2的充能上限",
	},
	[wakaba.Enums.Collectibles.MAGMA_BLADE] = { -- TODO
		desc = "↑ {{Damage}} +1攻击力#{{WakabaModRgon}} Explosive immunity#{{WakabaModRgon}} Isaac swings fire blade and flame wave every 20 tears",
	},
}
wakaba.descriptions[desclang].conditionals.trinkets = {}
wakaba.descriptions[desclang].conditionals.cards = {}

if EID then
	if EID.descriptions[desclang].ItemReminder and EID.descriptions[desclang].ItemReminder.CategoryNames then
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Character = "角色"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Starting = "初始道具"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_WakabaUniform = "若叶的制服"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_Curse = "诅咒"
		EID.descriptions[desclang].ItemReminder.CategoryNames.w_ShioriFlags = "汐宫的眼泪效果"
	end

	EID.descriptions[desclang].WakabaGlobalWarningTitle = "{{ColorOrange}} 若叶的警告"
	EID.descriptions[desclang].WakabaRGONWarningText =
	"未安装REPENTOGON! mod可以运行, 但是部分道具和效果将会移除!"
	EID.descriptions[desclang].WakabaDamoclesWarningText =
	"达摩克利斯API被禁用!一些道具需要它，并将被删除，直到它再次重新启用!"

	EID.descriptions[desclang].WakabaAchievementWarningTitle = "{{ColorYellow}}!!! 成就？"
	EID.descriptions[desclang].WakabaAchievementWarningText =
	"Mod中的角色都有完整的解锁奖励#这是一个可选的功能#你想把一些物品锁在我们的角色后面吗？"

	EID.descriptions[desclang].TaintedTsukasaAWarningTitle = "{{ColorYellow}}!!! 锁定 !!!"
	EID.descriptions[desclang].TaintedTsukasaWarningText =
	"必须先解锁这个角色#方法：用红色钥匙打开家里的隐藏衣柜，扮演司#进入右边的门会退出游戏"
	EID.descriptions[desclang].TaintedRicherWarningText =
	"必须先解锁这个角色#方法：用红色钥匙打开家里的隐藏衣柜，扮演璃贝#进入右边的门会退出游戏"

	EID.descriptions[desclang].SweetsChallenge = "使用时，显示品质提示#如果品质匹配，获得物品"
	EID.descriptions[desclang].SweetsFlipFlop =
	"再次使用物品取消#{{ButtonY}}/{{ButtonX}}:{{Quality1}}或{{Quality3}}#{{ButtonA}}/{{ButtonB}}:{{Quality2}}或{{Quality4}}#如果选择的品质与物品的品质相符，获得物品，否则消失"

	EID.descriptions[desclang].SweetsChallengeFailed = "{{ColorOrange}}因为品质不匹配而失败 : "
	EID.descriptions[desclang].SweetsChallengeSuccess = "{{ColorCyan}}因为品质匹配而成功 : "

	EID.descriptions[desclang].WakabaVintageHotkey = "#!!! 按 {1} 立即激活"


	EID.descriptions[desclang].CaramellaFlyRicher = "!!! {{ColorRicher}}璃贝：苍蝇造成4倍玩家的伤害"
	EID.descriptions[desclang].CaramellaFlyRira = "!!! {{ColorRira}}莉良: 苍蝇造成3倍玩家的伤害+潮湿状态"
	EID.descriptions[desclang].CaramellaFlyCiel =
	"!!! {{ColorCiel}}希耶尔: 苍蝇造成10倍艾萨克的伤害+爆炸伤害（不伤害玩家）"
	EID.descriptions[desclang].CaramellaFlyKoron =
	"!!! {{ColorKoron}}心月: 苍蝇造成4倍玩家的伤害+石化状态"

	EID.descriptions[desclang].MaidDuetBlacklisted =
	"!!! {{ColorRicher}}璃贝{{CR}} & {{ColorRira}}莉良{{CR}} 不能把这个放进口袋!"

	EID.descriptions[desclang].AquaTrinketText = "!!! {{ColorCyan}}水之饰品 : 自动吞下{{CR}}"

	EID.descriptions[desclang].AlbireoPool = "{{RicherPlanetarium}} 本楼层的 道具池 : "
end
