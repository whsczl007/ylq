local skynet = require "skynet"

local gamedefines = import(lualib_path("public.gamedefines"))
local pfobj = import(service_path("perform/pfobj"))

function NewCPerform(...)
    local o = CPerform:New(...)
    return o
end

CPerform = {}
CPerform.__index = CPerform
inherit(CPerform, pfobj.CPassivePerform)

function CPerform:New(pfid)
    local o = super(CPerform).New(self,pfid)
    return o
end

function CPerform:CalWarrior(oAction,oPerformMgr)
    local iSkill = self:Type()
    local fCallback = function (oAttack,oVictim,oPerform,iDamage)
        local oSkill = oAttack:GetPerform(iSkill)
        if oSkill then
             oSkill:OnAttack(oAttack,oVictim,oPerform,iDamage)
        end
    end
    oAction:AddFunction("OnAttack",self.m_ID,fCallback)
end

function CPerform:OnAttack(oAttack,oVictim,oPerform,iDamage)
    local mArgs = self:GetSkillArgsEnv()
    local iRatio = mArgs["ratio"] or 500
    local iMinRatio = mArgs["min_ratio"] or 1000
    local iMaxRatio = mArgs["max_ratio"] or 5000
    local iAbnormalRatio = oAttack:AbnormalRatio(oVictim,iRatio,iMaxRatio,iMinRatio)
    if not in_random(iAbnormalRatio,10000) then
        return
    end
    self:ShowPerfrom(oAttack)
    self:Effect_Condition_For_Victim(oVictim,oAttack)
end