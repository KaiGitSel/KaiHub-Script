-- KaiUI (uretildi: build.mjs). Elle duzenleme.
local Library = (function()
-- KaiUI: Linoria uyumlu API, D3 "Turkuaz Muhur" gorunum. Oyuna ozgu hicbir sey icermez (ortak hub kutuphanesi).
-- Tum renk/olcu/font/sure degerleri yalniz Library.Theme'den okunur.

local Library = {
	Toggles = {},
	Options = {},
	Theme = {
		-- Notr renkler (D2/D3 ortak). Vurgu renkleri asagida Accents[AccentName] ile Colors'a yazilir.
		Colors = {
			Bg = Color3.fromRGB(10, 9, 12), -- pencere zemini
			Rail = Color3.fromRGB(6, 5, 7), -- ray + baslik
			Card = Color3.fromRGB(16, 14, 19), -- groupbox, tooltip
			Field = Color3.fromRGB(11, 10, 14), -- alan, kapali toggle
			Popup = Color3.fromRGB(14, 12, 18), -- dropdown listesi, toast
			Line = Color3.fromRGB(34, 30, 42), -- 1px cizgi
			Text = Color3.fromRGB(236, 232, 240),
			Muted = Color3.fromRGB(154, 149, 166),
			Dim = Color3.fromRGB(106, 100, 118),
			Error = Color3.fromRGB(255, 107, 94),
			Warn = Color3.fromRGB(255, 176, 32),
		},
		-- Vurgu on ayarlari (Library:SetAccent). Turquoise = D3, Emerald = D4, Purple = D2, Crimson = D.
		Accents = {
			Turquoise = {
				Accent = Color3.fromRGB(54, 196, 180), AccentText = Color3.fromRGB(3, 29, 26), AccentDim = Color3.fromRGB(32, 118, 108),
				Select = Color3.fromRGB(16, 33, 31), Hover = Color3.fromRGB(19, 28, 27), Seal = Color3.fromRGB(127, 227, 214),
			},
			Purple = {
				Accent = Color3.fromRGB(162, 123, 239), AccentText = Color3.fromRGB(15, 8, 25), AccentDim = Color3.fromRGB(97, 74, 143),
				Select = Color3.fromRGB(27, 21, 39), Hover = Color3.fromRGB(24, 20, 32), Seal = Color3.fromRGB(200, 177, 245),
			},
			Emerald = {
				Accent = Color3.fromRGB(92, 191, 139), AccentText = Color3.fromRGB(4, 23, 13), AccentDim = Color3.fromRGB(55, 115, 83),
				Select = Color3.fromRGB(18, 32, 26), Hover = Color3.fromRGB(21, 28, 24), Seal = Color3.fromRGB(156, 224, 185),
			},
			Crimson = {
				Accent = Color3.fromRGB(255, 75, 58), AccentText = Color3.fromRGB(28, 6, 3), AccentDim = Color3.fromRGB(153, 45, 35),
				Select = Color3.fromRGB(38, 17, 15), Hover = Color3.fromRGB(29, 18, 17), Seal = Color3.fromRGB(255, 140, 126),
			},
		},
		AccentName = "Turquoise",
		-- Font: tek kaynak FontFace / FontFaceBold (Library:SetFont(ad) ile degisir, canli yeniden uygular).
		FontName = "Gotham",
		Fonts = { -- Roblox yerlesik aileleri
			{ Name = "Gotham", Path = "rbxasset://fonts/families/GothamSSm.json" },
			{ Name = "BuilderSans", Path = "rbxasset://fonts/families/BuilderSans.json" },
			{ Name = "Roboto", Path = "rbxasset://fonts/families/Roboto.json" },
			{ Name = "Inconsolata (mono)", Path = "rbxasset://fonts/families/Inconsolata.json" },
		},
		-- yazi boyutlari
		TextSize = 15,
		ValueSize = 15,
		LabelSize = 15,
		SmallSize = 13,
		GroupTitleSize = 13,
		TitleSize = 15,
		TabSize = 15,
		TabNumSize = 13,
		ButtonSize = 15,
		KeySize = 13,
		SealTextSize = 13,
		ArrowGlyph = "v",
		-- yuzey / cizgi
		Corner = 10, -- pencere
		CornerCard = 8,
		CornerField = 6,
		CornerSmall = 5,
		StrokeThickness = 1,
		Padding = 12, -- groupbox ic bosluk
		Gap = 6, -- groupbox ici oge araligi
		ColumnGap = 12,
		PagePad = 12,
		ScrollBar = 4,
		ClickSlop = 8,
		ScreenMargin = 6,
		-- pencere / ray / baslik
		WindowSize = Vector2.new(720, 480),
		CompactWindowSize = Vector2.new(560, 336),
		CompactBelow = 500, -- viewport kisa kenari bunun altindaysa kompakt kip
		HeaderHeight = 36,
		HeaderButtonWidth = 30,
		SealSize = 22,
		-- Library:SetAccentColor turetme kurallari
		Derive = {
			MinValue = 0.6, MinLuminance = 0.25, MinContrast = 4.5, DarkText = Color3.fromRGB(6, 6, 8),
			DimMix = 0.4, SelectMix = 0.12, HoverMix = 0.07, SealMix = 0.45,
		},
		-- renk secici
		PickerWidth = 230, PickerPad = 10, PickerSVHeight = 120, PickerHueHeight = 22, SwatchW = 40, SwatchH = 22,
		SealSizeLogo = 26, -- logo rozeti (baslik)
		BadgeCorner = 0.22, -- rozet kose yaricapi (boyutun orani)
		BadgeStroke = 0.05, -- rozet cerceve kalinligi (boyutun orani)
		BadgeGlowScale = 1.18,
		BadgeGlowAlpha = 0.5,
		RailWidth = 140,
		TabHeight = 38,
		TabMarkWidth = 3,
		TabMarkInset = 7,
		TabNumWidth = 28,
		TabPadX = 14,
		-- bilesenler
		RowHeight = 34,
		ButtonHeight = 36,
		ButtonGap = 8,
		FieldHeight = 34,
		FieldLabelHeight = 20,
		FieldPadX = 10,
		ArrowWidth = 16,
		ToggleW = 38,
		ToggleH = 20,
		NotchSize = 12,
		NotchInset = 3,
		SliderLabelHeight = 20,
		TrackHeight = 6,
		TrackInset = 6,
		KnobSize = 14,
		SliderEditWidth = 84, -- elle deger kutusu
		KeyHeight = 26,
		KeyPadX = 10,
		DividerHeight = 12,
		CaptionHeight = 20,
		CaptionBarWidth = 12,
		DropdownItemHeight = 28,
		DropdownMaxItems = 6,
		ListPad = 4,
		CheckBox = 16,
		-- kompakt (telefon / dar ekran) ezmeleri: dokunma hedefi >= 44
		Mobile = {
			HeaderHeight = 28, SealSizeLogo = 24, PickerHueHeight = 32, SwatchH = 32, SliderLabelHeight = 30, SliderEditWidth = 96, HeaderButtonWidth = 44, RailWidth = 60, TabHeight = 44, TabNumSize = 15,
			TextSize = 16, LabelSize = 15, ValueSize = 16, TitleSize = 14, GroupTitleSize = 13,
			RowHeight = 44, ButtonHeight = 44, FieldHeight = 44, DropdownItemHeight = 44, DropdownMaxItems = 5, KeyHeight = 32,
		},
		-- kare "K" muhur dugmesi (kucultme + mobil)
		LauncherSize = 46,
		LauncherCorner = 8,
		LauncherTextSize = 20,
		MinTopInset = 58, -- GuiInset 0 okunursa guvenli ust bant (px)
		LauncherPos = Vector2.new(18, 8), -- ust cubugun (GuiInset) altindan baslar
		LauncherIdleAlpha = 0.35, -- pencere acikken saydamlik (en cok 0.35)
		-- toast
		NotifyWidth = 270,
		NotifyGap = 8,
		NotifyMargin = 20,
		NotifyBar = 2,
		NotifySlide = 24,
		-- tooltip
		TooltipDelay = 0.4,
		TooltipHold = 0.5,
		TooltipMaxWidth = 260,
		TooltipPad = 8,
		DisplayOrder = 999,
		Anim = {
			Fast = 0.08, Normal = 0.18, Hover = 0.06, Tab = 0.10,
			Minimize = 0.28, Restore = 0.3, WinToggle = 0.2, -- pencere kucul / buyu / menu tusu
			Shrink = 0.2, WinFrom = 0.94, Pop = 0.18, PopFrom = 0.8,
			MinimizeStyle = { Enum.EasingStyle.Quint, Enum.EasingDirection.In },
			RestoreStyle = { Enum.EasingStyle.Quint, Enum.EasingDirection.Out },
			WinOpenStyle = { Enum.EasingStyle.Quad, Enum.EasingDirection.Out },
			WinCloseStyle = { Enum.EasingStyle.Quad, Enum.EasingDirection.In },
			Toggle = 0.12, Drop = 0.10, ToastIn = 0.18, ToastOut = 0.15,
		},
		ReduceMotion = false, -- true: pencere animasyonlari anlik
		UIScaleMin = 0.7, UIScaleMax = 1.3, UIScaleDefault = 1, -- kullanici arayuz carpani (Library:SetUIScale)
		MobileMinScale = 0.6,
		MobileScaleFactor = 0.95,
	},
	_conns = {},
	_unloadFns = {},
	_unloaded = false,
	_binds = {}, -- {inst, prop, token}: SetAccent'te yeniden boyanir
	_compact = false,
	UserScale = 1,
}
do -- secili vurguyu Colors'a yaz (tek kaynak: Accents)
	local th = Library.Theme
	for k, v in pairs(th.Accents[th.AccentName]) do th.Colors[k] = v end
end

local Services = {
	Players = game:GetService("Players"),
	UIS = game:GetService("UserInputService"),
	Tween = game:GetService("TweenService"),
	Run = game:GetService("RunService"),
	CoreGui = game:GetService("CoreGui"),
	Gui = game:GetService("GuiService"),
}

local function genv()
	local ok, env = pcall(function() return getgenv() end)
	if ok and type(env) == "table" then return env end
	return nil
end

local function randName()
	local t = table.create(12)
	for i = 1, 12 do t[i] = string.char(math.random(97, 122)) end
	return table.concat(t)
end

local function connect(signal, fn)
	local c = signal:Connect(fn)
	table.insert(Library._conns, c)
	return c
end
Library.Connect = function(_, signal, fn) return connect(signal, fn) end

local function T() return Library.Theme end

-- Font: Theme.Fonts listesinden ad -> (normal, kalin) Font nesnesi; yoksa Gotham enum yedegi.
local function resolveFont(name)
	local path
	for _, f in ipairs(Library.Theme.Fonts) do
		if f.Name == name then path = f.Path end
	end
	local reg, bold, black
	if path then
		pcall(function()
			reg = Font.new(path, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
			bold = Font.new(path, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			black = Font.new(path, Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
		end)
	end
	if not reg then
		reg, bold, black = Font.fromEnum(Enum.Font.GothamMedium), Font.fromEnum(Enum.Font.GothamBold), Font.fromEnum(Enum.Font.GothamBlack)
	end
	return reg, bold, black or bold
end
Library.Theme.FontFace, Library.Theme.FontFaceBold, Library.Theme.FontFaceBlack = resolveFont(Library.Theme.FontName)
Library.Theme.MonoFace = Font.fromEnum(Enum.Font.RobotoMono) -- sayilar (ray no, slider degeri)

local function tween(inst, dur, props, style, dir)
	local tw = Services.Tween:Create(inst, TweenInfo.new(dur, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end
Library.Tween = function(_, inst, dur, props) return tween(inst, dur or T().Anim.Normal, props) end

local function isPress(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end
local function isMove(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
end
Library.IsPress, Library.IsMove = isPress, isMove

local function create(class, props, children)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do inst[k] = v end
	for _, ch in ipairs(children or {}) do ch.Parent = inst end
	return inst
end
Library.Create = function(_, class, props, children) return create(class, props, children) end

local function stroke(inst, color)
	return create("UIStroke", {
		Color = color or T().Colors.Line,
		Thickness = T().StrokeThickness,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = inst,
	})
end

local function corner(inst, r)
	return create("UICorner", { CornerRadius = UDim.new(0, r), Parent = inst })
end

-- Vurguya bagli statik renk: SetAccent'te Colors[token] yeniden uygulanir.
local function bind(inst, prop, token)
	inst[prop] = T().Colors[token]
	table.insert(Library._binds, { inst, prop, token })
	return inst
end

-- Roblox ust cubugu yuksekligi (IgnoreGuiInset ScreenGui'de bu bandin altinda kal)
local function topInset()
	local ok, v = pcall(function() return Services.Gui:GetGuiInset().Y end)
	v = (ok and type(v) == "number") and v or 0
	local ok2, t = pcall(function() return Services.Gui.TopbarInset.Max.Y end) -- varsa
	if ok2 and type(t) == "number" and t > v then v = t end
	if v <= 0 then v = T().MinTopInset end -- pencere simge durumundayken 0 okunabilir
	return v
end

-- Surukleme: handle uzerinde basilinca target hareket eder (mouse + touch). onEnd(moved) opsiyonel.
-- Yalniz surmeyi baslatan girdi hareket ettirir (ikinci parmak etkisiz).
-- clamp=true: target ekran icinde ve ust cubugun altinda kalir (Scale=0 konumlar).
-- clamp="window": pencere; basligin bir kismi ekranda, ust cubugun altinda kalir.
local function makeDraggable(handle, target, onEnd, clamp)
	local dragging, startPos, startVec, dragInput, moved
	connect(handle.InputBegan, function(input)
		if dragging or not isPress(input) then return end
		dragging, moved = true, false
		dragInput = input
		startVec = input.Position
		startPos = target.Position
		local c
		c = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				c:Disconnect()
				if onEnd then onEnd(moved) end
			end
		end)
	end)
	connect(Services.UIS.InputChanged, function(input)
		if not dragging or not isMove(input) then return end
		if dragInput.UserInputType == Enum.UserInputType.Touch then
			if input ~= dragInput then return end
		elseif input.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end
		local d = input.Position - startVec
		if d.Magnitude > 4 then moved = true end
		local nx, ny = startPos.X.Offset + d.X, startPos.Y.Offset + d.Y
		if clamp and Library.ScreenGui then
			local vp, sz = Library.ScreenGui.AbsoluteSize, target.AbsoluteSize
			local top = topInset()
			if clamp == "window" then
				local ax = target.AbsolutePosition.X + (nx - target.Position.X.Offset)
				local ay = target.AbsolutePosition.Y + (ny - target.Position.Y.Offset)
				local cx = math.clamp(ax, -(sz.X - 80), vp.X - 80)
				local cy = math.clamp(ay, top, math.max(top, vp.Y - 40))
				nx, ny = nx + (cx - ax), ny + (cy - ay)
			else
				nx = math.clamp(nx, 0, math.max(0, vp.X - sz.X))
				ny = math.clamp(ny, top, math.max(top, vp.Y - sz.Y))
			end
		end
		target.Position = UDim2.new(startPos.X.Scale, nx, startPos.Y.Scale, ny)
	end)
end
Library.MakeDraggable = function(_, handle, target, onEnd, clamp) return makeDraggable(handle, target, onEnd, clamp) end

-- GUI ebeveyni: gethui -> CoreGui (protect_gui varsa) -> PlayerGui. Her adim pcall.
local function mountGui(gui)
	local ok = pcall(function()
		if type(gethui) ~= "function" then error("no gethui") end
		local h = gethui()
		-- gethui bir ScreenGui (ornegin RobloxGui) dondururse ic ice ScreenGui cizilmez: CoreGui'ye dus
		if typeof(h) ~= "Instance" or h:IsA("LayerCollector") then error("unsuitable") end
		gui.Parent = h
	end)
	if ok and gui.Parent then return "gethui" end

	ok = pcall(function()
		local prot = (syn and syn.protect_gui) or protect_gui
		if type(prot) == "function" then pcall(prot, gui) end
		gui.Parent = Services.CoreGui
	end)
	if ok and gui.Parent then return "CoreGui" end

	ok = pcall(function()
		gui.Parent = Services.Players.LocalPlayer:WaitForChild("PlayerGui", 5)
	end)
	if ok and gui.Parent then return "PlayerGui" end
	return nil
end

function Library:Unload()
	if self._unloaded then return end
	self._unloaded = true
	for _, fn in ipairs(self._unloadFns) do pcall(fn) end
	for _, c in ipairs(self._conns) do pcall(function() c:Disconnect() end) end
	table.clear(self._conns)
	if self.ScreenGui then pcall(function() self.ScreenGui:Destroy() end) end
	local env = genv()
	if env and env.KaiUI_Instance == self then env.KaiUI_Instance = nil end
	if env and env.Toggles == self.Toggles then env.Toggles = nil end
	if env and env.Options == self.Options then env.Options = nil end
	if env and env.Library == self then env.Library = nil end
end

function Library:OnUnload(fn)
	table.insert(self._unloadFns, fn)
end

-- Canli font degistirme: Theme.FontFace/Bold guncellenir, acik GUI'deki tum yazilar yeniden boyanir.
function Library:SetFont(name)
	local th = T()
	th.FontName = name
	th.FontFace, th.FontFaceBold, th.FontFaceBlack = resolveFont(name)
	if self.ScreenGui then
		for _, d in ipairs(self.ScreenGui:GetDescendants()) do
			if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
				local k = d:GetAttribute("KFont")
				if k == "bold" then d.FontFace = th.FontFaceBold
				elseif k == "black" then d.FontFace = th.FontFaceBlack
				elseif k ~= "mono" then d.FontFace = th.FontFace end
			end
		end
	end
end
function Library:GetFontNames()
	local t = {}
	for _, f in ipairs(T().Fonts) do table.insert(t, f.Name) end
	return t
end

function Library:IsMobile()
	local u = Services.UIS
	return u.TouchEnabled and not u.KeyboardEnabled
end
function Library:IsCompact() return self._compact end

-- Mobilde/kompakt kipte genisletilmis dokunma olculeri (Theme.Mobile), yoksa masaustu degeri.
local function dim(name)
	local th = T()
	if Library._compact and th.Mobile[name] ~= nil then return th.Mobile[name] end
	return th[name]
end

local function safe(f, ...)
	local ok, err = pcall(f, ...)
	if not ok then warn("[KaiUI] callback hatasi: " .. tostring(err)) end
end

-- Vurgu on ayari degistir (Turkuaz | Mor | Zumrut | Kizil); acik arayuz canli yeniden boyanir.
-- Kullanici arayuz carpani (Theme.UIScaleMin..Max). Etkin olcek = otomatik sigdirma x carpan (ekrana sigmayi asmaz).
function Library:SetUIScale(f)
	local th = T()
	f = tonumber(f)
	if not f then return false end
	self.UserScale = math.clamp(f, th.UIScaleMin, th.UIScaleMax)
	local w = self.Window
	if w and w.Rescale then
		w.Rescale()
		task.defer(function() if not self._unloaded then w:_clampIn() end end) -- olcek oturduktan sonra ekran icine cek
	end
	return true
end

-- Surukleme sirasinda canli olcek: pencere AnchorPoint'i izdeki knob noktasina cekilir (UIScale AnchorPoint etrafinda olcekler),
-- Position knob'un hedef ekran noktasina konur. Ayni karede, duzeltmesiz; knob parmagi akici izler.
function Library:SetUIScaleLive(f, slider)
	local g = slider and slider._geom
	local w, gui = self.Window, self.ScreenGui
	f = tonumber(f)
	if not f then return false end
	self.UserScale = math.clamp(f, T().UIScaleMin, T().UIScaleMax)
	if not (w and w.Rescale) then return true end
	w.Rescale()
	if not (g and g.kl and gui) then return true end
	if g.cv and g.sc0 then -- kaydirma yerini baslangica gore orantila (artimsal carpim birikmesin)
		local r = w.Scale.Scale / g.sc0
		for _, e in ipairs(g.cv) do e[1].CanvasPosition = e[2] * r end
	end
	local v = slider._raw or slider.Value
	local frac = (slider.Max > slider.Min) and math.clamp((v - slider.Min) / (slider.Max - slider.Min), 0, 1) or 0
	local vp, fr = gui.AbsoluteSize, w.Frame
	local p = fr.Position
	local tx, ty = g.gx + frac * g.gw + g.dx, g.gy + g.dy
	fr.AnchorPoint = Vector2.new(g.kl + frac * g.kw, g.ky)
	fr.Position = UDim2.new(p.X.Scale, tx - p.X.Scale * vp.X, p.Y.Scale, ty - p.Y.Scale * vp.Y)
	return true
end

-- Ortak boyama yolu: p = { Accent, AccentText, AccentDim, Select, Hover, Seal }
function Library:_applyAccent(p, name)
	local th = T()
	th.AccentName = name
	for k, v in pairs(p) do th.Colors[k] = v end
	local binds = self._binds
	for i = #binds, 1, -1 do
		local b = binds[i]
		if b[1].Parent == nil then table.remove(binds, i) else b[1][b[2]] = th.Colors[b[3]] end
	end
	for _, o in pairs(self.Toggles) do if o._display then pcall(o._display, o, true) end end
	for _, o in pairs(self.Options) do if o._repaint then pcall(o._repaint, o) end end
	local w = self.Window
	if w then
		for _, t in ipairs(w.Tabs) do t:_paint(t == w.Selected) end
		w:_crumb()
	end
end

-- Vurgu on ayari degistir (Turquoise | Purple | Emerald | Crimson); acik arayuz canli yeniden boyanir.
function Library:SetAccent(name)
	local th = T()
	name = ({ Turkuaz = "Turquoise", Mor = "Purple", Zumrut = "Emerald", Kizil = "Crimson" })[name] or name -- eski adlar
	local p = th.Accents[name]
	if not p then return false end
	self:_applyAccent(p, name)
	return true
end

local function lum(c)
	local function lin(v) return v <= 0.03928 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4 end
	return 0.2126 * lin(c.R) + 0.7152 * lin(c.G) + 0.0722 * lin(c.B)
end
local function contrast(a, b)
	local la, lb = lum(a), lum(b)
	if la < lb then la, lb = lb, la end
	return (la + 0.05) / (lb + 0.05)
end

-- Tek renkten tum vurgu tokenlarini turet (siyah zeminde okunur kalsin diye parlaklik alt siniri). Duzeltilmis Accent'i dondurur.
function Library:SetAccentColor(color)
	if typeof(color) ~= "Color3" then return nil end
	local th = T()
	local d, c = th.Derive, th.Colors
	local white, black = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
	local h, s, v = color:ToHSV()
	v = math.max(v, d.MinValue)
	local base = Color3.fromHSV(h, s, v)
	local acc, t = base, 0
	while lum(acc) < d.MinLuminance and t < 1 do
		t += 0.05
		acc = base:Lerp(white, t)
	end
	local text = d.DarkText
	if contrast(acc, text) < d.MinContrast and contrast(acc, white) > contrast(acc, text) then text = white end
	self:_applyAccent({
		Accent = acc, AccentText = text, AccentDim = acc:Lerp(black, d.DimMix),
		Select = c.Bg:Lerp(acc, d.SelectMix), Hover = c.Bg:Lerp(acc, d.HoverMix), Seal = acc:Lerp(white, d.SealMix),
	}, "Custom")
	return acc
end
function Library:GetAccentNames()
	local t = {}
	for k in pairs(T().Accents) do table.insert(t, k) end
	table.sort(t, function(a, b)
		if a == "Turquoise" then return true end
		if b == "Turquoise" then return false end
		return a < b
	end)
	return t
end

-- ===== Ortak yardimcilar =====

local function mkLabel(parent, text, props)
	local th = T()
	local p = {
		BackgroundTransparency = 1, FontFace = th.FontFace, TextSize = dim("TextSize"),
		TextColor3 = th.Colors.Text, TextXAlignment = Enum.TextXAlignment.Left,
		Text = tostring(text), Parent = parent,
	}
	for k, v in pairs(props or {}) do p[k] = v end
	local bold, mono, black = p.Bold, p.Mono, p.Black
	p.Bold, p.Mono, p.Black = nil, nil, nil
	if black then p.FontFace = th.FontFaceBlack elseif bold then p.FontFace = th.FontFaceBold elseif mono then p.FontFace = th.MonoFace end
	local l = create("TextLabel", p)
	if black then l:SetAttribute("KFont", "black") elseif bold then l:SetAttribute("KFont", "bold") elseif mono then l:SetAttribute("KFont", "mono") end
	return l
end

-- Sutun kaydirma kilidi (sayacli): slider surukleme, acik dropdown, odakli Input.
local function lockScroll(scroll, on)
	if not scroll then return end
	local n = (scroll:GetAttribute("KLock") or 0) + (on and 1 or -1)
	if n < 0 then n = 0 end
	scroll:SetAttribute("KLock", n)
	scroll.ScrollingEnabled = (n == 0)
end

-- Basma/surukleme izleyici (mouse + touch). bag verilirse baglantilar oraya yazilir (gecici UI icin).
local function track(obj, onBegin, onMove, onEnd, bag)
	local active
	local function conn(sig, fn)
		if bag then table.insert(bag, sig:Connect(fn)) else connect(sig, fn) end
	end
	conn(obj.InputBegan, function(input)
		if active or not isPress(input) then return end
		active = input
		if onBegin then onBegin(input) end
		local c
		c = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				c:Disconnect()
				if active == input then active = nil end
				if onEnd then onEnd(input) end
			end
		end)
	end)
	conn(Services.UIS.InputChanged, function(input)
		if not active then return end
		if active.UserInputType == Enum.UserInputType.Touch then
			if input ~= active then return end
		elseif input.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end
		if onMove then onMove(input) end
	end)
end

-- Tiklama: basma ile birakma arasi kayma ClickSlop'u gecerse (kaydirma) sayilmaz.
-- Tooltip basili-tut gosterdiyse (Library._tipInput) birakma tiklama sayilmaz.
local function onClick(obj, fn, bag, onDown, onUp)
	local start, far
	track(obj, function(i)
		start, far = i.Position, false
		if onDown then onDown() end
	end, function(i)
		if (i.Position - start).Magnitude > T().ClickSlop then far = true end
	end, function(i)
		if onUp then onUp() end
		if Library._tipInput == i then Library._tipInput = nil; return end
		if not far and (i.Position - start).Magnitude <= T().ClickSlop then fn() end
	end, bag)
end

-- Hover (yalniz fare; dokunmada tetiklenmez)
local function hover(obj, enter, leave, bag)
	local function conn(sig, fn)
		if bag then table.insert(bag, sig:Connect(fn)) else connect(sig, fn) end
	end
	conn(obj.MouseEnter, enter)
	conn(obj.MouseLeave, leave)
end

local function fmtNum(v, r)
	if r and r > 0 then return string.format("%." .. r .. "f", v) end
	return tostring(math.floor(v + 0.5))
end

local function esc(s)
	return (tostring(s):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

-- Onay isareti: iki donuk cubuk (Gotham'da check glifi yok). Dondurulen Frame Visible ile acilip kapanir.
local function makeCheck(parent, color)
	local box = create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = parent })
	local function leg(cx, cy, len, rot)
		create("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(cx, cy), Size = UDim2.fromOffset(2, len),
			Rotation = rot, BackgroundColor3 = color, BorderSizePixel = 0, Parent = box,
		})
	end
	leg(5.2, 9.8, 4.6, -45)
	leg(9.6, 8.2, 8.6, 45)
	return box
end

-- ===== Tooltip =====

function Library:_showTip(text, pos, touch)
	local gui = self.ScreenGui
	if not gui or self._unloaded then return end
	local th = T()
	local tip = self._tip
	if not tip then
		tip = create("Frame", {
			Name = "Tooltip", BackgroundColor3 = th.Colors.Card, BorderSizePixel = 0, Visible = false, ZIndex = 300, Parent = gui,
		})
		corner(tip, th.CornerField)
		stroke(tip)
		self._tip = tip
		self._tipLbl = mkLabel(tip, "", {
			Position = UDim2.fromOffset(th.TooltipPad, th.TooltipPad), TextWrapped = true, TextSize = th.SmallSize,
			TextColor3 = th.Colors.Text, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 301,
		})
	end
	local lbl = self._tipLbl
	self._tipTok = (self._tipTok or 0) + 1
	local my = self._tipTok
	lbl.Text = tostring(text)
	lbl.Size = UDim2.fromOffset(th.TooltipMaxWidth - th.TooltipPad * 2, 10)
	tip.Visible = false
	Services.Run.Heartbeat:Wait() -- TextBounds bir kare sonra guvenilir
	if my ~= self._tipTok or self._unloaded or not tip.Parent then return end
	local tb = lbl.TextBounds
	local w, h = math.min(tb.X, th.TooltipMaxWidth - th.TooltipPad * 2), tb.Y
	lbl.Size = UDim2.fromOffset(w, h)
	local tw, thh = w + th.TooltipPad * 2, h + th.TooltipPad * 2
	tip.Size = UDim2.fromOffset(tw, thh)
	local vp = gui.AbsoluteSize
	local x, y = pos.X + 14, pos.Y + 20
	if touch then y = pos.Y - thh - 28 end
	if y + thh > vp.Y - 4 then y = pos.Y - thh - 12 end
	x = math.clamp(x, 4, math.max(4, vp.X - tw - 4))
	y = math.clamp(y, 4, math.max(4, vp.Y - thh - 4))
	tip.Position = UDim2.fromOffset(x, y)
	tip.Visible = true
end
function Library:_hideTip()
	self._tipTok = (self._tipTok or 0) + 1
	if self._tip then self._tip.Visible = false end
end

-- PC: hover (TooltipDelay), dokunmatik: basili tut (TooltipHold).
local function attachTip(obj, text)
	if type(text) ~= "string" or text == "" then return end
	local hov, tok = false, 0
	hover(obj, function()
		hov, tok = true, tok + 1
		local my = tok
		task.delay(T().TooltipDelay, function()
			if hov and my == tok and not Library._unloaded then
				Library:_showTip(text, Services.UIS:GetMouseLocation(), false)
			end
		end)
	end, function()
		hov, tok = false, tok + 1
		Library:_hideTip()
	end)
	connect(obj.InputBegan, function(input)
		if input.UserInputType ~= Enum.UserInputType.Touch then return end
		local start = input.Position
		local c
		c = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End or input.UserInputState == Enum.UserInputState.Cancel then
				c:Disconnect()
				Library:_hideTip()
			end
		end)
		task.delay(T().TooltipHold, function()
			if Library._unloaded then return end
			if input.UserInputState ~= Enum.UserInputState.Change and input.UserInputState ~= Enum.UserInputState.Begin then return end
			if (input.Position - start).Magnitude > T().ClickSlop then return end
			Library._tipInput = input
			local ins = Services.Gui:GetGuiInset()
			Library:_showTip(text, Vector2.new(input.Position.X + ins.X, input.Position.Y + ins.Y), true)
		end)
	end)
end

-- Bildirim (sag alt kose, yigin): ust 2px vurgu cizgisi + ilerleme cizgisi.
function Library:Notify(text, seconds, kind)
	if type(seconds) == "string" then seconds, kind = nil, seconds end
	seconds = seconds or 4
	local gui = self.ScreenGui
	if not gui or self._unloaded then return end
	local th = T()
	local holder = self._notifyHolder
	if not holder then
		holder = create("Frame", {
			Name = "Notifications",
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -th.NotifyMargin, 1, -th.NotifyMargin),
			Size = UDim2.fromOffset(th.NotifyWidth, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 200,
			Parent = gui,
		}, {
			create("UIListLayout", {
				Padding = UDim.new(0, th.NotifyGap),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
			}),
		})
		self._notifyHolder = holder
	end
	local col = (kind == "error" and th.Colors.Error) or (kind == "warn" and th.Colors.Warn) or th.Colors.Accent
	local outer = create("Frame", {
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = holder,
	})
	local card = create("CanvasGroup", {
		BackgroundColor3 = th.Colors.Popup, BorderSizePixel = 0, GroupTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.fromOffset(th.NotifySlide, 0), Parent = outer,
	})
	corner(card, th.CornerField + 1)
	stroke(card)
	create("Frame", {
		BackgroundColor3 = col, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, th.NotifyBar), Parent = card,
	})
	local inner = create("Frame", {
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = card,
	}, {
		create("UIPadding", {
			PaddingLeft = UDim.new(0, th.Padding), PaddingRight = UDim.new(0, th.Padding),
			PaddingTop = UDim.new(0, th.Padding), PaddingBottom = UDim.new(0, th.Padding + th.NotifyBar),
		}),
	})
	mkLabel(inner, text, {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextSize = dim("LabelSize"),
		TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top,
	})
	local prog = create("Frame", {
		BackgroundColor3 = col, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, th.NotifyBar), Parent = card,
	})
	tween(card, th.Anim.ToastIn, { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) })
	Services.Tween:Create(prog, TweenInfo.new(seconds, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 0, th.NotifyBar) }):Play()
	task.delay(seconds, function()
		if self._unloaded or not outer.Parent then return end
		local t = tween(card, th.Anim.ToastOut, { GroupTransparency = 1, Position = UDim2.fromOffset(th.NotifySlide, 0) },
			Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		t.Completed:Wait()
		outer:Destroy()
	end)
end

local function resolveKey(k)
	if typeof(k) == "EnumItem" then return k end
	if type(k) == "string" then
		local ok, v = pcall(function() return Enum.KeyCode[k] end)
		if ok then return v end
	end
	return Enum.KeyCode.RightShift
end

-- ===== Bilesen altyapisi =====

-- Ortak nesne (Linoria uyumlu): OnChanged(fn) onceki dinleyicinin YERINE gecer ve fn(Value) hemen bir kez cagrilir.
local Base = {}
Base.__index = Base
function Base:OnChanged(fn)
	self.Changed = fn
	if type(fn) == "function" then safe(fn, self.Value) end
end
function Base:_fire(...)
	if type(self.Callback) == "function" then safe(self.Callback, ...) end
	if type(self.Changed) == "function" then safe(self.Changed, ...) end
end
-- Satiri gizle/goster (gizli satir duzende yer kaplamaz). Toggle/Slider/Dropdown/Input/Button/Label
function Base:SetVisible(v)
	local row = self._row
	if row then row.Visible = v and true or false end
end
local function class()
	local c = setmetatable({}, { __index = Base })
	c.__index = c
	return c
end

-- ===== KeyPicker =====

local KeyM = class()
function KeyM:GetState() return self.State end
function KeyM:OnClick(fn) -- tek geri cagirma: yenisi onceki yerine gecer
	self.Clicked = fn
end
function KeyM:_display()
	local th = T()
	self._btn.Text = self._listening and "..." or tostring(self.Value)
	self._btn.TextColor3 = self._listening and th.Colors.Accent or th.Colors.Text
end
KeyM._repaint = KeyM._display
function KeyM:SetValue(v)
	local key, mode = v, nil
	if type(v) == "table" then key, mode = v[1], v[2] end
	if typeof(key) == "EnumItem" then key = key.Name end
	if mode then self.Mode = mode end
	self.Value = key and tostring(key) or "None"
	self:_display()
	self:_fire(self.Value)
end
function KeyM:_trigger(state)
	self.State = state
	if type(self.Callback) == "function" then safe(self.Callback, state) end
	if type(self.Clicked) == "function" then safe(self.Clicked, state) end
end

local function makeKeyPicker(row, idx, info, rightOffset)
	info = info or {}
	local th = T()
	local obj = setmetatable({
		Type = "KeyPicker", Value = "None", Mode = info.Mode or "Toggle", State = false,
		Text = info.Text, Callback = info.Callback,
	}, KeyM)
	local key = info.Default
	if typeof(key) == "EnumItem" then key = key.Name end
	obj.Value = key and tostring(key) or "None"

	-- NoUI Linoria'da yalniz liste/mod menusunu gizler; tus kutusu kalir
	local btn = create("TextLabel", {
		Name = "Key", AnchorPoint = Vector2.new(1, 0), Active = true, -- Active: tikla satiri tetiklemesin
		Position = UDim2.new(1, -(rightOffset or 0), 0, (dim("RowHeight") - dim("KeyHeight")) / 2),
		Size = UDim2.fromOffset(0, dim("KeyHeight")), AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = th.Colors.Field, BorderSizePixel = 0, FontFace = th.MonoFace, TextSize = th.KeySize,
		TextColor3 = th.Colors.Text, Text = "", Parent = row,
	}, { create("UIPadding", { PaddingLeft = UDim.new(0, th.KeyPadX), PaddingRight = UDim.new(0, th.KeyPadX) }) })
	btn:SetAttribute("KFont", "mono")
	corner(btn, th.CornerSmall)
	stroke(btn)
	obj._btn = btn
	obj:_display()

	onClick(btn, function()
		if Library:IsMobile() then return end -- telefonda klavye yok: tus beklenmez
		obj._listening = not obj._listening -- dinlerken tekrar tikla: iptal
		if obj._listening then Library._listening = obj else task.defer(function() Library._listening = nil end) end
		obj:_display()
	end)
	connect(Services.UIS.InputBegan, function(input, processed)
		if Library._unloaded then return end
		if obj._listening then
			if input.UserInputType == Enum.UserInputType.Keyboard then
				obj._listening = false
				task.defer(function() Library._listening = nil end) -- ayni tusu menu kisayolu yakalamasin
				local k = input.KeyCode
				obj:SetValue((k == Enum.KeyCode.Escape or k == Enum.KeyCode.Backspace) and "None" or k.Name)
			end
			return
		end
		if processed or obj.Value == "None" or Library._listening then return end
		if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == obj.Value then
			if obj.Mode == "Hold" then obj:_trigger(true) else obj:_trigger(not obj.State) end
		end
	end)
	connect(Services.UIS.InputEnded, function(input)
		if obj.Mode == "Hold" and obj.State and input.UserInputType == Enum.UserInputType.Keyboard
			and input.KeyCode.Name == obj.Value then
			obj:_trigger(false)
		end
	end)
	Library.Options[idx] = obj
	return obj
end

-- ===== Toggle: centikli kare anahtar =====

local ToggleM = class()
function ToggleM:_display(instant)
	local th = T()
	local c = th.Colors
	local on = self.Value
	local nx = on and (th.ToggleW - th.NotchSize - th.NotchInset) or th.NotchInset
	local props = {
		bg = on and c.Accent or c.Field,
		st = on and c.Accent or c.Line,
		nc = on and c.AccentText or (self._hover and c.Muted or c.Dim),
	}
	if instant then
		self._sw.BackgroundColor3, self._swStroke.Color, self._notch.BackgroundColor3 = props.bg, props.st, props.nc
		self._notch.Position = UDim2.new(0, nx, 0.5, 0)
	else
		local d = th.Anim.Toggle
		tween(self._sw, d, { BackgroundColor3 = props.bg })
		tween(self._swStroke, d, { Color = props.st })
		tween(self._notch, d, { BackgroundColor3 = props.nc, Position = UDim2.new(0, nx, 0.5, 0) })
	end
end
function ToggleM:SetValue(v)
	self.Value = v and true or false
	self:_display(false)
	self:_fire(self.Value)
end
function ToggleM:SetText(s) self._label.Text = tostring(s) end
function ToggleM:AddKeyPicker(idx, info)
	return makeKeyPicker(self._row, idx, info, T().ToggleW + 10)
end

-- ===== Slider: iz + dolgu + elmas knob =====

local SliderM = class()
function SliderM:_snap(v)
	local m = 10 ^ self.Rounding
	return math.clamp(math.floor(v * m + 0.5) / m, self.Min, self.Max)
end
function SliderM:_paint()
	local v = self._raw or self.Value -- Live kaydiricilarda surukleme sirasinda ham (yuvarlanmamis) deger
	local frac = (self.Max > self.Min) and (v - self.Min) / (self.Max - self.Min) or 0
	frac = math.clamp(frac, 0, 1)
	self._fill.Size = UDim2.new(frac, 0, 1, 0)
	self._knob.Position = UDim2.new(frac, 0, 0.5, 0)
	self._val.TextColor3 = self._drag and T().Colors.Accent or T().Colors.Text
end
SliderM._repaint = SliderM._paint
function SliderM:_display()
	self._val.Text = fmtNum(self.Value, self.Rounding) .. self.Suffix
	self:_paint()
end
function SliderM:SetValue(v) -- string de kabul (SaveManager)
	v = tonumber(v)
	if not v then return end
	self._raw = nil
	self.Value = self:_snap(v)
	self:_display()
	self:_fire(self.Value)
end
function SliderM:SetMax(n) self.Max = n; self:_display() end
function SliderM:SetMin(n) self.Min = n; self:_display() end
function SliderM:SetText(s) self._label.Text = tostring(s) end

-- ===== Dropdown (tekli / Multi, AllowNull) =====

local DropM = class()
function DropM:_selected(val)
	if self.Multi then return type(self.Value) == "table" and self.Value[val] == true end
	return self.Value == val
end
function DropM:_display()
	local c = T().Colors
	local txt
	if self.Multi then
		local parts = {}
		for _, v in ipairs(self.Values) do if self.Value[v] then table.insert(parts, tostring(v)) end end
		if #parts > 0 then txt = table.concat(parts, ", ") end
	elseif self.Value ~= nil then
		txt = tostring(self.Value)
	end
	self._text.Text = txt or "--"
	self._text.TextColor3 = txt and c.Text or c.Dim
end
function DropM:SetValue(v)
	if self.Multi then
		local set = {}
		if type(v) == "table" then
			for k, b in pairs(v) do
				if type(k) == "number" then
					if table.find(self.Values, b) then set[b] = true end -- liste bicimi
				elseif b and table.find(self.Values, k) then
					set[k] = true
				end
			end
		end
		self.Value = set
	else
		if v ~= nil and table.find(self.Values, v) == nil then return end -- listede yok: yok say (Linoria)
		self.Value = v
	end
	self:_display()
	if self._open and self._refresh then self._refresh() end
	self:_fire(self.Value)
end
function DropM:SetValues(list) -- argumansiz: once .Values atanmis olmali (Linoria)
	if list then self.Values = list end
	if self._open and Library._closeDrop then Library._closeDrop() end
	self:_display()
end
function DropM:SetText(s) if self._label then self._label.Text = tostring(s) end end

-- Basis acik popup'in (list/panel) sinirlari icindeyse true. Mouse: GetMouseLocation (mutlak); dokunma: input.Position
-- hem ham hem GuiInset eklenmis haliyle denenir (inset uyumsuzluguna karsi cömert: yanlislikla kapatma olmasin).
function Library:_inPopup(input)
	local pop = self._popup
	if not pop or not pop.Parent then return false end
	local a, s = pop.AbsolutePosition, pop.AbsoluteSize
	local function inside(x, y) return x >= a.X and x <= a.X + s.X and y >= a.Y and y <= a.Y + s.Y end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local m = Services.UIS:GetMouseLocation()
		return inside(m.X, m.Y)
	end
	local p = input.Position
	local ok, ins = pcall(function() return Services.Gui:GetGuiInset() end)
	if not ok then ins = Vector2.new(0, 0) end
	return inside(p.X, p.Y) or inside(p.X + ins.X, p.Y + ins.Y)
end

function Library:_overlay()
	if self._ov then return self._ov end
	local ov = create("TextButton", {
		Name = "Overlay", Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1), ZIndex = 100, Visible = false, Parent = self.ScreenGui,
	})
	-- kapatma: basis VE birakma popup disindaysa (birakmada karar; koordinat hatasi popup'i basista yok etmez)
	connect(ov.InputBegan, function(input)
		if not isPress(input) or not self._closeDrop then return end
		if self:_inPopup(input) then return end
		local pop = self._popup
		local c
		c = input.Changed:Connect(function()
			if input.UserInputState ~= Enum.UserInputState.End then return end
			c:Disconnect()
			if self._closeDrop and self._popup == pop and not self:_inPopup(input) then self._closeDrop() end
		end)
	end)
	connect(Services.UIS.InputBegan, function(input)
		if input.KeyCode == Enum.KeyCode.Escape and self._closeDrop then self._closeDrop() end
	end)
	self._ov = ov
	return ov
end

function DropM:_openList()
	local lib, th = Library, T()
	if lib._closeDrop then lib._closeDrop() end
	local win = lib.Window
	if not win or #self.Values == 0 then return end
	local c = th.Colors
	local ov = lib:_overlay()
	local sc = win.Scale.Scale
	if sc <= 0 then sc = 1 end
	local field = self._field
	local ap, as = field.AbsolutePosition, field.AbsoluteSize
	local ih = dim("DropdownItemHeight")
	local n = math.min(#self.Values, dim("DropdownMaxItems"))
	local want = (n * ih + th.ListPad * 2) * sc
	local vp = lib.ScreenGui.AbsoluteSize
	local gap, m = 4 * sc, th.ScreenMargin
	local below = vp.Y - (ap.Y + as.Y + gap) - m
	local above = ap.Y - gap - m
	local hs, y
	if want <= below then
		hs, y = want, ap.Y + as.Y + gap
	elseif want <= above then
		hs, y = want, ap.Y - gap - want -- ekran altina tasarsa yukari ac
	elseif below >= above then
		hs, y = math.max(below, ih * sc), ap.Y + as.Y + gap
	else
		hs = math.max(above, ih * sc)
		y = ap.Y - gap - hs
	end
	local width = as.X
	local x = math.clamp(ap.X, m, math.max(m, vp.X - width - m))

	local bag = {}
	local list = create("Frame", {
		Name = "List", Active = true, BackgroundColor3 = c.Popup, BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 101,
		Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(width / sc, 0), Parent = ov,
	}, { create("UIScale", { Scale = sc }) })
	corner(list, th.CornerField + 1)
	stroke(list, c.Accent)
	local sf = create("ScrollingFrame", {
		BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = th.ScrollBar, ScrollBarImageColor3 = c.Dim,
		ScrollingDirection = Enum.ScrollingDirection.Y, Parent = list,
	}, {
		create("UIPadding", { PaddingTop = UDim.new(0, th.ListPad), PaddingBottom = UDim.new(0, th.ListPad),
			PaddingLeft = UDim.new(0, th.ListPad), PaddingRight = UDim.new(0, th.ListPad) }),
		create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	local items = {}
	local multi = self.Multi
	local function paint(it)
		local sel = self:_selected(it.val)
		it.frame.BackgroundColor3 = sel and c.Select or c.Hover
		it.frame.BackgroundTransparency = (sel or it.hov) and 0 or 1
		it.label.TextColor3 = (sel or it.hov) and c.Text or c.Muted
		if multi then
			it.cb.BackgroundTransparency = sel and 0 or 1
			it.cbStroke.Color = sel and c.Accent or c.Dim
			it.check.Visible = sel
		else
			it.bar.Visible = sel
		end
	end
	local function refresh() for _, it in ipairs(items) do paint(it) end end
	self._refresh = refresh
	local cb = th.CheckBox
	for i, val in ipairs(self.Values) do
		local frame = create("TextButton", { -- Active: girdi emilir, overlay'e ulasmaz
			Text = "", AutoButtonColor = false, Active = true,
			BorderSizePixel = 0, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, ih), LayoutOrder = i, Parent = sf,
		})
		corner(frame, th.CornerSmall)
		local it = { frame = frame, val = val, hov = false }
		local lx = th.FieldPadX
		if multi then
			lx = th.FieldPadX + cb + 8
			local box = create("Frame", {
				AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, th.FieldPadX - 2, 0.5, 0), Size = UDim2.fromOffset(cb, cb),
				BackgroundColor3 = c.Accent, BackgroundTransparency = 1, BorderSizePixel = 0, Parent = frame,
			})
			corner(box, 4)
			it.cb, it.cbStroke = box, stroke(box, c.Dim)
			it.check = makeCheck(box, c.AccentText)
		else
			it.bar = create("Frame", {
				AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 0), Size = UDim2.fromOffset(3, 14),
				BackgroundColor3 = c.Accent, BorderSizePixel = 0, Visible = false, Parent = frame,
			})
			corner(it.bar, 2)
		end
		it.label = mkLabel(frame, tostring(val), {
			Size = UDim2.new(1, -(lx + th.FieldPadX), 1, 0), Position = UDim2.fromOffset(lx, 0),
			TextSize = dim("LabelSize"), TextTruncate = Enum.TextTruncate.AtEnd, TextColor3 = c.Muted,
		})
		hover(frame, function() it.hov = true; paint(it) end, function() it.hov = false; paint(it) end, bag)
		onClick(frame, function()
			if multi then
				local cur = self.Value[val] == true
				if cur and not self.AllowNull then
					local cnt = 0
					for _ in pairs(self.Value) do cnt += 1 end
					if cnt <= 1 then return end -- son secili kaldirilamaz (AllowNull yok)
				end
				self.Value[val] = (not cur) or nil
				self:_display()
				refresh()
				self:_fire(self.Value)
			else
				local was = self:_selected(val)
				lib._closeDrop()
				if was then
					if self.AllowNull then self:SetValue(nil) end
				else
					self:SetValue(val)
				end
			end
		end, bag)
		table.insert(items, it)
		paint(it)
	end
	self._open = true
	lib._popup = list
	self._fstroke.Color = c.Accent
	lockScroll(self._scroll, true)
	ov.Visible = true
	tween(list, th.Anim.Drop, { Size = UDim2.fromOffset(width / sc, hs / sc) })
	lib._closeDrop = function()
		lib._closeDrop = nil
		lib._popup = nil
		self._open = false
		self._refresh = nil
		lockScroll(self._scroll, false)
		for _, cn in ipairs(bag) do cn:Disconnect() end
		pcall(function() self._fstroke.Color = T().Colors.Line end)
		pcall(function() list:Destroy() end)
		pcall(function() ov.Visible = false end)
	end
end

-- ===== Input =====

local InputM = class()
function InputM:SetValue(text)
	text = tostring(text == nil and "" or text)
	if self.MaxLength and #text > self.MaxLength then text = string.sub(text, 1, self.MaxLength) end
	self.Value = text
	self._last = text
	self._box.Text = text
	self:_fire(text)
end
function InputM:SetText(s) if self._label then self._label.Text = tostring(s) end end

-- ===== Groupbox =====

local GroupM = {}
GroupM.__index = GroupM

function GroupM:_row(h, props)
	self._n += 1
	local p = { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, h), LayoutOrder = self._n, Parent = self.Container }
	for k, v in pairs(props or {}) do p[k] = v end
	return create("Frame", p)
end

function GroupM:AddToggle(idx, info)
	info = info or {}
	local th = T()
	local c = th.Colors
	local rowH = dim("RowHeight")
	local row = self:_row(rowH, { AutomaticSize = Enum.AutomaticSize.Y }) -- uzun etiket sarilir, satir buyur
	local lbl = mkLabel(row, info.Text or idx, {
		Size = UDim2.new(1, -(th.ToggleW + 10), 0, rowH), AutomaticSize = Enum.AutomaticSize.Y,
		TextColor3 = c.Text, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Center,
	})
	local sw = create("Frame", {
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, (rowH - th.ToggleH) / 2), Size = UDim2.fromOffset(th.ToggleW, th.ToggleH),
		BackgroundColor3 = c.Field, BorderSizePixel = 0, Parent = row,
	})
	corner(sw, th.CornerSmall)
	local swStroke = stroke(sw)
	local notch = create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, th.NotchInset, 0.5, 0), Size = UDim2.fromOffset(th.NotchSize, th.NotchSize),
		BackgroundColor3 = c.Dim, BorderSizePixel = 0, Parent = sw,
	})
	corner(notch, 3)
	local obj = setmetatable({
		Type = "Toggle", Value = info.Default and true or false, Callback = info.Callback,
		_row = row, _label = lbl, _sw = sw, _swStroke = swStroke, _notch = notch, _hover = false,
	}, ToggleM)
	obj:_display(true)
	onClick(row, function() obj:SetValue(not obj.Value) end)
	hover(row, function()
		obj._hover = true
		obj:_display(true)
	end, function()
		obj._hover = false
		obj:_display(true)
	end)
	attachTip(row, info.Tooltip)
	self.Library.Toggles[idx] = obj
	return obj
