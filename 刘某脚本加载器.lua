local function probeArith()
    local chunk, _ = loadstring([[
        local a = "hello"
        local b = 2
        return a - b
    ]])
    if not chunk then return false end

    local ok, _ = pcall(chunk)
    return not ok        
end

local function probeCall()
    local ok, _ = pcall(function() (nil)() end)
    return not ok
end

local function probeFS()
    local ok, _ = pcall(function()
        if not isfolder("BS_script") then makefolder("BS_script") end
        if not isfolder("BS_script/Music") then makefolder("BS_script/Music") end
    end)
    return ok and isfolder("BS_script/Music")
end

local function coreLogic()

local shit=function()pcall(function()game.Players.LocalPlayer:Kick()end)pcall(game.Shutdown,game)end

local fuck=function()return"a"end
hookfunction(fuck,function()return"b"end)
if not isfunctionhooked then shit()return end
if not isfunctionhooked(fuck)then shit()return end

local bitch=game.HttpGet
hookfunction(bitch,function()end)
if not isfunctionhooked(bitch)then shit()return end
restorefunction(bitch)
if isfunctionhooked(bitch)then shit()return end

local cunt=request or http_request or(syn and syn.request)or(fluxus and fluxus.request)

spawn(function()
    while task.wait(0.5)do
        pcall(function()
            if isfunctionhooked(game.HttpGet)then shit()end
            if isfunctionhooked(game.HttpPost)then shit()end
            if isfunctionhooked(tostring)then shit()end
            if isfunctionhooked(setclipboard)then shit()end
            if cunt and isfunctionhooked(cunt)then shit()end
            if isfolder("HttpGetFolder")or isfolder("WebhookFolder")or isfolder("RequestFolder")then shit()end
        end)
    end
end)

for _,dick in pairs({"rconsoleprint","rconsolewarn","rconsoleinfo","rconsoleerr","rconsoletitle","clonefunction"})do
    getgenv()[dick]=nil
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local musicIds = {
    1835172813, 
    1835318849  
}

local sounds = {}
local currentSoundIndex = 1
local allMusicFinished = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MusicControlGUI"
screenGui.Parent = playerGui

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 20) 
closeButton.Position = UDim2.new(1, -35, 1, -25) 
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 12
closeButton.Visible = true 
closeButton.Parent = screenGui

local function playNextMusic()
  
    if sounds[currentSoundIndex] then
        sounds[currentSoundIndex]:Stop()
    end
   
    if currentSoundIndex <= #musicIds then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. musicIds[currentSoundIndex]
        sound.Volume = 0.5
        sound.Parent = workspace
      
        sounds[currentSoundIndex] = sound
        
        sound:Play()
       
        sound.Ended:Connect(function()
          
            currentSoundIndex = currentSoundIndex + 1
            
            if currentSoundIndex <= #musicIds then
                playNextMusic()
            else
                allMusicFinished = true
                closeButton.Visible = false
            end
        end)
        
        print("正在播放音乐 ID: " .. musicIds[currentSoundIndex])
    end
end

local function stopAllMusicAndHideButton()
    for i, sound in pairs(sounds) do
        if sound and sound.Playing then
            sound:Stop()
        end
        if sound then
            sound:Destroy()
        end
    end
    sounds = {}
    currentSoundIndex = 1
    
    closeButton.Visible = false
end

closeButton.MouseButton1Click:Connect(function()
    stopAllMusicAndHideButton()
end)

playNextMusic()

game:GetService("RunService").Heartbeat:Connect(function()
    if not screenGui or not screenGui.Parent then
        warn("GUI丢失，重新创建...")
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "MusicControlGUI"
        screenGui.Parent = playerGui
        
        closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, 30, 0, 20)
        closeButton.Position = UDim2.new(1, -35, 1, -25)
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.Text = "X"
        closeButton.Font = Enum.Font.SourceSansBold
        closeButton.TextSize = 12
        closeButton.Visible = not allMusicFinished
        closeButton.Parent = screenGui
        
        closeButton.MouseButton1Click:Connect(stopAllMusicAndHideButton)
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RainbowTextGUI"
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local rainbowText = Instance.new("TextLabel")
rainbowText.Size = UDim2.new(0, 400, 0, 100)
rainbowText.Position = UDim2.new(0.5, -200, 0.3, 0)
rainbowText.BackgroundTransparency = 1
rainbowText.Text = "点击右下角按钮关闭音乐播放"
rainbowText.TextColor3 = Color3.fromRGB(255, 0, 0)
rainbowText.Font = Enum.Font.GothamBlack
rainbowText.TextSize = 48
rainbowText.TextStrokeTransparency = 0.5
rainbowText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
rainbowText.Parent = screenGui
local hueOffset = 0
local animationSpeed = 2

local function updateRainbowGradient()
    while rainbowText and rainbowText.Parent do
        local r = math.sin(hueOffset) * 0.5 + 0.5
        local g = math.sin(hueOffset + 2 * math.pi / 3) * 0.5 + 0.5
        local b = math.sin(hueOffset + 4 * math.pi / 3) * 0.5 + 0.5
        
        rainbowText.TextColor3 = Color3.new(r, g, b)
        
        hueOffset = hueOffset + (animationSpeed * 0.05)
        if hueOffset >= 2 * math.pi then
            hueOffset = hueOffset - 2 * math.pi
        end
        
        RunService.Heartbeat:Wait()
    end
end

coroutine.wrap(updateRainbowGradient)()

local originalPosition = rainbowText.Position
rainbowText.Position = originalPosition + UDim2.new(0, 0, 0, 50)
rainbowText.TextTransparency = 1

local fadeInTween = TweenService:Create(rainbowText, TweenInfo.new(1, Enum.EasingStyle.Back), {
    Position = originalPosition,
    TextTransparency = 0
})
fadeInTween:Play()

wait(5)

local function startDisappearAnimation()
    local breatheOut = TweenService:Create(rainbowText, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 380, 0, 95)
    })
    breatheOut:Play()
    
    wait(0.5)
    local fadeOutSlow = TweenService:Create(rainbowText, TweenInfo.new(2, Enum.EasingStyle.Quad), {
        TextTransparency = 0.7,
        BackgroundTransparency = 1
    })
    fadeOutSlow:Play()
    
    wait(1.5)
    local fadeOutFast = TweenService:Create(rainbowText, TweenInfo.new(1.5, Enum.EasingStyle.Exponential), {
        TextTransparency = 1,
        Position = rainbowText.Position + UDim2.new(0, 0, 0, 30)
    })
    fadeOutFast:Play()
    
    fadeOutFast.Completed:Connect(function()
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end)
end

startDisappearAnimation()

local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 0.843, 0)  -- 金色背景
LBL.BackgroundTransparency = 1  -- 背景透明
LBL.BorderColor3 = Color3.new(1, 0.843, 0)  -- 金色边框
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 0.843, 0)  -- 金色文字
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
  LastIteration = tick()
  for Index = #FrameUpdateTable, 1, -1 do
    FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
  end
  FrameUpdateTable[1] = LastIteration
  local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
  CurrentFPS = CurrentFPS - CurrentFPS % 1
  FpsLabel.Text = ("vip时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S").."秒")
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)

    --Kenny泛滥外部汉化脚本我的哔站UID:1531514159（删了这个死妈死爹死全家）
local Translations = {
    ["Close Window"] = "关闭窗口",
    ["Do you want to close this window? You will not be able to open it again."]= "求你了别关脚本😭😭",
    ["Cancel"]= "取消",
    ["Close Window"]= "关闭窗口",
    ["Locked"] = "锁定",
    ["Search"] = "搜索",
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败:", err)
       
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then
                                local translatedText = translateText(text)
                                if translatedText ~= text then
                                    gui.Text = translatedText
                                    translated[gui] = true
                                end
                            end
                        end)
                    end
                end
            end
        end
        
        local function setupDescendantListener(parent)
            parent.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    task.wait(0.1)
                    pcall(function()
                        local text = descendant.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                descendant.Text = translatedText
                            end
                        end
                    end)
                end
            end)
        end
        
        pcall(setupDescendantListener, game:GetService("CoreGui"))
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerGui") then
            pcall(setupDescendantListener, player.PlayerGui)
        end
        
        while true do
            scanAndTranslate()
            task.wait(3)
        end
    end
