-- ==================================================
-- ✅ FNAM PREMIUM AIMBOT - VERSÃO DE LUXO
-- ✅ TUDO DO BOM E DO MELHOR | OTIMIZADO 2026
-- ✅ INTERFACE MAIS BONITA E ESTÁVEL DO MERCADO
-- ✅ SISTEMA COMPLETO PARA VENDA
-- ✅ TELA DE CARREGAMENTO PERSONALIZADA
-- ✅ COMPATÍVEL COM TODOS OS JOGOS DE TIRO
-- ==================================================

-- ==============================================
-- 🔹 SERVIÇOS E CONFIGURAÇÃO GLOBAL
-- ==============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Limpa qualquer versão antiga
if CoreGui:FindFirstChild("FNAM_PREMIUM_SYSTEM") then CoreGui.FNAM_PREMIUM_SYSTEM:Destroy() end

-- ==============================================
-- ⏳ TELA DE CARREGAMENTO FNAM - DESIGN PREMIUM
-- ==============================================
local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.Name = "FNAM_PREMIUM_SYSTEM"
LoadingScreen.Parent = CoreGui
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.IgnoreGuiInset = true
LoadingScreen.DisplayOrder = 999999

-- Fundo com efeito gradiente
local Background = Instance.new("Frame")
Background.Parent = LoadingScreen
Background.BackgroundColor3 = Color3.fromRGB(6, 8, 15)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0,0,0,0)
Background.BorderSizePixel = 0

-- Camada de brilho
local Glow = Instance.new("Frame")
Glow.Parent = Background
Glow.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
Glow.BackgroundTransparency = 0.85
Glow.Size = UDim2.new(2, 0, 2, 0)
Glow.Position = UDim2.new(-0.5, 0, -0.5, 0)
Glow.BorderSizePixel = 0

-- Caixa Principal
local LoadingBox = Instance.new("Frame")
LoadingBox.Parent = Background
LoadingBox.BackgroundColor3 = Color3.fromRGB(16, 18, 28)
LoadingBox.Size = UDim2.new(0, 360, 0, 200)
LoadingBox.Position = UDim2.new(0.5, -180, 0.5, -100)
LoadingBox.BorderSizePixel = 0
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = LoadingBox

-- Borda brilhante
local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = LoadingBox
UIStroke.Color = Color3.fromRGB(66, 133, 244)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.3

-- TITULO FNAM ANIMADO
local Title = Instance.new("TextLabel")
Title.Parent = LoadingBox
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,0,0.08,0)
Title.Size = UDim2.new(1,0,0,50)
Title.Font = Enum.Font.GothamBlack
Title.Text = "F N A M"
Title.TextColor3 = Color3.fromRGB(66, 133, 244)
Title.TextSize = 34
Title.TextStrokeTransparency = 0.8
Title.TextStrokeColor3 = Color3.fromRGB(100, 160, 255)

-- Efeito de brilho no título
spawn(function()
    while true do
        TweenService:Create(Title, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.3}):Play()
        TweenService:Create(Title, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
        wait(1)
    end
end)

-- Subtítulo
local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = LoadingBox
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0,0,0.32,0)
SubTitle.Size = UDim2.new(1,0,0,22)
SubTitle.Font = Enum.Font.GothamSemibold
SubTitle.Text = "PREMIUM CHEAT SYSTEM"
SubTitle.TextColor3 = Color3.fromRGB(180, 200, 255)
SubTitle.TextSize = 13

-- Mensagem de agradecimento
local Message = Instance.new("TextLabel")
Message.Parent = LoadingBox
Message.BackgroundTransparency = 1
Message.Position = UDim2.new(0,0,0.48,0)
Message.Size = UDim2.new(1,0,0,20)
Message.Font = Enum.Font.Gotham
Message.Text = "✅ Obrigado por adquirir nosso sistema!"
Message.TextColor3 = Color3.fromRGB(220, 220, 220)
Message.TextSize = 12

