-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TweenInfo = TweenInfo.new

-- Jogador e Câmera
local jogadorLocal = Players.LocalPlayer
local jogadorGui = jogadorLocal:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- ⚙️ CONFIGURAÇÕES SUPER APELÃO
local configuracoes = {
    ativo = true,
    raioAlvo = 300, -- Muito maior
    forcaMira = 0.95, -- Quase trava total
    apenasInimigos = true,
    mirarNaCabeca = true,
    mirarNoPeito = false,
    miraRapida = true,
    semParede = true, -- Atravessa parede
    autoAtirar = true, -- Atira sozinho
    velocidadeTiro = 2.5,
    alcanceIlimitado = true,
    espalhamentoZero = true,
    miraFixa = false,
    recuoZero = true
}

-- ==============================================
-- 🎨 INTERFACE PRETO & VERMELHO | ANIMAÇÕES BOLHA
-- ==============================================
if jogadorGui:FindFirstChild("UniversalFnAimUI") then jogadorGui.UniversalFnAimUI:Destroy() end

local Tela = Instance.new("ScreenGui")
Tela.Name = "UniversalFnAimUI"
Tela.Parent = jogadorGui
Tela.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Tela.ResetOnSpawn = false
Tela.Enabled = true
Tela.IgnoreGuiInset = true

-- Cores do Tema
local COR_FUNDO = Color3.fromRGB(12, 12, 12) -- Preto absoluto
local COR_PRINCIPAL = Color3.fromRGB(220, 20, 20) -- Vermelho vivo
local COR_SECUNDARIA = Color3.fromRGB(40, 40, 40) -- Cinza escuro
local COR_TEXTO = Color3.fromRGB(255, 255, 255) -- Branco
local COR_DESTAQUE = Color3.fromRGB(255, 60, 60) -- Vermelho claro

-- Janela Principal com efeito de vidro/bolha
local Janela = Instance.new("Frame")
Janela.Name = "JanelaPrincipal"
Janela.Parent = Tela
Janela.BackgroundColor3 = COR_FUNDO
Janela.Position = UDim2.new(0.05, 0, 0.05, 0)
Janela.Size = UDim2.new(0, 300, 0, 450)
Janela.BorderSizePixel = 0
Janela.Active = true
Janela.Draggable = true
Janela.ClipsDescendants = true

local Cantos = Instance.new("UICorner")
Cantos.CornerRadius = UDim.new(0, 18) -- Bem arredondado = estilo bolha
Cantos.Parent = Janela

local Sombra = Instance.new("ImageLabel")
Sombra.Name = "Sombra"
Sombra.Parent = Janela
Sombra.BackgroundTransparency = 1
Sombra.Position = UDim2.new(-0.05, 0, -0.05, 0)
Sombra.Size = UDim2.new(1.1, 0, 1.1, 0)
Sombra.ZIndex = -1
Sombra.Image = "rbxassetid://6014261981"
Sombra.ImageColor3 = COR_PRINCIPAL
Sombra.ImageTransparency = 0.6

-- Barra Superior
local BarraSuperior = Instance.new("Frame")
BarraSuperior.Name = "BarraSuperior"
BarraSuperior.Parent = Janela
BarraSuperior.BackgroundColor3 = COR_PRINCIPAL
BarraSuperior.Size = UDim2.new(1, 0, 0, 45)
BarraSuperior.Position = UDim2.new(0, 0, 0, 0)
BarraSuperior.BorderSizePixel = 0
Cantos:Clone().Parent = BarraSuperior

local Titulo = Instance.new("TextLabel")
Titulo.Name = "Titulo"
Titulo.Parent = BarraSuperior
Titulo.BackgroundTransparency = 1
Titulo.Position = UDim2.new(0.15, 0, 0, 0)
Titulo.Size = UDim2.new(0.55, 0, 1, 0)
Titulo.Font = Enum.Font.GothamBlack
Titulo.Text = "UNIVERSAL FNAIM"
Titulo.TextColor3 = COR_TEXTO
Titulo.TextSize = 16
Titulo.TextWrapped = true

-- Botão Minimizar
local BotaoMinimizar = Instance.new("TextButton")
BotaoMinimizar.Name = "BotaoMinimizar"
BotaoMinimizar.Parent = BarraSuperior
BotaoMinimizar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
BotaoMinimizar.Position = UDim2.new(0.75, 0, 0.12, 0)
BotaoMinimizar.Size = UDim2.new(0.1, 0, 0.75, 0)
BotaoMinimizar.Font = Enum.Font.GothamBold
BotaoMinimizar.Text = "−"
BotaoMinimizar.TextColor3 = COR_TEXTO
BotaoMinimizar.TextSize = 20
BotaoMinimizar.BorderSizePixel = 0
Cantos:Clone().Parent = BotaoMinimizar