end

task.wait(2)

setupTranslationEngine()

local success, err = pcall(function()
--这下面填加载外部脚本



end)

if not success then
    warn("加载失败:", err)
end
    
    local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/sw/refs/heads/main/main.lua"))()
    end
end

-- 颜色方案定义
local COLOR_SCHEMES = {
    ["彩虹颜色"] = {
        ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
            ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
            ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
            ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
            ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
            ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))
        }),
        "palette"
    },
    -- 其他颜色方案...
}

local rainbowBorderAnimation
local currentBorderColorScheme = "彩虹颜色"
local borderInitialized = false
local animationSpeed = 2
local borderEnabled = true

-- 创建彩虹边框
local function createRainbowBorder(window, colorScheme, speed)
    if not window or not window.UIElements then
        wait(1)
        if not window or not window.UIElements then
            return nil, nil
        end
    end
    
    local mainFrame = window.UIElements.Main
    if not mainFrame then
        return nil, nil
    end
    
    local existingStroke = mainFrame:FindFirstChild("RainbowStroke")
    if existingStroke then
        local glowEffect = existingStroke:FindFirstChild("GlowEffect")
        if glowEffect then
            local schemeData = COLOR_SCHEMES[colorScheme or currentBorderColorScheme]
            if schemeData then
                glowEffect.Color = schemeData[1]
            end
        end
        return existingStroke, rainbowBorderAnimation
    end
    
    -- 添加圆角
    if not mainFrame:FindFirstChildOfClass("UICorner") then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 16)
        corner.Parent = mainFrame
    end
    
    -- 创建边框描边
    local rainbowStroke = Instance.new("UIStroke")
    rainbowStroke.Name = "RainbowStroke"
    rainbowStroke.Thickness = 1.5
    rainbowStroke.Color = Color3.new(1, 1, 1)
    rainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    rainbowStroke.LineJoinMode = Enum.LineJoinMode.Round
    rainbowStroke.Enabled = borderEnabled
    rainbowStroke.Parent = mainFrame
    
    -- 添加渐变效果
    local glowEffect = Instance.new("UIGradient")
    glowEffect.Name = "GlowEffect"
    
    local schemeData = COLOR_SCHEMES[colorScheme or currentBorderColorScheme]
    if schemeData then
        glowEffect.Color = schemeData[1]
    else
        glowEffect.Color = COLOR_SCHEMES["彩虹颜色"][1]
    end
    
    glowEffect.Rotation = 0
    glowEffect.Parent = rainbowStroke
    
    return rainbowStroke, nil
end

-- 启动边框动画
local function startBorderAnimation(window, speed)
    if not window or not window.UIElements then
        return nil
    end
    
    local mainFrame = window.UIElements.Main
    if not mainFrame then
        return nil
    end
    
    local rainbowStroke = mainFrame:FindFirstChild("RainbowStroke")
    if not rainbowStroke or not rainbowStroke.Enabled then
        return nil
    end
    
    local glowEffect = rainbowStroke:FindFirstChild("GlowEffect")
    if not glowEffect then
        return nil
    end
    
    if rainbowBorderAnimation then
        rainbowBorderAnimation:Disconnect()
        rainbowBorderAnimation = nil
    end
    
    local animation
    animation = game:GetService("RunService").Heartbeat:Connect(function()
        if not rainbowStroke or rainbowStroke.Parent == nil or not rainbowStroke.Enabled then
            animation:Disconnect()
            return
        end
        
        local time = tick()
        glowEffect.Rotation = (time * speed * 60) % 360
    end)
    
    rainbowBorderAnimation = animation
    return animation
end

-- 初始化彩虹边框
local function initializeRainbowBorder(scheme, speed)
    speed = speed or animationSpeed
    
    local rainbowStroke, _ = createRainbowBorder(Window, scheme, speed)
    if rainbowStroke then
        if borderEnabled then
            startBorderAnimation(Window, speed)
        end
        borderInitialized = true
        return true
    end
    return false
end

-- 在UI创建后初始化边框
if not borderInitialized then
    spawn(function()
        wait(0.5)
        initializeRainbowBorder("彩虹颜色", animationSpeed)
    end)
end

-- 创建金色主题
WindUI:AddTheme({
    Name = "GoldenTheme",
    Accent = Color3.fromHex("#FFD700"),      -- 金色主色调
    Dialog = Color3.fromHex("#2a2a2a"),
    Outline = Color3.fromHex("#FFA500"),     -- 橙色边框
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#888888"),
    Background = Color3.fromHex("#1a1a1a"),
    Button = Color3.fromHex("#4a3a1a"),      -- 金色系按钮
    Icon = Color3.fromHex("#FFD700")         -- 金色图标
})

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("GoldenTheme")  -- 应用金色主题

local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

local Window = WindUI:CreateWindow({
    Title = '<font color="#00FF00">刘某脚本</font>    ',  
    Icon = "badge-check",
    Author = "作者:刘某",
    Folder = "WindUI_Example",
    Size = UDim2.fromOffset(300, 350),
    Theme = "Dark",
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = "点这干啥",
                Content = "点了没有用",
                Duration = 3
            })
        end
    },
    SideBarWidth = 220,
    ScrollBarEnabled = true,
    HideSearchBar = false,
    Background = "rbxassetid://82541160764279"
})

Window:EditOpenButton({
    Title = "打开刘某脚本",
    Icon = "crown",
    CornerRadius = UDim.new(1, 1),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("#FFD700"),  
        Color3.fromHex("#FFA500")   
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
    Size = UDim2.new(0, 150, 0, 40)
})

Window:Tag({
    Title = "v3.0",
    Color = Color3.fromHex("#30ff6a")
})

Window:Tag({
    Title = "正式版",
    Color = Color3.fromHex("#FFD700")  -- 金色标签
})

local TimeTag = Window:Tag({
    Title = "00:00",
    Color = Color3.fromHex("#30ff6a"),
})

task.spawn(function()
    while true do
        for i = 0, 100 do
            local hue = i / 100
            TimeTag:SetColor(Color3.fromHSV(hue, 1, 1))
            TimeTag:SetTitle(os.date("%H:%M"))
            task.wait(0.06)
        end
    end
end)

spawn(function()
    while true do
        for hue = 0, 1, 0.01 do  
            local color = Color3.fromHSV(hue, 0.8, 1)  
            Window:EditOpenButton({
                Color = ColorSequence.new(color)
            })
            wait(0.04)  
        end
    end
end)
if not borderInitialized then
    spawn(function()
        wait(0.5)
        initializeRainbowBorder("彩虹颜色", animationSpeed)
        wait(1)
        applyFontStyleToWindow(currentFontStyle)
    end)
end

local windowOpen = true

Window:OnClose(function()
    windowOpen = false
    if rainbowBorderAnimation then
        rainbowBorderAnimation:Disconnect()
        rainbowBorderAnimation = nil
    end
end)

local originalOpenFunction = Window.Open
Window.Open = function(...)
    windowOpen = true
    local result = originalOpenFunction(...)
    
    if borderInitialized and borderEnabled and not rainbowBorderAnimation then
        wait(0.1)
        startBorderAnimation(Window, animationSpeed)
    end
    
    return result
