--import module

local global = require "global"
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
    local fCallback = function (oAttack,oVictim,iDamage)
        local oSkill = oAttack:GetPerform(iSkill)
        if oSkill then
            oSkill:OnKill(oAttack,oVictim,iDamage)
        end
    end
    oAction:AddFunction("OnKill",self.m_ID,fCallback)

    local fCallback = function (oAttack,lVictim,oPerform)
        local oSkill = oAttack:GetPerform(iSkill)
        if oSkill then
            oSkill:OnPerform(oAttack,lVictim,oPerform)
        end
    end
    oAction:AddFunction("OnPerform",self.m_ID,fCallback)


end

function CPerform:OnKill(oAttack,oVictim,iDamage)
    if oAttack:GetPerform(40903) then
        return
    end
    if oAttack:QueryBoutArgs("zuiji_pf") and oAttack:QueryBoutArgs("zuiji_pf") ~= self:Type() then
        return
    end
    oAttack:SetBoutArgs("zuiji",true)
    oAttack:SetBoutArgs("zuiji_pf",self:Type())
end

function CPerform:OnPerform(oAttack,lVictim,oPerform)
    if not oAttack:QueryBoutArgs("zuiji") then
        return
    end

    oAttack:SetBoutArgs("zuiji",false)
    local mArgs = self:GetSkillArgsEnv()
    local iRatio = mArgs["ratio"] or 3000
    if not in_random(iRatio,10000) then
        return
    end
    local iNormalAttackId = oAttack:GetNormalAttackSkillId()
    local oPerform = oAttack:GetPerform(iNormalAttackId)
    if not oPerform then
        return
    end
    local mEnemy = oAttack:GetEnemyList()
    if #mEnemy <= 0 then
        return
    end
    self:ShowPerfrom(oAttack)
    local oWarrior = mEnemy[math.random(#mEnemy)]
    oPerform:Perform(oAttack,{oWarrior})

end