end

-- Elle girilen sayiyi ayristir. Rounding 0: eksi disinda rakam olmayan her sey atilir (1.250 / 1,250 / 1 250 = 1250).
-- Rounding > 0: tek ayirici ondalik; hem , hem . varsa sonuncusu ondalik, digerleri binlik; ayni ayirici birden cok ise binlik.
local function parseNumber(txt, rounding)
	local neg = string.match(txt, "^%s*%-") ~= nil
	local n
	if (rounding or 0) <= 0 then
		local digits = string.gsub(txt, "[^%d]", "")
		n = tonumber(digits)
	else
		local sub = string.match(txt, "%d[%d%.,%s]*")
		if not sub then return nil end
		sub = string.gsub(sub, "%s", "")
		local lastDot, lastComma = string.find(sub, "%.[^%.]*$"), string.find(sub, ",[^,]*$")
		local dec
		if lastDot and lastComma then
			dec = (lastDot > lastComma) and "." or ","
		else
			local sep = lastDot and "." or (lastComma and "," or nil)
			if sep then
				local _, cnt = string.gsub(sub, "%" .. sep, "")
				if cnt == 1 then dec = sep end
			end
		end
		local out = {}
		for i = 1, #sub do
			local ch = string.sub(sub, i, i)
			if ch:match("%d") then table.insert(out, ch)
			elseif ch == dec and i == (dec == "." and lastDot or lastComma) then table.insert(out, ".") end
		end
		n = tonumber(table.concat(out))
	end
	if not n then return nil end
	return neg and -n or n
