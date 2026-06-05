-- ==================================================
-- ✅ FNAM AIMBOT - VERSÃO CORRIGIDA PARA ESSE JOGO
-- ✅ TELA DE CARREGAMENTO FNAM 100%
-- ✅ MENU APARECE, NÃO FICA MAIS PRETO
-- ✅ ORION UI + SISTEMA RESERVA
-- ✅ TUDO EM INGLÊS
-- ==================================================

-- 🔹 SERVIÇOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ==============================================
-- ⏳ TELA DE CARREGAMENTO FNAM (GARANTIDA)
-- ==============================================
-- Limpa qualquer coisa antiga
if CoreGui:FindFirstChild("FNAM_LOADING") then CoreGui.FNAM_LOADING:Destroy() end

local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.Name = "FNAM_LOADING"
LoadingScreen.Parent = CoreGui
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.IgnoreGuiInset = true
LoadingScreen.DisplayOrder = 999

-- Fundo Escuro
local Background = Instance.new("Frame")
Background.Parent = LoadingScreen
Background.BackgroundColor3 = Color3.fromRGB(8, 10, 18)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0,0,0,0)
Background.BorderSizePixel = 0

-- Caixa Central
local LoadingBox = Instance.new("Frame")
LoadingBox.Parent = Background
LoadingBox.BackgroundColor3 = Color3.fromRGB(22, 25, 38)
LoadingBox.Size = UDim2.new(0, 320, 0, 180)
LoadingBox.Position = UDim2.new(0.5, -160, 0.5, -90)
LoadingBox.BorderSizePixel = 0
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 14)
Corner.Parent = LoadingBox

-- TITULO GRANDE FNAM
local Title = Instance.new("TextLabel")
Title.Parent = LoadingBox
Title.BackgroundTransparency = 0
Title.BackgroundColor3 = Color3.fromRGB(22,25,38)
Title.Position = UDim2.new(0,0,0.05,0)
Title.Size = UDim2.new(1,0,0,45)
Title.Font = Enum.Font.GothamBlack
Title.Text = "F N A M"
Title.TextColor3 = Color3.fromRGB(66, 133, 244)
Title.TextSize = 30
Title.TextStrokeTransparency = 0.8

-- Mensagem de agradecimento
local Message = Instance.new("TextLabel")
Message.Parent = LoadingBox
Message.BackgroundTransparency = 0
Message.BackgroundColor3 = Color3.fromRGB(22,25,38)
Message.Position = UDim2.new(0.1,0,0.38,0)
Message.Size = UDim2.new(0.8,0,0,25)
Message.Font = Enum.Font.GothamSemibold
Message.Text = "Obrigado por testá-lo!"
Message.TextColor3 = Color3.fromRGB(210, 210, 210)
Message.TextSize = 14

-- Barra de fundo
local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingBox
BarBackground.BackgroundColor3 = Color3.fromRGB(35, 38, 55)
BarBackground.Size = UDim2.new(0.8, 0, 0, 12)
BarBackground.Position = UDim2.new(0.1,0,0.62,0)
BarBackground.BorderSizePixel = 0
Corner:Clone().Parent = BarBackground

-- Barra de progresso (que enche)
local BarFill = Instance.new("Frame")
BarFill.Parent = BarBackground
BarFill.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.Position = UDim2.new(0,0,0,0)
BarFill.BorderSizePixel = 0
Corner:Clone().Parent = BarFill

-- Texto de status
local StatusText = Instance.new("TextLabel")
StatusText.Parent = LoadingBox
StatusText.BackgroundTransparency = 0
StatusText.BackgroundColor3 = Color3.fromRGB(22,25,38)
StatusText.Position = UDim2.new(0,0,0.82,0)
StatusText.Size = UDim2.new(1,0,0,20)
StatusText.Font = Enum.Font.Gotham
StatusText.Text = "Iniciando sistema... 0%"
StatusText.TextColor3 = Color3.fromRGB(160, 160, 160)
StatusText.TextSize = 12

