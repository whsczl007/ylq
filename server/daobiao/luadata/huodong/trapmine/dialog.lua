-- ./excel/huodong/trapmine/dialog.xlsx
return {

    [100] = {
        content = "是否消灭{npcname}？{ownercd}（推荐组队会更快消灭唷）",
        dialog_id = 100,
        last_action = {{["content"] = "战斗", ["event"] = "TPF"}, {["content"] = "发起组队", ["event"] = "CT"}, {["content"] = "放弃"}},
        next = "0",
        pre_id_list = "0",
        status = 2,
        subid = 1,
        type = 2,
        ui_mode = 2,
        voice = 0,
    },

    [200] = {
        content = "已有玩家先一步与{npcname}进行搏斗，请稍后再进行挑战。",
        dialog_id = 200,
        last_action = {},
        next = "0",
        pre_id_list = "0",
        status = 2,
        subid = 1,
        type = 2,
        ui_mode = 2,
        voice = 0,
    },

    [300] = {
        content = "{rolename}等级不足38级，无法进入战斗。",
        dialog_id = 300,
        last_action = {},
        next = "0",
        pre_id_list = "0",
        status = 2,
        subid = 1,
        type = 2,
        ui_mode = 2,
        voice = 0,
    },

    [301] = {
        content = "已达全服挑战次数上限",
        dialog_id = 301,
        last_action = {},
        next = "0",
        pre_id_list = "0",
        status = 2,
        subid = 1,
        type = 2,
        ui_mode = 2,
        voice = 0,
    },

    [302] = {
        content = "今日已达挑战次数上限",
        dialog_id = 302,
        last_action = {},
        next = "0",
        pre_id_list = "0",
        status = 2,
        subid = 1,
        type = 2,
        ui_mode = 2,
        voice = 0,
    },

    [303] = {
        content = "秘宝猎人冷却时间#R{boxbosscd}#n，请在冷却时间结束再挑战。",
        dialog_id = 303,
        last_action = {},
        next = "0",
        pre_id_list = "0",
        status = 2,
        subid = 1,
        type = 2,
        ui_mode = 2,
        voice = 0,
    },

    [304] = {
        content = "目前只有发现者的队伍可进行挑战，请在保护时间结束后进行挑战。{ownercd}后变为共享状态。",
        dialog_id = 304,
        last_action = {},
        next = "0",
        pre_id_list = "0",
        status = 2,
        subid = 1,
        type = 2,
        ui_mode = 2,
        voice = 0,
    },

    [305] = {
        content = "{npcname}已变为狂化，需要2人以上才可挑战噢。",
        dialog_id = 305,
        last_action = {},
        next = "0",
        pre_id_list = "0",
        status = 2,
        subid = 1,
        type = 2,
        ui_mode = 2,
        voice = 0,
    },

}