-- Barra de fundo estilizada
local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingBox
BarBackground.BackgroundColor3 = Color3.fromRGB(30, 34, 50)
BarBackground.Size = UDim2.new(0.85, 0, 0, 14)
BarBackground.Position = UDim2.new(0.075,0,0.70,0)
BarBackground.BorderSizePixel = 0
Corner:Clone().Parent = BarBackground

-- Barra de progresso com gradiente
local BarFill = Instance.new("Frame")
BarFill.Parent = BarBackground
BarFill.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.Position = UDim2.new(0,0,0,0)
BarFill.BorderSizePixel = 0
Corner:Clone().Parent = BarFill

local Gradient = Instance.new("UIGradient")
Gradient.Parent = BarFill
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(66,133,244)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120,180,255))
})
Gradient.Rotation = 45

-- Texto de status
local StatusText = Instance.new("TextLabel")
StatusText.Parent = LoadingBox
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.new(0,0,0.88,0)
StatusText.Size = UDim2.new(1,0,0,20)
StatusText.Font = Enum.Font.GothamSemibold
StatusText.Text = "Iniciando sistema... 0%"
StatusText.TextColor3 = Color3.fromRGB(160, 180, 220)
StatusText.TextSize = 11

-- ==============================================
-- 🚀 ANIMAÇÃO DE CARREGAMENTO FLUÍDA
-- ==============================================
task.spawn(function()
    -- Progresso realístico
    for i = 0, 100 do
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        StatusText.Text = 
            i < 25 and "Carregando núcleo... "..i.."%" or
            i < 50 and "Verificando segurança... "..i.."%" or
            i < 75 and "Carregando módulos de mira... "..i.."%" or
            i < 90 and "Otimizando para o jogo... "..i.."%" or
            "Quase pronto... "..i.."%"
        task.wait(0.022)
    end

    StatusText.Text = "✅ SISTEMA FNAM ATIVADO COM SUCESSO!"
    task.wait(0.8)

    -- Animação de saída elegante
    TweenService:Create(LoadingBox, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 400, 0, 0),
        Position = UDim2.new(0.5, -200, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(Background, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play()

    task.delay(0.75, function() 
        LoadingScreen:Destroy() 
        -- ✅ CARREGA O SISTEMA PRINCIPAL
        LoadPremiumSystem()
    end)
end)

-- ==============================================
-- ⚙️ SISTEMA PRINCIPAL - O MELHOR DO MERCADO
-- ==============================================
function LoadPremiumSystem()

    -- 🔹 CARREGAR A INTERFACE MAIS ESTÁVEL E BONITA (KAVO UI)
    -- Essa é a que todos os criadores de cheat usam, não tem erro, não fica preta, abre sempre
    local success, KavoLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Kavo-UI-Library/main/source.lua"))()
    end)

    -- ⚠️ SISTEMA DE SEGURANÇA: Se a Kavo falhar, usa Orion, se falhar, usa UI própria premium
    if not success or not KavoLib then
        success, KavoLib = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
        end)
        if not success then
            -- UI PRÓPRIA DE LUXO - NÃO FALHA NUNCA
            KavoLib = nil
        end
    end

    -- ==============================================
    -- 📋 CONFIGURAÇÕES COMPLETAS DO AIMBOT
    -- ==============================================
    local Settings = {
        -- Geral
        Enabled = true,
        TeamCheck = true,
        VisibleCheck = true,
        AutoDisableOnDeath = true,

        -- Mira
        AimMode = "Closest", -- Closest / LowestHealth / First
        AimPart = "Head", -- Head / Torso / Random
        AimSmoothness = 0.82,
        AimFOV = 220,
        AimRange = 400,
        InstantAim = false,
        Prediction = 0.15, -- Correção de movimento do inimigo

        -- Sistema de Parede
        WallCheck = true,
        ThroughWalls = false,
        IgnoreTransparent = true,

        -- Disparo
        AutoShoot = false,
        ShootDelay = 0.05,
        OnlyWhenOnScreen = true,

        -- Visuais
        ShowFOV = true,
        FOVColor = Color3.fromRGB(66, 133, 244),
        FOVThickness = 2,
        ShowTargetInfo = true
    }

    -- ==============================================
    -- 🎨 INTERFACE PRINCIPAL - MODO PREMIUM
    -- ==============================================
    local Window, MainTab, VisualTab, AdvancedTab

    if KavoLib then
        -- USANDO KAVO UI (MAIS BONITA E PROFISSIONAL)
        Window = KavoLib:CreateWindow({
            Name = "FNAM PREMIUM",
            LoadingTitle = "FNAM SYSTEM",
            LoadingSubtitle = "Premium Experience",
            ConfigurationSaving = {Enabled = true, FolderName = "FNAM_Config"},
            Discord = {Enabled = false},
            KeySystem = {Enabled = false}
        })

        MainTab = Window:CreateTab("Aimbot", "rbxassetid://4483345898")
        VisualTab = Window:CreateTab("Visuals", "rbxassetid://3926305904")
        AdvancedTab = Window:CreateTab("Advanced", "rbxassetid://4483346215")

        -- 📌 ABA PRINCIPAL - CONFIGURAÇÕES DE MIRA
        MainTab:CreateSection("MAIN SETTINGS")
        MainTab:CreateToggle("Enable Aimbot", Settings.Enabled, function(v) Settings.Enabled = v end)
        MainTab:CreateToggle("Team Check", Settings.TeamCheck, function(v) Settings.TeamCheck = v end)
        MainTab:CreateToggle("Auto Disable On Death", Settings.AutoDisableOnDeath, function(v) Settings.AutoDisableOnDeath = v end)

        MainTab:CreateSection("AIM SETTINGS")
        MainTab:CreateDropdown("Aim Mode", {"Closest", "LowestHealth", "First"}, Settings.AimMode, function(v) Settings.AimMode = v end)
        MainTab:CreateDropdown("Aim Part", {"Head", "Torso", "Random"}, Settings.AimPart, function(v) Settings.AimPart = v end)
        
        MainTab:CreateSlider("Aim Smoothness", 0.1, 1, Settings.AimSmoothness, 0.01, function(v) Settings.AimSmoothness = v end)
        MainTab:CreateSlider("FOV Size", 30, 500, Settings.AimFOV, 1, function(v) Settings.AimFOV = v end)
        MainTab:CreateSlider("Max Range", 100, 1000, Settings.AimRange, 10, function(v) Settings.AimRange = v end)
        MainTab:CreateSlider("Prediction", 0, 0.5, Settings.Prediction, 0.01, function(v) Settings.Prediction = v end)
        
        MainTab:CreateToggle("Instant Aim", Settings.InstantAim, function(v) Settings.InstantAim = v end)

        MainTab:CreateSection("WALL SYSTEM")
        MainTab:CreateToggle("Wall Check (Only Visible)", Settings.WallCheck, function(v)
            Settings.WallCheck = v
            if v then Settings.ThroughWalls = false end
        end)
        MainTab:CreateToggle("Through Walls (Anywhere)", Settings.ThroughWalls, function(v)
            Settings.ThroughWalls = v
            if v then Settings.WallCheck = false end
        end)

        MainTab:CreateSection("SHOOT SYSTEM")
        MainTab:CreateToggle("Auto Shoot", Settings.AutoShoot, function(v) Settings.AutoShoot = v end)
        MainTab:CreateSlider("Shoot Delay", 0.01, 0..5, Settings.ShootDelay, 0.01, function(v) Settings.ShootDelay = v end)

        -- 📌 ABA VISUAL
        VisualTab:CreateSection("VISUALS")
        VisualTab:CreateToggle("Show FOV Circle", Settings.ShowFOV, function(v) Settings.ShowFOV = v end)
        VisualTab:CreateColorPicker("FOV Color", Settings.FOVColor, function(v) Settings.FOVColor = v end)
        VisualTab:CreateToggle("Show Target Info", Settings.ShowTargetInfo, function(v) Settings.ShowTargetInfo = v end)

    else
        -- UI PRÓPRIA DE LUXO - IGUAL AS FAMOSAS
        local Screen = Instance.new("ScreenGui")
        Screen.Name = "FNAM_UI_PREMIUM"
        Screen.Parent = CoreGui
        Screen.IgnoreGuiInset = true
        Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        -- Janela Principal
        local MainWindow = Instance.new("Frame")
        MainWindow.Parent = Screen
        MainWindow.BackgroundColor3 = Color3.fromRGB(14, 16, 26)
        MainWindow.Position = UDim2.new(0.04,0,0.04,0)
        MainWindow.Size = UDim2.new(0, 300, 0, 450)
        MainWindow.BorderSizePixel = 0
        Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 14)
        Instance.new("UIStroke", MainWindow).Color = Color3.fromRGB(66,133,244)

        -- Barra Superior
        local TopBar = Instance.new("Frame")
        TopBar.Parent = MainWindow
        TopBar.BackgroundColor3 = Color3.fromRGB(20, 22, 34)
        TopBar.Size = UDim2.new(1,0,0,45)
        TopBar.BorderSizePixel = 0
        Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

        local Title = Instance.new("TextLabel", TopBar)
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0.1,0,0,0)
        Title.Size = UDim2.new(0.8,0,1,0)
        Title.Font = Enum.Font.GothamBold
        Title.Text = "FNAM PREMIUM"
        Title.TextColor3 = Color3.fromRGB(66,133,244)
        Title.TextSize = 15

        -- Sistema de Arrasto
        local Drag = {false, nil, nil}
        TopBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then Drag = {true, MainWindow.Position, i.Position} end end)
        UIS.InputChanged:Connect(function(i) if Drag[1] then MainWindow.Position = UDim2.new(Drag[2].X.Scale, Drag[2].X.Offset + (i.Position.X - Drag[3].X), Drag[2].Y.Scale, Drag[2].Y.Offset + (i.Position.Y - Drag[3].Y)) end end)
        UIS.InputEnded:Connect(function() Drag[1] = false end)

        -- Área de Rolagem
        local Scroller = Instance.new("ScrollingFrame")
        Scroller.Parent = MainWindow
        Scroller.BackgroundColor3 = Color3.fromRGB(18, 20, 30)
        Scroller.Position = UDim2.new(0, 8, 0, 53)
        Scroller.Size = UDim2.new(1, -16, 1, -61)
        Scroller.BorderSizePixel = 0
        Scroller.ScrollBarThickness = 4
        Scroller.ScrollBarImageColor3 = Color3.fromRGB(66,133,244)
        Scroller.CanvasSize = UDim2.new(0,0,0,700)

        local Layout = Instance.new("UIListLayout", Scroller)
        Layout.Padding = UDim.new(0, 12)
        Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        -- Funções de Criação
        local function CreateToggle(Name, Default, Callback)
            local Btn = Instance.new("TextButton", Scroller)
            Btn.Size = UDim2.new(0.92,0,0,38)
            Btn.BackgroundColor3 = Default and Color3.fromRGB(34,197,94) or Color3.fromRGB(30,34,48)
            Btn.Font = Enum.Font.GothamSemibold
            Btn.Text = Name
            Btn.TextColor3 = Color3.white
            Btn.TextSize = 13
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
            Btn.MouseButton1Click:Connect(function() Default = not Default; Btn.BackgroundColor3 = Default and Color3.fromRGB(34,197,94) or Color3.fromRGB(30,34,48); Callback(Default) end)
        end

        local function CreateSlider(Name, Min, Max, Val, Callback)
            local Cont = Instance.new("Frame", Scroller)
            Cont.Size = UDim2.new(0.92,0,0,46)
            Cont.BackgroundColor3 = Color3.fromRGB(30,34,48)
            Instance.new("UICorner", Cont).CornerRadius = UDim.new(0,8)

            local Label = Instance.new("TextLabel", Cont)
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0.08,0,0.1,0)
            Label.Size = UDim2.new(0.85,0,0,20)
            Label.Font = Enum.Font.Gotham
            Label.Text = Name..": "..math.floor(Val*100)/100
            Label.TextColor3 = Color3.fromRGB(180,180,180)
            Label.TextSize = 12

            local Back = Instance.new("Frame", Cont)
            Back.BackgroundColor3 = Color3.fromRGB(22,24,36)
            Back.Position = UDim2.new(0.08,0,0.65,0)
            Back.Size = UDim2.new(0.85,0,0,8)
            Instance.new("UICorner", Back).CornerRadius = UDim.new(0,4)

            local Fill = Instance.new("Frame", Back)
            Fill.BackgroundColor3 = Color3.fromRGB(66,133,244)
            Fill.Size = UDim2.new((Val-Min)/(Max-Min),0,1,0)
            Fill.AnchorPoint = Vector2.new(0,0.5)
            Fill.Position = UDim2.new(0,0,0.5,0)
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(0,4)

            local Drag = false
            Back.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then Drag=true end end)
            UIS.InputEnded:Connect(function() Drag=false end)
            UIS.InputChanged:Connect(function(i)
                if Drag then
                    local p = math.clamp((i.Position.X - Back.AbsolutePosition.X)/Back.AbsoluteSize.X,0,1)
                    local v = Min + (Max-Min)*p
                    Fill.Size = UDim2.new(p,0,1,0)
                    Label.Text = Name..": "..math.floor(v*100)/100
                    Callback(v)
                end
            end)
        end

        -- Adiciona todas opções
        CreateToggle("✅ ENABLE AIMBOT", Settings.Enabled, function(v) Settings.Enabled=v end)
        CreateToggle("👥 TEAM CHECK", Settings.TeamCheck, function(v) Settings.TeamCheck=v end)
        CreateSlider("📏 AIM SMOOTHNESS", 0.1,1,Settings.AimSmoothness, function(v) Settings.AimSmoothness=v end)
        CreateSlider("🎯 FOV SIZE", 50,500,Settings.AimFOV, function(v) Settings.AimFOV=v end)
        CreateSlider("💨 PREDICTION", 0,0.5,Settings.Prediction, function(v) Settings.Prediction=v end)
        CreateToggle("👁️ WALL CHECK", Settings.WallCheck, function(v) Settings.WallCheck=v; if v then Settings.ThroughWalls=false end end)
        CreateToggle("🛡️ THROUGH WALLS", Settings.ThroughWalls, function(v) Settings.ThroughWalls=v; if v then Settings.WallCheck=false end end)
        CreateToggle("⚡ INSTANT AIM", Settings.InstantAim, function(v) Settings.InstantAim=v end)
        CreateToggle("🔫 AUTO SHOOT", Settings.AutoShoot, function(v) Settings.AutoShoot=v end)
        CreateToggle("⭕ SHOW FOV", Settings.ShowFOV, function(v) Settings.ShowFOV=v end)
    end

    -- ==============================================
    -- ⚙️ SISTEMA DE DETECÇÃO DE ALVO - O MAIS PRECISO
    -- ==============================================

    -- Verifica se o jogador é válido
    local function IsValid(Target)
        if not Target or Target == LocalPlayer then return false end
        if Settings.TeamCheck and Target.Team == LocalPlayer.Team then return false end
        
        local Char = Target.Character
        if not Char then return false end
        
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        local Hum = Char:FindFirstChild("Humanoid")
        if not HRP or not Hum or Hum.Health <= 0 then return false end

        -- Verificação de distância
        if (Camera.CFrame.Position - HRP.Position).Magnitude > Settings.AimRange then return false end

        return true, HRP, Hum, Char
    end

    -- Verificação de parede otimizada
    local function IsVisible(From, To)
        local Ray = Ray.new(From, (To - From).Unit * (To - From).Magnitude)
        local Hit = Workspace:FindPartOnRayWithIgnoreList(Ray, {LocalPlayer.Character})
        return not Hit or Hit:IsDescendantOf(To.Parent) or (Settings.IgnoreTransparent and Hit.Transparency > 0.5)
    end

    -- Escolhe qual parte do corpo mirar
    local function GetAimPart(Char)
        if Settings.AimPart == "Head" and Char:FindFirstChild("Head") then return Char.Head.Position end
        if Settings.AimPart == "Torso" and Char:FindFirstChild("Torso") then return Char.Torso.Position end
        return Char.HumanoidRootPart.Position
    end

    -- Sistema de escolha de alvo inteligente
    local function GetBestTarget()
        local Best, BestScore = nil, math.huge
        local CamPos = Camera.CFrame.Position
        local ScreenCenter = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

        for _, Plr in pairs(Players:GetPlayers()) do
            local Valid, HRP, Hum, Char = IsValid(Plr)
            if not Valid then continue end

            -- Posição com predição de movimento
            local PredictedPos = HRP.Position + HRP.Velocity * Settings.Prediction

            -- Verificação de tela
            local ScreenPos, OnScreen = Camera:WorldToViewportPoint(PredictedPos)
            if not OnScreen then continue end

            -- Cálculo de FOV
            local FovDist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - ScreenCenter).Magnitude
            if FovDist > Settings.AimFOV then continue end

            -- Verificação de parede
            local CanAim = Settings.ThroughWalls or (Settings.WallCheck and IsVisible(CamPos, PredictedPos))
            if not CanAim then continue end

            -- Pontuação do alvo (quanto menor, melhor)
            local Score = 0
            if Settings.AimMode == "Closest" then
                Score = FovDist -- Mais próximo do centro da tela
            elseif Settings.AimMode == "LowestHealth" then
                Score = Hum.Health -- Menor vida primeiro
            else
                Score = (CamPos - HRP.Position).Magnitude -- Mais próximo em distância
            end

            if Score < BestScore then
                BestScore = Score
                Best = {Char = Char, AimPos = GetAimPart(Char)}
            end
        end

        return Best
    end

    -- ==============================================
    -- 🔄 LOOP PRINCIPAL - OTIMIZADO E FLUÍDO
    -- ==============================================

    -- Desenho do FOV
    local Circle = Drawing.new("Circle")
    Circle.Thickness = Settings.FOVThickness
    Circle.Color = Settings.FOVColor
    Circle.Filled = false
    Circle.Radius = Settings.AimFOV
    Circle.Visible = Settings.ShowFOV

    RunService.RenderStepped:Connect(function()
        -- Atualiza FOV visual
        Circle.Visible = Settings.ShowFOV and Settings.Enabled
        Circle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        Circle.Radius = Settings.AimFOV
        Circle.Color = Settings.FOVColor

        if not Settings.Enabled then return end

        -- Pega alvo
        local Target = GetBestTarget()
        if not Target then return end

        -- Movimento suave ou instantâneo
        local TargetCFrame = CFrame.new(Camera.CFrame.Position, Target.AimPos)
        local Alpha = Settings.InstantAim and 1 or Settings.AimSmoothness

        -- Aplica mira
        Camera.CFrame = Camera.CFrame:Lerp(TargetCFrame, Alpha)

        -- Sistema de disparo automático
        if Settings.AutoShoot then
            task.wait(Settings.ShootDelay)
            if Settings.OnlyWhenOnScreen then
                local _, Visible = Camera:WorldToViewportPoint(Target.AimPos)
                if Visible then Mouse:Button1Down() wait(0.03) Mouse:Button1Up() end
            else
                Mouse:Button1Down() wait(0.03) Mouse:Button1Up()
            end
        end
    end)

    -- ==============================================
    -- ✅ FINALIZAÇÃO
    -- ==============================================
    print("[✅] FNAM PREMIUM SYSTEM LOADED SUCCESSFULLY")
end
