-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Jogador e Câmera
local jogadorLocal = Players.LocalPlayer
local jogadorGui = jogadorLocal:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- ⚙️ CONFIGURAÇÕES
local configuracoes = {
    ativo = true,
    raioAlvo = 50,
    forcaMira = 0.3,
    apenasInimigos = true,
    mirarNaCabeca = true
}

-- ==============================================
-- 🎨 CRIAÇÃO DA INTERFACE - UNIVERSAL FNAIM
-- ==============================================
-- Remover UI antiga se já existir (evita erro no Delta)
if jogadorGui:FindFirstChild("UniversalFnAimUI") then
    jogadorGui.UniversalFnAimUI:Destroy()
end

local Tela = Instance.new("ScreenGui")
Tela.Name = "UniversalFnAimUI"
Tela.Parent = jogadorGui
Tela.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Tela.ResetOnSpawn = false
-- Compatibilidade Delta
Tela.Enabled = true

local Janela = Instance.new("Frame")
Janela.Name = "JanelaPrincipal"
Janela.Parent = Tela
Janela.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Janela.Position = UDim2.new(0.02, 0, 0.02, 0)
Janela.Size = UDim2.new(0, 220, 0, 300)
Janela.BorderSizePixel = 0
Janela.Active = true
Janela.Draggable = true

local Cantos = Instance.new("UICorner")
Cantos.CornerRadius = UDim.new(0, 8)
Cantos.Parent = Janela

local Titulo = Instance.new("TextLabel")
Titulo.Name = "Titulo"
Titulo.Parent = Janela
Titulo.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Titulo.Size = UDim2.new(1, 0, 0, 35)
Titulo.Font = Enum.Font.GothamBold
Titulo.Text = "UNIVERSAL FNAIM"
Titulo.TextColor3 = Color3.fromRGB(80, 200, 255)
Titulo.TextSize = 14
Titulo.BorderSizePixel = 0
Titulo.TextWrapped = true
Cantos:Clone().Parent = Titulo

-- Função para criar botão
local function criarBotao(texto, posicao, cor, acao)
    local Botao = Instance.new("TextButton")
    Botao.Parent = Janela
    Botao.BackgroundColor3 = cor
    Botao.Position = posicao
    Botao.Size = UDim2.new(0.9, 0, 0, 30)
    Botao.Font = Enum.Font.GothamSemibold
    Botao.Text = texto
    Botao.TextColor3 = Color3.fromRGB(255, 255, 255)
    Botao.TextSize = 13
    Botao.BorderSizePixel = 0
    Cantos:Clone().Parent = Botao
    
    Botao.MouseButton1Click:Connect(acao)
    
    -- Efeito de hover
    Botao.MouseEnter:Connect(function()
        TweenService:Create(Botao, TweenInfo.new(0.15), {BackgroundColor3 = Color3.new(
            math.min(cor.R*1.3, 1), 
            math.min(cor.G*1.3, 1), 
            math.min(cor.B*1.3, 1)
        )}):Play()
    end)
    Botao.MouseLeave:Connect(function()
        TweenService:Create(Botao, TweenInfo.new(0.15), {BackgroundColor3 = cor}):Play()
    end)
    
    return Botao
end

-- Função para criar barra de ajuste
local function criarBarra(texto, posicao, valorMin, valorMax, valorInicial, acao)
    local Container = Instance.new("Frame")
    Container.Parent = Janela
    Container.BackgroundTransparency = 1
    Container.Position = posicao
    Container.Size = UDim2.new(0.9, 0, 0, 40)
    Container.AnchorPoint = Vector2.new(0.5, 0)
    Container.Position = UDim2.new(0.5, 0, posicao.Y.Scale, posicao.Y.Offset)
    
    local Texto = Instance.new("TextLabel")
    Texto.Parent = Container
    Texto.BackgroundTransparency = 1
    Texto.Size = UDim2.new(1, 0, 0, 15)
    Texto.Font = Enum.Font.Gotham
    Texto.Text = texto .. ": " .. math.floor(valorInicial * 100) / 100
    Texto.TextColor3 = Color3.fromRGB(220, 220, 220)
    Texto.TextSize = 12
    Texto.TextXAlignment = Enum.TextXAlignment.Left
    
    local BarraFundo = Instance.new("Frame")
    BarraFundo.Parent = Container
    BarraFundo.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    BarraFundo.Position = UDim2.new(0, 0, 0, 20)
    BarraFundo.Size = UDim2.new(1, 0, 0, 8)
    Cantos:Clone().Parent = BarraFundo
    
    local BarraValor = Instance.new("Frame")
    BarraValor.Parent = BarraFundo
    BarraValor.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
    BarraValor.Size = UDim2.new((valorInicial - valorMin) / (valorMax - valorMin), 0, 1, 0)
    BarraValor.AnchorPoint = Vector2.new(0, 0)
    Cantos:Clone().Parent = BarraValor

    -- Detectar clique e arraste na barra
    local arrastando = false
    BarraFundo.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            arrastando = true
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            arrastando = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if arrastando and input.UserInputType == Enum.UserInputType.MouseMovement then
            local posicaoRelativa = input.Position.X - BarraFundo.AbsolutePosition.X
            local proporcao = math.clamp(posicaoRelativa / BarraFundo.AbsoluteSize.X, 0, 1)
            local valorAtual = valorMin + (valorMax - valorMin) * proporcao
            
            BarraValor.Size = UDim2.new(proporcao, 0, 1, 0)
            Texto.Text = texto .. ": " .. math.floor(valorAtual * 100) / 100
            acao(valorAtual)
        end
    end)