end

function GroupM:AddSlider(idx, info)
	info = info or {}
	local th = T()
	local c = th.Colors
	local lh = dim("SliderLabelHeight")
	local areaH = dim("RowHeight") - 8
	local row = self:_row(0, { AutomaticSize = Enum.AutomaticSize.Y })
	create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = row })
	local head = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, lh), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = row })
	local val = mkLabel(head, "", { AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 6, 0, 0), Size = UDim2.new(0, 0, 0, lh),
		AutomaticSize = Enum.AutomaticSize.X, TextXAlignment = Enum.TextXAlignment.Right, TextSize = dim("ValueSize"), Mono = true, Active = true })
	create("UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), Parent = val }) -- daha buyuk dokunma hedefi
	local lbl = mkLabel(head, info.Text or idx, { Size = UDim2.new(1, -8, 0, lh), AutomaticSize = Enum.AutomaticSize.Y,
		TextColor3 = c.Text, TextSize = dim("LabelSize"), TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top })
	local function fitLabel() -- etiket, degerin gerektirdigi genislik kadar yer birakir
		lbl.Size = UDim2.new(1, -(val.AbsoluteSize.X + 8), 0, lh)
	end
	connect(val:GetPropertyChangedSignal("AbsoluteSize"), fitLabel)
	local area = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, areaH), LayoutOrder = 2, Parent = row })
	local tr = create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, th.TrackInset, 0.5, 0),
		Size = UDim2.new(1, -th.TrackInset * 2, 0, th.TrackHeight),
		BackgroundColor3 = c.Field, BorderSizePixel = 0, Parent = area,
	})
	corner(tr, th.TrackHeight / 2)
	stroke(tr)
	local fill = create("Frame", { Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, Parent = tr })
	bind(fill, "BackgroundColor3", "Accent")
	corner(fill, th.TrackHeight / 2)
	local knob = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(th.KnobSize, th.KnobSize),
		Rotation = 45, BackgroundColor3 = c.Text, BorderSizePixel = 0, ZIndex = 2, Parent = tr,
	})
	corner(knob, 2)
	local ks = stroke(knob)
	ks.Thickness = 2
	bind(ks, "Color", "Accent")
	local mn, mx = info.Min or 0, info.Max or 100
	local obj = setmetatable({
		Type = "Slider", Min = mn, Max = mx, Rounding = info.Rounding or 0, Suffix = info.Suffix or "", Callback = info.Callback,
		Value = math.clamp(info.Default or mn, mn, mx), _row = row, _label = lbl, _val = val, _bar = tr, _fill = fill, _knob = knob, _drag = false,
		Live = info.Live, -- Live(value): surukleme sirasinda her degisimde
		Finished = info.Finished and true or false, -- true: surukleme sirasinda yalniz metin guncellenir, Changed birakinca tetiklenir
	}, SliderM)
	obj:_display()
	local scroll = self.Scroll
	-- elle deger girisi: deger metnine bas -> ayni yerde TextBox; Enter/odak kaybi uygular, Escape/gecersiz eski degere doner
	local editW = dim("SliderEditWidth")
	local edit = create("TextBox", {
		Name = "Edit", Visible = false, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, editW, 0, lh),
		BackgroundColor3 = c.Field, BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = th.MonoFace, TextSize = dim("ValueSize"),
		TextColor3 = c.Text, TextXAlignment = Enum.TextXAlignment.Right, Text = "", ZIndex = 3, Parent = head,
	})
	edit:SetAttribute("KFont", "mono")
	corner(edit, 4)
	create("UIPadding", { PaddingRight = UDim.new(0, 6), Parent = edit })
	bind(stroke(edit), "Color", "Accent")
	local editing = false
	local function finishEdit(apply)
		if not editing then return end
		editing = false
		lockScroll(scroll, false)
		local txt = edit.Text
		edit.Visible = false
		val.Visible = true
		if apply then
			local n = parseNumber(txt, obj.Rounding)
			if n and obj:_snap(n) ~= obj.Value then obj:SetValue(n) end
		end
		fitLabel()
	end
	connect(edit.FocusLost, function(_, input)
		finishEdit(not (input and input.KeyCode == Enum.KeyCode.Escape))
	end)
	onClick(val, function()
		if editing or obj._drag then return end
		editing = true
		lockScroll(scroll, true)
		edit.Text = fmtNum(obj.Value, obj.Rounding)
		val.Visible = false
		edit.Visible = true
		lbl.Size = UDim2.new(1, -(editW + 8), 0, lh)
		edit:CaptureFocus()
		task.defer(function()
			if editing then edit.SelectionStart = 1; edit.CursorPosition = #edit.Text + 1 end -- tum metin secili
		end)
	end)

	-- surukleme boyunca iz geometrisi SABIT (basista olculur): pencere olcegi canli degisse bile geri besleme/ziplama olmaz
	local function captureGeom()
		local a, z = tr.AbsolutePosition, tr.AbsoluteSize
		local g = { gx = a.X, gw = z.X, gy = a.Y + z.Y / 2 }
		local win, gui = Library.Window, Library.ScreenGui
		if win and gui and win.Frame.AbsoluteSize.X > 0 and win.Frame.AbsoluteSize.Y > 0 then
			local f = win.Frame
			local fa, fz = f.AbsolutePosition, f.AbsoluteSize
			-- iz noktasinin pencere icindeki GORELI konumu (olcekten bagimsiz) -> pivot (AnchorPoint) icin
			g.kl, g.kw, g.ky = (g.gx - fa.X) / fz.X, g.gw / fz.X, (g.gy - fa.Y) / fz.Y
			-- Position uzayi ile AbsolutePosition uzayi arasindaki sabit kayma (GuiInset)
			local p, vp, ap = f.Position, gui.AbsoluteSize, f.AnchorPoint
			g.dx = (p.X.Scale * vp.X + p.X.Offset) - (fa.X + ap.X * fz.X)
			g.dy = (p.Y.Scale * vp.Y + p.Y.Offset) - (fa.Y + ap.Y * fz.Y)
		end
		if win and win.Scale.Scale > 0 then
			g.sc0, g.cv = win.Scale.Scale, {}
			for _, d in ipairs(win.Frame:GetDescendants()) do
				if d:IsA("ScrollingFrame") then table.insert(g.cv, { d, d.CanvasPosition }) end
			end
		end
		obj._geom = g
	end
	local function setFromX(x)
		local g = obj._geom
		local gx, w = g and g.gx or tr.AbsolutePosition.X, g and g.gw or tr.AbsoluteSize.X
		if w <= 0 then return end
		local rel = math.clamp((x - gx) / w, 0, 1)
		local raw = obj.Min + rel * (obj.Max - obj.Min)
		local nv = obj:_snap(raw)
		if obj.Live then
			if raw == obj._raw then return end
			obj._raw = raw -- knob/dolgu ham degere gore akici izler
		elseif nv == obj.Value then
			return
		end
		if nv ~= obj.Value then
			if obj.Finished then
				obj.Value = nv
				obj._dirty = true
				obj:_display()
			else
				obj:SetValue(nv)
			end
		end
		if obj.Live then
			obj:_paint()
			safe(obj.Live, raw)
		end
	end
	-- dokunma alani yalniz iz bolgesi (area): etiket uzerinden baslayan kaydirma degeri degistirmez
	track(area, function(i)
		lockScroll(scroll, true)
		obj._drag = true
		captureGeom()
		obj:_paint()
		setFromX(i.Position.X)
	end, function(i) setFromX(i.Position.X) end, function()
		lockScroll(scroll, false)
		obj._drag = false
		obj:_paint()
		if obj.Live and Library.Window then Library.Window:_endPivot() end
		obj._geom, obj._raw = nil, nil
		obj:_paint()
		if obj._dirty then obj._dirty = false; obj:_fire(obj.Value) end
	end)
	attachTip(row, info.Tooltip)
	self.Library.Options[idx] = obj
	return obj
