-- =================================================================
-- 🦊🌸⛩️ KITSUNE HUB V1.0 - THE CLASSIC SOCCER (TCS)
-- GitHub RAW Universal Loader
-- =================================================================

local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("KitsuneHub") then
    CoreGui.KitsuneHub:Destroy()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- ==================== SISTEMA DE IDIOMAS ====================
local CurrentLang = "PT"

local Translations = {
    PT = {
        Title = "KITSUNE HUB 🦊🌸⛩️",
        TabHome = "⛩️ Home",
        TabFollow = "⚽ Follow",
        TabBall = "🌀 Ball",
        TabGraphics = "🌿 Visuals",
        TabGK = "🧤 GK",
        Welcome = "Bem-vindo ao Kitsune Hub!",
        SelectLang = "Idioma / Language:",
        BtnLang = "Português 🇧🇷 (Clique p/ Mudar)",
        FollowToggle = "⚽ Seguir Bola Automático: ",
        CurveOff = "🌀 Curva Automática: DESATIVADO",
        CurveRight = "🌀 Curva Automática: DIREITA ➡️",
        CurveLeft = "🌀 Curva Automática: ESQUERDA ⬅️",
        AntiLag = "⚡ Modo Anti-Lag (FPS Boost): ",
        GrassBlack = "⬛ Gramado: Preto",
        GrassRed = "🟥 Gramado: Vermelho",
        GrassPurple = "🟪 Gramado: Roxo",
        GrassWhite = "⬜ Gramado: Branco",
        GrassBlue = "🟦 Gramado: Azul",
        GrassDefault = "🌱 Gramado: Padrão",
        Stretched = "📺 Stretched Screen: ",
        AutoDive = "🧤 Auto Dive: ",
        GKReach = "📏 GK Reach (Moderado): "
    },
    EN = {
        Title = "KITSUNE HUB 🦊🌸⛩️",
        TabHome = "⛩️ Home",
        TabFollow = "⚽ Follow",
        TabBall = "🌀 Ball",
        TabGraphics = "🌿 Visuals",
        TabGK = "🧤 GK",
        Welcome = "Welcome to Kitsune Hub!",
        SelectLang = "Language / Idioma:",
        BtnLang = "English 🇺🇸 (Click to Switch)",
        FollowToggle = "⚽ Auto Follow Ball: ",
        CurveOff = "🌀 Auto Curve: OFF",
        CurveRight = "🌀 Auto Curve: RIGHT ➡️",
        CurveLeft = "🌀 Auto Curve: LEFT ⬅️",
        AntiLag = "⚡ Anti-Lag Mode: ",
        GrassBlack = "⬛ Pitch: Black",
        GrassRed = "🟥 Pitch: Red",
        GrassPurple = "🟪 Pitch: Purple",
        GrassWhite = "⬜ Pitch: White",
        GrassBlue = "🟦 Pitch: Blue",
        GrassDefault = "🌱 Pitch: Default",
        Stretched = "📺 Stretched Screen: ",
        AutoDive = "🧤 Auto Dive: ",
        GKReach = "📏 GK Reach (Moderate): "
    }
}

local States = {
    Follow = false,
    Curve = "OFF",
    AntiLag = false,
    Stretched = false,
    AutoDive = false,
    GKReach = false
}

-- ==================== GUI PRINCIPAL ====================
local Gui = Instance.new("ScreenGui")
Gui.Name = "KitsuneHub"
Gui.ResetOnSpawn = false

pcall(function()
    Gui.Parent = CoreGui
end)
if not Gui.Parent then
    Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 340, 0, 310)
Frame.Position = UDim2.new(0.5, -170, 0.5, -155)
Frame.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Parent = Gui

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 12)

local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Thickness = 2
FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Gradient = Instance.new("UIGradient", FrameStroke)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 196)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
})

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 0, 35)
TitleLabel.Position = UDim2.new(0, 10, 0, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = Translations[CurrentLang].Title
TitleLabel.TextColor3 = Color3.fromRGB(255, 102, 196)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Frame

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Frame

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 4)

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -20, 1, -80)
ContentArea.Position = UDim2.new(0, 10, 0, 75)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = Frame

