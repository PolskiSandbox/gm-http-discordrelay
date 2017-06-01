local discordrelay = discordrelay

local prefixes = {"!", "/", "."} --cba to use the lua pattern
hook.Add("PlayerSay", "DiscordRelayChat", function(ply, text, teamChat)
    if aowl then
        for cmd,v in pairs(aowl.cmds) do
            for k,prefix in pairs(prefixes) do
                if string.StartWith(text, prefix..cmd) then
                    if aowl.cmds[cmd] and aowl.cmds[cmd].hidechat then
                        return
                    end
                end
            end
        end
    end
    if discordrelay and discordrelay.enabled then
        text = string.Replace(text, "@everyone", "everyone")
        text = string.Replace(text, "@here", "here")

        discordrelay.GetAvatar(ply:SteamID(), function(ret)
            discordrelay.ExecuteWebhook(discordrelay.webhookid, discordrelay.webhooktoken, {
                ["username"] = ply:Nick(),
                ["content"] = text,
                ["avatar_url"] = ret
                })
        end)
    end
end)