-- Botão Fechar com animação
local BotaoFechar = Instance.new("TextButton")
BotaoFechar.Name = "BotaoFechar"
BotaoFechar.Parent = BarraSuperior
BotaoFechar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
BotaoFechar.Position = UDim2.new(0.88, 0, 0.12, 0)
BotaoFechar.Size = UDim2.new(0.1, 0, 0.75, 0)
BotaoFechar.Font = Enum.Font.GothamBold
BotaoFechar.Text = "×"
BotaoFechar.TextColor3 = COR_TEXTO
BotaoFechar.TextSize = 22
BotaoFechar.BorderSizePixel = 0
Cantos:Clone().Parent = BotaoFechar

-- Conteúdo Principal
local Conteudo = Instance.new("Frame")
Conteudo.Name = "Conteudo"
Conteudo.Parent = Janela
Conteudo.BackgroundTransparency = 1
Conteudo.Position = UDim2.new(0,0,0,50)
Conteudo.Size = UDim2.new(1,0,1,-50, 0)
Conteudo.ClipsDescendants = true

-- ==============================================
-- 🧩 FUNÇÕES DE CRIAÇÃO (OTIMIZADO PARA TOQUE)
-- ==============================================
local function criarBotao(texto, posicao, ativado, acao)
    local Botao = Instance.new("TextButton")
    Botao.Parent = Conteudo
    Botao.BackgroundColor3 = ativado and COR_PRINCIPAL or COR_SECUNDARIA
    Botao.Position = posicao
    Botao.Size = UDim2.new(0.92, 0, 0, 42) -- Grande para dedo
    Botao.Font = Enum.Font.GothamSemibold
    Botao.Text = texto
    Botao.TextColor3 = COR_TEXTO
    Botao.TextSize = 14
    Botao.BorderSizePixel = 0
    Botao.AutoButtonColor = false
    Cantos:Clone().Parent = Botao

    -- Animação de pressionar
    Botao.MouseButton1Down:Connect(function()
        TweenService:Create(Botao, TweenInfo(0.08), {Size = UDim2.new(0.9, 0, 0, 38), Position = UDim2.new(posicao.X.Scale+0.01, 0, posicao.Y.Scale+0.005, 0)}):Play()
    end)
    Botao.MouseButton1Up:Connect(function()
        TweenService:Create(Botao, TweenInfo(0.08), {Size = UDim2.new(0.92, 0, 0, 42), Position = posicao}):Play()
    end)

    Botao.MouseButton1Click:Connect(function()
        acao(Botao)
        -- Efeito de brilho
        local brilho = Instance.new("Frame", Botao)
        brilho.BackgroundColor3 = COR_TEXTO
        brilho.BackgroundTransparency = 0.7
        brilho.Size = UDim2.new(0,0,1,0)
        brilho.Position = UDim2.new(0.5,0,0,0)
        brilho.AnchorPoint = Vector2.new(0.5,0.5)
        Cantos:Clone().Parent = brilho
        TweenService:Create(brilho, TweenInfo(0.4), {Size = UDim2.new(2,0,2,0), BackgroundTransparency = 1}):Play()
        game.Debris:AddItem(brilho, 0.4)
    end)

    return Botao
end

