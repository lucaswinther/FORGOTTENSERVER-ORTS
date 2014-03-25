local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_SOUND_PURPLE)

local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, 4000)
setConditionParam(condition, CONDITION_PARAM_SKILL_MELEEPERCENT, 25)

local area = createCombatArea(AREA_BEAM1)
setCombatArea(combat, area)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
       return doCombat(cid, combat, var)
end