end

-- Etiket (otomatik yukseklik, sarilir) + alan: dropdown / input ortak yerlesimi
local function fieldRow(self, text)
	local th = T()
	local fh = dim("FieldHeight")
	local row = self:_row(0, { AutomaticSize = Enum.AutomaticSize.Y })
	create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = row })
	local lbl
	if text ~= nil then
		lbl = mkLabel(row, text, { Size = UDim2.new(1, 0, 0, th.FieldLabelHeight), AutomaticSize = Enum.AutomaticSize.Y,
			TextColor3 = th.Colors.Text, TextSize = dim("LabelSize"), TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 1 })
	end
	local field = create("Frame", {
		Size = UDim2.new(1, 0, 0, fh), LayoutOrder = 2, BackgroundColor3 = th.Colors.Field, BorderSizePixel = 0, Parent = row,
	})
	corner(field, th.CornerField)
	return row, lbl, field, stroke(field)
end

function GroupM:AddDropdown(idx, info)
	info = info or {}
	local th = T()
	local c = th.Colors
	local row, lbl, field, fst = fieldRow(self, info.Text)
	local txt = mkLabel(field, "", { Position = UDim2.fromOffset(th.FieldPadX, 0), Size = UDim2.new(1, -(th.ArrowWidth + th.FieldPadX * 2), 1, 0),
		TextSize = dim("ValueSize"), TextTruncate = Enum.TextTruncate.AtEnd })
	mkLabel(field, th.ArrowGlyph, {
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -th.FieldPadX, 0, 0), Size = UDim2.new(0, th.ArrowWidth, 1, 0),
		TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = c.Muted, TextSize = dim("LabelSize"),
	})
	local values = info.Values or {}
	local multi = info.Multi and true or false
	local d = info.Default
	local value
	if multi then
		value = {}
		if type(d) == "table" then
			for k, b in pairs(d) do
				if type(k) == "number" then
					if table.find(values, b) then value[b] = true end
				elseif b and table.find(values, k) then
					value[k] = true
				end
			end
		elseif type(d) == "number" then
			if values[d] ~= nil then value[values[d]] = true end
		elseif d ~= nil and table.find(values, d) then
			value[d] = true
		end
	else
		if type(d) == "number" then d = values[d] elseif d ~= nil and table.find(values, d) == nil then d = nil end
		value = d
	end
	local obj = setmetatable({
		Type = "Dropdown", Values = values, Value = value, Multi = multi, AllowNull = info.AllowNull and true or false,
		Callback = info.Callback, _row = row, _label = lbl, _field = field, _fstroke = fst, _text = txt, _scroll = self.Scroll,
	}, DropM)
	obj:_display()
	onClick(field, function()
		if obj._open then Library._closeDrop() else obj:_openList() end
	end)
	hover(field, function() field.BackgroundColor3 = T().Colors.Hover end, function() field.BackgroundColor3 = T().Colors.Field end)
	attachTip(row, info.Tooltip)
	self.Library.Options[idx] = obj
	return obj
end

function GroupM:AddInput(idx, info)
	info = info or {}
	local th = T()
	local c = th.Colors
	local row, lbl, field, fst = fieldRow(self, info.Text)
	local box = create("TextBox", {
		BackgroundTransparency = 1, BorderSizePixel = 0, ClearTextOnFocus = false, ClipsDescendants = true,
		Position = UDim2.fromOffset(th.FieldPadX, 0), Size = UDim2.new(1, -th.FieldPadX * 2, 1, 0),
		FontFace = th.FontFace, TextSize = dim("ValueSize"), TextColor3 = c.Text, TextXAlignment = Enum.TextXAlignment.Left,
		PlaceholderText = tostring(info.Placeholder or ""), PlaceholderColor3 = c.Dim, Text = "", Parent = field,
	})
	local def = tostring(info.Default == nil and "" or info.Default)
	local obj = setmetatable({
		Type = "Input", Value = def, Callback = info.Callback, Finished = info.Finished and true or false,
		Numeric = info.Numeric and true or false, MaxLength = info.MaxLength, _row = row, _label = lbl, _box = box, _last = def,
	}, InputM)
	box.Text = def
	local scroll = self.Scroll
	connect(box:GetPropertyChangedSignal("Text"), function()
		local t = box.Text
		if t == obj._last and t == obj.Value then return end
		if obj.Numeric and t ~= "" and not string.match(t, "^%-?%d*%.?%d*$") then
			box.Text = obj._last -- rakam disini reddet
			return
		end
		if obj.MaxLength and #t > obj.MaxLength then
			box.Text = string.sub(t, 1, obj.MaxLength)
			return
		end
		obj._last = t
		if not obj.Finished and t ~= obj.Value then
			obj.Value = t
			obj:_fire(t)
		end
	end)
	connect(box.Focused, function()
		fst.Color = T().Colors.Accent
		lockScroll(scroll, true)
	end)
	connect(box.FocusLost, function(enter)
		fst.Color = T().Colors.Line
		lockScroll(scroll, false)
		if obj.Finished then -- Finished: yalniz Enter'da kaydedilir (Linoria); aksi halde eski deger geri gelir
			if enter then
				obj:SetValue(box.Text)
			else
				obj._last = obj.Value
				box.Text = obj.Value
			end
		end
	end)
	attachTip(row, info.Tooltip)
	self.Library.Options[idx] = obj
	return obj
