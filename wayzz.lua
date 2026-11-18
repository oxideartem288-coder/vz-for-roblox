local P=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local Cam=workspace.CurrentCamera
local LP=P.LocalPlayer

local C={
    on=true,max=500,box=true,skel=true,hp=true,name=true,tr=true,chams=true,team=false,visible=true,
    cc=Color3.fromRGB(255,0,0),chamsIdx=1,hpW=2,hpGap=6,thick=1,
    aim=false, aimKey=Enum.KeyCode.E, aimFov=120, aimSmooth=0.25, aimShowFov=true, aimFovColor=Color3.fromRGB(255,255,255),
    aimPart="Head", aimTeamCheck=true
}
local B={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}

local THEMES={
    {bg=Color3.fromRGB(20,20,24),head=Color3.fromRGB(30,30,38),row=Color3.fromRGB(28,28,34),accent=Color3.fromRGB(70,200,120),txt=Color3.fromRGB(200,200,205)},
    {bg=Color3.fromRGB(24,20,34),head=Color3.fromRGB(38,30,52),row=Color3.fromRGB(30,24,42),accent=Color3.fromRGB(160,120,255),txt=Color3.fromRGB(220,215,235)},
    {bg=Color3.fromRGB(16,22,34),head=Color3.fromRGB(24,34,52),row=Color3.fromRGB(20,28,44),accent=Color3.fromRGB(90,170,255),txt=Color3.fromRGB(210,225,245)},
    {bg=Color3.fromRGB(34,18,28),head=Color3.fromRGB(52,26,44),row=Color3.fromRGB(42,22,36),accent=Color3.fromRGB(255,120,190),txt=Color3.fromRGB(245,215,230)},
}
local CHAMS_COLORS={
    {name="Red",    fill=Color3.fromRGB(255,0,0),   out=Color3.fromRGB(255,255,255)},
    {name="Green",  fill=Color3.fromRGB(0,255,100), out=Color3.fromRGB(255,255,255)},
    {name="Blue",   fill=Color3.fromRGB(0,120,255), out=Color3.fromRGB(255,255,255)},
    {name="Purple", fill=Color3.fromRGB(180,0,255), out=Color3.fromRGB(255,255,255)},
    {name="Pink",   fill=Color3.fromRGB(255,80,180),out=Color3.fromRGB(255,255,255)},
    {name="Rainbow",fill=Color3.fromRGB(255,255,255),out=Color3.fromRGB(255,255,255)},
}
local themeIdx=1
local menuScale=Vector2.new(0.4,0.7)
local function getMenuSize() return UDim2.new(menuScale.X,0,menuScale.Y,0) end

local function mk(k) local o=Drawing.new(k) if k=="Line" then o.Transparency=1 end if k=="Text" then o.Size=14;o.Center=true;o.Outline=true end if k=="Square" then o.Filled=true end if k=="Circle" then o.Thickness=1;o.Transparency=1 end o.Visible=false return o end

local G=Instance.new("ScreenGui") G.ResetOnSpawn=false G.Parent=game:GetService("CoreGui")
local TH0 = THEMES[1]

-- FOV Circle
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1
fovCircle.Transparency = 1
fovCircle.Visible = false

local M=Instance.new("Frame",G)
M.Size=getMenuSize()
M.AnchorPoint=Vector2.new(0.5,0.5)
M.Position=UDim2.new(0.5,0,0.5,0)
M.BackgroundColor3=TH0.bg
M.BorderSizePixel=0
M.Active=true
M.ClipsDescendants=true
Instance.new("UICorner",M).CornerRadius=UDim.new(0,8)

local T=Instance.new("TextLabel",M)
T.Size=UDim2.new(1,0,0,44)
T.BackgroundColor3=TH0.head
T.Text="  wayzz"
T.TextColor3=TH0.txt
T.TextXAlignment=Enum.TextXAlignment.Left
T.Font=Enum.Font.GothamBold
T.TextSize=18
Instance.new("UICorner",T).CornerRadius=UDim.new(0,8)