local Tabs = {}
local TabButtons = {}

local function CreateTabContainer(name)
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.Visible = false
    container.ScrollBarThickness = 3
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.Parent = ContentArea
    
    local layout = Instance.new("UIListLayout", container)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    
    return container
end

Tabs.Home = CreateTabContainer("Home")
Tabs.Follow = CreateTabContainer("Follow")
Tabs.Ball = CreateTabContainer("Ball")
Tabs.Graphics = CreateTabContainer("Graphics")
Tabs.GK = CreateTabContainer("GK")

local function SelectTab(tabName)
    for name, container in pairs(Tabs) do
        container.Visible = (name == tabName)
    end
    for name, btn in pairs(TabButtons) do
        if name == tabName then
            btn.BackgroundColor3 = Color3.fromRGB(255, 102, 196)
            btn.TextColor3 = Color3.fromRGB(15, 12, 20)
        else
            btn.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
end

local function AddTabButton(name, textKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.19, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = Translations[CurrentLang][textKey]
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    btn.Parent = TabBar
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    
    TabButtons[name] = btn
    btn.Activated:Connect(function() SelectTab(name) end)
end

AddTabButton("Home", "TabHome")
AddTabButton("Follow", "TabFollow")
AddTabButton("Ball", "TabBall")
AddTabButton("Graphics", "TabGraphics")
AddTabButton("GK", "TabGK")

SelectTab("Home")

local function CreateOptionButton(parent, defaultText, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(28, 25, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = defaultText
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 13
    btn.Parent = parent
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(0, 255, 255)
    
    btn.Activated:Connect(function() callback(btn) end)
    return btn
end

-- ==================== ABA 1: HOME ====================
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, -6, 0, 25)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = Translations[CurrentLang].Welcome
WelcomeLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
WelcomeLabel.Font = Enum.Font.SourceSansBold
WelcomeLabel.TextSize = 14
WelcomeLabel.Parent = Tabs.Home

local LangBtn
LangBtn = CreateOptionButton(Tabs.Home, Translations[CurrentLang].BtnLang, function()
    CurrentLang = (CurrentLang == "PT") and "EN" or "PT"
    TitleLabel.Text = Translations[CurrentLang].Title
    TabButtons.Home.Text = Translations[CurrentLang].TabHome
    TabButtons.Follow.Text = Translations[CurrentLang].TabFollow
    TabButtons.Ball.Text = Translations[CurrentLang].TabBall
    TabButtons.Graphics.Text = Translations[CurrentLang].TabGraphics
    TabButtons.GK.Text = Translations[CurrentLang].TabGK
    WelcomeLabel.Text = Translations[CurrentLang].Welcome
    LangBtn.Text = Translations[CurrentLang].BtnLang
end)

-- ==================== ABA 2: FOLLOW ====================
local FollowBtn
FollowBtn = CreateOptionButton(Tabs.Follow, Translations[CurrentLang].FollowToggle .. "OFF", function()
    States.Follow = not States.Follow
    FollowBtn.Text = Translations[CurrentLang].FollowToggle .. (States.Follow and "ON" or "OFF")
    FollowBtn.TextColor3 = States.Follow and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 255, 255)
end)

RunService.RenderStepped:Connect(function()
    if States.Follow then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hrp and hum and hum.MoveDirection.Magnitude == 0 then
            local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("SoccerBall")
            if ball and ball:IsA("BasePart") then
                hum:MoveTo(ball.Position)
            end
        end
    end
end)

-- ==================== ABA 3: BALL ====================
local CurveBtn
CurveBtn = CreateOptionButton(Tabs.Ball, Translations[CurrentLang].CurveOff, function()
    if States.Curve == "OFF" then
        States.Curve = "RIGHT"
        CurveBtn.Text = Translations[CurrentLang].CurveRight
    elseif States.Curve == "RIGHT" then
        States.Curve = "LEFT"
        CurveBtn.Text = Translations[CurrentLang].CurveLeft
    else
        States.Curve = "OFF"
        CurveBtn.Text = Translations[CurrentLang].CurveOff
    end
end)

RunService.Heartbeat:Connect(function()
    if States.Curve ~= "OFF" then
        local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("SoccerBall")
        if ball and ball:IsA("BasePart") and ball.AssemblyLinearVelocity.Magnitude > 8 then
            local force = (States.Curve == "RIGHT") and 12 or -12
            ball.AssemblyLinearVelocity = ball.AssemblyLinearVelocity + (Camera.CFrame.RightVector * force * 0.05)
        end
    end
end)

-- ==================== ABA 4: GRAPHICS ====================
CreateOptionButton(Tabs.Graphics, Translations[CurrentLang].AntiLag .. "OFF", function(btn)
    States.AntiLag = not States.AntiLag
    btn.Text = Translations[CurrentLang].AntiLag .. (States.AntiLag and "ON" or "OFF")
    if States.AntiLag then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end)

local function SetGrassColor(color)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (string.find(string.lower(obj.Name), "grass") or string.find(string.lower(obj.Name), "pitch") or string.find(string.lower(obj.Name), "field")) then
            obj.Color = color
            obj.Material = Enum.Material.SmoothPlastic
        end
    end
end

CreateOptionButton(Tabs.Graphics, Translations[CurrentLang].GrassBlack, function() SetGrassColor(Color3.fromRGB(20, 20, 20)) end)
CreateOptionButton(Tabs.Graphics, Translations[CurrentLang].GrassRed, function() SetGrassColor(Color3.fromRGB(180, 20, 20)) end)
CreateOptionButton(Tabs.Graphics, Translations[CurrentLang].GrassPurple, function() SetGrassColor(Color3.fromRGB(130, 20, 180)) end)
CreateOptionButton(Tabs.Graphics, Translations[CurrentLang].GrassWhite, function() SetGrassColor(Color3.fromRGB(240, 240, 240)) end)
CreateOptionButton(Tabs.Graphics, Translations[CurrentLang].GrassBlue, function() SetGrassColor(Color3.fromRGB(20, 100, 220)) end)

CreateOptionButton(Tabs.Graphics, Translations[CurrentLang].Stretched .. "OFF", function(btn)
    States.Stretched = not States.Stretched
    btn.Text = Translations[CurrentLang].Stretched .. (States.Stretched and "ON" or "OFF")
    Camera.FieldOfView = States.Stretched and 110 or 70
end)

-- ==================== ABA 5: GK ====================
CreateOptionButton(Tabs.GK, Translations[CurrentLang].AutoDive .. "OFF", function(btn)
    States.AutoDive = not States.AutoDive
    btn.Text = Translations[CurrentLang].AutoDive .. (States.AutoDive and "ON" or "OFF")
end)

CreateOptionButton(Tabs.GK, Translations[CurrentLang].GKReach .. "OFF", function(btn)
    States.GKReach = not States.GKReach
    btn.Text = Translations[CurrentLang].GKReach .. (States.GKReach and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("SoccerBall")
    
    if hrp and ball and ball:IsA("BasePart") then
        local dist = (hrp.Position - ball.Position).Magnitude
        if States.AutoDive and dist < 18 then
            hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(ball.Position.X, hrp.Position.Y, ball.Position.Z))
        end
        if States.GKReach and dist < 12 then
            firetouchinterest(hrp, ball, 0)
            firetouchinterest(hrp, ball, 1)
        end
    end
end)

-- ==================== BOTÃO FLUTUANTE ====================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
ToggleBtn.Text = "🦊"
ToggleBtn.TextSize = 26
ToggleBtn.Active = true
ToggleBtn.Parent = Gui

local MainCorner = Instance.new("UICorner", ToggleBtn)
MainCorner.CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", ToggleBtn)
MainStroke.Thickness = 2

local MainGradient = Instance.new("UIGradient", MainStroke)
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 196)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
})

pcall(function()
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1, 0, 1, 0)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://92775594578384"
    img.Parent = ToggleBtn
    local imgCorner = Instance.new("UICorner", img)
    imgCorner.CornerRadius = UDim.new(0, 12)
end)

ToggleBtn.Activated:Connect(function()
    Frame.Visible = not Frame.Visible
end)