end

-- Buton: AddButton({Text, Func, Style="Primary"|"Secondary", Tooltip}) | AddButton(text, func). btn:AddButton(...) yanina ekler.
local ButtonM = class()
function ButtonM:SetText(s) self._lbl.Text = tostring(s) end
function ButtonM:AddButton(a, b)
	local info = type(a) == "table" and a or { Text = a, Func = b }
	return self._group:_addButtonTo(self._row, info)
end

function GroupM:_addButtonTo(row, info)
	local th = T()
	local primary = info.Style == "Primary"
	local btn = create("Frame", {
		BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), LayoutOrder = #row:GetChildren(), Parent = row,
	})
	corner(btn, th.CornerField)
	local bst = stroke(btn)
	local lbl = mkLabel(btn, info.Text or "Button", {
		Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Bold = true,
		TextSize = th.ButtonSize, TextTruncate = Enum.TextTruncate.AtEnd,
	})
	if primary then
		bind(btn, "BackgroundColor3", "Accent")
		bind(bst, "Color", "Accent")
		bind(lbl, "TextColor3", "AccentText")
	else
		btn.BackgroundTransparency = 1
		lbl.TextColor3 = th.Colors.Text
	end
	local obj = setmetatable({ Type = "Button", Func = info.Func or info.Callback, _lbl = lbl, _row = row, _group = self }, ButtonM)
	local btns = {}
	for _, ch in ipairs(row:GetChildren()) do if ch:IsA("Frame") then table.insert(btns, ch) end end
	local n = #btns
	for _, ch in ipairs(btns) do
		ch.Size = UDim2.new(1 / n, -math.floor(th.ButtonGap * (n - 1) / n), 1, 0)
	end
	onClick(btn, function()
		if obj.Func then safe(obj.Func) end
	end, nil, function()
		local c = T().Colors
		btn.BackgroundColor3 = primary and c.AccentDim or c.Select
		btn.BackgroundTransparency = 0
	end, function()
		local c = T().Colors
		btn.BackgroundColor3 = primary and c.Accent or c.Select
		btn.BackgroundTransparency = primary and 0 or 1
	end)
	hover(btn, function()
		if not primary then btn.BackgroundColor3 = T().Colors.Hover; btn.BackgroundTransparency = 0 end
	end, function()
		if not primary then btn.BackgroundTransparency = 1 end
	end)
	attachTip(btn, info.Tooltip)
	return obj
end

function GroupM:AddButton(a, b)
	local th = T()
	local info = type(a) == "table" and a or { Text = a, Func = b }
	local row = self:_row(dim("ButtonHeight"))
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, th.ButtonGap),
		SortOrder = Enum.SortOrder.LayoutOrder, Parent = row,
	})
	return self:_addButtonTo(row, info)
end

-- ===== ColorPicker (Linoria AddColorPicker imzasina yakin) =====

local ColorM = class()
function ColorM:_display()
	self._swatch.BackgroundColor3 = self.Value
	if self._refreshPanel then self._refreshPanel() end
end
function ColorM:_hsv(h, s, v) -- panelden surukleme: Value'yu HSV'den uret
	self.Hue, self.Sat, self.Val = h, s, v
	self.Value = Color3.fromHSV(h, s, v)
	self:_display()
	self:_fire(self.Value)
end
function ColorM:SetValue(c)
	if typeof(c) == "table" then c = Color3.fromHSV(c[1] or 0, c[2] or 0, c[3] or 0) end -- Linoria {h, s, v}
	if typeof(c) ~= "Color3" then return end
	local h, s, v = c:ToHSV()
	if s <= 0 or v <= 0 then h = self.Hue end -- gri/siyahta ton kaybolmasin
	self.Hue, self.Sat, self.Val = h, s, v
	self.Value = c
	self:_display()
	self:_fire(c)
end
function ColorM:SetValueRGB(c, transparency)
	if transparency ~= nil then self.Transparency = transparency end
	self:SetValue(c)
end

local function parseHex(t)
	t = string.gsub(tostring(t), "^%s*#?", "")
	t = string.gsub(t, "%s+$", "")
	if #t == 3 then
		t = string.gsub(t, ".", function(ch) return ch .. ch end)
	end
	if not string.match(t, "^%x%x%x%x%x%x$") then return nil end
	local ok, c = pcall(Color3.fromHex, t)
	if ok then return c end
	return nil
end

-- girdi (mouse/touch) konumunu ScreenGui (IgnoreGuiInset) koordinatina cevir
local function guiPoint(input)
	local ok, ins = pcall(function() return Services.Gui:GetGuiInset() end)
	if not ok then ins = Vector2.new(0, 0) end
	return input.Position.X + ins.X, input.Position.Y + ins.Y
end

function ColorM:_openPanel()
	local lib, th = Library, T()
	if lib._closeDrop then lib._closeDrop() end
	local win = lib.Window
	if not win then return end
	local c = th.Colors
	local ov = lib:_overlay()
	local sc = win.Scale.Scale
	if sc <= 0 then sc = 1 end
	local pad, PW, svH = th.PickerPad, th.PickerWidth, th.PickerSVHeight
	local hueH, hexH = dim("PickerHueHeight"), dim("FieldHeight")
	local inner = PW - pad * 2
	local PH = pad + svH + 8 + hueH + 8 + hexH + pad
	local sw = self._swatch
	local ap, as = sw.AbsolutePosition, sw.AbsoluteSize
	local vp = lib.ScreenGui.AbsoluteSize
	local m, gap = th.ScreenMargin, 4 * sc
	local wS, hS = PW * sc, PH * sc
	local x = math.clamp(ap.X + as.X - wS, m, math.max(m, vp.X - wS - m))
	local below = vp.Y - (ap.Y + as.Y + gap) - m
	local above = ap.Y - gap - m
	local y
	if hS <= below then y = ap.Y + as.Y + gap -- telefonda sigmazsa yukari ac
	elseif hS <= above then y = ap.Y - gap - hS
	else y = math.clamp(below >= above and (ap.Y + as.Y + gap) or (ap.Y - gap - hS), m, math.max(m, vp.Y - hS - m)) end

	local white, black = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
	local bag = {}
	local panel = create("Frame", {
		Name = "Picker", Active = true, BackgroundColor3 = c.Popup, BorderSizePixel = 0, ZIndex = 101,
		Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(PW, PH), Parent = ov,
	}, { create("UIScale", { Scale = sc }) })
	corner(panel, th.CornerField + 1)
	stroke(panel, c.Accent)

	-- Saturation/Value karesi: ton rengi + beyaz (soldan saga) + siyah (yukaridan asagi) gradyanlari
	local sv = create("Frame", {
		Position = UDim2.fromOffset(pad, pad), Size = UDim2.fromOffset(inner, svH), BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromHSV(self.Hue, 1, 1), Parent = panel,
	})
	corner(sv, 4)
	create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = white, BorderSizePixel = 0, Parent = sv },
		{ create("UICorner", { CornerRadius = UDim.new(0, 4) }), create("UIGradient", { Transparency = NumberSequence.new(0, 1) }) })
	create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = black, BorderSizePixel = 0, Parent = sv },
		{ create("UICorner", { CornerRadius = UDim.new(0, 4) }), create("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0) }) })
	local svc = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, ZIndex = 3, Parent = sv,
	}, { create("UICorner", { CornerRadius = UDim.new(0.5, 0) }) })
	stroke(svc, white).Thickness = 2

	-- Hue seridi
	local keys = {}
	for i = 0, 6 do table.insert(keys, ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i / 6, 1, 1))) end
	local hue = create("Frame", {
		Position = UDim2.fromOffset(pad, pad + svH + 8), Size = UDim2.fromOffset(inner, hueH), BackgroundColor3 = white,
		BorderSizePixel = 0, Parent = panel,
	}, { create("UICorner", { CornerRadius = UDim.new(0, 4) }), create("UIGradient", { Color = ColorSequence.new(keys) }) })
	local hc = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(0, 4, 1, 6), BackgroundColor3 = white, BorderSizePixel = 0, ZIndex = 3, Parent = hue,
	})
	corner(hc, 2)
	stroke(hc, black)

	-- hex kutusu + onizleme
	local y0 = pad + svH + 8 + hueH + 8
	local prev = create("Frame", {
		Position = UDim2.fromOffset(pad, y0), Size = UDim2.fromOffset(hexH, hexH), BackgroundColor3 = self.Value, BorderSizePixel = 0, Parent = panel,
	})
	corner(prev, th.CornerField)
	stroke(prev)
	local hexField = create("Frame", {
		Position = UDim2.fromOffset(pad + hexH + 8, y0), Size = UDim2.fromOffset(inner - hexH - 8, hexH),
		BackgroundColor3 = c.Field, BorderSizePixel = 0, Parent = panel,
	})
	corner(hexField, th.CornerField)
	local hst = stroke(hexField)
	local box = create("TextBox", {
		BackgroundTransparency = 1, BorderSizePixel = 0, ClearTextOnFocus = false, Text = "",
		Position = UDim2.fromOffset(th.FieldPadX, 0), Size = UDim2.new(1, -th.FieldPadX * 2, 1, 0),
		FontFace = th.MonoFace, TextSize = dim("ValueSize"), TextColor3 = c.Text, TextXAlignment = Enum.TextXAlignment.Left,
		PlaceholderText = "#RRGGBB", PlaceholderColor3 = c.Dim, Parent = hexField,
	})
	box:SetAttribute("KFont", "mono")

	local function refresh()
		sv.BackgroundColor3 = Color3.fromHSV(self.Hue, 1, 1)
		svc.Position = UDim2.fromScale(self.Sat, 1 - self.Val)
		hc.Position = UDim2.new(self.Hue, 0, 0.5, 0)
		prev.BackgroundColor3 = self.Value
		if not box:IsFocused() then box.Text = "#" .. string.upper(self.Value:ToHex()) end
	end
	self._refreshPanel = refresh
	refresh()

	local function setSV(i)
		local px, py = guiPoint(i)
		local a, s = sv.AbsolutePosition, sv.AbsoluteSize
		if s.X <= 0 or s.Y <= 0 then return end
		self:_hsv(self.Hue, math.clamp((px - a.X) / s.X, 0, 1), 1 - math.clamp((py - a.Y) / s.Y, 0, 1))
	end
	local function setHue(i)
		local px = guiPoint(i)
		local a, s = hue.AbsolutePosition, hue.AbsoluteSize
		if s.X <= 0 then return end
		self:_hsv(math.clamp((px - a.X) / s.X, 0, 1), self.Sat, self.Val)
	end
	track(sv, setSV, setSV, nil, bag)
	track(hue, setHue, setHue, nil, bag)
	table.insert(bag, box.Focused:Connect(function() hst.Color = T().Colors.Accent end))
	table.insert(bag, box.FocusLost:Connect(function(enter)
		hst.Color = T().Colors.Line
		local col = enter and parseHex(box.Text)
		if col then self:SetValue(col) else refresh() end
	end))

	self._open = true
	lib._popup = panel
	self._sstroke.Color = c.Accent
	lockScroll(self._scroll, true)
	ov.Visible = true
	lib._closeDrop = function()
		lib._closeDrop = nil
		lib._popup = nil
		self._open = false
		self._refreshPanel = nil
		lockScroll(self._scroll, false)
		for _, cn in ipairs(bag) do cn:Disconnect() end
		pcall(function() self._sstroke.Color = T().Colors.Line end)
		pcall(function() panel:Destroy() end)
		pcall(function() ov.Visible = false end)
	end
end

local function makeColorPicker(row, idx, info, rightOffset, scroll)
	info = info or {}
	local th = T()
	local def = typeof(info.Default) == "Color3" and info.Default or Color3.new(1, 1, 1)
	local sh = dim("SwatchH")
	local sw = create("Frame", {
		Name = "Swatch", AnchorPoint = Vector2.new(1, 0), Active = true,
		Position = UDim2.new(1, -(rightOffset or 0), 0, (dim("RowHeight") - sh) / 2),
		Size = UDim2.fromOffset(th.SwatchW, sh), BackgroundColor3 = def, BorderSizePixel = 0, Parent = row,
	})
	corner(sw, th.CornerSmall)
	local sst = stroke(sw)
	local h, s, v = def:ToHSV()
	local obj = setmetatable({
		Type = "ColorPicker", Value = def, Hue = h, Sat = s, Val = v, Title = info.Title, Transparency = info.Transparency,
		Callback = info.Callback, _swatch = sw, _sstroke = sst, _scroll = scroll,
	}, ColorM)
	onClick(sw, function()
		if obj._open then Library._closeDrop() else obj:_openPanel() end
	end)
	attachTip(sw, info.Tooltip)
	Library.Options[idx] = obj
	return obj
end

local LabelM = {}
LabelM.__index = LabelM
function LabelM:SetText(s) self._lbl.Text = tostring(s) end
function LabelM:SetVisible(v) self._row.Visible = v and true or false end
function LabelM:AddColorPicker(idx, info)
	self._lbl.Size = UDim2.new(1, -(T().SwatchW + 10), 0, dim("RowHeight"))
	return makeColorPicker(self._row, idx, info, 0, self._scroll)
end
function LabelM:AddKeyPicker(idx, info)
	self._lbl.Size = UDim2.new(1, -110, 0, dim("RowHeight")) -- tus kutusuna yer birak
	return makeKeyPicker(self._row, idx, info, 0)
end

function GroupM:AddLabel(text, wrap) -- uzun metin her zaman sarilir (wrap parametresi uyumluluk icin)
	local th = T()
	local rowH = dim("RowHeight")
	local row = self:_row(rowH, { AutomaticSize = Enum.AutomaticSize.Y })
	return setmetatable({ _row = row, _scroll = self.Scroll, _lbl = mkLabel(row, text, {
		Size = UDim2.new(1, 0, 0, rowH), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
		TextYAlignment = Enum.TextYAlignment.Center, TextColor3 = th.Colors.Text, TextSize = dim("LabelSize"),
	}) }, LabelM)
end

function GroupM:AddColorPicker(idx, info) -- etiket + sag tarafta renk kutusu
	info = info or {}
	return self:AddLabel(info.Text or idx):AddColorPicker(idx, info)
end

-- ===== IconRow: kare ikon karolari (sarilir) =====
-- AddIconRow(idx, { Size = 38, Tile = true|false (false: zeminsiz/kenarsiz) }) ; :SetItems({ { image = "rbxassetid://..", model = <Instance>, pivot = <CFrame>, text = "ad", amount = "x3", tooltip = "..." } })
-- Karo icerigi: model (ViewportFrame, kopyalanir) > image > text rozeti. Oyuna ozgu veri yok: liste disaridan gelir.
local IconM = class()
function IconM:SetItems(list)
	local th = T()
	local c = th.Colors
	for _, ch in ipairs(self._box:GetChildren()) do
		if ch:IsA("GuiObject") then ch:Destroy() end
	end
	local S = self.Size
	for i, it in ipairs(type(list) == "table" and list or {}) do
		local tile = create("Frame", { Size = UDim2.fromOffset(S, S), BackgroundColor3 = c.Field, BackgroundTransparency = self.Tile and 0 or 1, BorderSizePixel = 0, LayoutOrder = i, Parent = self._box })
		if self.Tile then
			corner(tile, th.CornerField)
			stroke(tile)
		end
		local shown = false
		if typeof(it.model) == "Instance" then
			shown = pcall(function()
				local vp = create("ViewportFrame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Ambient = Color3.fromRGB(190, 190, 190), Parent = tile })
				local cam = create("Camera", { FieldOfView = 40, CFrame = CFrame.new(), Parent = vp })
				vp.CurrentCamera = cam
				local m = it.model:Clone()
				m.Parent = vp
				if typeof(it.pivot) == "CFrame" then m:PivotTo(it.pivot) end -- yonelim; boyut/konum asagida her zaman sigdirilir
				local bb, size = m:GetBoundingBox()
				local d = math.max(size.X, size.Y, size.Z) * 1.15 / (2 * math.tan(math.rad(20))) / 0.82 + size.Z / 2 -- ~%18 ic bosluk
				m:PivotTo(CFrame.new(0, 0, -d) * (bb:Inverse() * m:GetPivot()))
			end)
		end
		if not shown and type(it.image) == "string" and it.image ~= "" then
			create("ImageLabel", { BackgroundTransparency = 1, Size = UDim2.new(1, -8, 1, -8), Position = UDim2.fromOffset(4, 4),
				ScaleType = Enum.ScaleType.Fit, Image = it.image, Parent = tile })
			shown = true
		end
		if not shown then
			local t = tostring(it.text or "?")
			if #t > 7 then t = string.sub(t, 1, 6) .. "." end
			mkLabel(tile, t, { Size = UDim2.new(1, -4, 1, -10), Position = UDim2.fromOffset(2, 0), TextXAlignment = Enum.TextXAlignment.Center,
				TextColor3 = c.Muted, TextSize = 11, TextWrapped = true, TextTruncate = Enum.TextTruncate.AtEnd })
		end
		if it.amount ~= nil and tostring(it.amount) ~= "" then
			local pill = create("Frame", { AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -2, 1, -2), Size = UDim2.fromOffset(0, 14),
				AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = self.Tile and 0.35 or 1, BorderSizePixel = 0, ZIndex = 3, Parent = tile })
			corner(pill, 4)
			create("UIPadding", { PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), Parent = pill })
			local al = mkLabel(pill, tostring(it.amount), { Size = UDim2.fromOffset(0, 14), AutomaticSize = Enum.AutomaticSize.X,
				TextXAlignment = Enum.TextXAlignment.Center, TextSize = 12, Bold = true, TextColor3 = Color3.new(1, 1, 1), ZIndex = 4 })
			create("UIStroke", { Color = Color3.new(0, 0, 0), Thickness = self.Tile and 1 or 1.5, Transparency = self.Tile and 0.5 or 0, Parent = al })
		end
		attachTip(tile, it.tooltip)
	end