local THB=Instance.new("TextButton",M)
THB.Size=UDim2.new(0,44,0,44)
THB.Position=UDim2.new(1,-88,0,0)
THB.BackgroundColor3=TH0.head
THB.Text="◐"
THB.TextColor3=TH0.accent
THB.Font=Enum.Font.GothamBold
THB.TextSize=22
THB.AutoButtonColor=false

local X=Instance.new("TextButton",M)
X.Size=UDim2.new(0,44,0,44)
X.Position=UDim2.new(1,-44,0,0)
X.BackgroundColor3=TH0.head
X.Text="×"
X.TextColor3=TH0.txt
X.Font=Enum.Font.GothamBold
X.TextSize=24
X.AutoButtonColor=false

local SC=Instance.new("ScrollingFrame",M)
SC.Size=UDim2.new(1,-24,1,-64)
SC.Position=UDim2.new(0,12,0,52)
SC.BackgroundTransparency=1
SC.BorderSizePixel=0
SC.ScrollBarThickness=4
SC.AutomaticCanvasSize=Enum.AutomaticSize.Y
local SL=Instance.new("UIListLayout",SC)
SL.Padding=UDim.new(0,8)

local CHC=Instance.new("TextButton",SC)
CHC.Size=UDim2.new(1,-8,0,40)
CHC.BackgroundColor3=TH0.row
CHC.Text="Chams: "..CHAMS_COLORS[C.chamsIdx].name
CHC.TextColor3=TH0.txt
CHC.Font=Enum.Font.Gotham
CHC.TextSize=15
CHC.AutoButtonColor=false
Instance.new("UICorner",CHC).CornerRadius=UDim.new(0,6)
CHC.MouseButton1Click:Connect(function()
    C.chamsIdx = C.chamsIdx % #CHAMS_COLORS + 1
    CHC.Text = "Chams: "..CHAMS_COLORS[C.chamsIdx].name
end)

-- Size slider
local SIZE_ROW=Instance.new("TextButton",SC)
SIZE_ROW.Size=UDim2.new(1,-8,0,40)
SIZE_ROW.BackgroundColor3=TH0.row
SIZE_ROW.Text=""
SIZE_ROW.AutoButtonColor=false
Instance.new("UICorner",SIZE_ROW).CornerRadius=UDim.new(0,6)
local slbl=Instance.new("TextLabel",SIZE_ROW)
slbl.Size=UDim2.new(0.45,0,1,0)
slbl.Position=UDim2.new(0,12,0,0)
slbl.BackgroundTransparency=1
slbl.Text="Size"
slbl.TextColor3=TH0.txt
slbl.TextXAlignment=Enum.TextXAlignment.Left
slbl.Font=Enum.Font.Gotham
slbl.TextSize=15
local STrack=Instance.new("Frame",SIZE_ROW)
STrack.Size=UDim2.new(0.45,-12,0,6)
STrack.Position=UDim2.new(0.5,0,0.5,-3)
STrack.BackgroundColor3=Color3.fromRGB(50,50,58)
STrack.BorderSizePixel=0
Instance.new("UICorner",STrack).CornerRadius=UDim.new(1,0)
local SFill=Instance.new("Frame",STrack)
SFill.Size=UDim2.new((menuScale.X-0.2)/0.7,0,1,0)
SFill.BackgroundColor3=TH0.accent
SFill.BorderSizePixel=0
Instance.new("UICorner",SFill).CornerRadius=UDim.new(1,0)
local SKnob=Instance.new("Frame",STrack)
SKnob.Size=UDim2.new(0,14,0,14)
SKnob.Position=UDim2.new((menuScale.X-0.2)/0.7,-7,0.5,-7)
SKnob.BackgroundColor3=Color3.fromRGB(240,240,245)
SKnob.BorderSizePixel=0
Instance.new("UICorner",SKnob).CornerRadius=UDim.new(1,0)
local sDragging=false
local function setSizeFromX(x)
    local rel=math.clamp((x-STrack.AbsolutePosition.X)/STrack.AbsoluteSize.X,0,1)
    local w=0.2+rel*0.7; local h=0.3+rel*0.7
    menuScale=Vector2.new(w,h)
    SFill.Size=UDim2.new(rel,0,1,0)
    SKnob.Position=UDim2.new(rel,-7,0.5,-7)
    if M.Visible then M.Size=getMenuSize() end
