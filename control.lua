local chat_title = "[color=green]MidyMidyFactorio: [/color]"

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
end

script.on_event(defines.events.on_player_died, function (event)
    chat("Oops")
    chat(sarcasm[(event.player_index + event.tick) % #sarcasm + 1])
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
    end
end)

commands.add_command("me", {"command-help.me"}, function (cmd)
    if cmd.player_index then
        local name = game.get_player(cmd.player_index).name
        game.print("* " .. name .. " " .. (cmd.parameter or ""))
    end
end)