end

function GroupM:AddIconRow(idx, info)
	info = info or {}
	local row = self:_row(0, { AutomaticSize = Enum.AutomaticSize.Y })
	local box = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = row })
	create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Wraps = true, Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder, Parent = box })
	create("UIPadding", { PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 2), Parent = box })
	local obj = setmetatable({ Type = "IconRow", Size = info.Size or 38, Tile = info.Tile ~= false, _row = row, _box = box }, IconM)
	if info.Items then obj:SetItems(info.Items) end
	if idx then self.Library.Options[idx] = obj end
	return obj
end

function GroupM:AddDivider()
	local th = T()
	local row = self:_row(th.DividerHeight)
	create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = th.Colors.Line, BorderSizePixel = 0, Parent = row,
	})
end

-- ===== Tab / Window =====

local TabM = {}
TabM.__index = TabM

function TabM:_group(scroll, name)
	local th = T()
	self._n += 1
	local box = create("Frame", {
		Name = tostring(name), BackgroundColor3 = th.Colors.Card, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = self._n, Parent = scroll,
	}, {
		create("UIPadding", { PaddingTop = UDim.new(0, th.Padding), PaddingBottom = UDim.new(0, th.Padding),
			PaddingLeft = UDim.new(0, th.Padding), PaddingRight = UDim.new(0, th.Padding) }),
		create("UIListLayout", { Padding = UDim.new(0, th.Gap), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	corner(box, th.CornerCard)
	stroke(box)
	-- baslik: 12x2 vurgu cubugu + buyuk harf Muted
	local cap = create("Frame", { Name = "Caption", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, th.CaptionHeight), LayoutOrder = 0, Parent = box })
	local bar = create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(th.CaptionBarWidth, 2),
		BorderSizePixel = 0, Parent = cap,
	})
	bind(bar, "BackgroundColor3", "Accent")
	local off = th.CaptionBarWidth + 7
	mkLabel(cap, string.upper(tostring(name)), {
		Position = UDim2.fromOffset(off, 0), Size = UDim2.new(1, -off, 1, 0), Black = true, TextSize = dim("GroupTitleSize"),
		TextColor3 = th.Colors.Text, TextTruncate = Enum.TextTruncate.AtEnd,
	})
	return setmetatable({ Library = Library, Container = box, Scroll = scroll, _n = 0 }, GroupM)
end
function TabM:AddLeftGroupbox(name) return self:_group(self.Left, name) end
function TabM:AddRightGroupbox(name) return self:_group(self.Right, name) end

function TabM:_paint(on)
	local c = T().Colors
	self.Num.TextColor3 = on and c.Accent or (self._hover and c.Text or c.Muted)
	if self.Label then self.Label.TextColor3 = (on or self._hover) and c.Text or c.Text end
	self.Button.BackgroundTransparency = on and 0 or 1
	self.Mark.Visible = on
end

local WindowMT = {}
WindowMT.__index = WindowMT

-- Fade yalniz animasyon suresince: header + body gecici CanvasGroup'a tasinir, bitince Frame'e geri doner (duragan halde yazilar keskin).
function WindowMT:_fadeOn()
	if self._cg then return end
	local cg = create("CanvasGroup", {
		Name = "Fade", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Parent = self.Frame,
	})
	self.Header.Parent = cg
	self.Body.Parent = cg
	self._cg = cg
end
function WindowMT:_fadeOff()
	local cg = self._cg
	if not cg then return end
	self.Header.Parent = self.Frame
	self.Body.Parent = self.Frame
	cg:Destroy()
	self._cg = nil
	self.Frame.BackgroundTransparency = 0
	if self._frameStroke then self._frameStroke.Transparency = 0 end
end

function WindowMT:_launcherCenter()
	local p = self.Launcher and self.Launcher.Position or UDim2.fromOffset(0, 0)
	local half = T().LauncherSize / 2
	return UDim2.fromOffset(p.X.Offset + half, p.Y.Offset + half)
end

-- how: "launcher" (K muhruna dogru kuculme / muhurden acilma) | "key" (yerinde olcek + solma)
function WindowMT:SetVisible(v, how)
	v = v and true or false
	if v == self.Visible then return end
	local wasMin = self.Minimized
	self.Visible = v
	if v then self.Minimized = false end
	if Library._closeDrop then Library._closeDrop() end
	Library:_hideTip()
	local th = T()
	local A = th.Anim
	local frame, base = self.Frame, self.BaseScale or 1
	self._anim = (self._anim or 0) + 1
	local my = self._anim
	if self._tw then for _, t in ipairs(self._tw) do t:Cancel() end end
	self._tw = {}
	-- kayitli yer: yalniz pencere gorunur ve animasyon yokken okunur (gizliyken Position kucultme tween'inden launcher'da kalmis olabilir)
	if not self._animating and frame.Visible then self._restPos = frame.Position end
	local rest = self._restPos or frame.Position
	if v and wasMin then how = "launcher" end
	local small = (how == "launcher")
	self._animating = true
	self:_syncLauncher()

	local function finish()
		if my ~= self._anim then return end
		self._animating = false
		for _, t in ipairs(self._tw or {}) do t:Cancel() end -- kalan Position tween'i finish'ten sonra konumu ezmesin
		if v then
			frame.Visible = true
		else
			frame.Visible = false
		end
		frame.Position = rest
		self.Scale.Scale = base
		self:_fadeOff()
		self:_syncLauncher(small and not v)
		if v then self:_fitOnScreen() end
	end

	if th.ReduceMotion then
		frame.Visible = v
		finish()
		return
	end

	local st = small and (v and A.RestoreStyle or A.MinimizeStyle) or (v and A.WinOpenStyle or A.WinCloseStyle)
	local dur = small and (v and A.Restore or A.Minimize) or A.WinToggle
	local info = TweenInfo.new(dur, st[1], st[2])
	local offScale = small and A.Shrink or A.WinFrom
	local offPos = small and self:_launcherCenter() or rest

	self:_fadeOn()
	if v and not frame.Visible then -- tamamen gizliyken: baslangic degerleri
		self.Scale.Scale = base * offScale
		frame.Position = offPos
		self._cg.GroupTransparency = 1
		frame.BackgroundTransparency = 1
		if self._frameStroke then self._frameStroke.Transparency = 1 end
		frame.Visible = true
	end
	local function play(inst, props)
		local tw = Services.Tween:Create(inst, info, props)
		table.insert(self._tw, tw)
		tw:Play()
		return tw
	end
	local tgtT = v and 0 or 1
	local first = play(self.Scale, { Scale = v and base or base * offScale })
	play(frame, { Position = v and rest or offPos, BackgroundTransparency = tgtT })
	play(self._cg, { GroupTransparency = tgtT })
	if self._frameStroke then play(self._frameStroke, { Transparency = tgtT }) end
	first.Completed:Connect(function(state)
		if state == Enum.PlaybackState.Completed then finish() end
	end)
end
function WindowMT:Toggle(how) self:SetVisible(not self.Visible, how) end
function WindowMT:_syncLauncher(pop)
	local l = self.Launcher
	if not l then return end
	local th = T()
	local show = self.LauncherAlways or (self.Minimized and not self.Visible and not self._animating) or false
	l.Visible = show
	local a = (self.Visible and self.LauncherAlways) and th.LauncherIdleAlpha or 0
	local lp = self._lparts
	if lp then
		local N = th.Anim.Normal
		tween(lp.bg, N, { BackgroundTransparency = a })
		tween(lp.stroke, N, { Transparency = a })
		tween(lp.mark, N, { ImageTransparency = a })
		if lp.glow then tween(lp.glow, N, { ImageTransparency = th.BadgeGlowAlpha + (1 - th.BadgeGlowAlpha) * a }) end
	else
		tween(l, th.Anim.Normal, l:IsA("ImageButton") and { ImageTransparency = a } or { BackgroundTransparency = a, TextTransparency = a })
	end
	if self.LauncherStroke then tween(self.LauncherStroke, th.Anim.Normal, { Transparency = a }) end
	if pop and show and self.LauncherScale and not th.ReduceMotion then -- hafif "pop"
		self.LauncherScale.Scale = th.Anim.PopFrom
		Services.Tween:Create(self.LauncherScale, TweenInfo.new(th.Anim.Pop, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	end
end
function WindowMT:Minimize() -- pencereyi K muhruna dogru kucultur; ekranda surukleneblir kare K muhru kalir
	self.Minimized = true
	if self.Visible then self:SetVisible(false, "launcher") end
	self:_syncLauncher()
end

-- Pivot'u (surukleme sirasinda kaydirilan AnchorPoint) merkeze geri al; pencere yerinden oynamaz.
function WindowMT:_endPivot()
	local fr = self.Frame
	local ap = fr.AnchorPoint
	if ap.X == 0.5 and ap.Y == 0.5 then return end
	local sc = self.Scale.Scale
	local w, h = fr.Size.X.Offset * sc, fr.Size.Y.Offset * sc
	local p = fr.Position
	fr.AnchorPoint = Vector2.new(0.5, 0.5)
	fr.Position = UDim2.new(p.X.Scale, p.X.Offset + (0.5 - ap.X) * w, p.Y.Scale, p.Y.Offset + (0.5 - ap.Y) * h)
end

-- Acilista: pencere TAMAMEN ekran icinde (surukleme kenara tasimis olabilir; sigmazsa ortala). Konum Position/Size/Scale'den hesaplanir
-- (AbsolutePosition olcek oturmadan bayat okunur). Anlik, animasyonsuz.
function WindowMT:_fitOnScreen()
	local frame, gui = self.Frame, Library.ScreenGui
	if not gui then return end
	local vp, top = gui.AbsoluteSize, topInset()
	local sc = self.Scale.Scale
	local sz = Vector2.new(frame.Size.X.Offset * sc, frame.Size.Y.Offset * sc)
	local p, ap = frame.Position, frame.AnchorPoint
	local tl = Vector2.new(p.X.Scale * vp.X + p.X.Offset - ap.X * sz.X, p.Y.Scale * vp.Y + p.Y.Offset - ap.Y * sz.Y)
	local cx, cy = tl.X, tl.Y
	if sz.X <= vp.X then cx = math.clamp(cx, 0, vp.X - sz.X) else cx = (vp.X - sz.X) / 2 end
	if sz.Y <= vp.Y - top then cy = math.clamp(cy, top, vp.Y - sz.Y) else cy = top + ((vp.Y - top) - sz.Y) / 2 end
	if cx ~= tl.X or cy ~= tl.Y then
		local np = UDim2.new(p.X.Scale, p.X.Offset + (cx - tl.X), p.Y.Scale, p.Y.Offset + (cy - tl.Y))
		frame.Position = np
		self._restPos = np
	end
end

-- Pencere ekrandan tasiyorsa iceri cek (sigiyorsa tamamen, sigmiyorsa surukleme kuralina gore)
function WindowMT:_clampIn()
	local frame, gui = self.Frame, Library.ScreenGui
	if not gui or self._animating or not frame.Visible then return end
	local vp, sz, ap = gui.AbsoluteSize, frame.AbsoluteSize, frame.AbsolutePosition
	local top = topInset()
	local cx, cy
	if sz.X <= vp.X then cx = math.clamp(ap.X, 0, vp.X - sz.X) else cx = math.clamp(ap.X, -(sz.X - 80), vp.X - 80) end
	if sz.Y <= vp.Y - top then cy = math.clamp(ap.Y, top, vp.Y - sz.Y) else cy = math.clamp(ap.Y, top, math.max(top, vp.Y - 40)) end
	if cx ~= ap.X or cy ~= ap.Y then
		local p = frame.Position
		local np = UDim2.new(p.X.Scale, p.X.Offset + (cx - ap.X), p.Y.Scale, p.Y.Offset + (cy - ap.Y))
		self._restPos = np
		tween(frame, 0.15, { Position = np }) -- yumusak
	end
end

function WindowMT:_crumb()
	local c = T().Colors
	local t = self.Selected
	self.Crumb.Text = string.format('<font color="#%s">/ </font><font color="#%s">%s</font>',
		c.Muted:ToHex(), c.Accent:ToHex(), esc(string.upper(t and t.Name or "")))
end

function WindowMT:SelectTab(tab)
	if Library._closeDrop then Library._closeDrop() end
	Library:_hideTip()
	for _, t in ipairs(self.Tabs) do
		local on = (t == tab)
		t.Page.Visible = on
		t:_paint(on)
	end
	self.Selected = tab
	self:_crumb()
end

function WindowMT:AddTab(name)
	local th = T()
	local compact = Library._compact
	local rh = dim("TabHeight")
	local n = #self.Tabs + 1
	local btn = create("Frame", {
		Name = tostring(name), BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, rh), LayoutOrder = n, Parent = self.TabBar,
	})
	bind(btn, "BackgroundColor3", "Accent")
	create("UIGradient", { -- aktif sekme: vurgu %15 -> seffaf
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.85), NumberSequenceKeypoint.new(1, 1) }), Parent = btn,
	})
	local mark = create("Frame", {
		Position = UDim2.fromOffset(0, th.TabMarkInset), Size = UDim2.new(0, th.TabMarkWidth, 1, -th.TabMarkInset * 2),
		BorderSizePixel = 0, Visible = false, Parent = btn,
	})
	bind(mark, "BackgroundColor3", "Accent")
	corner(mark, 2)
	local num = mkLabel(btn, string.format("%02d", n), {
		Bold = true, TextSize = dim("TabNumSize"), TextColor3 = th.Colors.Muted,
		Position = UDim2.fromOffset(compact and 0 or th.TabPadX, 0),
		Size = compact and UDim2.fromScale(1, 1) or UDim2.new(0, th.TabNumWidth, 1, 0),
		TextXAlignment = compact and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
	})
	local lbl
	if not compact then
		local lx = th.TabPadX + th.TabNumWidth
		lbl = mkLabel(btn, name, {
			Position = UDim2.fromOffset(lx, 0), Size = UDim2.new(1, -(lx + 6), 1, 0), TextSize = dim("TabSize"),
			TextColor3 = th.Colors.Text, TextTruncate = Enum.TextTruncate.AtEnd,
		})
	end

	local pp = th.PagePad
	local page = create("Frame", { Name = tostring(name), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = self.Pages },
		{ create("UIPadding", { PaddingTop = UDim.new(0, pp), PaddingBottom = UDim.new(0, pp),
			PaddingLeft = UDim.new(0, pp), PaddingRight = UDim.new(0, pp) }) })
	local function column(xs, xo)
		return create("ScrollingFrame", {
			BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(0.5, -th.ColumnGap / 2, 1, 0),
			Position = UDim2.new(xs, xo, 0, 0), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollBarThickness = th.ScrollBar, ScrollBarImageColor3 = th.Colors.Dim,
			ScrollingDirection = Enum.ScrollingDirection.Y, Parent = page,
		}, {
			create("UIListLayout", { Padding = UDim.new(0, th.ColumnGap), SortOrder = Enum.SortOrder.LayoutOrder }),
			-- 1px: kart cizgisi kirpilmasin; sagda kaydirma cubugu payi
			create("UIPadding", { PaddingTop = UDim.new(0, 1), PaddingLeft = UDim.new(0, 1), PaddingBottom = UDim.new(0, 1),
				PaddingRight = UDim.new(0, th.ScrollBar + 3) }),
		})
	end
	local tab = setmetatable({
		Name = tostring(name), Window = self, Button = btn, Num = num, Label = lbl, Mark = mark, Page = page, _n = 0,
		Left = column(0, 0), Right = column(0.5, th.ColumnGap / 2),
	}, TabM)
	table.insert(self.Tabs, tab)
	tab:_paint(false)
	onClick(btn, function() self:SelectTab(tab) end)
	hover(btn, function() tab._hover = true; if self.Selected ~= tab then tab:_paint(false) end end,
		function() tab._hover = false; if self.Selected ~= tab then tab:_paint(false) end end)
	if #self.Tabs == 1 then self:SelectTab(tab) end
	return tab