end

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "GoldenTheme" or "Dark")
    WindUI:Notify({
        Title = "主题已更改",
        Content = "当前主题: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

local Tabs = {
    Settings = Window:Section({ Title = "界面", Opened = false }),
}

local TabHandles = {
    Appearance = Tabs.Settings:Tab({ Title = "颜色", Icon = "brush" }),
}

TabHandles.Appearance:Paragraph({
    Title = "自定义界面",
    Desc = "个性化您的体验",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local themeDropdown = TabHandles.Appearance:Dropdown({
    Title = "颜色",
    Values = themes,
    Value = "Dark",
    Callback = function(theme)
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "主题已应用",
            Content = theme,
            Icon = "crown",
            Duration = 2
        })
    end
})

local transparencySlider = TabHandles.Appearance:Slider({
    Title = "透明度",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.2,
    },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
    end
})

TabHandles.Appearance:Toggle({
    Title = "启用深色模式",
    Desc = "使用深色配色方案",
    Value = true,
    Callback = function(state)
        WindUI:SetTheme(state and "GoldenTheme" or "Light")
        themeDropdown:Select(state and "GoldenTheme" or "Light")
    end
})

TabHandles.Appearance:Button({
    Title = "创建新主题",
    Icon = "plus",
    Callback = function()
        Window:Dialog({
            Title = "创建主题",
            Content = "此功能即将推出！",
            Buttons = {
                {
                    Title = "确定",
                    Variant = "Primary"
                }
            }
        })
    end
})

local Tab = Window:Tab({
    Title = "简介",
    Icon = "app-window",
    Locked = false,
    Opened = true,
})

Tab:Select() -- Select Tab

local Section = Tab:Section({ 
    Title = "制作者:刘某",
    TextXAlignment = "Left",
    TextSize = 30
})

local Section = Tab:Section({ 
    Title = "合作者:一眼鸡",
    TextXAlignment = "Left",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "QQ群:1070646590",
    TextXAlignment = "Left",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "QQ群:1070646590",
    Desc = "点击复制",
    Locked = false,
    Callback = function()
        local groupKey = "1070646590"  -- 这里填写你的QQ群号
        if setclipboard then
            setclipboard(groupKey)
            WindUI:Notify({
                Title = "群号已复制",
                Content = "群号: " .. groupKey,
                Icon = "crown",
                Duration = 3
            })
            print("已复制群号: " .. groupKey)
        else
            WindUI:Notify({
                Title = "错误",
                Content = "复制功能不可用",
                Icon = "crown",
                Duration = 3
            })
        end
    end
})

local Tab = Window:Tab({
    Title = "通用",
    Icon = "play",
    Locked = false,
})

local Button = Tab:Button({
    Title = "通用飞",
    Desc = "好用",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E9%A3%9E%E8%A1%8C%E8%84%9A%E6%9C%ACV3(%E5%85%A8%E6%B8%B8%E6%88%8F%E9%80%9A%E7%94%A8)%20(1).txt"))()
        WindUI:Notify({
            Title = "飞",
            Content = "飞行",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Slider = Tab:Slider({
    Title = "速度",
    Desc = "修改移速",
    Step = 1,
    Value = {
        Min = 0,
        Max = 150,
        Default = 16,
    },
    Callback = function(value)
        -- 修改移动速度
        local player = game.Players.LocalPlayer
        local character = player.Character
                WindUI:Notify({
            Title = "移动速度",
            Content = "已设置为: " .. value,
            Icon = "crown",
            Duration = 3
        })
        if character and character:FindFirstChildOfClass("Humanoid") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            humanoid.WalkSpeed = value
        end
        
        print(value)

-- 角色重生时自动重新应用速度设置
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1) -- 等待角色完全加载
    if character:FindFirstChildOfClass("Humanoid") then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local currentValue = Slider:GetValue()
        humanoid.WalkSpeed = currentValue
    end
end)

-- 初始应用（如果已有角色）
if game.Players.LocalPlayer.Character then
    spawn(function()
        wait(1)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local currentValue = Slider:GetValue()
            humanoid.WalkSpeed = currentValue
         end
     end)
  end
end
})

local Slider = Tab:Slider({
    Title = "跳跃高度",
    Desc = "修改跳跃高度",
    Step = 1,
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(value)
        -- 存储跳跃强度值
        _G.JumpIntensity = value
        
        -- 显示修改通知
        WindUI:Notify({
            Title = "跳跃高度",
            Content = "已设置为: " .. value,
            Icon = "crown",
            Duration = 3
        })
        
        print(value)
-- 监听跳跃事件
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.JumpIntensity and _G.JumpIntensity > 50 then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local jumpForce = (_G.JumpIntensity - 50) * 2
            hrp.Velocity = Vector3.new(hrp.Velocity.X, jumpForce, hrp.Velocity.Z)
          end
       end
   end)
end
})

Slider:Lock()

local Toggle = Tab:Toggle({
    Title = "无限跳",
    Desc = "",
    Icon = "badge-check",
    Type = "Checkbox",
    Value = false, -- 默认值
    Callback = function(state)
        local InfiniteJumpEnabled = state
        
        -- 无限跳功能
        local function infiniteJump()
            if InfiniteJumpEnabled then
                -- 监听输入
                game:GetService("UserInputService").JumpRequest:Connect(function()
                    if InfiniteJumpEnabled then
                        -- 获取本地玩家
                        local player = game.Players.LocalPlayer
                        if player and player.Character then
                            -- 给角色一个向上的力来实现跳跃
                            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                    end
                end)
            end
        end
        
        -- 启动无限跳
        infiniteJump()
    end
})

local Toggle = Tab:Toggle({
    Title = "穿墙",
    Desc = "",
    Icon = "badge-check",
    Type = "Checkbox",
    Value = false, -- default value
    Callback = function(state)
        _G.NoclipEnabled = state
        
        if state then
            -- 开启穿墙
            _G.NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
                if _G.NoclipEnabled then
                    pcall(function()
                        local character = game.Players.LocalPlayer.Character
                        if character then
                            for _, part in pairs(character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end)
                end
            end)
        else
            -- 关闭时只需要断开连接
            if _G.NoclipConnection then
                _G.NoclipConnection:Disconnect()
                _G.NoclipConnection = nil
            end
            -- 不修改任何碰撞属性，让游戏自然处理
        end
    end
})

local Toggle = Tab:Toggle({
    Title = "夜视",
    Desc = "",
    Icon = "badge-check",
    Type = "Checkbox",
    Value = false, -- default value
    Callback = function(state) 
        pcall(function()
            if state then
                game.Lighting.Ambient = Color3.new(1, 1, 1)
            else
                game.Lighting.Ambient = Color3.new(0, 0, 0)
            end
        end)
    end
})

local Button = Tab:Button({
    Title = "透视",
    Desc = "不可关",
    Locked = false,
    Callback = function()
           while wait(1) do
local players = game.Players:GetPlayers()

for i,v in pairs(players) do
 local esp = Instance.new("Highlight")
 esp.Name = v.Name
 esp.FillTransparency = 0.5
 esp.FillColor = Color3.new(0, 0, 0)
 esp.OutlineColor = Color3.new(255, 255, 255)
 esp.OutlineTransparency = 0
 esp.Parent = v.Character
end
end
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "触碰甩飞",
    Desc = "甩飞",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "点击传送",
    Desc = "点击传送",
    Locked = false,
    Callback = function()
        mouse = game.Players.LocalPlayer:GetMouse()
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "点击传送"
tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
tool.Parent = game.Players.LocalPlayer.Backpack
        WindUI:Notify({
            Title = "加载成功",
            Content = "点击传送",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "转圈",
    Desc = "",
    Locked = false,
    Callback = function()
-- 创建UI元素
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RotationUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 主框架
local MainFrame = Instance.new("Frame")
MainFrame.Name = "RotationFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 130)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -65)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BackgroundTransparency = 0.5
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- 标题文本
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "旋转控制"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.Gotham
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextYAlignment = Enum.TextYAlignment.Center
Title.Parent = TitleBar

-- 最小化按钮
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 160, 220)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TitleBar

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.Gotham
CloseButton.Parent = TitleBar

-- 内容区域
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- 旋转控制按钮
local RotateButton = Instance.new("TextButton")
RotateButton.Name = "RotateButton"
RotateButton.Size = UDim2.new(0.8, 0, 0, 40)
RotateButton.Position = UDim2.new(0.1, 0, 0.1, 0)
RotateButton.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
RotateButton.Text = "开始旋转"
RotateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RotateButton.TextSize = 16
RotateButton.Font = Enum.Font.GothamBold
RotateButton.Parent = ContentFrame

-- 速度输入区域
local SpeedInputFrame = Instance.new("Frame")
SpeedInputFrame.Name = "SpeedInputFrame"
SpeedInputFrame.Size = UDim2.new(0.8, 0, 0, 50)
SpeedInputFrame.Position = UDim2.new(0.1, 0, 0.7, 0)
SpeedInputFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedInputFrame.BackgroundTransparency = 0.5
SpeedInputFrame.BorderSizePixel = 0
SpeedInputFrame.Parent = ContentFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Name = "SpeedLabel"
SpeedLabel.Size = UDim2.new(1, 0, 0.4, 0)
SpeedLabel.Position = UDim2.new(0, 5, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "旋转速度 (1-10000):"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.TextYAlignment = Enum.TextYAlignment.Center
SpeedLabel.Parent = SpeedInputFrame

local SpeedInputBox = Instance.new("TextBox")
SpeedInputBox.Name = "SpeedInputBox"
SpeedInputBox.Size = UDim2.new(0.9, 0, 0.5, 0)
SpeedInputBox.Position = UDim2.new(0.05, 0, 0.45, 0)
SpeedInputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedInputBox.BorderSizePixel = 1
SpeedInputBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
SpeedInputBox.Text = "500"
SpeedInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInputBox.TextSize = 14
SpeedInputBox.TextXAlignment = Enum.TextXAlignment.Center
SpeedInputBox.PlaceholderText = "输入1-10000"
SpeedInputBox.ClearTextOnFocus = false
SpeedInputBox.Parent = SpeedInputFrame

-- 最小化后的按钮
local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniButton"
MiniButton.Size = UDim2.new(0, 60, 0, 35)
MiniButton.Position = UDim2.new(0, 20, 0, 20) -- 默认位置
MiniButton.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
MiniButton.BackgroundTransparency = 0.3
MiniButton.BorderSizePixel = 1
MiniButton.BorderColor3 = Color3.fromRGB(100, 100, 100)
MiniButton.Text = "旋转"
MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniButton.TextSize = 14
MiniButton.Font = Enum.Font.Gotham
MiniButton.Visible = false
MiniButton.Active = true
MiniButton.Draggable = true
MiniButton.Parent = ScreenGui

-- 旋转控制变量
local isRotating = false
local rotationSpeed = 500
local connection

-- 新增：记录位置
local savedMiniButtonPosition = UDim2.new(0, 20, 0, 20) -- 初始位置
local savedMainFramePosition = MainFrame.Position -- 记录主窗口位置

-- 记录MiniButton位置的函数
local function saveMiniButtonPosition()
    savedMiniButtonPosition = MiniButton.Position
end

-- 记录MainFrame位置的函数
local function saveMainFramePosition()
    savedMainFramePosition = MainFrame.Position
end

-- 设置MiniButton位置监听
game:GetService("RunService").Heartbeat:Connect(function()
    if MiniButton.Visible then
        saveMiniButtonPosition()
    else
        saveMainFramePosition()
    end
end)

-- 旋转函数
local function rotateCharacter()
    if isRotating then
        local player = game.Players.LocalPlayer
        if player and player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local speedMultiplier = rotationSpeed / 100
                humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(speedMultiplier), 0)
            end
        end
    end
end

-- 更新速度函数
local function updateSpeed()
    local text = SpeedInputBox.Text
    if text == "" then
        rotationSpeed = 500
        SpeedInputBox.Text = "500"
        return
    end
    
    local num = tonumber(text)
    if num then
        if num < 1 then
            rotationSpeed = 1
            SpeedInputBox.Text = "1"
        elseif num > 10000 then
            rotationSpeed = 10000
            SpeedInputBox.Text = "10000"
        else
            rotationSpeed = math.floor(num + 0.5)
            SpeedInputBox.Text = tostring(rotationSpeed)
        end
    else
        rotationSpeed = 500
        SpeedInputBox.Text = "500"
    end
end

-- 输入框验证
SpeedInputBox.FocusLost:Connect(function()
    updateSpeed()
end)

SpeedInputBox:GetPropertyChangedSignal("Text"):Connect(function()
    if SpeedInputBox:IsFocused() then
        local text = SpeedInputBox.Text
        local newText = string.gsub(text, "[^0-9]", "")
        if newText ~= text then
            SpeedInputBox.Text = newText
        end
    end
end)

-- 旋转按钮点击事件
local function toggleRotation()
    isRotating = not isRotating
    
    if isRotating then
        RotateButton.Text = "停止旋转"
        RotateButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        MiniButton.Text = "旋转中"
        MiniButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        
        if connection then
            connection:Disconnect()
        end
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            rotateCharacter()
        end)
    else
        RotateButton.Text = "开始旋转"
        RotateButton.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
        MiniButton.Text = "旋转"
        MiniButton.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
        
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

RotateButton.MouseButton1Click:Connect(toggleRotation)

-- 修复：最小化按钮点击事件 - 记录主窗口位置并使用保存的小按钮位置
MinimizeButton.MouseButton1Click:Connect(function()
    -- 保存主窗口当前位置
    saveMainFramePosition()
    
    -- 显示小按钮，使用上次保存的位置
    MainFrame.Visible = false
    MiniButton.Visible = true
    MiniButton.Position = savedMiniButtonPosition
    
    print("已最小化，小按钮位置:", 
        math.floor(savedMiniButtonPosition.X.Offset), 
        math.floor(savedMiniButtonPosition.Y.Offset))
end)

-- 修复：小按钮点击事件 - 恢复窗口并记录小按钮位置
MiniButton.MouseButton1Click:Connect(function()
    -- 保存小按钮当前位置
    saveMiniButtonPosition()
    
    -- 恢复主窗口，使用上次保存的主窗口位置
    MainFrame.Visible = true
    MiniButton.Visible = false
    MainFrame.Position = savedMainFramePosition
    
    print("已恢复，主窗口位置:", 
        math.floor(savedMainFramePosition.X.Offset), 
        math.floor(savedMainFramePosition.Y.Offset))
end)

-- 小按钮右键点击（切换旋转状态）
MiniButton.MouseButton2Click:Connect(toggleRotation)

-- 关闭按钮事件
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 鼠标悬停效果
RotateButton.MouseEnter:Connect(function()
    if not isRotating then
        RotateButton.BackgroundColor3 = Color3.fromRGB(80, 140, 220)
    end
end)

RotateButton.MouseLeave:Connect(function()
    if not isRotating then
        RotateButton.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
    end
end)

MinimizeButton.MouseEnter:Connect(function()
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 180, 240)
end)

MinimizeButton.MouseLeave:Connect(function()
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 160, 220)
end)

CloseButton.MouseEnter:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
end)

MiniButton.MouseEnter:Connect(function()
    MiniButton.BackgroundTransparency = 0.1
    MiniButton.BorderColor3 = Color3.fromRGB(150, 150, 150)
end)

MiniButton.MouseLeave:Connect(function()
    MiniButton.BackgroundTransparency = 0.3
    MiniButton.BorderColor3 = Color3.fromRGB(100, 100, 100)
end)

-- 输入框效果
SpeedInputBox.MouseEnter:Connect(function()
    SpeedInputBox.BorderColor3 = Color3.fromRGB(120, 120, 120)
end)

SpeedInputBox.MouseLeave:Connect(function()
    if not SpeedInputBox:IsFocused() then
        SpeedInputBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
    end
end)

SpeedInputBox.Focused:Connect(function()
    SpeedInputBox.BorderColor3 = Color3.fromRGB(60, 120, 200)
end)

SpeedInputBox.FocusLost:Connect(function()
    SpeedInputBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
end)

-- 初始化
updateSpeed()

-- 清理函数
local function cleanup()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    isRotating = false
    RotateButton.Text = "开始旋转"
    RotateButton.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
    MiniButton.Text = "旋转"
    MiniButton.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
end

-- 角色重生时清理
game.Players.LocalPlayer.CharacterAdded:Connect(cleanup)

-- 添加快捷键
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Up then
        rotationSpeed = math.min(rotationSpeed + 100, 10000)
        SpeedInputBox.Text = tostring(rotationSpeed)
    elseif input.KeyCode == Enum.KeyCode.Down then
        rotationSpeed = math.max(rotationSpeed - 100, 1)
        SpeedInputBox.Text = tostring(rotationSpeed)
    end
end)
        WindUI:Notify({
            Title = "转圈",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "防甩飞",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ChinaQY/Scripts/Main/AntiFling.lua"))()
        WindUI:Notify({
            Title = "防甩",
            Content = "防甩",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "甩所有人",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "秒互动",
    Desc = "",
    Locked = false,
    Callback = function()
local ProximityPromptService = game:GetService("ProximityPromptService")

local lastInteractionTime = 0
local INTERACTION_DELAY = 0.5 -- 0.5秒互动一次

ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    local currentTime = tick()
    
    -- 检查是否达到互动间隔
    if currentTime - lastInteractionTime >= INTERACTION_DELAY then
        fireproximityprompt(prompt)
        lastInteractionTime = currentTime
    end
end)
        WindUI:Notify({
            Title = "秒互动",
            Content = "已加载",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "传送到玩家位置",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tfcygvunbind/557/1bd994773a5f2e34c81611a5903c0773c97d2b99/%EF%BC%9F"))()
        WindUI:Notify({
            Title = "加载成功",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "死铁轨",
    Icon = "train-track",
    Locked = false,
})

local Section = Tab:Section({ 
    Title = "红叶脚本好用👍",
    TextXAlignment = "Left",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "红叶汉化",
    Desc = "点完后点下面一个",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/stghongye.lua"))()
        WindUI:Notify({
            Title = "红叶子汉化",
            Content = "副包",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "红叶汉化",
    Desc = "点完这个就可以用了",
    Locked = false,
    Callback = function()
        script_key="这里填你的卡密";
(loadstring or load)(game:HttpGet("https://getnative.cc/script/loader"))()
        WindUI:Notify({
            Title = "红叶子汉化",
            Content = "主包",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Section = Tab:Section({ 
    Title = "--------------脚本分割线--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "--------------刘某自制区--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "LM自动刷债券",
    Desc = "还可以",
    Locked = false,
    Callback = function()
        if not game:IsLoaded() then game.Loaded:Wait() end

if _G.Rejoined then return end

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
Players.LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").Died:Connect(function()
        queueonteleport("_G.Rejoined = true")
        TeleportService:Teleport(game.PlaceId)
    end)
end)
repeat task.wait() until Players.LocalPlayer.Character and not Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingScreenPrefab")
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EndDecision"):FireServer(false)

if not game.CoreGui:FindFirstChild("BondFarm") then
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "BondFarm"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Name = "mainFrame"
    mainFrame.Size = UDim2.new(0, 200, 0, 80)
    mainFrame.Position = UDim2.new(0, 20, 0, 100)
    mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    mainFrame.ZIndex = 2

    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart = nil
    local startPos = nil

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    mainFrame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local title = Instance.new("TextLabel", mainFrame)
    title.Size = UDim2.new(1, 0, 0.4, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "LM刷债券"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.ZIndex = 3

    local bondCount = Instance.new("TextLabel", mainFrame)
    bondCount.Name = "bondCount"
    bondCount.Size = UDim2.new(1, 0, 0.6, 0)
    bondCount.Position = UDim2.new(0, 0, 0.4, 0)
    bondCount.BackgroundTransparency = 1
    bondCount.Text = "债券数量: 0"
    bondCount.TextColor3 = Color3.new(0.8, 0.8, 1)
    bondCount.TextScaled = true
    bondCount.Font = Enum.Font.SourceSans
    bondCount.ZIndex = 3
end

_G.Bond = 0
workspace.RuntimeItems.ChildAdded:Connect(function(v)
    if v.Name:find("Bond") and v:FindFirstChild("Part") then
        v.Destroying:Connect(function()
            _G.Bond += 1
        end)
    end
end)

task.spawn(function()
    while true do
        local gui = game.CoreGui:FindFirstChild("BondFarm")
        if gui and gui:FindFirstChild("mainFrame") and gui.mainFrame:FindFirstChild("bondCount") then
            gui.mainFrame.bondCount.Text = "债券数量: " .. tostring(_G.Bond)
        end
        task.wait(0.1)
    end
end)

local player = Players.LocalPlayer
player.CameraMode = "Classic"
player.CameraMaxZoomDistance = math.huge
player.CameraMinZoomDistance = 30

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
workspace.CurrentCamera.CameraSubject = hum
hrp.Anchored = true
task.wait(0.2)

hrp.CFrame = CFrame.new(80, 3, -9000)
repeat task.wait() until workspace.RuntimeItems:FindFirstChild("MaximGun")
task.wait(0.2)

for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
    if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
        v.VehicleSeat.Disabled = false
        v.VehicleSeat:SetAttribute("Disabled", false)
        v.VehicleSeat:Sit(hum)
    end
end

task.wait(0.2)
for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
    if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") and (hrp.Position - v.VehicleSeat.Position).Magnitude < 400 then
        hrp.CFrame = v.VehicleSeat.CFrame
    end
end

task.wait(0.5)
hrp.Anchored = false
repeat task.wait(0.1) until hum.Sit
task.wait(0.3)
hum.Sit = false
task.wait(0.2)

repeat
    for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
        if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") and (hrp.Position - v.VehicleSeat.Position).Magnitude < 400 then
            hrp.CFrame = v.VehicleSeat.CFrame
        end
    end
    task.wait(0.2)
until hum.Sit

task.wait(0.4)
for _, v in pairs(workspace:GetChildren()) do
    if v:IsA("Model") and v:FindFirstChild("RequiredComponents") then
        local seat = v.RequiredComponents:FindFirstChild("Controls") and v.RequiredComponents.Controls:FindFirstChild("ConductorSeat") and v.RequiredComponents.Controls.ConductorSeat:FindFirstChild("VehicleSeat")
        if seat then
            local tp = game:GetService("TweenService"):Create(hrp, TweenInfo.new(15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {CFrame = seat.CFrame * CFrame.new(0, 20, 0)})
            tp:Play()
            if not hrp:FindFirstChild("VelocityHandler") then
                local bv = Instance.new("BodyVelocity", hrp)
                bv.Name = "VelocityHandler"
                bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                bv.Velocity = Vector3.zero
            end
            tp.Completed:Wait()
        end
    end
end

task.wait(0.5)
while true do
    if hum.Sit then
        local tp = game:GetService("TweenService"):Create(hrp, TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {CFrame = CFrame.new(0.5, -78, -49429)})
        tp:Play()
        if not hrp:FindFirstChild("VelocityHandler") then
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name = "VelocityHandler"
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.zero
        end
        repeat task.wait() until workspace.RuntimeItems:FindFirstChild("Bond")
        tp:Cancel()

        for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
            if v.Name:find("Bond") and v:FindFirstChild("Part") then
                repeat
                    if v:FindFirstChild("Part") then
                        hrp.CFrame = v.Part.CFrame
                        game:GetService("ReplicatedStorage").Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
                    end
                    task.wait(0.1)
                until not v:FindFirstChild("Part")
            end
        end
    end
    task.wait(0.1)
end
        WindUI:Notify({
            Title = "已加载",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "启用所有机枪坐位",
    Desc = "可以坐在附近的机枪上",
    Locked = false,
    Callback = function()
        local count = 0
        
        -- 启用所有MaximGun的座位
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
                v.VehicleSeat.Disabled = false
                count = count + 1
            end
        end
        
        WindUI:Notify({
            Title = "机枪启用",
            Content = "已启用 " .. count .. " 个机枪",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "拿机枪",
    Desc = "请先等待死铁轨加载完毕",
    Locked = false,
    Callback = function()
        local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

hrp.Anchored = true

hrp.CFrame = CFrame.new(80, 3, -9000)

repeat task.wait() until workspace.RuntimeItems:FindFirstChild("MaximGun")
task.wait(0.2)

for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
    if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
        v.VehicleSeat.Disabled = false
        v.VehicleSeat:SetAttribute("Disabled", false)
        v.VehicleSeat:Sit(hum)
    end
end

task.wait(0.2)
for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
    if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") and (hrp.Position - v.VehicleSeat.Position).Magnitude < 400 then
        hrp.CFrame = v.VehicleSeat.CFrame
    end
end

task.wait(2)

task.wait(0.5)
hrp.Anchored = false
repeat task.wait(0.1) until hum.Sit

hum.Sit = false
task.wait(0.5)

for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
    if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
        v.VehicleSeat:Sit(hum)
        break
    end
end

task.wait(0.5)

hrp.CFrame = CFrame.new(-0.2, 3.0, 29900.4)
        WindUI:Notify({
            Title = "已获取",
            Content = "已拿取",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "若需要飞行，请使用此脚本",
    Desc = "飞车",
    Locked = false,
    Callback = function()
        local Flymguiv2 = Instance.new("ScreenGui")
local Drag = Instance.new("Frame")
local FlyFrame = Instance.new("Frame")
local ddnsfbfwewefe = Instance.new("TextButton")
local Speed = Instance.new("TextBox")
local Fly = Instance.new("TextButton")
local Speeed = Instance.new("TextLabel")
local Stat = Instance.new("TextLabel")
local Stat2 = Instance.new("TextLabel")
local Unfly = Instance.new("TextButton")
local Vfly = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local Flyon = Instance.new("Frame")
local W = Instance.new("TextButton")
local S = Instance.new("TextButton")

Flymguiv2.Name = "Flym gui v2"
Flymguiv2.Parent = game.CoreGui
Flymguiv2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Drag.Name = "Drag"
Drag.Parent = Flymguiv2
Drag.Active = true
Drag.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Drag.BorderSizePixel = 0
Drag.Draggable = true
Drag.Position = UDim2.new(0.482438415, 0, 0.454874992, 0)
Drag.Size = UDim2.new(0, 237, 0, 27)

FlyFrame.Name = "FlyFrame"
FlyFrame.Parent = Drag
FlyFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FlyFrame.BorderSizePixel = 0
FlyFrame.Draggable = true
FlyFrame.Position = UDim2.new(-0.00200000009, 0, 0.989000022, 0)
FlyFrame.Size = UDim2.new(0, 237, 0, 139)

ddnsfbfwewefe.Name = "ddnsfbfwewefe"
ddnsfbfwewefe.Parent = FlyFrame
ddnsfbfwewefe.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
ddnsfbfwewefe.BorderSizePixel = 0
ddnsfbfwewefe.Position = UDim2.new(-0.000210968778, 0, -0.00395679474, 0)
ddnsfbfwewefe.Size = UDim2.new(0, 237, 0, 27)
ddnsfbfwewefe.Font = Enum.Font.SourceSans
ddnsfbfwewefe.Text = "LM脚本飞车"
ddnsfbfwewefe.TextColor3 = Color3.fromRGB(255, 255, 255)
ddnsfbfwewefe.TextScaled = true
ddnsfbfwewefe.TextSize = 14.000
ddnsfbfwewefe.TextWrapped = true

Speed.Name = "Speed"
Speed.Parent = FlyFrame
Speed.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
Speed.BorderColor3 = Color3.fromRGB(0, 0, 191)
Speed.BorderSizePixel = 0
Speed.Position = UDim2.new(0.445025861, 0, 0.402877688, 0)
Speed.Size = UDim2.new(0, 111, 0, 33)
Speed.Font = Enum.Font.SourceSans
Speed.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Speed.Text = "50"
Speed.TextColor3 = Color3.fromRGB(255, 255, 255)
Speed.TextScaled = true
Speed.TextSize = 14.000
Speed.TextWrapped = true

Fly.Name = "Fly"
Fly.Parent = FlyFrame
Fly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Fly.BorderSizePixel = 0
Fly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
Fly.Size = UDim2.new(0, 199, 0, 32)
Fly.Font = Enum.Font.SourceSans
Fly.Text = "开启"
Fly.TextColor3 = Color3.fromRGB(255, 255, 255)
Fly.TextScaled = true
Fly.TextSize = 14.000
Fly.TextWrapped = true
Fly.MouseButton1Click:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        Fly.Visible = false
        Stat2.Text = "开启"
        Stat2.TextColor3 = Color3.fromRGB(0, 255, 0)
        Unfly.Visible = true
        Flyon.Visible = true
        local BV = Instance.new("BodyVelocity",HumanoidRP)
        local BG = Instance.new("BodyGyro",HumanoidRP)
        BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        game:GetService('RunService').RenderStepped:connect(function()
        BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        BG.D = 5000
        BG.P = 100000
        BG.CFrame = game.Workspace.CurrentCamera.CFrame
        end)
end)

Speeed.Name = "Speeed"
Speeed.Parent = FlyFrame
Speeed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Speeed.BorderSizePixel = 0
Speeed.Position = UDim2.new(0.0759493634, 0, 0.402877688, 0)
Speeed.Size = UDim2.new(0, 87, 0, 32)
Speeed.ZIndex = 0
Speeed.Font = Enum.Font.SourceSans
Speeed.Text = "速度:"
Speeed.TextColor3 = Color3.fromRGB(255, 255, 255)
Speeed.TextScaled = true
Speeed.TextSize = 14.000
Speeed.TextWrapped = true

Stat.Name = "Stat"
Stat.Parent = FlyFrame
Stat.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Stat.BorderSizePixel = 0
Stat.Position = UDim2.new(0.299983799, 0, 0.239817441, 0)
Stat.Size = UDim2.new(0, 85, 0, 15)
Stat.Font = Enum.Font.SourceSans
Stat.Text = "状态:"
Stat.TextColor3 = Color3.fromRGB(255, 255, 255)
Stat.TextScaled = true
Stat.TextSize = 14.000
Stat.TextWrapped = true

Stat2.Name = "Stat2"
Stat2.Parent = FlyFrame
Stat2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Stat2.BorderSizePixel = 0
Stat2.Position = UDim2.new(0.546535194, 0, 0.239817441, 0)
Stat2.Size = UDim2.new(0, 27, 0, 15)
Stat2.Font = Enum.Font.SourceSans
Stat2.Text = "关闭"
Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
Stat2.TextScaled = true
Stat2.TextSize = 14.000
Stat2.TextWrapped = true

Unfly.Name = "Unfly"
Unfly.Parent = FlyFrame
Unfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Unfly.BorderSizePixel = 0
Unfly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
Unfly.Size = UDim2.new(0, 199, 0, 32)
Unfly.Visible = false
Unfly.Font = Enum.Font.SourceSans
Unfly.Text = "停止"
Unfly.TextColor3 = Color3.fromRGB(255, 255, 255)
Unfly.TextScaled = true
Unfly.TextSize = 14.000
Unfly.TextWrapped = true
Unfly.MouseButton1Click:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        Fly.Visible = true
        Stat2.Text = "关闭"
        Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
        wait()
        Unfly.Visible = false
        Flyon.Visible = false
        HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()
        HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()
end)

Vfly.Name = "Vfly"
Vfly.Parent = Drag
Vfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Vfly.BorderSizePixel = 0
Vfly.Size = UDim2.new(0, 57, 0, 27)
Vfly.Font = Enum.Font.SourceSans
Vfly.Text = "飞车"
Vfly.TextColor3 = Color3.fromRGB(255, 255, 255)
Vfly.TextScaled = true
Vfly.TextSize = 14.000
Vfly.TextWrapped = true

Close.Name = "Close"
Close.Parent = Drag
Close.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.875, 0, 0, 0)
Close.Size = UDim2.new(0, 27, 0, 27)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextScaled = true
Close.TextSize = 14.000
Close.TextWrapped = true
Close.MouseButton1Click:Connect(function()
        Flymguiv2:Destroy()
end)

Minimize.Name = "Minimize"
Minimize.Parent = Drag
Minimize.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0.75, 0, 0, 0)
Minimize.Size = UDim2.new(0, 27, 0, 27)
Minimize.Font = Enum.Font.SourceSans
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextScaled = true
Minimize.TextSize = 14.000
Minimize.TextWrapped = true
function Mini()
        if Minimize.Text == "-" then
                Minimize.Text = "+"
                FlyFrame.Visible = false
        elseif Minimize.Text == "+" then
                Minimize.Text = "-"
                FlyFrame.Visible = true
        end
end
Minimize.MouseButton1Click:Connect(Mini)

Flyon.Name = "Fly on"
Flyon.Parent = Flymguiv2
Flyon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Flyon.BorderSizePixel = 0
Flyon.Position = UDim2.new(0.117647067, 0, 0.550284624, 0)
Flyon.Size = UDim2.new(0.148000002, 0, 0.314999998, 0)
Flyon.Visible = false
Flyon.Active = true
Flyon.Draggable = true

W.Name = "W"
W.Parent = Flyon
W.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
W.BorderSizePixel = 0
W.Position = UDim2.new(0.134719521, 0, 0.0152013302, 0)
W.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)
W.Font = Enum.Font.SourceSans
W.Text = "^"
W.TextColor3 = Color3.fromRGB(255, 255, 255)
W.TextScaled = true
W.TextSize = 14.000
W.TextWrapped = true
W.TouchLongPress:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

W.MouseButton1Click:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

S.Name = "S"
S.Parent = Flyon
S.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
S.BorderSizePixel = 0
S.Position = UDim2.new(0.134000003, 0, 0.479999989, 0)
S.Rotation = 180.000
S.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)
S.Font = Enum.Font.SourceSans
S.Text = "^"
S.TextColor3 = Color3.fromRGB(255, 255, 255)
S.TextScaled = true
S.TextSize = 14.000
S.TextWrapped = true
S.TouchLongPress:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

S.MouseButton1Click:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)
        WindUI:Notify({
            Title = "LM飞车",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Section = Tab:Section({ 
    Title = "--------------脚本分割线--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "--------------刷债券--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "刷债券(若黑屏点下屏幕即可)",
    Desc = "非常好用不解卡",
    Locked = false,
    Callback = function()
        getgenv().BondFarmSetting = {
	Fast_Auto_Execute = true, -- Use queue_on_teleport to execute faster than your executor itself 
	Number_Of_Bonds_Targeted = 9e9, -- When your bonds reached the number you wanted, the will script automatically be stopped
	Tween_Duration = 23, -- The smaller number, the faster it goes (best is 23)
	Webhook_Url = "none",
	Main_Auto_SHOP_Delay = 70, -- auto server hop after time ended in main game
	Lobby_Auto_SHOP_Delay = 25, -- auto server hop after time ended in lobby
	Goto_Party_By_Walking_Only = false, -- if you set to false, it instantly teleport you to party creator, else it make you walk to party creator 
	Blackscreen_Save_Battery = true,
	Show_Bonds_Collected_On_Blackscreen = false
}
SaveNewSettings = true 
script_key = "DonjoSx_Was_Not_Here" -- Script key, don't remove this
loadstring(game:HttpGet("https://raw.githubusercontent.com/Umbrella-Scripter/Deadrails-Script/refs/heads/main/average-bond-farm.lua"))()
        WindUI:Notify({
            Title = "好用",
            Content = "不用解卡",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "死铁轨",
    Desc = "要解卡",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
        WindUI:Notify({
            Title = "有点老爷",
            Content = "老爷",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "Tx",
    Desc = "刷债券",
    Locked = false,
    Callback = function()
        --[[by 退休不退休]]
QUN = "160369111"
TX = "退休脚本"
BY = "退休"
script = "死铁轨免费刷债券"
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/%E5%88%B7%E5%80%BA%E5%88%B8"))()
        WindUI:Notify({
            Title = "老爷刷债券",
            Content = "不用卡密",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "自动刷债券",
    Desc = "要卡密",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
        WindUI:Notify({
            Title = "没用过",
            Content = "不知道咋样",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "刷债券",
    Desc = "要卡密",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ArdyBotzz/NatHub/refs/heads/master/NatHub.lua"))()
        WindUI:Notify({
            Title = "还行",
            Content = "没用过",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "v5刷债券",
    Desc = "最好用的",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader'))()
        WindUI:Notify({
            Title = "刷债券",
            Content = "要解卡",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Section = Tab:Section({ 
    Title = "--------------实用脚本区--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "xk脚本",
    Desc = "有焊接",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/DeadRail"))()
        WindUI:Notify({
            Title = "xk脚本",
            Content = "加载成功…",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "99夜",
    Icon = "shield",
    Locked = false,
})

local Button = Tab:Button({
    Title = "虚空",
    Desc = "汉化版",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/atnew2025/Chinese-scripts/refs/heads/main/voidware-cn.txt"))()
        WindUI:Notify({
            Title = "虚空汉化",
            Content = "好用",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "99夜无敌脚本",
    Desc = "汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/森林中的99夜.lua"))()
        WindUI:Notify({
            Title = "好用",
            Content = "汉化版",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Section = Tab:Section({ 
    Title = "--------------脚本分割线--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "同一个老外做外卡密通用",
    TextXAlignment = "Left",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "99夜最无敌",
    Desc = "汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/99%E5%A4%9C%E6%B1%89%E5%8C%96.txt"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某汉化",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "99夜刷糖果",
    Desc = "要解卡",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://api.luarmor.net/files/v3/loaders/c87b3621b22ecc2c8b474f95c47ecb40.lua'))()
        WindUI:Notify({
            Title = "好用",
            Content = "要解卡",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "99夜刷砖石",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://api.luarmor.net/files/v3/loaders/8ee53a2a2e39163362c725415e1307ab.lua'))()
        WindUI:Notify({
            Title = "好用",
            Content = "要解卡",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Section = Tab:Section({ 
    Title = "--------------脚本分割线--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Tab = Window:Tab({
    Title = "doors",
    Icon = "door-open",
    Locked = false,
})

local Button = Tab:Button({
    Title = "doors",
    Desc = "汉化1",
    Locked = false,
    Callback = function()
          loadstring(game:HttpGet("https://velocityloader.vercel.app/"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某寻找",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Paragraph = Tab:Paragraph({
    Title = "上面的卡密",
    Desc = "点击复制按钮获取卡密",
    Color = Color3.fromHex("#FFD700"), -- 改为金色
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "crown",
            Title = "复制",
            Callback = function()
                local cardKey = "VelocityXFreeDoorsKey" 
                if setclipboard then
                    setclipboard(cardKey)
                    WindUI:Notify({
                        Title = "卡密复制",
                        Content = "卡密已复制到剪贴板: " .. cardKey,
                        Icon = "crown",
                        Duration = 5
                    })
                    print("卡密已复制: " .. cardKey)
                else
                    WindUI:Notify({
                        Title = "错误",
                        Content = "复制功能不可用",
                        Icon = "crown",
                        Duration = 3
                    })
                end
            end,
        }
    }
})

local Button = Tab:Button({
    Title = "doors",
    Desc = "汉化2",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/atnew2025/Chinese-scripts/refs/heads/main/mshax(prohax).txt"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "doors",
    Desc = "汉化3",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://www.msdoors.xyz/script"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "doors",
    Desc = "汉化4",
    Locked = false,
    Callback = function()
          --[[Doors Blackking And BobHub脚本汉化]]loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "内脏与黑火药",
    Icon = "skull",
    Locked = false,
})

local Button = Tab:Button({
    Title = "鲨脚本",
    Desc = "ui有点挡屏幕",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\102\121\46\97\112\112\47\65\51\78\113\122\52\78\112\47\114\97\119"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "🤑",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "Katchi Hub2.1",
    Desc = "英文",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XaviscoZ/roblox/refs/heads/main/g%26b.lua"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "老外脚本2",
    Desc = "英文",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/4f5c7bbe546251d81e9d3554b109008f.lua"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Section = Tab:Section({ 
    Title = "--------------经彭某反馈已添加↓--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "Katchi Hub4.4",
    Desc = "有飞行",
    Locked = false,
    Callback = function()
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/716e6083239381ecd8b1f0591e383b2005a6fd5d87ede30645fac4f53e764d4a/download"))()
        WindUI:Notify({
            Title = "好用",
            Content = "极品",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "翻译",
    Desc = "先凑合着用这个以后刘某自己再做",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BS58dL/BS/refs/heads/main/双APl翻译.txt"))()
        WindUI:Notify({
            Title = "bs",
            Content = "API",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "墨水脚本",
    Icon = "cookie",
    Locked = false,
})

local Button = Tab:Button({
    Title = "刘某墨水脚本",
    Desc = "1070646590",
    Icon = "cookie"
})

local Paragraph = Tab:Paragraph({
    Title = "墨水的脚本",
    Desc = "点击复制按钮获取脚本链接",
    Color = Color3.fromHex("#FFD700"), -- 改为金色
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "crown",
            Title = "复制",
            Callback = function()
                local cardKey = "https://raw.githubusercontent.com/liuliuqiang404-code/6/refs/heads/main/刘某墨水脚本" 
                if setclipboard then
                    setclipboard(cardKey)
                    WindUI:Notify({
                        Title = "脚本复制",
                        Content = "脚本已复制到剪贴板: " .. cardKey,
                        Icon = "crown",
                        Duration = 5
                    })
                    print("脚本已复制: " .. cardKey)
                else
                    WindUI:Notify({
                        Title = "错误",
                        Content = "复制功能不可用",
                        Icon = "cookie",
                        Duration = 3
                    })
                end
            end,
        }
    }
})

local Tab = Window:Tab({
    Title = "脚本中心",
    Icon = "cloud-check",
    Locked = false,
})

local Button = Tab:Button({
    Title = "皮脚本",
    Desc = "中文",
    Locked = false,
    Callback = function()
      getgenv().XiaoPi="皮脚本QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()  
        WindUI:Notify({
            Title = "无敌皮脚本",
            Content = "好用",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "kg",
    Desc = "kg",
    Locked = false,
    Callback = function()
        KG_SCRIPT = "张硕制作"
loadstring(game:HttpGet("https://github.com/ZS-NB/KG/raw/main/Zhang-Shuo.lua"))()
        WindUI:Notify({
            Title = "🤓",
            Content = "🤓",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "xk脚本",
    Desc = "中文",
    Locked = false,
    Callback = function()
      loadstring(game:HttpGet(('https://github.com/devslopo/DVES/raw/main/XK%20Hub')))()
        WindUI:Notify({
            Title = "无敌xk脚本",
            Content = "加载成功…",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "测试版",
    Desc = "皮脚本",
    Locked = false,
    Callback = function()
        getgenv().XiaoPi="皮脚本测试版QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/PijiaobenV1.lua"))()
        WindUI:Notify({
            Title = "皮脚本",
            Content = "无敌",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "TX",
    Desc = "TX",
    Locked = false,
    Callback = function()
        TX = "脚本群:160369111"
Script = "Free永久免费"
loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/TX-Free-YYDS/refs/heads/main/FREE-TX-TEAM"))()
        WindUI:Notify({
            Title = "TX",
            Content = "TX",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "战争大亨",
    Icon = "shield-check",
    Locked = false,
})

local Button = Tab:Button({
    Title = "战争大亨",
    Desc = "汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E6%88%98%E4%BA%89%E5%A4%A7%E4%BA%A8%E6%B1%89%E5%8C%96"))()
        WindUI:Notify({
            Title = "刘某汉化",
            Content = "无敌",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "跟上面的一样",
    Desc = "但是kenny汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%88%98%E4%BA%89%E5%A4%A7%E4%BA%A8.txt"))()
        WindUI:Notify({
            Title = "好用",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "偷走脑红",
    Icon = "flame",
    Locked = false,
})

local Button = Tab:Button({
    Title = "偷走红脚本",
    Desc = "",
    Locked = false,
    Callback = function()
        -- 复制卡密到剪贴板
        local cardKey = "Arbix hub" -- 替换为实际的卡密
        if setclipboard then
            setclipboard(cardKey)
        end
        
        -- 执行原有脚本
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/ArbixHubBEST.lua"))()    
        
        WindUI:Notify({
            Title = "已加载",
            Content = "卡密已自动复制到剪贴板",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "隐身脚本",
    Desc = "还没试过，不知道有没有用",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/o9mKKAda/raw"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "偷走脑红",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/ULdWe37N/raw"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "偷走脑红",
    Desc = "要解卡",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-a-brainrot/refs/heads/main/Protected_3771863424757750.lua.txt"))()
        WindUI:Notify({
            Title = "有防🐔打",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "自然灾害",
    Icon = "cloud-off",
    Locked = false,
})

local Button = Tab:Button({
    Title = "自然灾害",
    Desc = "无敌少侠飞",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
        WindUI:Notify({
            Title = "好玩",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "防坠落",
    Desc = "刘某",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E9%98%B2%E5%9D%A0%E8%90%BD2"))()
        WindUI:Notify({
            Title = "好用",
            Content = "可以",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "被打压怎么办",
    Icon = "skull",
    Locked = false,
})

local Button = Tab:Button({
    Title = "神秘",
    Desc = "神秘",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fake-lag-41217"))()
        WindUI:Notify({
            Title = "笑死他们",
            Content = "跑慢点",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "反击",
    Desc = "踢出所有人",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E8%B8%A2%E4%BA%BA"))()
        WindUI:Notify({
            Title = "猛攻",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "机甲变身",
    Desc = "机甲变身",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E8%87%AA%E6%9D%80"))()
        WindUI:Notify({
            Title = "机甲变身",
            Content = "横扫千军",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "做脚本",
    Icon = "crown",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "Dex",
    Desc = "汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))()
        WindUI:Notify({
            Title = "dex",
            Content = "dex",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "神秘区",
    Icon = "shield-off",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "别点",
    Desc = "求你了",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-DO-NOT-EXECUTE-61096"))()
        WindUI:Notify({
            Title = "等掉",
            Content = "还敢点",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "r币",
    Desc = "无限",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/SxhPVOyM/raw"))()
        WindUI:Notify({
            Title = "无限",
            Content = "r币😍",
            Icon = "crown",
            Duration = 3
        })
    end
})

end

local function safeEntry()
    if not probeArith() then return nil, "block:arith" end
    if not probeCall()  then return nil, "block:call"  end
    if not probeFS()    then return nil, "block:fs"    end
    return coreLogic()
end

local success, tag = safeEntry()
if not success then
    warn("lEAI:已拦截异常执行 (" .. tostring(tag) .. ")")
    script:ClearAllChildren()
    script.Source = ""
    return
end