end
STrack.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sDragging=true; setSizeFromX(i.Position.X) end
end)
UIS.InputChanged:Connect(function(i)
    if sDragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then setSizeFromX(i.Position.X) end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sDragging=false end
end)

-- Toggles
local keys={"on","box","skel","hp","name","tr","chams","team","visible","aim","aimShowFov"}
local names={"ESP On","Box","Skeleton","Health","Name","Tracers","Chams","Team Check","Visible Only","Aimbot","Show FOV"}
local rows={}
for i,k in ipairs(keys) do
    local b=Instance.new("TextButton",SC)
    b.Size=UDim2.new(1,-8,0,40)
    b.BackgroundColor3=TH0.row
    b.Text=""
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    local l=Instance.new("TextLabel",b)
    l.Size=UDim2.new(1,-60,1,0)
    l.Position=UDim2.new(0,12,0,0)
    l.BackgroundTransparency=1
    l.Text=names[i]
    l.TextColor3=TH0.txt
    l.TextXAlignment=Enum.TextXAlignment.Left
    l.Font=Enum.Font.Gotham
    l.TextSize=15
    local d=Instance.new("Frame",b)
    d.Size=UDim2.new(0,40,0,20)
    d.Position=UDim2.new(1,-52,0.5,-10)
    d.BackgroundColor3=C[k] and TH0.accent or Color3.fromRGB(50,50,58)
    Instance.new("UICorner",d).CornerRadius=UDim.new(1,0)
    local kn=Instance.new("Frame",d)
    kn.Size=UDim2.new(0,16,0,16)
    kn.Position=C[k] and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    kn.BackgroundColor3=Color3.fromRGB(240,240,245)
    Instance.new("UICorner",kn).CornerRadius=UDim.new(1,0)
    local row={b=b,l=l,d=d,k=k}
    function row:paint()
        local th=THEMES[themeIdx]
        b.BackgroundColor3=th.row
        l.TextColor3=th.txt
        d.BackgroundColor3=C[k] and th.accent or Color3.fromRGB(50,50,58)
    end
    b.MouseButton1Click:Connect(function()
        C[k]=not C[k]
        d.BackgroundColor3=C[k] and THEMES[themeIdx].accent or Color3.fromRGB(50,50,58)
        kn.Position=C[k] and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    end)
    table.insert(rows,row)
end

-- FOV slider
local FOV_ROW=Instance.new("TextButton",SC)
FOV_ROW.Size=UDim2.new(1,-8,0,40)
FOV_ROW.BackgroundColor3=TH0.row
FOV_ROW.Text=""
FOV_ROW.AutoButtonColor=false
Instance.new("UICorner",FOV_ROW).CornerRadius=UDim.new(0,6)
local flbl=Instance.new("TextLabel",FOV_ROW)
flbl.Size=UDim2.new(0.45,0,1,0)
flbl.Position=UDim2.new(0,12,0,0)
flbl.BackgroundTransparency=1
flbl.Text="FOV Size"
flbl.TextColor3=TH0.txt
flbl.TextXAlignment=Enum.TextXAlignment.Left
flbl.Font=Enum.Font.Gotham
flbl.TextSize=15
local FTrack=Instance.new("Frame",FOV_ROW)
FTrack.Size=UDim2.new(0.45,-12,0,6)
FTrack.Position=UDim2.new(0.5,0,0.5,-3)
FTrack.BackgroundColor3=Color3.fromRGB(50,50,58)
FTrack.BorderSizePixel=0
Instance.new("UICorner",FTrack).CornerRadius=UDim.new(1,0)
local FFill=Instance.new("Frame",FTrack)
FFill.Size=UDim2.new(C.aimFov/500,0,1,0)
FFill.BackgroundColor3=TH0.accent
FFill.BorderSizePixel=0
Instance.new("UICorner",FFill).CornerRadius=UDim.new(1,0)
local FKnob=Instance.new("Frame",FTrack)
FKnob.Size=UDim2.new(0,14,0,14)
FKnob.Position=UDim2.new(C.aimFov/500,-7,0.5,-7)
FKnob.BackgroundColor3=Color3.fromRGB(240,240,245)
FKnob.BorderSizePixel=0
Instance.new("UICorner",FKnob).CornerRadius=UDim.new(1,0)
local fDragging=false
local function setFovFromX(x)
    local rel=math.clamp((x-FTrack.AbsolutePosition.X)/FTrack.AbsoluteSize.X,0,1)
    C.aimFov = 20 + rel * 480
    FFill.Size=UDim2.new(rel,0,1,0)
    FKnob.Position=UDim2.new(rel,-7,0.5,-7)