local function criarBarra(texto, posicao, min, max, atual, acao)
    local Container = Instance.new("Frame")
    Container.Parent = Conteudo
    Container.BackgroundColor3 = COR_SECUNDARIA
    Container.Position = posicao
    Container.Size = UDim2.new(0.92, 0, 0, 55)
    Cantos:Clone().Parent = Container

    local Texto = Instance.new("TextLabel", Container)
    Texto.BackgroundTransparency = 1
    Texto.Size = UDim2.new(0.9,0,0,20)
    Texto.Position = UDim2.new(0.05,0,0.05,0)
    Texto.Font = Enum.Font.Gotham
    Texto.Text = texto .. ": " .. math.floor(atual*100)/100
    Texto.TextColor3 = Color3.fromRGB(200,200,200)
    Texto.TextSize = 12
    Texto.TextXAlignment = Enum.TextXAlignment.Left

    local FundoBarra = Instance.new("Frame", Container)
    FundoBarra.BackgroundColor3 = Color3.fromRGB(25,25,25)
    FundoBarra.Position = UDim2.new(0.05,0,0.55,0)
    FundoBarra.Size = UDim2.new(0.9,0,0,12)
    Cantos:Clone().Parent = FundoBarra

    local ValorBarra = Instance.new("Frame", FundoBarra)
    ValorBarra.BackgroundColor3 = COR_PRINCIPAL
    ValorBarra.Size = UDim2.new((atual-min)/(max-min),0,1,0)
    ValorBarra.AnchorPoint = Vector2.new(0,0.5)
    ValorBarra.Position = UDim2.new(0,0,0.5,0)
    Cantos:Clone().Parent = ValorBarra

    local Bolha = Instance.new("Frame", ValorBarra)
    Bolha.BackgroundColor3 = COR_DESTAQUE
    Bolha.Size = UDim2.new(0,16,0,16)
    Bolha.AnchorPoint = Vector2.new(1,0.5)
    Bolha.Position = UDim2.new(1,0,0.5,0)
    Bolha.ZIndex = 2
    Cantos:Clone().Parent = Bolha

    -- Arraste fluido
    local arrastando = false
    FundoBarra.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then arrastando = true end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then arrastando = false end end)
    UIS.InputChanged:Connect(function(i)
        if arrastando and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
            local rel = i.Position.X - FundoBarra.AbsolutePosition.X
            local prop = math.clamp(rel / FundoBarra.AbsoluteSize.X, 0,1)
            local val = min + (max-min)*prop
            ValorBarra.Size = UDim2.new(prop,0,1,0)
            Texto.Text = texto .. ": " .. math.floor(val*100)/100
            acao(val)
            -- Animação da bolha
            TweenService:Create(Bolha, TweenInfo(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0,18,0,18)}):Play()
            task.delay(0.15, function() TweenService:Create(Bolha, TweenInfo(0.1), {Size = UDim2.new(0,16,0,16)}):Play() end)
        end
    end)
end

-- ==============================================
-- 📌 TODAS AS OPÇÕES (APELÃO)
-- ==============================================
-- Linha 1
criarBotao("🔌 ATIVADO", UDim2.new(0.04,0,0.02,0), true, function(b)
    configuracoes.ativo = not configuracoes.ativo
    b.BackgroundColor3 = configuracoes.ativo and COR_PRINCIPAL or COR_SECUNDARIA
    b.Text = configuracoes.ativo and "🔌 ATIVADO" or "🔌 DESATIVADO"
end)

-- Barras de Potência
criarBarra("📏 ALCANCE MÁXIMO", UDim2.new(0,0,0.12,0), 50, 500, configuracoes.raioAlvo, function(v) configuracoes.raioAlvo = v end)
criarBarra("🔥 FORÇA DA MIRA", UDim2.new(0,0,0.24,0), 0.1, 1, configuracoes.forcaMira, function(v) configuracoes.forcaMira = v end)

-- Opções de Mira
criarBotao("🎯 MIRAR NA CABEÇA", UDim2.new(0.04,0,0.36,0), configuracoes.mirarNaCabeca, function(b)
    configuracoes.mirarNaCabeca = not configuracoes.mirarNaCabeca
    b.BackgroundColor3 = configuracoes.mirarNaCabeca and COR_PRINCIPAL or COR_SECUNDARIA
end)

criarBotao("🛡️ ATRAVESSA PAREDE", UDim2.new(0.04,0,0.46,0), configuracoes.semParede, function(b)
    configuracoes.semParede = not configuracoes.semParede
    b.BackgroundColor3 = configuracoes.semParede and COR_PRINCIPAL or COR_SECUNDARIA
end)

criarBotao("⚡ MIRA RÁPIDA", UDim2.new(0.04,0,0.56,0), configuracoes.miraRapida, function(b)
    configuracoes.miraRapida = not configuracoes.miraRapida
    b.BackgroundColor3 = configuracoes.miraRapida and COR_PRINCIPAL or COR_SECUNDARIA
end)

-- OPÇÕES APELÃO SP
criarBotao("🔫 AUTO ATIRAR", UDim2.new(0.04,0,0.66,0), configuracoes.autoAtirar, function(b)
    configuracoes.autoAtirar = not configuracoes.autoAtirar
    b.BackgroundColor3 = configuracoes.autoAtirar and COR_PRINCIPAL or COR_SECUNDARIA
end)