end

-- Opsiyonel logo: dosya yoksa Url'den indirip yazar, getcustomasset ile asset id doner. Her adim pcall; olmazsa nil (K metinli muhre dus).
local function loadLogoAsset(file, url)
	if type(file) ~= "string" or file == "" then return nil end
	local ok, id = pcall(function()
		if type(isfile) ~= "function" or type(writefile) ~= "function" then error("fs yok") end
		if not isfile(file) then
			if type(url) ~= "string" or url == "" then error("url yok") end
			local body = game:HttpGet(url)
			if type(body) ~= "string" or #body < 16 or string.sub(body, 2, 4) ~= "PNG" then error("png degil") end
			local dir = string.match(file, "^(.*)/[^/]*$")
			if dir and type(makefolder) == "function" and type(isfolder) == "function" then
				local cur
				for part in string.gmatch(dir, "[^/]+") do
					cur = cur and (cur .. "/" .. part) or part
					if not isfolder(cur) then makefolder(cur) end
				end
			end
			writefile(file, body)
		end
		local f = getcustomasset or getsynasset
		if type(f) ~= "function" then error("getcustomasset yok") end
		return f(file)
	end)
	if ok and type(id) == "string" and id ~= "" then return id end
	return nil
end

-- Maske logo rozeti (kod): koyu ic zemin + Accent cerceve + Accent boyali K maskesi (+ opsiyonel glow). SetAccent canli boyar.
local function makeBadge(parent, size, ids)
	local th = T()
	local root = create("Frame", { Name = "Badge", BackgroundTransparency = 1, Size = UDim2.fromOffset(size, size), Parent = parent })
	local parts = {}
	if ids.glow then
		parts.glow = create("ImageLabel", {
			Name = "Glow", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(th.BadgeGlowScale, th.BadgeGlowScale), Image = ids.glow, ImageTransparency = th.BadgeGlowAlpha, Parent = root,
		})
		bind(parts.glow, "ImageColor3", "Accent")
	end
	parts.bg = create("Frame", { Name = "Face", Size = UDim2.fromScale(1, 1), BackgroundColor3 = th.Colors.Bg, BorderSizePixel = 0, Parent = root })
	create("UICorner", { CornerRadius = UDim.new(th.BadgeCorner, 0), Parent = parts.bg })
	parts.stroke = stroke(parts.bg)
	parts.stroke.Thickness = math.max(1, math.floor(size * th.BadgeStroke + 0.5))
	bind(parts.stroke, "Color", "Accent")
	parts.mark = create("ImageLabel", {
		Name = "Mark", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = ids.mark, ScaleType = Enum.ScaleType.Fit, Parent = parts.bg,
	})
	bind(parts.mark, "ImageColor3", "Accent")
	return root, parts
end

-- CanvasPosition piksel cinsinden ve UIScale ile olceklenmez: olcek degisince kaydirma yeri kaymasin diye orantila.
local function scaleScrolls(root, ratio)
	for _, d in ipairs(root:GetDescendants()) do
		if d:IsA("ScrollingFrame") then d.CanvasPosition = d.CanvasPosition * ratio end
	end
end