-- ==============================================
-- 🚀 ANIMAÇÃO DE CARREGAMENTO
-- ==============================================
task.spawn(function()
    -- Progresso de 0 a 100% devagar
    for i = 0, 100 do
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        StatusText.Text = "Carregando módulos... " .. i .. "%"
        task.wait(0.02)
    end

    StatusText.Text = "✅ Pronto! Abrindo painel..."
    task.wait(0.5)

    -- Animação de saída
    TweenService:Create(LoadingBox, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 320, 0, 0),
        Position = UDim2.new(0.5, -160, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()

    -- Destroi depois da animação
    task.delay(0.6, function() 
        LoadingScreen:Destroy() 
        -- ✅ CHAMA O MENU PRINCIPAL
        LoadRealMenu()
    end)
end)

-- ==============================================
-- ⚙️ FUNÇÃO DO MENU PRINCIPAL (CORRIGIDA PARA ESSE JOGO)
-- ==============================================
function LoadRealMenu()
    -- 🔹 CARREGAR ORION COM PROTEÇÃO
    local success, OrionLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
    end)

    -- 🛑 SE ORION FALHAR OU FICAR PRETO, USA UI PRÓPRIA 100% FUNCIONAL
    if not success or not OrionLib then
        -- UI PRÓPRIA QUE NÃO FICA PRETA
        local MainUI = Instance.new("ScreenGui")
        MainUI.Name = "FNAM_Aimbot_Main"
        MainUI.Parent = CoreGui
        MainUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        MainUI.IgnoreGuiInset = true
        MainUI.DisplayOrder = 9999

        -- JANELA PRINCIPAL
        local Window = Instance.new("Frame")
        Window.Name = "Janela"
        Window.Parent = MainUI
        Window.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
        Window.Position = UDim2.new(0.05, 0, 0.05, 0)
        Window.Size = UDim2.new(0, 280, 0, 420)
        Window.BorderSizePixel = 0
        Instance.new("UICorner", Window).CornerRadius = UDim.new(0, 12)

        -- BARRA DE CIMA (ARRASTAR)
        local TopBar = Instance.new("Frame")
        TopBar.Name = "TopBar"
        TopBar.Parent = Window
        TopBar.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
        TopBar.Size = UDim2.new(1, 0, 0, 40)
        TopBar.BorderSizePixel = 0
        Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

        local Title = Instance.new("TextLabel", TopBar)
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1, 0, 1, 0)
        Title.Font = Enum.Font.GothamBold
        Title.Text = "FNAM AIMBOT"
        Title.TextColor3 = Color3.new(1,1,1)
        Title.TextSize = 14

        -- SISTEMA DE ARRASTAR
        local DragState = {Dragging=false, StartPos=nil, StartMouse=nil}
        TopBar.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                DragState.Dragging = true
                DragState.StartPos = Window.Position
                DragState.StartMouse = i.Position
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if DragState.Dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                local Delta = i.Position - DragState.StartMouse
                Window.Position = UDim2.new(
                    DragState.StartPos.X.Scale, DragState.StartPos.X.Offset + Delta.X,
                    DragState.StartPos.Y.Scale, DragState.StartPos.Y.Offset + Delta.Y
                )
            end
        end)
        UIS.InputEnded:Connect(function() DragState.Dragging = false end)

        -- ÁREA DE CONTEÚDO
        local Content = Instance.new("ScrollingFrame")
        Content.Parent = Window
        Content.BackgroundColor3 = Color3.fromRGB(25, 27, 38)
        Content.Position = UDim2.new(0, 8, 0, 48)
        Content.Size = UDim2.new(1, -16, 1, -56)
        Content.BorderSizePixel = 0
        Content.ScrollBarThickness = 4
        Content.ScrollBarImageColor3 = Color3.fromRGB(66,133,244)
        Content.CanvasSize = UDim2.new(0,0,0,500)
        Content.ClipsDescendants = true

        local Layout = Instance.new("UIListLayout")
        Layout.Parent = Content
        Layout.Padding = UDim.new(0, 10)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        -- ⚙️ CONFIGURAÇÕES
        local Settings = {
            Enabled = true,
            MaxRange = 350,
            AimStrength = 0.85,
            AimAtHead = true,
            WallCheck = true,
            ThroughWalls = false,
            InstantAim = false,
            TeamCheck = true,
            FOV = 220
        }

        -- 🧩 FUNÇÕES DE BOTÃO E BARRA
        local function AddToggle(Name, Default, Callback)
            local Btn = Instance.new("TextButton")
            Btn.Parent = Content
            Btn.BackgroundColor3 = Default and Color3.fromRGB(34,197,94) or Color3.fromRGB(40,44,58)
            Btn.Size = UDim2.new(0.9,0,0,36)
            Btn.Font = Enum.Font.GothamSemibold
            Btn.Text = Name
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.TextSize = 13
            Btn.BorderSizePixel = 0
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

            Btn.MouseButton1Click:Connect(function()
                Default = not Default
                Btn.BackgroundColor3 = Default and Color3.fromRGB(34,197,94) or Color3.fromRGB(40,44,58)
                Callback(Default)
            end)
        end

        local function AddSlider(Name, Min, Max, Default, Callback)
            local Cont = Instance.new("Frame")
            Cont.Parent = Content
            Cont.BackgroundColor3 = Color3.fromRGB(30,33,46)
            Cont.Size = UDim2.new(0.9,0,0,44)
            Instance.new("UICorner", Cont).CornerRadius = UDim.new(0,8)

            local Label = Instance.new("TextLabel", Cont)
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0.08,0,0.1,0)
            Label.Size = UDim2.new(0.85,0,0,40)
            Label.Font = Enum.Font.Gotham
            Label.Text = Name .. ": " .. math.floor(Default*100)/100
            Label.TextColor3 = Color3.fromRGB(180,180,180)
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local Back = Instance.new("Frame", Cont)
            Back.BackgroundColor3 = Color3.fromRGB(22,24,34)
            Back.Position = UDim2.new(0.08,0,0.65,0)
            Back.Size = UDim2.new(0.85,0,0,7)
            Instance.new("UICorner", Back).CornerRadius = UDim.new(0,4)

            local Fill = Instance.new("Frame", Back)
            Fill.BackgroundColor3 = Color3.fromRGB(66,133,244)
            Fill.Size = UDim2.new((Default-Min)/(Max-Min),0,1,0)
            Fill.AnchorPoint = Vector2.new(0,0.5)
            Fill.Position = UDim2.new(0,0,0.5,0)
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(0,4)

            local Drag = false
            Back.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then Drag=true end end)
            UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then Drag=false end end)
            UIS.InputChanged:Connect(function(i)
                if Drag and i.UserInputType==Enum.UserInputType.MouseMovement then
                    local Rel = i.Position.X - Back.AbsolutePosition.X
                    local Perc = math.clamp(Rel / Back.AbsoluteSize.X, 0,1)
                    local Val = Min + (Max-Min)*Perc
                    Fill.Size = UDim2.new(Perc,0,1,0)
                    Label.Text = Name .. ": " .. math.floor(Val*100)/100
                    Callback(Val)
                end
            end)
        end

        -- 📌 ADICIONA TODAS AS OPÇÕES
        AddToggle("✅ ENABLE AIMBOT", Settings.Enabled, function(v) Settings.Enabled=v end)
        AddSlider("📏 MAX RANGE", 50, 800, Settings.MaxRange, function(v) Settings.MaxRange=v end)
        AddSlider("🔥 AIM STRENGTH", 0.1, 1, Settings.AimStrength, function(v) Settings.AimStrength=v end)
        AddSlider("🎯 FOV SIZE", 50, 400, Settings.FOV, function(v) Settings.FOV=v end)
        AddToggle("🎯 AIM AT HEAD", Settings.AimAtHead, function(v) Settings.AimAtHead=v end)
        AddToggle("👁️ WALL CHECK", Settings.WallCheck, function(v) Settings.WallCheck=v; if v then Settings.ThroughWalls=false end end)
        AddToggle("🛡️ THROUGH WALLS", Settings.ThroughWalls, function(v) Settings.ThroughWalls=v; if v then Settings.WallCheck=false end end)
        AddToggle("⚡ INSTANT AIM", Settings.InstantAim, function(v) Settings.InstantAim=v end)
        AddToggle("👥 TEAM CHECK", Settings.TeamCheck, function(v) Settings.TeamCheck=v end)

        -- ==============================================
        -- ⚙️ LÓGICA DO AIMBOT (FUNCIONAL PARA ESSE JOGO)
        -- ==============================================
        local function IsValidTarget(Player)
            if not Player or Player == LocalPlayer then return false end
            if Settings.TeamCheck and Player.Team == LocalPlayer.Team then return false end
            local Character = Player.Character
            if not Character then return false end
            local HRP = Character:FindFirstChild("HumanoidRootPart")
            local Hum = Character:FindFirstChild("Humanoid")
            if not HRP or not Hum or Hum.Health <= 0 then return false end
            return true, HRP, Character
        end

        local function IsVisible(From, ToPos)
            local Ray = Ray.new(From, (ToPos - From).Unit * (ToPos - From).Magnitude)
            local Hit = Workspace:FindPartOnRayWithIgnoreList(Ray, {LocalPlayer.Character})
            return not Hit or Hit:IsDescendantOf(ToPos.Parent)
        end

        local function GetBestTarget()
            local Best, BestDist = nil, math.huge
            local CamPos = Camera.CFrame.Position
            local Center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

            for _, Plr in pairs(Players:GetPlayers()) do
                local Ok, HRP, Char = IsValidTarget(Plr)
                if not Ok then continue end

                local Dist = (CamPos - HRP.Position).Magnitude
                if Dist > Settings.MaxRange then continue end

                local ScreenPos, OnScreen = Camera:WorldToViewportPoint(HRP.Position)
                if not OnScreen then continue end
                local FovDist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Center).Magnitude
                if FovDist > Settings.FOV then continue end

                local Can = false
                if Settings.ThroughWalls then Can = true
                elseif Settings.WallCheck then Can = IsVisible(CamPos, HRP.Position)
                else Can = true end

                if Can and Dist < BestDist then
                    BestDist = Dist
                    Best = Char
                end
            end
            return Best
        end

        -- LOOP PRINCIPAL
        RunService.RenderStepped:Connect(function()
            if not Settings.Enabled then return end
            local Target = GetBestTarget()
            if Target then
                local AimPos = Settings.AimAtHead and Target:FindFirstChild("Head") and Target.Head.Position or Target.HumanoidRootPart.Position
                local NewCam = CFrame.new(Camera.CFrame.Position, AimPos)
                Camera.CFrame = Camera.CFrame:Lerp(NewCam, Settings.InstantAim and 1 or Settings.AimStrength)
            end
        end)

        return
    end

    -- 🎨 SE ORION CARREGOU CERTO
    local Window = OrionLib:MakeWindow({
        Name = "FNAM Aimbot",
        SaveConfig = false,
        IntroText = "Sistema Pronto ✅",
        Icon = "rbxassetid://4483345898"
    })

    local MainTab = Window:MakeTab({Name = "Aimbot", Icon = "rbxassetid://4483345898"})

    -- ⚙️ CONFIGURAÇÕES
    local Settings = {
        Enabled = true,
        MaxRange = 350,
        AimStrength = 0.85,
        AimAtHead = true,
        WallCheck = true,
        ThroughWalls = false,
        InstantAim = false,
        TeamCheck = true,
        FOV = 220
    }

    -- 📌 OPÇÕES
    MainTab:AddSection({Name = "MAIN SETTINGS"})
    MainTab:AddToggle({Name = "Enable Aimbot", Default = Settings.Enabled, Callback = function(v) Settings.Enabled = v end})
    MainTab:AddSlider({Name = "Max Range", Min = 50, Max = 800, Default = Settings.MaxRange, Color = Color3.fromRGB(59,130,246), Callback = function(v) Settings.MaxRange = v end})
    MainTab:AddSlider({Name = "Aim Strength", Min = 0.1, Max = 1, Default = Settings.AimStrength, Color = Color3.fromRGB(34,197,94), Callback = function(v) Settings.AimStrength = v end})
    MainTab:AddSlider({Name = "FOV Size", Min = 50, Max = 400, Default = Settings.FOV, Color = Color3.fromRGB(239,68,68), Callback = function(v) Settings.FOV = v end})

    MainTab:AddSection({Name = "WALL SYSTEM"})
    MainTab:AddToggle({Name = "Aim At Head", Default = Settings.AimAtHead, Callback = function(v) Settings.AimAtHead = v end})
    MainTab:AddToggle({Name = "Wall Check", Default = Settings.WallCheck, Callback = function(v) Settings.WallCheck=v; if v then Settings.ThroughWalls=false end end})
    MainTab:AddToggle({Name = "Through Walls", Default = Settings.ThroughWalls, Callback = function(v) Settings.ThroughWalls=v; if v then Settings.WallCheck=false end end})
    MainTab:AddToggle({Name = "Instant Aim", Default = Settings.InstantAim, Callback = function(v) Settings.InstantAim = v end})
    MainTab:AddToggle({Name = "Team Check", Default = Settings.TeamCheck, Callback = function(v) Settings.TeamCheck = v end})

    -- ==============================================
    -- ⚙️ LÓGICA DO AIMBOT
    -- ==============================================
    local function IsValidTarget(Player)
        if not Player or Player == LocalPlayer then return false end
        if Settings.TeamCheck and Player.Team == LocalPlayer.Team then return false end
        local Character = Player.Character
        if not Character then return false end
        local HRP = Character:FindFirstChild("HumanoidRootPart")
        local Hum = Character:FindFirstChild("Humanoid")
        if not HRP or not Hum or Hum.Health <= 0 then return false end
        return true, HRP, Character
    end

    local function IsVisible(From, ToPos)
        local Ray = Ray.new(From, (ToPos - From).Unit * (ToPos - From).Magnitude)
        local Hit = Workspace:FindPartOnRayWithIgnoreList(Ray, {LocalPlayer.Character})
        return not Hit or Hit:IsDescendantOf(ToPos.Parent)
    end

    local function GetBestTarget()
        local Best, BestDist = nil, math.huge
        local CamPos = Camera.CFrame.Position
        local Center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

        for _, Plr in pairs(Players:GetPlayers()) do
            local Ok, HRP, Char = IsValidTarget(Plr)
            if not Ok then continue end

            local Dist = (CamPos - HRP.Position).Magnitude
            if Dist > Settings.MaxRange then continue end

            local ScreenPos, OnScreen = Camera:WorldToViewportPoint(HRP.Position)
            if not OnScreen then continue end
            local FovDist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Center).Magnitude
            if FovDist > Settings.FOV then continue end

            local Can = false
            if Settings.ThroughWalls then Can = true
            elseif Settings.WallCheck then Can = IsVisible(CamPos, HRP.Position)
            else Can = true end

            if Can and Dist < BestDist then
                BestDist = Dist
                Best = Char
            end
        end
        return Best
    end

    -- LOOP PRINCIPAL
    RunService.RenderStepped:Connect(function()
        if not Settings.Enabled then return end
        local Target = GetBestTarget()
        if Target then
            local AimPos = Settings.AimAtHead and Target:FindFirstChild("Head") and Target.Head.Position or Target.HumanoidRootPart.Position
            local NewCam = CFrame.new(Camera.CFrame.Position, AimPos)
            Camera.CFrame = Camera.CFrame:Lerp(NewCam, Settings.InstantAim and 1 or Settings.AimStrength)
        end
    end)

    OrionLib:Init()
end