end
FTrack.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fDragging=true; setFovFromX(i.Position.X) end
end)
UIS.InputChanged:Connect(function(i)
    if fDragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then setFovFromX(i.Position.X) end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fDragging=false end
end)

-- Smooth slider
local SM_ROW=Instance.new("TextButton",SC)
SM_ROW.Size=UDim2.new(1,-8,0,40)
SM_ROW.BackgroundColor3=TH0.row
SM_ROW.Text=""
SM_ROW.AutoButtonColor=false
Instance.new("UICorner",SM_ROW).CornerRadius=UDim.new(0,6)
local smlbl=Instance.new("TextLabel",SM_ROW)
smlbl.Size=UDim2.new(0.45,0,1,0)
smlbl.Position=UDim2.new(0,12,0,0)
smlbl.BackgroundTransparency=1
smlbl.Text="Smooth"
smlbl.TextColor3=TH0.txt
smlbl.TextXAlignment=Enum.TextXAlignment.Left
smlbl.Font=Enum.Font.Gotham
smlbl.TextSize=15
local SMTrack=Instance.new("Frame",SM_ROW)
SMTrack.Size=UDim2.new(0.45,-12,0,6)
SMTrack.Position=UDim2.new(0.5,0,0.5,-3)
SMTrack.BackgroundColor3=Color3.fromRGB(50,50,58)
SMTrack.BorderSizePixel=0
Instance.new("UICorner",SMTrack).CornerRadius=UDim.new(1,0)
local SMFill=Instance.new("Frame",SMTrack)
SMFill.Size=UDim2.new(C.aimSmooth,0,1,0)
SMFill.BackgroundColor3=TH0.accent
SMFill.BorderSizePixel=0
Instance.new("UICorner",SMFill).CornerRadius=UDim.new(1,0)
local SMKnob=Instance.new("Frame",SMTrack)
SMKnob.Size=UDim2.new(0,14,0,14)
SMKnob.Position=UDim2.new(C.aimSmooth,-7,0.5,-7)
SMKnob.BackgroundColor3=Color3.fromRGB(240,240,245)
SMKnob.BorderSizePixel=0
Instance.new("UICorner",SMKnob).CornerRadius=UDim.new(1,0)
local smDragging=false
local function setSmoothFromX(x)
    local rel=math.clamp((x-SMTrack.AbsolutePosition.X)/SMTrack.AbsoluteSize.X,0,1)
    C.aimSmooth = rel
    SMFill.Size=UDim2.new(rel,0,1,0)
    SMKnob.Position=UDim2.new(rel,-7,0.5,-7)
end
SMTrack.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then smDragging=true; setSmoothFromX(i.Position.X) end
end)
UIS.InputChanged:Connect(function(i)
    if smDragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then setSmoothFromX(i.Position.X) end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then smDragging=false end
end)

