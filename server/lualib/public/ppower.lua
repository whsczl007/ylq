-- import file

local lpsum = require "lpsum"

local Attr2Index = {
    maxhp=0,attack=1,defense=2,speed=3,critical_ratio=4,res_critical_ratio=5,
    critical_damage=6,abnormal_attr_ratio=7,res_abnormal_ratio=8,cure_critical_ratio=9,sub_power=10,
}

MO_PARTNER_ATTR ={
    PMO_BASE = 0,
    PMO_BR_SKILL = 1,
    PMO_BR_EQUIP = 2,
    PMO_BR_STONE = 3,
    PMO_ADD_SKILL = 4,
    PMO_ADD_EQUIP = 5,
    PMO_ADD_STONE = 6,
    PMO_ATTR = 7,
    PMO_BASE_RATIO = 8,
    PMO_ATTR_ADD = 9,
    PMO_BR_ORG = 10,
}

BR_POS2MO = {
    skill = MO_PARTNER_ATTR.PMO_BR_SKILL,
    equip = MO_PARTNER_ATTR.PMO_BR_EQUIP,
    stone = MO_PARTNER_ATTR.PMO_BR_STONE,
    org = MO_PARTNER_ATTR.PMO_BR_ORG,
}

ADD_POS2MO = {
    skill = MO_PARTNER_ATTR.PMO_ADD_SKILL,
    equip = MO_PARTNER_ATTR.PMO_ADD_EQUIP,
    stone = MO_PARTNER_ATTR.PMO_ADD_STONE,
}

function NewCPower(...)
    return CCPower:New(...)
end

CCPower = {}
CCPower.__index = CCPower
inherit(CCPower, logic_base_cls())

function CCPower:New()
    local o = super(CCPower).New(self)
    o.m_cSum = lpsum.lpsum_create()
    return o
end

function CCPower:Release()
    self.m_cSum = nil
    super(CCPower).Release(self)
end

function CCPower:GetIndex(sAttr)
    return Attr2Index[sAttr]
end

function CCPower:SetRatioApply(sPos,sAttr,Val)
    local iIndex = self:GetIndex(sAttr)
    if not iIndex then return end
    local oSum = self.m_cSum
    local iMo = BR_POS2MO[sPos]
    if not iMo then return end
    oSum:set(iIndex,iMo,Val)
end

function CCPower:MultiSetRatioApply(sPos,mAttr)
    local iMo = BR_POS2MO[sPos]
    if not iMo then return end
    local mChangeAttr = {}
    for sAttr,Val in pairs(mAttr) do
        local iIndex = self:GetIndex(sAttr)
        if iIndex then
            mChangeAttr[iIndex] = Val
        end
    end
    local oSum = self.m_cSum
    oSum:multiset(iMo,mChangeAttr)
end

function CCPower:AddRatioApply(sPos,sAttr,Val)
    local iIndex = self:GetIndex(sAttr)
    if not iIndex then return end
    local oSum = self.m_cSum
    local iMo = BR_POS2MO[sPos]
    if not iMo then return end
    oSum:add(iIndex,iMo,Val)
end

function CCPower:ClearRatioApply(sPos)
    local oSum = self.m_cSum
    local iMo = BR_POS2MO[sPos]
    if not iMo then return end
    oSum:clear(iMo)
end

function CCPower:SetApply(sPos,sAttr,Val)
    local iIndex = self:GetIndex(sAttr)
    if not iIndex then return end
    local oSum = self.m_cSum
    local iMo = ADD_POS2MO[sPos]
    if not iMo then return end
    oSum:set(iIndex,iMo,Val)
end

function CCPower:MultiSetApply(sPos,mAttr)
    local iMo = ADD_POS2MO[sPos]
    if not iMo then return end
    local mChangeAttr = {}
    for sAttr,Val in pairs(mAttr) do
        local iIndex = self:GetIndex(sAttr)
        if iIndex then
            mChangeAttr[iIndex] = Val
        end
    end
    local oSum = self.m_cSum
    oSum:multiset(iMo,mChangeAttr)
end

function CCPower:AddApply(sPos,sAttr,Val)
    local iIndex = self:GetIndex(sAttr)
    if not iIndex then return end
    local oSum = self.m_cSum
    local iMo = ADD_POS2MO[sPos]
    if not iMo then return end
    oSum:add(iIndex,iMo,Val)
end

function CCPower:ClearApply(sPos)
    local oSum = self.m_cSum
    local iMo = ADD_POS2MO[sPos]
    if not iMo then return end
    oSum:clear(iMo)
end

function CCPower:SetEquipPower(iVal)
    local oSum = self.m_cSum
    oSum:seteppower(iVal)
end

function CCPower:SetBaseAttr(mAttr)
    local mChangeAttr = {}
    for sAttr,Val in pairs(mAttr) do
        local iIndex = self:GetIndex(sAttr)
        if iIndex then
            mChangeAttr[iIndex] = Val
        end
    end
    local oSum = self.m_cSum
    oSum:multiset(MO_PARTNER_ATTR.PMO_BASE,mChangeAttr)
end

function CCPower:GetAttr(sAttr)
    local iIndex = self:GetIndex(sAttr)
    if not iIndex then return 0 end
    local oSum = self.m_cSum
    return oSum:getattr(iIndex)
end

function CCPower:GetBaseRatio(sAttr)
    local iIndex = self:GetIndex(sAttr)
    if not iIndex then return 0 end
    local oSum = self.m_cSum
    return oSum:getbaseratio(iIndex)
end

function CCPower:GetAttrAdd(sAttr)
    local iIndex = self:GetIndex(sAttr)
    if not iIndex then return 0 end
    local oSum = self.m_cSum
    return oSum:getattradd(iIndex)
end

function CCPower:GetPower(sSchool)
    local oSum = self.m_cSum
    return oSum:getpower(sSchool)
end

function CCPower:Print(iMo)
    local oSum = self.m_cSum
    oSum:print(iMo)
end

function SyncPowerData(sType,mData)
    local mFliterData = {}
    local iIndex
    for sAttr,Val in pairs(mData) do
        iIndex = Attr2Index[sAttr]
        if iIndex then
            mFliterData[iIndex] = Val
        end
    end
    lpsum.lpsum_powerdata(sType,mFliterData)
end