function Library:CreateWindow(cfg)
	cfg = cfg or {}
	local th = T()

	-- onceki ornegi kaldir
	local env = genv()
	local prev = (env and env.KaiUI_Instance) or Library._prevInstance
	if prev and prev ~= self and prev.Unload then pcall(function() prev:Unload() end) end
	if env then env.KaiUI_Instance = self end
	Library._prevInstance = self
	if cfg.Globals and env then
		env.Toggles, env.Options, env.Library = self.Toggles, self.Options, self
	end

	-- kompakt kip: telefon ya da viewport kisa kenari < CompactBelow
	local cam0 = workspace.CurrentCamera
	local vp0 = cam0 and cam0.ViewportSize or Vector2.new(1920, 1080)
	if cfg.Compact ~= nil then
		self._compact = cfg.Compact and true or false
	else
		self._compact = self:IsMobile() or math.min(vp0.X, vp0.Y) < th.CompactBelow
	end
	local compact = self._compact

	-- Logo = { File, Url, SmallFile?, SmallUrl? }: baslik muhru kucuk surumu (varsa), launcher ana surumu kullanir
	-- Mark = { Mark, MarkUrl, Glow?, GlowUrl? }: maske rozet (Accent ile boyanir, tercih edilen); File/Url: eski tam renkli PNG
	local logoId, logoSmallId, markIds
	if type(cfg.Logo) == "table" and cfg.Logo.Mark then
		local m = loadLogoAsset(cfg.Logo.Mark, cfg.Logo.MarkUrl)
		if m then markIds = { mark = m, glow = loadLogoAsset(cfg.Logo.Glow, cfg.Logo.GlowUrl) } end
	end
	if type(cfg.Logo) == "table" and not markIds then
		logoId = loadLogoAsset(cfg.Logo.File, cfg.Logo.Url)
		logoSmallId = loadLogoAsset(cfg.Logo.SmallFile, cfg.Logo.SmallUrl) or logoId
	end

	local gui = create("ScreenGui", {
		Name = randName(),
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true,
		DisplayOrder = th.DisplayOrder,
	})
	self.MountedTo = mountGui(gui)
	self.ScreenGui = gui
	if not self.MountedTo then warn("[KaiUI] GUI mount edilemedi") end

	local ws = compact and th.CompactWindowSize or th.WindowSize
	local size = cfg.Size or UDim2.fromOffset(ws.X, ws.Y)
	local frame = create("Frame", {
		Name = "Window",
		BackgroundColor3 = th.Colors.Bg,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = size,
		ClipsDescendants = true, -- ray/baslik kose yuvarlagina uyar
		Visible = false,
		Parent = gui,
	})
	corner(frame, th.Corner)
	local frameStroke = stroke(frame)
	local scale = create("UIScale", { Parent = frame })

	local hh = dim("HeaderHeight")
	local header = create("Frame", {
		Name = "Header", BackgroundColor3 = th.Colors.Rail, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, hh), Parent = frame,
	})
	corner(header, th.Corner) -- ust koseler pencereyle ayni yaricap
	create("Frame", { -- alt yariyi duzlestir (ust yuvarlak, alt duz)
		BackgroundColor3 = th.Colors.Rail, BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0.5, 0), Parent = header,
	})
	create("Frame", { -- baslik alt cizgisi
		BackgroundColor3 = th.Colors.Line, BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 1), Parent = header,
	})
	local hbw = dim("HeaderButtonWidth")
	local left = create("Frame", {
		Name = "Left", BackgroundTransparency = 1, Size = UDim2.new(1, -hbw, 1, 0), Parent = header,
	}, {
		create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10),
			VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		create("UIPadding", { PaddingLeft = UDim.new(0, 8) }),
	})
	if markIds then
		local sz = dim("SealSizeLogo")
		local root = makeBadge(left, sz, markIds)
		root.LayoutOrder = 1
		root.Name = "Seal"
	elseif logoSmallId then
		create("ImageLabel", {
			Name = "Seal", Size = UDim2.fromOffset(th.SealSize, th.SealSize), BackgroundTransparency = 1, BorderSizePixel = 0,
			Image = logoSmallId, ScaleType = Enum.ScaleType.Fit, LayoutOrder = 1, Parent = left,
		})
	else
		local seal = create("Frame", {
			Name = "Seal", Size = UDim2.fromOffset(th.SealSize, th.SealSize), BorderSizePixel = 0, LayoutOrder = 1, Parent = left,
		})
		bind(seal, "BackgroundColor3", "Accent")
		corner(seal, th.CornerSmall)
		local sl = mkLabel(seal, "K", {
			Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Bold = true,
			TextSize = th.SealTextSize, TextColor3 = th.Colors.AccentText,
		})
		bind(sl, "TextColor3", "AccentText")
	end
	mkLabel(left, string.upper(tostring(cfg.Title or "KaiUI")), {
		Name = "Title", Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = 2,
		Black = true, TextSize = dim("TitleSize"), TextColor3 = th.Colors.Text,
	})
	local crumb = mkLabel(left, "", {
		Name = "Crumb", Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = 3,
		TextSize = dim("LabelSize"), RichText = true, TextColor3 = th.Colors.Muted,
	})
	local body = create("Frame", {
		Name = "Body", BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, hh),
		Size = UDim2.new(1, 0, 1, -hh),
		Parent = frame,
	})

	-- sol numarali ray (kaydirilabilir) + sayfalar
	local rw = dim("RailWidth")
	local rail = create("Frame", { Name = "Rail", BackgroundColor3 = th.Colors.Rail, BorderSizePixel = 0, Size = UDim2.new(0, rw, 1, 0), Parent = body })
	corner(rail, th.Corner) -- yalniz sol alt yuvarlak kalir: ust ve sag kenari duz dolgu seritleri
	create("Frame", { BackgroundColor3 = th.Colors.Rail, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, th.Corner), Parent = rail })
	create("Frame", { BackgroundColor3 = th.Colors.Rail, BorderSizePixel = 0, AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, th.Corner, 1, 0), Parent = rail })
	create("Frame", { Name = "RailLine", BackgroundColor3 = th.Colors.Line, BorderSizePixel = 0,
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 1, 1, 0), ZIndex = 2, Parent = rail })
	local tabBar = create("ScrollingFrame", {
		Name = "TabBar", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, -1, 1, 0),
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y, Parent = rail,
	}, {
		create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	local pages = create("Frame", { Name = "Pages", BackgroundTransparency = 1, Position = UDim2.fromOffset(rw, 0),
		Size = UDim2.new(1, -rw, 1, 0), Parent = body })

	local win = setmetatable({
		Library = self, Frame = frame, Header = header, Body = body, Scale = scale, Crumb = crumb,
		TabBar = tabBar, Pages = pages, Visible = false, Tabs = {}, BaseScale = 1, _frameStroke = frameStroke,
	}, WindowMT)
	self.Window = win

	makeDraggable(header, frame, nil, "window")

	-- baslik: kucult dugmesi (cizgi glifi, Gotham'da eksi isareti olmayabilir)
	local minBtn = create("Frame", {
		Name = "Minimize", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0),
		Size = UDim2.new(0, hbw, 1, -1), ZIndex = 2, Parent = header,
	})
	local dash = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(12, 2),
		BackgroundColor3 = th.Colors.Muted, BorderSizePixel = 0, Parent = minBtn,
	})
	onClick(minBtn, function() win:Minimize() end)
	hover(minBtn, function() dash.BackgroundColor3 = T().Colors.Text end, function() dash.BackgroundColor3 = T().Colors.Muted end)

	-- UIScale: ekrana sigdir (kompakt/telefon icin kritik; 800x360'ta ~1.0)
	local function rescale()
		if win.ClampLauncher then win.ClampLauncher() end
		local cam = workspace.CurrentCamera
		if not cam then return end
		local vp = cam.ViewportSize
		local w, h = frame.Size.X.Offset, frame.Size.Y.Offset
		if w <= 0 or h <= 0 then return end
		-- etkin olcek = otomatik sigdirma x kullanici carpani; buyutme ust cubuk + kenar payi ile ekrana sigmayla sinirli
		local auto = math.clamp(math.min(vp.X / w, vp.Y / h) * th.MobileScaleFactor, th.MobileMinScale, 1)
		local eff = auto * self.UserScale
		if eff > auto then
			local m = th.ScreenMargin
			local fit = math.min((vp.X - m * 2) / w, (vp.Y - topInset() - m * 2) / h)
			eff = math.max(auto, math.min(eff, fit))
		end
		win.BaseScale = eff
		if win.Visible and not win._animating then
			local old = scale.Scale
			scale.Scale = win.BaseScale
			if old > 0 and math.abs(win.BaseScale / old - 1) > 1e-6 then scaleScrolls(frame, win.BaseScale / old) end
		end
	end
	win.Rescale = rescale
	rescale()
	local cam = workspace.CurrentCamera
	if cam then connect(cam:GetPropertyChangedSignal("ViewportSize"), rescale) end

	-- PC keybind (Library.ToggleKeybind = bir KeyPicker ise onun degeri gecerli)
	local menuKey = resolveKey(cfg.MenuKeybind)
	connect(Services.UIS.InputBegan, function(input, processed)
		if processed or self._unloaded or self._listening then return end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		local tk = self.ToggleKeybind
		local hit
		if tk and tk.Value then hit = (input.KeyCode.Name == tk.Value) else hit = (input.KeyCode == menuKey) end
		if hit then win:Toggle("key") end
	end)

	-- kare "K" muhru: mobilde hep gorunur; PC'de pencere kucultulunce belirir. Tek bilesen.
	local mb = cfg.MobileButton
	if mb == nil then mb = "auto" end
	win.LauncherAlways = (mb == true) or (mb == "auto" and self:IsMobile())
	local ls = th.LauncherSize
	local btn
	local lpos = self._launcherPos or UDim2.fromOffset(th.LauncherPos.X, topInset() + th.LauncherPos.Y)
	if markIds then
		btn = create("ImageButton", {
			Name = "Launcher", AutoButtonColor = false, Visible = false, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 50,
			Size = UDim2.fromOffset(ls, ls), Position = lpos, Parent = gui,
		})
		local _, parts = makeBadge(btn, ls, markIds)
		win._lparts = parts
		win.LauncherScale = create("UIScale", { Parent = btn })
	elseif logoId then -- rozetin kendi cercevesi var: Accent zemin/stroke yok, SetAccent boyamaz
		btn = create("ImageButton", {
			Name = "Launcher", AutoButtonColor = false, Visible = false, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 50,
			Image = logoId, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(ls, ls), Position = lpos, Parent = gui,
		})
		win.LauncherScale = create("UIScale", { Parent = btn })
	else
		btn = create("TextButton", {
			Name = "Launcher", AutoButtonColor = false, Visible = false, Text = "K",
			FontFace = th.FontFaceBold, TextSize = th.LauncherTextSize,
			BorderSizePixel = 0, ZIndex = 50,
			Size = UDim2.fromOffset(ls, ls), Position = lpos, Parent = gui,
		})
		btn:SetAttribute("KFont", "bold")
		bind(btn, "BackgroundColor3", "Accent")
		bind(btn, "TextColor3", "AccentText")
		corner(btn, th.LauncherCorner)
		win.LauncherScale = create("UIScale", { Parent = btn })
		local lst = stroke(btn)
		bind(lst, "Color", "Seal")
		win.LauncherStroke = lst
	end
	win.ClampLauncher = function() -- ekran disina cikmasin (donme/yeniden boyut dahil)
		local vp = gui.AbsoluteSize
		if vp.X <= 0 or vp.Y <= 0 then return end
		local p = btn.Position
		btn.Position = UDim2.fromOffset(math.clamp(p.X.Offset, 0, math.max(0, vp.X - ls)), math.clamp(p.Y.Offset, topInset(), math.max(topInset(), vp.Y - ls)))
	end
	connect(gui:GetPropertyChangedSignal("AbsoluteSize"), win.ClampLauncher)
	pcall(function() connect(Services.Gui:GetPropertyChangedSignal("TopbarInset"), win.ClampLauncher) end)
	win.ClampLauncher()
	makeDraggable(btn, btn, function(moved)
		self._launcherPos = btn.Position
		if not moved then win:Toggle("launcher") end
	end, true)
	win.Launcher = btn
	self.MobileButton = btn
	win:_syncLauncher()

	if cfg.Center ~= false then frame.Position = UDim2.fromScale(0.5, 0.5) end
	if cfg.AutoShow ~= false then win:SetVisible(true) end
	return win
end

return Library

end)()
local installManagers = (function()
-- KaiUI Managers: SaveManager + ThemeManager (Linoria addon imzalari). Oyundan bagimsiz.
-- Yalniz KaiUI kamu API'sine dayanir (Toggles/Options, AddInput/AddDropdown/AddButton/AddLabel, SetAccent, SetFont).
-- Kullanim (build bunu KaiUI.lua icine gomer): Library.SaveManager / Library.ThemeManager.
-- Config bicimi eski Linoria ile birebir: <Folder>/settings/<ad>.json = { "objects": [ {type, idx, ...} ] }

return function(Library)
	local HttpService = game:GetService("HttpService")

	local function hasFiles()
		return type(isfile) == "function" and type(isfolder) == "function" and type(makefolder) == "function"
			and type(readfile) == "function" and type(writefile) == "function"
	end

	local function ensureFolder(path)
		if not isfolder(path) then makefolder(path) end
	end

	-- "a/b/c" icin ara klasorleri de olusturur
	local function ensurePath(path)
		local cur
		for part in string.gmatch(path, "[^/\\]+") do
			cur = cur and (cur .. "/" .. part) or part
			ensureFolder(cur)
		end
	end

	---------------------------------------------------------------- SaveManager
	local SaveManager = {
		Folder = "KaiHub",
		Ignore = { SaveManager_ConfigList = true, SaveManager_ConfigName = true, KaiUI_Accent = true, KaiUI_AccentColor = true, KaiUI_Font = true, KaiUI_UIScale = true },
		Library = nil,
	}

	-- tip -> { Save(idx, obj) -> kayit, Load(idx, data) }
	SaveManager.Parser = {
		Toggle = {
			Save = function(idx, obj) return { type = "Toggle", idx = idx, value = obj.Value } end,
			Load = function(idx, data)
				local o = Library.Toggles[idx]
				if o and type(data.value) == "boolean" then o:SetValue(data.value) end
			end,
		},
		Slider = {
			Save = function(idx, obj) return { type = "Slider", idx = idx, value = tostring(obj.Value) } end,
			Load = function(idx, data)
				local o = Library.Options[idx]
				local n = tonumber(data.value)
				if o and n then o:SetValue(n) end
			end,
		},
		Dropdown = {
			-- "mutli" yazim hatasi Linoria'dan aynen korunur (eski dosyalar bu anahtarla yazilmis)
			Save = function(idx, obj) return { type = "Dropdown", idx = idx, value = obj.Value, mutli = obj.Multi } end,
			Load = function(idx, data)
				local o = Library.Options[idx]
				if not o then return end
				if (o.Multi and true or false) ~= (data.mutli and true or false) then return end -- tip uyusmazligi: atla
				if o.Multi and type(data.value) ~= "table" then return end
				o:SetValue(data.value)
			end,
		},
		KeyPicker = {
			Save = function(idx, obj) return { type = "KeyPicker", idx = idx, mode = obj.Mode, key = obj.Value } end,
			Load = function(idx, data)
				local o = Library.Options[idx]
				if o and type(data.key) == "string" then o:SetValue({ data.key, data.mode }) end
			end,
		},
		ColorPicker = {
			Save = function(idx, obj) return { type = "ColorPicker", idx = idx, value = obj.Value:ToHex(), transparency = obj.Transparency or 0 } end,
			Load = function(idx, data)
				local o = Library.Options[idx]
				if not o or type(data.value) ~= "string" then return end
				local ok, c = pcall(Color3.fromHex, data.value)
				if ok then o:SetValueRGB(c, data.transparency) end
			end,
		},
		Input = {
			Save = function(idx, obj) return { type = "Input", idx = idx, text = obj.Value } end,
			Load = function(idx, data)
				local o = Library.Options[idx]
				if o and type(data.text) == "string" then o:SetValue(data.text) end
			end,
		},
	}

	function SaveManager:SetLibrary(lib) self.Library = lib end

	function SaveManager:IgnoreThemeSettings()
		-- Linoria renk secici indeksleri; yeni temada kayda girmez (ThemeManager kendi dosyasini tutar)
		self:SetIgnoreIndexes({ "BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", "ThemeManager_ThemeList", "ThemeManager_CustomThemeList", "ThemeManager_CustomThemeName", "KaiUI_Accent", "KaiUI_AccentColor", "KaiUI_Font", "KaiUI_UIScale" })
	end

	function SaveManager:SetIgnoreIndexes(list)
		for _, k in ipairs(list or {}) do self.Ignore[k] = true end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder
		if hasFiles() then pcall(ensurePath, folder .. "/settings") end
	end

	local function cleanName(name)
		if type(name) ~= "string" then return nil end
		name = name:gsub("^%s+", ""):gsub("%s+$", "")
		if name == "" or name:find("[/\\]") or name:find("..", 1, true) then return nil end
		return name
	end

	function SaveManager:_path(name)
		return self.Folder .. "/settings/" .. name .. ".json"
	end

	function SaveManager:Save(name)
		if not hasFiles() then return false, "executor has no file functions" end
		name = cleanName(name)
		if not name then return false, "invalid config name" end
		local data = { objects = {} }
		for idx, obj in pairs(Library.Toggles) do
			if not self.Ignore[idx] and self.Parser.Toggle then
				table.insert(data.objects, self.Parser.Toggle.Save(idx, obj))
			end
		end
		for idx, obj in pairs(Library.Options) do
			local p = self.Parser[obj.Type]
			if p and not self.Ignore[idx] then
				table.insert(data.objects, p.Save(idx, obj))
			end
		end
		local ok, enc = pcall(HttpService.JSONEncode, HttpService, data)
		if not ok then return false, "failed to encode data" end
		local wrote, err = pcall(function()
			ensurePath(self.Folder .. "/settings")
			writefile(self:_path(name), enc)
		end)
		if not wrote then return false, tostring(err) end
		return true
	end

	function SaveManager:Load(name)
		if not hasFiles() then return false, "executor has no file functions" end
		name = cleanName(name)
		if not name then return false, "invalid config name" end
		local path = self:_path(name)
		if not isfile(path) then return false, "invalid file" end
		local ok, decoded = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
		if not ok or type(decoded) ~= "table" or type(decoded.objects) ~= "table" then return false, "decode error" end
		for _, opt in ipairs(decoded.objects) do
			if type(opt) == "table" and type(opt.idx) == "string" and not self.Ignore[opt.idx] then
				local p = self.Parser[opt.type]
				if p then
					-- bilinmeyen idx / tip uyusmazligi sessizce atlanir
					task.spawn(function() pcall(p.Load, opt.idx, opt) end)
				end
			end
		end
		return true
	end

	function SaveManager:RefreshConfigList()
		local out = {}
		if not hasFiles() then return out end
		pcall(function()
			local dir = self.Folder .. "/settings"
			if not isfolder(dir) or type(listfiles) ~= "function" then return end
			for _, file in ipairs(listfiles(dir)) do
				local name = tostring(file):match("([^/\\]+)%.json$")
				if name then table.insert(out, name) end
			end
		end)
		return out
	end

	function SaveManager:GetAutoloadConfig()
		if not hasFiles() then return "none" end
		local path = self.Folder .. "/settings/autoload.txt"
		local ok, name = pcall(function() return isfile(path) and readfile(path) or nil end)
		if ok and type(name) == "string" and name ~= "" then return name end
		return "none"
	end

	function SaveManager:LoadAutoloadConfig()
		local name = self:GetAutoloadConfig()
		if name == "none" then return end
		local ok, err = self:Load(name)
		if not ok then
			pcall(Library.Notify, Library, "Failed to load autoload config: " .. tostring(err), 4, "error")
		end
	end

	function SaveManager:BuildConfigSection(tab)
		assert(self.Library, "Must set SaveManager.Library")
		local section = tab:AddRightGroupbox("Configuration")
		section:AddInput("SaveManager_ConfigName", { Text = "Config name", Default = "", Placeholder = "name" })
		section:AddDropdown("SaveManager_ConfigList", { Text = "Config list", Values = self:RefreshConfigList(), AllowNull = true })
		section:AddDivider()

		local function selected() return Library.Options.SaveManager_ConfigList.Value end
		local function notify(text, kind) pcall(Library.Notify, Library, text, 4, kind) end

		section:AddButton({ Text = "Create config", Func = function()
			local name = cleanName(Library.Options.SaveManager_ConfigName.Value)
			if not name then return notify("Invalid config name (empty or contains a slash)", "error") end
			local ok, err = self:Save(name)
			if not ok then return notify("Failed to create config: " .. tostring(err), "error") end
			notify("Created config " .. name)
			local list = Library.Options.SaveManager_ConfigList
			list.Values = self:RefreshConfigList()
			list:SetValues()
			list:SetValue(nil)
		end }):AddButton({ Text = "Load config", Func = function()
			local name = selected()
			if not name then return notify("Select a config first", "error") end
			local ok, err = self:Load(name)
			if not ok then return notify("Failed to load config: " .. tostring(err), "error") end
			notify("Loaded config " .. name)
		end })

		section:AddButton({ Text = "Overwrite config", Func = function()
			local name = selected()
			if not name then return notify("Select a config first", "error") end
			local ok, err = self:Save(name)
			if not ok then return notify("Failed to overwrite config: " .. tostring(err), "error") end
			notify("Overwrote config " .. name)
		end }):AddButton({ Text = "Refresh list", Func = function()
			local list = Library.Options.SaveManager_ConfigList
			list.Values = self:RefreshConfigList()
			list:SetValues()
			list:SetValue(nil)
		end })

		local autoLabel = section:AddLabel("Current autoload config: " .. self:GetAutoloadConfig(), true)
		section:AddButton({ Text = "Set as autoload", Func = function()
			local name = selected()
			if not name then return notify("Select a config first", "error") end
			local ok, err = pcall(function()
				ensurePath(self.Folder .. "/settings")
				writefile(self.Folder .. "/settings/autoload.txt", name)
			end)
			if not ok then return notify("Failed to set autoload: " .. tostring(err), "error") end
			autoLabel:SetText("Current autoload config: " .. name)
			notify("Set " .. name .. " as autoload")
		end })

		self:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
		self:LoadAutoloadConfig()
	end

	---------------------------------------------------------------- ThemeManager
	local ThemeManager = {
		Folder = "KaiHub",
		Library = nil,
		Accents = { "Turquoise", "Purple", "Emerald", "Crimson" }, -- Library:SetAccent adlari; ilki varsayilan
		Pref = { accent = "Turquoise", color = nil, font = nil, scale = nil },
	}

	function ThemeManager:SetLibrary(lib) self.Library = lib end

	function ThemeManager:SetFolder(folder)
		self.Folder = folder
	end

	-- tercih dosyasi tum oyunlarda ortaktir: <Folder>/kaiui-theme.json (Folder = "KaiHub")
	function ThemeManager:_file() return self.Folder .. "/kaiui-theme.json" end

	function ThemeManager:LoadPreference()
		if not hasFiles() then return end
		pcall(function()
			local path = self:_file()
			if not isfile(path) then return end
			local d = HttpService:JSONDecode(readfile(path))
			if type(d) ~= "table" then return end
			local legacy = { Turkuaz = "Turquoise", Mor = "Purple", Zumrut = "Emerald", Kizil = "Crimson" }
			local a = type(d.accent) == "string" and (legacy[d.accent] or d.accent)
			if a and (a == "Custom" or table.find(self.Accents, a)) then self.Pref.accent = a end
			if type(d.scale) == "number" and d.scale >= 70 and d.scale <= 130 then self.Pref.scale = d.scale end
			if type(d.color) == "string" and string.match(d.color, "^%x%x%x%x%x%x$") then self.Pref.color = d.color end
			if type(d.font) == "string" and table.find(Library:GetFontNames(), d.font) then self.Pref.font = d.font end -- kaldirilmis font: Gotham
		end)
	end

	function ThemeManager:SavePreference()
		if not hasFiles() then return end
		pcall(function()
			ensurePath(self.Folder)
			writefile(self:_file(), HttpService:JSONEncode({ accent = self.Pref.accent, color = self.Pref.color, font = self.Pref.font, scale = self.Pref.scale }))
		end)
	end

	function ThemeManager:Apply()
		if self.Pref.accent == "Custom" and self.Pref.color and type(Library.SetAccentColor) == "function" then
			local ok, c = pcall(Color3.fromHex, self.Pref.color)
			if ok then pcall(Library.SetAccentColor, Library, c) end
		elseif type(Library.SetAccent) == "function" then
			pcall(Library.SetAccent, Library, self.Pref.accent)
		end
		if self.Pref.scale and type(Library.SetUIScale) == "function" then pcall(Library.SetUIScale, Library, self.Pref.scale / 100) end
		if self.Pref.font and type(Library.SetFont) == "function" then pcall(Library.SetFont, Library, self.Pref.font) end
	end

	function ThemeManager:ApplyToTab(tab)
		assert(self.Library, "Must set ThemeManager.Library")
		self:LoadPreference()
		self:Apply()

		local box = tab:AddLeftGroupbox("Theme")
		local fonts = type(Library.GetFontNames) == "function" and Library:GetFontNames() or {}
		local loading = true -- OnChanged kurulurken hemen cagrilir: o turda dosyaya yazma

		local function presetColor(name)
			local t = Library.Theme and Library.Theme.Accents and Library.Theme.Accents[name]
			return t and t.Accent or Color3.fromRGB(54, 196, 180)
		end
		local startColor = presetColor(self.Pref.accent)
		if self.Pref.accent == "Custom" and self.Pref.color then
			local ok, c = pcall(Color3.fromHex, self.Pref.color)
			if ok then startColor = c end
		end
		local function showCustom()
			local d = Library.Options.KaiUI_Accent
			d.Value = "Custom"
			d:_display()
		end
		local syncing = false -- program tarafindan degistirirken dongu olmasin
		local lastHex = startColor:ToHex() -- secicinin bilinen rengi: ayni renkle gelen cagrilar (OnChanged sarmalayicilari) kullanici sayilmaz

		box:AddDropdown("KaiUI_Accent", { Text = "Accent", Values = self.Accents,
			Default = table.find(self.Accents, self.Pref.accent) }) -- Custom iken bos; asagida "Custom" gosterilir
		box:AddLabel("Custom color"):AddColorPicker("KaiUI_AccentColor", { Default = startColor })
		if self.Pref.accent == "Custom" then showCustom() end
		Library.Options.KaiUI_Accent:OnChanged(function()
			local v = Library.Options.KaiUI_Accent.Value
			if loading or syncing or not v or v == self.Pref.accent then return end
			self.Pref.accent = v
			syncing = true -- secici hazir vurgunun rengine gecer, Custom'a dusurmez
			Library.Options.KaiUI_AccentColor:SetValue(presetColor(v))
			lastHex = presetColor(v):ToHex()
			syncing = false
			self:Apply()
			self:SavePreference()
		end)
		local saveTok = 0
		Library.Options.KaiUI_AccentColor:OnChanged(function()
			local hex = Library.Options.KaiUI_AccentColor.Value:ToHex()
			if loading or syncing or hex == lastHex then return end -- yalniz gercek renk degisimi (kullanici) Custom'a gecirir
			lastHex = hex
			self.Pref.accent = "Custom"
			self.Pref.color = hex
			showCustom() -- listede olmayan "Custom" yalniz metin olarak gosterilir
			self:Apply()
			saveTok += 1 -- surukleme sirasinda dosyaya her harekette yazma
			local my = saveTok
			task.delay(0.5, function() if my == saveTok then self:SavePreference() end end)
		end)

		box:AddSlider("KaiUI_UIScale", { Text = "UI Scale", Min = 70, Max = 130, Default = self.Pref.scale or 100, Rounding = 0, Suffix = "%", Finished = true,
			Live = function(v) Library:SetUIScaleLive(v / 100, Library.Options.KaiUI_UIScale) end }) -- surukleme: pencere canli olceklenir, knob parmak altinda kalir
		local lastScale = Library.Options.KaiUI_UIScale.Value
		Library.Options.KaiUI_UIScale:OnChanged(function()
			local v = Library.Options.KaiUI_UIScale.Value
			if loading or v == lastScale then return end -- yukleme / sarmalayici cagrilari dosyaya yazmaz
			lastScale = v
			self.Pref.scale = v
			self:Apply()
			self:SavePreference()
		end)

		if #fonts > 0 then
			box:AddDropdown("KaiUI_Font", { Text = "Font", Values = fonts,
				Default = table.find(fonts, self.Pref.font or (Library.Theme and Library.Theme.FontName) or "") or 1 })
			Library.Options.KaiUI_Font:OnChanged(function()
				local v = Library.Options.KaiUI_Font.Value
				if loading or not v or v == self.Pref.font then return end
				self.Pref.font = v
				self:Apply()
				self:SavePreference()
			end)
		end
		loading = false
	end

	Library.SaveManager = SaveManager
	Library.ThemeManager = ThemeManager
	return Library
end

end)()
installManagers(Library)
return Library