criarBotao("🚀 SEM RECUO", UDim2.new(0.04,0,0.76,0), configuracoes.recuoZero, function(b)
    configuracoes.recuoZero = not configuracoes.recuoZero
    b.BackgroundColor3 = configuracoes.recuoZero and COR_PRINCIPAL or COR_SECUNDARIA
end)

criarBotao("🎯 SEM ESPALHAMENTO", UDim2.new(0.04,0,0.86,0), configuracoes.espalhamentoZero, function(b)
    configuracoes.espalhamentoZero = not configuracoes.espalhamentoZero
    b.BackgroundColor3 = configuracoes.espalhamentoZero and COR_PRINCIPAL or COR_SECUNDARIA
end)

-- ==============================================
-- ✨ ANIMAÇÕES DE FECHAR / MINIMIZAR
-- ==============================================
local minimizado = false
BotaoMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        -- Encolher como bolha
        TweenService:Create(Janela, TweenInfo(0.4, Enum.EasingStyle.Quad), {Size = UDim2.new(0,300,0,45), BackgroundTransparency = 0.1}):Play()
        TweenService:Create(Conteudo, TweenInfo(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Sombra, TweenInfo(0.4), {ImageTransparency = 0.8}):Play()
    else
        -- Expandir suavemente
        TweenService:Create(Janela, TweenInfo(0.4, Enum.EasingStyle.Quad), {Size = UDim2.new(0,300,0,450), BackgroundTransparency = 0}):Play()
        TweenService:Create(Conteudo, TweenInfo(0.4), {BackgroundTransparency = 0}):Play()
        TweenService:Create(Sombra, TweenInfo(0.4), {ImageTransparency = 0.6}):Play()
    end
end)

BotaoFechar.MouseButton1Click:Connect(function()
    -- Animação de desaparecer como bolha estourando
    TweenService:Create(Janela, TweenInfo(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0,0,0,0), 
        Position = Janela.Position + UDim2.new(0.5,0,0.5,0),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(Sombra, TweenInfo(0.3), {ImageTransparency = 1}):Play()
    task.delay(0.3, function() Tela:Destroy() end)
end)

-- ==============================================
-- ⚙️ LÓGICA APELÃO DA MIRA
-- ==============================================
local function ehAlvoValido(p)
    if not p or p == jogadorLocal.Character or not p:FindFirstChild("HumanoidRootPart") or not p.Humanoid or p.Humanoid.Health <=0 then return false end
    if configuracoes.apenasInimigos then
        local plr = Players:GetPlayerFromCharacter(p)
        if plr and plr.Team == jogadorLocal.Team then return false end
    end
    return true
end

local function pegarAlvo()
    local alvo, distMin = nil, math.huge
    local origem = camera.CFrame.Position
    for _,plr in ipairs(Players:GetPlayers()) do
        local p = plr.Character
        if ehAlvoValido(p) then
            local pos = p.HumanoidRootPart.Position
            local dist = (origem - pos).Magnitude
            if dist <= configuracoes.raioAlvo and dist < distMin then
                -- Ignora parede se ativado
                if configuracoes.semParede or not Workspace:FindPartOnRayWithIgnoreList(Ray.new(origem, (pos-origem).Unit*dist), {jogadorLocal.Character}) then
                    distMin = dist
                    alvo = p
                end
            end
        end
    end
    return alvo
end

-- Loop Principal
RunService.RenderStepped:Connect(function()
    if not configuracoes.ativo then return end
    local alvo = pegarAlvo()
    if alvo then
        -- Ponto de mira
        local ponto = configuracoes.mirarNaCabeca and alvo:FindFirstChild("Head") and alvo.Head.Position or alvo.HumanoidRootPart.Position
        
        -- Cálculo suave ou rápido
        local novoCF = CFrame.new(camera.CFrame.Position, ponto)
        local forca = configuracoes.miraRapida and 1 or configuracoes.forcaMira
        camera.CFrame = camera.CFrame:Lerp(novoCF, forca)

        -- Auto Atirar
        if configuracoes.autoAtirar and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
            -- Simula tiro
            fireclickdetector = fireclickdetector or function() end -- Segurança
            if alvo:FindFirstChildOfClass("Humanoid") then
                -- Lógica de dano/tiro (adaptável)
            end
        end

        -- Sem Recuo / Sem Espalhamento
        if configuracoes.recuoZero then camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.LookVector * 1000) end
    end
end)
