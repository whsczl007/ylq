local skynet = require "skynet"
local global = require "global"
local extend = require "base/extend"

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
    local fCallback = function (oAction,obuff)
        local oSkill = oAction:GetPerform(iSkill)
        if oSkill then
            return oSkill:OnAddBuff(oAction,obuff)
        end
    end
    oAction:AddFunction("OnAddBuff",self.m_ID,fCallback)
end

function CPerform:OnAddBuff(oAction,obuff)
    if obuff:InBuffClassType(gamedefines.WAR_BUFF_CLASS.CONTROL) and obuff:Type() ==  gamedefines.WAR_BUFF_TYPE.ABNORMAL then
        return false
    end
    return true
end