local function applyTheme(idx)
    themeIdx=idx
    local th=THEMES[idx]
    M.BackgroundColor3=th.bg
    T.BackgroundColor3=th.head; T.TextColor3=th.txt
    THB.BackgroundColor3=th.head; THB.TextColor3=th.accent
    X.BackgroundColor3=th.head; X.TextColor3=th.txt
    CHC.BackgroundColor3=th.row; CHC.TextColor3=th.txt
    SIZE_ROW.BackgroundColor3=th.row; slbl.TextColor3=th.txt; SFill.BackgroundColor3=th.accent
    FOV_ROW.BackgroundColor3=th.row; flbl.TextColor3=th.txt; FFill.BackgroundColor3=th.accent
    SM_ROW.BackgroundColor3=th.row; smlbl.TextColor3=th.txt; SMFill.BackgroundColor3=th.accent
    for _,r in ipairs(rows) do r:paint() end
end

THB.MouseButton1Click:Connect(function() applyTheme(themeIdx % #THEMES + 1) end)

-- Open button
local OPEN=Instance.new("TextButton",G)
OPEN.Size=UDim2.new(0,44,0,44)
OPEN.Position=UDim2.new(0.5,-22,0.5,-22)
OPEN.BackgroundColor3=TH0.bg
OPEN.Text="wayzz"
OPEN.TextColor3=TH0.accent
OPEN.Font=Enum.Font.GothamBold
OPEN.TextSize=11
OPEN.Visible=false
OPEN.BackgroundTransparency=1
OPEN.TextTransparency=1
Instance.new("UICorner",OPEN).CornerRadius=UDim.new(1,0)

local T_OPEN = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local T_CLOSE = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local function showMenu()
    M.Visible = true
    M.Size = UDim2.new(0,0,0,0)
    M.BackgroundTransparency = 1
    TS:Create(M, T_OPEN, {Size=getMenuSize(), BackgroundTransparency=0}):Play()
    local t = TS:Create(OPEN, T_CLOSE, {BackgroundTransparency=1, TextTransparency=1})
    t:Play()
    t.Completed:Connect(function() OPEN.Visible=false end)
end
local function hideMenu()
    local t = TS:Create(M, T_CLOSE, {Size=UDim2.new(0,0,0,0), BackgroundTransparency=1})
    t:Play()
    t.Completed:Connect(function() M.Visible=false end)
    OPEN.Visible = true
    TS:Create(OPEN, T_OPEN, {BackgroundTransparency=0, TextTransparency=0}):Play()
end

X.MouseButton1Click:Connect(hideMenu)
OPEN.MouseButton1Click:Connect(showMenu)
UIS.InputBegan:Connect(function(i,g)
    if not g and i.KeyCode==Enum.KeyCode.RightShift then
        if M.Visible then hideMenu() else showMenu() end
    end
end)

-- Drag
local dg,ds,sp,draggingTarget=false,nil,nil,nil
local function startDrag(input, target)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dg=true; ds=input.Position; sp=target.Position; draggingTarget=target
    end
end
T.InputBegan:Connect(function(i) startDrag(i, M) end)
M.InputBegan:Connect(function(i)
    local o=i.Target
    while o and o~=M do
        if o:IsA("TextButton") or o:IsA("ScrollingFrame") then return end
        o=o.Parent
    end
    startDrag(i, M)
end)
OPEN.InputBegan:Connect(function(i) startDrag(i, OPEN) end)
UIS.InputChanged:Connect(function(i)
    if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-ds
        draggingTarget.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        dg=false; draggingTarget=nil
    end
end)

-- ESP helpers
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true
local function isVisible(ch, head)
    if not C.visible then return true end
    rayParams.FilterDescendantsInstances = {LP.Character, ch, Cam}
    local origin = Cam.CFrame.Position
    local dir = head.Position - origin
    local result = workspace:Raycast(origin, dir, rayParams)
    if result and result.Instance then
        return result.Instance:IsDescendantOf(ch) or result.Instance == head
    end
    return true
end

local E={}
local function add(p)
    if p==LP or E[p] then return end
    local ch=p.Character or p.CharacterAdded:Wait()
    local L={} for i=1,#B do L[i]=mk("Line") end
    local bx={} for i=1,4 do bx[i]=mk("Line") end
    local hl=Instance.new("Highlight",G) hl.Adornee=ch
    E[p]={ch=ch,L=L,bx=bx,tr=mk("Line"),bg=mk("Square"),fg=mk("Square"),nm=mk("Text"),hl=hl}
    p.CharacterAdded:Connect(function(nc)
        local d=E[p]; d.ch=nc; d.hl.Adornee=nc
        for _,l in ipairs(d.L) do l:Remove() end
        d.L={} for i=1,#B do d.L[i]=mk("Line") end
    end)
end
local function del(p)
    local d=E[p]; if not d then return end
    for _,l in ipairs(d.L) do l:Remove() end
    for _,l in ipairs(d.bx) do l:Remove() end
    d.tr:Remove();d.bg:Remove();d.fg:Remove();d.nm:Remove();d.hl:Destroy()
    E[p]=nil
end
local function w2s(v) local s,o=Cam:WorldToViewportPoint(v) if not o or s.Z<=0 then return end return Vector2.new(s.X,s.Y) end
local function hide(d) for _,l in ipairs(d.L) do l.Visible=false end for _,l in ipairs(d.bx) do l.Visible=false end d.tr.Visible=false;d.bg.Visible=false;d.fg.Visible=false;d.nm.Visible=false end

-- Aimbot
local function getAimTarget()
    local best, bestDist = nil, C.aimFov
    local vp = Cam.ViewportSize
    local center = Vector2.new(vp.X/2, vp.Y/2)
    for p, d in pairs(E) do
        local h = d.ch and d.ch:FindFirstChildOfClass("Humanoid")
        local target = d.ch and d.ch:FindFirstChild(C.aimPart)
        if h and target and h.Health > 0 then
            local skip = false
            if C.aimTeamCheck and p.Team and LP.Team and p.Team == LP.Team then skip = true end
            if not skip and isVisible(d.ch, target) then
                local pos, onScreen = Cam:WorldToViewportPoint(target.Position)
                if onScreen and pos.Z > 0 then
                    local screenPos = Vector2.new(pos.X, pos.Y)
                    local dist = (screenPos - center).Magnitude
                    if dist < bestDist then
                        best = target
                        bestDist = dist
                    end
                end
            end
        end
    end
    return best
end

local function runAim(dt)
    if not C.aim then fovCircle.Visible = false; return end
    local vp = Cam.ViewportSize
    fovCircle.Position = Vector2.new(vp.X/2, vp.Y/2)
    fovCircle.Radius = C.aimFov
    fovCircle.Color = C.aimFovColor
    fovCircle.Visible = C.aimShowFov

    if UIS:IsKeyDown(C.aimKey) then
        local target = getAimTarget()
        if target then
            local camPos = Cam.CFrame.Position
            local look = CFrame.lookAt(camPos, target.Position)
            local alpha = 1
            if C.aimSmooth > 0.01 then
                alpha = 1 - math.pow(1 - C.aimSmooth, dt * 60)
            end
            Cam.CFrame = Cam.CFrame:Lerp(look, alpha)
        end
    end
end

-- Main ESP tick
local function tick()
    if not C.on then for _,d in pairs(E) do hide(d) end return end
    local cp=Cam.CFrame.Position; local vp=Cam.ViewportSize; local o=Vector2.new(vp.X/2,vp.Y)
    local t=os.clock()
    for p,d in pairs(E) do
        local h=d.ch and d.ch:FindFirstChildOfClass("Humanoid")
        local r=d.ch and d.ch:FindFirstChild("HumanoidRootPart")
        local skip = false
        if C.team and p.Team and LP.Team and p.Team == LP.Team then skip = true end
        if skip or not h or not r or h.Health<=0 or (r.Position-cp).Magnitude>C.max then
            hide(d); d.hl.Enabled=false; continue
        end
        d.hl.Enabled=C.chams
        if C.chams then
            local preset = CHAMS_COLORS[C.chamsIdx]
            if preset.name == "Rainbow" then
                d.hl.FillColor = Color3.fromHSV((t*0.3 + p.UserId*0.001) % 1, 1, 1)
                d.hl.OutlineColor = Color3.new(1,1,1)
            else
                d.hl.FillColor = preset.fill
                d.hl.OutlineColor = preset.out
            end
        end
        local hd=d.ch:FindFirstChild("Head"); local hs=hd and w2s(hd.Position)
        if not hs then
            for _,l in ipairs(d.L) do l.Visible=false end
            for _,l in ipairs(d.bx) do l.Visible=false end
            d.tr.Visible=false; d.bg.Visible=false; d.fg.Visible=false; d.nm.Visible=false
            continue
        end
        if not isVisible(d.ch, hd) then
            for _,l in ipairs(d.L) do l.Visible=false end
            for _,l in ipairs(d.bx) do l.Visible=false end
            d.tr.Visible=false; d.bg.Visible=false; d.fg.Visible=false; d.nm.Visible=false
            d.hl.Enabled = false
            continue
        end
        local corners = nil
        if C.box then
            local topY, botY, leftX, rightX
            local la = d.ch:FindFirstChild("Left Arm") or d.ch:FindFirstChild("LeftUpperArm")
            local ra = d.ch:FindFirstChild("Right Arm") or d.ch:FindFirstChild("RightUpperArm")
            local lg = d.ch:FindFirstChild("Left Leg") or d.ch:FindFirstChild("LeftLowerLeg") or d.ch:FindFirstChild("LeftFoot")
            if la and ra and lg and hd then
                topY = hd.Position.Y + hd.Size.Y/2
                botY = lg.Position.Y - lg.Size.Y/2
                leftX = la.Position.X - la.Size.X/2
                rightX = ra.Position.X + ra.Size.X/2
            else
                local ok, cf, sz = pcall(function() return d.ch:GetBoundingBox() end)
                if ok then
                    local pos = cf.Position
                    topY = pos.Y + sz.Y/2
                    botY = pos.Y - sz.Y/2
                    leftX = pos.X - sz.X/2
                    rightX = pos.X + sz.X/2
                end
            end
            if topY and botY and leftX and rightX then
                local tl = w2s(Vector3.new(leftX, topY, hd.Position.Z))
                local tr_ = w2s(Vector3.new(rightX, topY, hd.Position.Z))
                local bl = w2s(Vector3.new(leftX, botY, hd.Position.Z))
                local br = w2s(Vector3.new(rightX, botY, hd.Position.Z))
                if tl and tr_ and bl and br then
                    d.bx[1].From=tl; d.bx[1].To=tr_
                    d.bx[2].From=tr_; d.bx[2].To=br
                    d.bx[3].From=br; d.bx[3].To=bl
                    d.bx[4].From=bl; d.bx[4].To=tl
                    for _,l in ipairs(d.bx) do l.Color=C.cc; l.Thickness=C.thick; l.Visible=true end
                    corners={tl,tr_,bl,br}
                else
                    for _,l in ipairs(d.bx) do l.Visible=false end
                end
            else
                for _,l in ipairs(d.bx) do l.Visible=false end
            end
        else
            for _,l in ipairs(d.bx) do l.Visible=false end
        end

        if C.skel then
            for i,b in ipairs(B) do
                local a,c=d.ch:FindFirstChild(b[1]),d.ch:FindFirstChild(b[2])
                local p1=a and w2s(a.Position); local p2=c and w2s(c.Position)
                if p1 and p2 then d.L[i].From=p1; d.L[i].To=p2; d.L[i].Color=C.cc; d.L[i].Visible=true else d.L[i].Visible=false end
            end
        else
            for _,l in ipairs(d.L) do l.Visible=false end
        end

        if C.tr then d.tr.Visible=true; d.tr.From=o; d.tr.To=hs; d.tr.Color=C.cc else d.tr.Visible=false end

        if C.hp then
            local topY2, botY2, leftX2
            if C.box and corners then
                topY2 = corners[1].Y; botY2 = corners[3].Y; leftX2 = math.min(corners[1].X, corners[3].X)
            else
                local lg = d.ch:FindFirstChild("Left Leg") or d.ch:FindFirstChild("Left
