local translate = require("translations")
local chat_title = "[color=green]MidyMidyFactorio: [/color]"
local log_title = "MidyMidyFactorio: "

local sarcasm = {
    "真弱鸡啊……",
    "行不行啊？",
    "不得行啊……",
    "安全生产 重于泰山",
    "-1s",
    "星际玩家？",
    "哈哈哈红红火火何厚铧喊憨厚韩寒嘿嘿嘿",
    "看来你还不知道生命的可贵",
    "清空经验和道具栏",
    "我就看着你作死",
    "达到死亡次数限制，从白名单移除",
    "你的寿命在以可见的速度流逝",
    "最怕空气突然安静",
    "送上一曲《凉凉》",
    "伙计倒下了！伙计倒下了！",
    "快别作死了行不行，保险公司都赔破产了",
    "嘿！这里死了不会变成盒子",
    "玩家 OUT，玩家 OUT",
    "啊朋友再见，啊朋友再见，啊朋友再见吧再见吧再见吧~",
    "Death, or new born?",
    "玩家数据删除",
    "朋友，收尸很麻烦的……",
    "亲，你还有复活币吗？",
    "小道新闻：阎王拒绝了玩家的加群请求",
    "胜败乃兵家常事 请大侠重新来过",
    "Is there a doctor in the server?",
    "桥豆麻袋，刚才发生了什么事情吗？（黑人问号",
    "死神：这是在割韭菜吗？",
    "Unit lost.",
    "哎哟，你超逊喔～",
    "Boom Shakalaka...",
}

function chat(line)
    game.print(chat_title .. line)
    log(log_title .. line)
end

function send_update(t)
    local json = helpers.table_to_json(t)
    if not storage.updates then
        storage.updates = {}
    end
    table.insert(storage.updates, json)
end

script.on_event(defines.events.on_pre_player_died, function (event)
    local s = sarcasm[(event.player_index + event.tick) % #sarcasm + 1]
    chat("Oops")
    chat(s)
    send_update({
        type = "oops",
        player_index = event.player_index,
        player_name = game.get_player(event.player_index).name,
        sarcasm = s
    })
end)

script.on_event(defines.events.on_player_joined_game, function (event)
    send_update({
        type = "player-joined",
        player_index = event.player_index,
        player_name = game.get_player(event.player_index).name
    })
end)

script.on_event(defines.events.on_player_left_game, function (event)
    send_update({
        type = "player-left",
        player_index = event.player_index,
        player_name = game.get_player(event.player_index).name
    })
end)

script.on_event(defines.events.on_research_started, function (event)
    send_update({
      type = "research-started",
      research_name = translate(event.research.name)
    })
end)

script.on_event(defines.events.on_research_finished, function (event)
    send_update({
      type = "research-finished",
      research_name = translate(event.research.name)
    })
end)

script.on_event(defines.events.on_resource_depleted, function (event)
    send_update({
      type = "resource-depleted",
      resource_name = translate(event.entity.name)
    })
end)

script.on_event(defines.events.on_console_chat, function (event)
    if event.player_index then
        local msg = string.lower(event.message)
        if msg == "ping" then
            chat("Pia!")
        elseif msg == "test" then
            chat("Test failed.")
        elseif msg == "ikilledmyself" then
            local c = game.get_player(event.player_index).character
            if c then c.die(c.force) end
        end

        send_update({
            type = "console-chat",
            player_index = event.player_index,
            player_name = game.get_player(event.player_index).name,
            message = event.message
        })
    end
end)

commands.add_command("me", {"command-help.me"}, function (cmd)
    if cmd.player_index then
        local name = game.get_player(cmd.player_index).name
        game.print("* " .. name .. " " .. (cmd.parameter or ""))
        log("* " .. name .. " " .. (cmd.parameter or ""))

        send_update({
            type = "console-me",
            player_index = cmd.player_index,
            player_name = name,
            message = cmd.parameter
        })
    end
end)

commands.add_command("pin", {"command-help.pin"}, function (cmd)
    if cmd.player_index then
        local name = game.get_player(cmd.player_index).name
        game.print(name .. ": " .. (cmd.parameter or ""))
        log(name .. ": " .. (cmd.parameter or ""))

        send_update({
            type = "console-pin",
            player_index = cmd.player_index,
            player_name = name,
            message = cmd.parameter
        })
    end
end)

commands.add_command("_midymidyws", "Fuck off!", function (cmd)
    if cmd.parameter == "get_update" then
        if not storage.updates or #storage.updates == 0 then
            rcon.print(helpers.table_to_json({ type = "empty" }))
        else
            rcon.print(storage.updates[1])
            table.remove(storage.updates, 1)
        end
    elseif cmd.parameter == "get_players" then
        local players = {}
        for _, p in pairs(game.players) do
            table.insert(players, {
                name = p.name,
                connected = p.connected,
                afk_time = p.afk_time,
                online_time = p.online_time,
                last_online = p.last_online,
                display_resolution = p.display_resolution,
                spectator = p.spectator
            })
        end
        rcon.print(helpers.table_to_json({ players = players }))
    elseif cmd.parameter and string.find(cmd.parameter, "post_messages", 1, true) == 1 then
        local json = string.sub(cmd.parameter, #"post_messages" + 2)
        for _, msg in pairs(helpers.json_to_table(json).messages) do
            chat("<" .. msg.name .. "> " .. msg.message)
        end
        rcon.print(helpers.table_to_json({ ok = true }))
    end
end)

commands.add_command("toggle_peaceful", "Cheat but not counted as cheat!", function (cmd)
  if cmd.player_index ~= nil then
    game.players[cmd.player_index].surface.peaceful_mode = not game.players[cmd.player_index].surface.peaceful_mode
  end
end)
