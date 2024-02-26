--[[
	Tainted Rira(뒤집힌 리라)
	야릇한 베이커리
	- 최대 체력 = 소울하트 보정
	- 토끼 와드가 주변에 없으면 지속적으로 체력 감소
	- 적 처치 시 특수 엘레멘트 드랍
	- 보물방이 전용 특수방인 '베이커리'로 대체 (베이스 보물방)
	-- 베이커리는 빵 관련 아이템(베이커리 배열)이 등장
	-- 엘레멘트 (R, G, B)와 동전을 소모하여 새로운 빵 관련 아이템 제작
	-- 만들어지는 빵의 등급은 소모한 엘레멘트와 동전에 비례
	--- 색상 기준은 R, G, B의 비중을 따라 결정
	-- More Options 소지 시 나오는 빵이 2개 등장하며 하나만 선택 가능
 ]]

--[[
	---- 베이커리 배열 아이템 ----
	---- 커뮤니티 아이디어 채용
	----

	---- 범용 ----
	- 공통 조건 : 3개 색상 비중 모두 낮음

	- 식빵 (Q3 > 2)
	-- 최대 체력 +1, 체력 모두 회복
	-- 빨간하트 수만큼 공격력 증가

	- 크림빵 (Q2 > 1)
	-- 최대 체력 +1, 빨간하트 +1
	-- 캐릭터의 위치에 적을 느리게 하는 크림 장판 생성

	- 머핀 (Q3)
	-- 소울하트 +2, 공격력 +1.5, 행운 +1

	- 바게트 (Q3)
	-- 소울하트 +1~2
	-- 블랙하트 +1~2
	-- 황금하트 +0~1

	- 샌드위치 (Q4)
	-- 최대 체력 +1, 체력 모두 회복
	-- 모든 능력치 +0.5(커뮤니티 아이디어, 조정 예정)
	-- REPENTOGON 한정 최종 악마방 확률 +40%, 최종 천체관 확률 +20%
	-- 빵 아이템 당 공격력 +2

	- 도넛 (Q2 > 1)
	-- 최대 체력 +1, 빨간하트 +1, 스피트 +0.2

	---- 베리류 ----

	- 딸기 케이크 (Q4), R 비중 매우 높음
	-- 최대 체력 +12, 체력 모두 회복
	-- 패널티 피격 시에도 악마방 확률 방어

	- 하트 슬러시 (Q?), R 비중 높음

	- 코론 아이스크림 콘 (Q?), R 비중 높음

	---- 초코류 ----

	- 초코 케이크 (Q4)
	-- 블랙하트 +3
	-- 공격력 +1.2
	-- 악마방 확정

	---- 치즈류 ----

	- 치즈 케이크 (Q4), R 비중 매우 높음, G 비중 높음
	-- 최대 체력 +4
	-- 매 스테이지마다 전용 보물방이 추가로 등장, 전용 보물방에는 등급이 높은 아이템 등장 및 열쇠 소모 없음
	-- 알트 리라 플레이 시 베이커리가 추가로 등장

	---- 카라멜로 ----
	- 공통 조건 : 3개 색상 비중 모두 매우 높음

	- 레인보우 케이크 (Q5)
	-- 최대 체력 +4
	-- 모든 아이템 Q3 이상 확정

	- 후르츠 드링크 (Q?)
 ]]