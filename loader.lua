-- KaiHub loader: reads version.json, then runs the build it points to for this game.
local BASE = "https://raw.githubusercontent.com/KaiGitSel/KaiHub-Script/main/"
-- execute counter: fire and forget, never blocks or breaks the load
task.spawn(pcall, function()
    local req = request or http_request
    if req then req({ Url = "https://kaihub-count.kaihub.workers.dev/e", Method = "POST" }) end
end)
local ok, err = pcall(function()
    local info = game:GetService("HttpService"):JSONDecode(game:HttpGet(BASE .. "version.json"))
    -- games[<GameId>].file picks the build; no entry = game not supported yet
    local g = type(info.games) == "table" and info.games[tostring(game.GameId)] or nil
    if type(g) ~= "table" then g = nil end
    local file = g and g.file or nil
    -- per-game kill wins over the top-level kill
    local kill = info.kill
    if g and g.kill ~= nil then kill = g.kill end
    if not file or kill == true then
        local msg = not file and "KaiHub: this game is not supported yet" or "KaiHub is disabled right now."
        local custom = g and type(g.message) == "string" and g.message or info.message
        if file and type(custom) == "string" and custom ~= "" then msg = msg .. " " .. custom:gsub("%c", " "):sub(1, 200) end
        warn("[KaiHub] " .. msg)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", { Title = "KaiHub", Text = msg, Duration = 6 })
        end)
        return
    end
    -- only builds/<name>.lua, plain characters, no ".." (the file name comes from a remote file)
    if type(file) ~= "string" or file:sub(1, 7) ~= "builds/" or file:sub(-4) ~= ".lua"
        or file:find("..", 1, true) or file:find("[^%w%._%-/]") then
        error("invalid build path in version.json")
    end
    loadstring(game:HttpGet(BASE .. file))()
end)
if not ok then warn("[KaiHub] loader failed:", err) end
