local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I heard he is some scary magician or so."})

local travelNode = keywordHandler:addKeyword({'east'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you seek a passage to the east end of Port Hope for free?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=32679, y=32777, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Maybe another time.'})

local travelNode = keywordHandler:addKeyword({'center'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you seek a passage to the centre of Port Hope for free?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=32628, y=32771, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Maybe another time.'})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if getPlayerRank(cid) >= 3 then -- 3 = RANK_RANGER in KillingInTheNameOfQuest.lua on /data/lib/
		if msgcontains(msg, 'darama') then
			npcHandler:say('Do you seek a passage to Darama?', cid)
			npcHandler.topic[cid] = 1
		elseif msgcontains(msg, 'chor') then
			npcHandler:say('Do you seek a passage to Chor?', cid)
			npcHandler.topic[cid] = 2
		elseif msgcontains(msg, 'banuta') then
			npcHandler:say('Do you seek a passage to Banuta?', cid)
			npcHandler.topic[cid] = 3
		end

		if msgcontains(msg, 'yes') then
			local pos
			if npcHandler.topic[cid] == 1 then
				pos = Position(32987, 32729, 7)
			elseif npcHandler.topic[cid] == 2 then
				pos = Position(32968, 32799, 7)
			elseif npcHandler.topic[cid] == 3 then
				pos = Position(32826, 32631, 7)
			end
			Player(cid):teleportTo(pos)
			pos:sendMagicEffect(CONST_ME_TELEPORT)
		end

	else
		npcHandler:say('Sorry, you are not a Ranger.', cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())