end

-- 📌 Adicionar os elementos na janela
local botaoLigar = criarBotao("🔌 LIGADO", UDim2.new(0.05, 0, 0.15, 0), Color3.fromRGB(40, 180, 80), function()
    configuracoes.ativo = not configuracoes.ativo
    botaoLigar.Text = configuracoes.ativo and "🔌 LIGADO" or "🔌 DESLIGADO"
    botaoLigar.BackgroundColor3 = configuracoes.ativo and Color3.fromRGB(40, 180, 80) or Color3.fromRGB(180, 40, 40)
end)

criarBarra("Distância Máxima", UDim2.new(0,0,0.30,0), 10, 200, configuracoes.raioAlvo, function(v)
    configuracoes.raioAlvo = v
end)

criarBarra("Força da Mira", UDim2.new(0,0,0.50,0), 0.05, 1, configuracoes.forcaMira, function(v)
    configuracoes.forcaMira = v
end)

local botaoCabeca = criarBotao("🎯 MIRAR: CABEÇA", UDim2.new(0.05, 0, 0.70, 0), Color3.fromRGB(80, 120, 255), function()
    configuracoes.mirarNaCabeca = not configuracoes.mirarNaCabeca
    botaoCabeca.Text = configuracoes.mirarNaCabeca and "🎯 MIRAR: CABEÇA" or "🎯 MIRAR: CORPO"
end)

-- ==============================================
-- ⚙️ LÓGICA DA MIRA ASSISTIDA
-- ==============================================

-- Verifica se o alvo é válido
local function ehAlvoValido(personagem)
    if not personagem then return false end
    if personagem == jogadorLocal.Character then return false end
    
    if configuracoes.apenasInimigos then
        local jogadorAlvo = Players:GetPlayerFromCharacter(personagem)
        if jogadorAlvo and jogadorAlvo.Team == jogadorLocal.Team then
            return false
        end
    end

    return personagem:FindFirstChild("HumanoidRootPart") and personagem:FindFirstChild("Humanoid") 
        and personagem.Humanoid.Health > 0
end

-- Encontra o alvo mais próximo visível
local function pegarAlvoMaisProximo()
    local alvoMaisProximo = nil
    local menorDistancia = math.huge
    local origemCamera = camera.CFrame.Position

    for _, jogador in ipairs(Players:GetPlayers()) do
        local personagem = jogador.Character
        if ehAlvoValido(personagem) then
            local posicaoAlvo = personagem.HumanoidRootPart.Position
            local distancia = (origemCamera - posicaoAlvo).Magnitude

            if distancia <= configuracoes.raioAlvo and distancia < menorDistancia then
                -- Verifica se tem parede no caminho
                local direcao = (posicaoAlvo - origemCamera).Unit * distancia
                local raio = Ray.new(origemCamera, direcao)
                local parteTocada = Workspace:FindPartOnRayWithIgnoreList(raio, {jogadorLocal.Character})

                if not parteTocada or parteTocada:IsDescendantOf(personagem) then
                    menorDistancia = distancia
                    alvoMaisProximo = personagem
                end
            end
        end
    end

    return alvoMaisProximo
end

-- Atualiza a mira a cada quadro
RunService.RenderStepped:Connect(function()
    if not configuracoes.ativo then return end

    local alvo = pegarAlvoMaisProximo()
    if alvo then
        -- Escolhe entre cabeça ou corpo
        local pontoAlvo = configuracoes.mirarNaCabeca and alvo:FindFirstChild("Head") and alvo.Head.Position or alvo.HumanoidRootPart.Position
        
        -- Calcula nova direção
        local direcao = (pontoAlvo - camera.CFrame.Position).Unit
        local novoCFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direcao)

        -- Suaviza o movimento
        camera.CFrame = camera.CFrame:Lerp(novoCFrame, configuracoes.forcaMira)
    end
end)

-- 🔑 TECLA PARA MOSTRAR/ESCONDER O MENU (Padrão: Tecla Insert)
local TECLA_TOGGLE = Enum.KeyCode.Insert
UIS.InputBegan:Connect(function(input, processado)
    if processado then return end
    if input.KeyCode == TECLA_TOGGLE then
        Tela.Enabled = not Tela.Enabled
    end
end)
