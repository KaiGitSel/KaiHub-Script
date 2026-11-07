-- KaiUI v2 (uretildi: build.mjs). Elle duzenleme.
local Library = (function()
-- KaiUI: Linoria uyumlu API, varsayilan "Sakura Gecesi" gorunum (Turkuaz/Altin on ayarlari var). Oyuna ozgu hicbir sey icermez (ortak hub kutuphanesi).
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
		-- Vurgu on ayarlari (Library:SetAccent). Asagidaki do-blogu Sakura (varsayilan), Turquoise ve Gold'u TASARIM bolum 7
		-- paletinden tam (notr + vurgu) kurar; Purple/Emerald/Crimson eski notrleri korur. Yeni tokenlar: Line2, Ok, Glow, Accent2.
		Accents = {
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
		AccentName = "Sakura",
		-- Font: tek kaynak FontFace / FontFaceBold (Library:SetFont(ad) ile degisir, canli yeniden uygular).
		FontName = "Gotham",
		Fonts = { -- Roblox yerlesik aileleri
			{ Name = "Gotham", Path = "rbxasset://fonts/families/GothamSSm.json" },
			{ Name = "BuilderSans", Path = "rbxasset://fonts/families/BuilderSans.json" },
			{ Name = "Roboto", Path = "rbxasset://fonts/families/Roboto.json" },
			{ Name = "Inconsolata (mono)", Path = "rbxasset://fonts/families/Inconsolata.json" },
		},
		-- yazi boyutlari
		TextSize = 12,
		ValueSize = 12,
		LabelSize = 12,
		SmallSize = 11,
		GroupTitleSize = 12,
		TitleSize = 16,
		TabSize = 12,
		TabNumSize = 11,
		ButtonSize = 12,
		KeySize = 11,
		SealTextSize = 13,
		ArrowGlyph = "v",
		-- yuzey / cizgi
		Corner = 10, -- pencere
		CornerCard = 7,
		CornerField = 5,
		CornerSmall = 5,
		StrokeThickness = 1,
		Padding = 10, -- groupbox ic bosluk
		Gap = 6, -- groupbox ici oge araligi
		ColumnGap = 12,
		PagePad = 12,
		ScrollBar = 4,
		ClickSlop = 8,
		ScreenMargin = 6,
		-- pencere / ray / baslik
		WindowSize = Vector2.new(720, 650),
		CompactWindowSize = Vector2.new(560, 336),
		CompactBelow = 500, -- viewport kisa kenari bunun altindaysa kompakt kip
		HeaderHeight = 90, -- ust satir (logo + orta + sag); PC'de altina arama satiri (HeaderSearchRow) eklenir
		HeaderSearchRow = 30,
		WindowStrokeAlpha = 0.66, -- pencere konturu: Accent, 1px
		HeaderLineAlpha = 0.82, -- baslik alt cizgisi / alan konturlari: Accent
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
		RailWidth = 148,
		TabHeight = 27,
		TabPadX = 8, -- ray ogesi ic bosluk
		TabIconSize = 13,
		TabActiveAlpha = 0.88, -- aktif ogenin Accent zemin saydamligi
		TabFade = 0.1,
		RailCorner = 8,
		RailPad = 6, -- ray ic bosluk
		CatTitleSize = 9,
		-- bilesenler
		RowHeight = 25,
		ButtonHeight = 28,
		ButtonGap = 8,
		ButtonCorner = 6, BtnHoverMix = 0.08, BtnPressMix = 0.2, -- birincil: hover +%8 parlak, basili %80
		FieldHeight = 25,
		FieldLabelHeight = 20,
		FieldPadX = 10,
		ArrowWidth = 16,
		ToggleW = 15, -- yuvarlak toggle capi
		ToggleH = 15,
		ToggleCore = 12, -- kapali: Line2 1.5px halka (ic disk Card)
		ToggleRing = 8, ToggleRingW = 2.5, -- acik: Card renkli ic halka
		SliderLabelHeight = 20,
		TrackHeight = 6,
		TrackInset = 0,
		FieldStrokeAlpha = 0.82, ListSelAlpha = 0.88, -- kutu kontur (Accent %18), acik listede secili satir (Accent %12)
		SliderEditWidth = 84, -- elle deger kutusu
		KeyHeight = 26,
		KeyPadX = 10,
		DividerHeight = 12,
		CaptionHeight = 18,
		GroupPadX = 10, GroupPadY = 8, GroupStrokeAlpha = 0.66, -- groupbox: ic bosluk, Accent kontur saydamligi
		DescSize = 10, DescLine = 1.45,
		DropdownItemHeight = 22,
		DropdownMaxItems = 6,
		ListPad = 4,
		-- kompakt (telefon / dar ekran) ezmeleri (TASARIM bolum 6): satir 36, dropdown 30, buton 32, ray 40
		Mobile = {
			HeaderHeight = 52, SealSizeLogo = 24, PickerHueHeight = 36, SwatchH = 36, SliderLabelHeight = 36, SliderEditWidth = 96, HeaderButtonWidth = 44, RailWidth = 44, TabHeight = 40, RailPad = 3, TabIconSize = 18,
			TextSize = 13, LabelSize = 13, ValueSize = 13, TitleSize = 14, GroupTitleSize = 12,
			RowHeight = 36, ButtonHeight = 36, FieldHeight = 36, DropdownItemHeight = 36, DropdownMaxItems = 5, KeyHeight = 36,
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
		NotifyBar = 3, -- sol durum cubugu
		NotifyStrokeAlpha = 0.45,
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
			Toggle = 0.12, Drop = 0.10, ToastIn = 0.2, ToastOut = 0.15,
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
do -- tam paletleri kur, secili olani Colors'a yaz (tek kaynak: Accents)
	local th = Library.Theme
	local black = Color3.new(0, 0, 0)
	local old = {} -- Purple/Emerald/Crimson icin eski notr renkler
	for k, v in pairs(th.Colors) do old[k] = v end
	local function shift(c) -- ikinci vurgu: ayni parlaklikta renk tonu kaydirilir
		local h, s, v = c:ToHSV()
		return Color3.fromHSV((h + 0.12) % 1, s, v)
	end
	for _, p in pairs(th.Accents) do -- eski 3 on ayar: notrleri ve yeni tokenlari tamamla
		for k, v in pairs(old) do if p[k] == nil then p[k] = v end end
		p.Glow = p.Seal
		p.Accent2 = shift(p.Accent)
		p.Line2 = p.Line:Lerp(p.Accent, 0.3)
		p.Ok = Color3.fromRGB(92, 214, 138)
	end
	local function pal(h) -- hex tablosu -> tam palet (AccentDim/Select/Seal turetilir)
		local p = {}
		for k, v in pairs(h) do p[k] = Color3.fromHex(v) end
		p.AccentDim = p.Accent:Lerp(black, 0.4)
		p.Select = p.Bg:Lerp(p.Accent, 0.16)
		p.Seal = p.Glow
		return p
	end
	th.Accents.Sakura = pal({
		Bg = "0D0A12", Rail = "09070D", Card = "151019", Field = "0F0B14", Popup = "120E17", Hover = "1C1523", Line = "2A2033", Line2 = "4A3459",
		Text = "F3EAF4", Muted = "B09DB7", Dim = "7C6B84", Accent = "FF7FB0", Glow = "FFB3D0", Accent2 = "B58CFF", AccentText = "2A0A18",
		Ok = "6FE0A8", Warn = "FFC15E", Error = "FF5A4A",
	})
	th.Accents.Turquoise = pal({
		Bg = "080C0E", Rail = "060A0B", Card = "0D1417", Field = "0A1012", Popup = "0A1013", Hover = "121B1E", Line = "1B2A2E", Line2 = "28444A",
		Text = "E6F2F0", Muted = "96AEAB", Dim = "62807C", Accent = "36C4B4", Glow = "7FE3D6", Accent2 = "4AA8FF", AccentText = "031D1A",
		Ok = "5CD68A", Warn = "FFB020", Error = "FF6B5E",
	})
	th.Accents.Gold = pal({
		Bg = "0E0C09", Rail = "0A0806", Card = "16120D", Field = "100D09", Popup = "120F0B", Hover = "1E1810", Line = "2E261A", Line2 = "54432A",
		Text = "F5EEDF", Muted = "B5A688", Dim = "80735B", Accent = "F2B84B", Glow = "FFD98A", Accent2 = "FF7A45", AccentText = "1E1300",
		Ok = "7FD66A", Warn = "E8D24A", Error = "FF5B5B",
	})
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

-- Ortak boyama yolu: p = tam palet ya da yalniz vurgu tokenlari { Accent, AccentText, AccentDim, Select, Hover, Seal, Glow, Accent2, ... }
function Library:_applyAccent(p, name)
	local th = T()
	th.AccentName = name
	local remap, any = {}, false -- eski renk -> yeni renk (notr tokenlar bind'siz boyandigi icin acik arayuzde esleme ile guncellenir)
	for k, v in pairs(p) do
		local o = th.Colors[k]
		local ho = o ~= nil and o:ToHex()
		if ho and o ~= v and remap[ho] == nil then remap[ho] = v; any = true end
		th.Colors[k] = v
	end
	local gui = self.ScreenGui
	if any and gui then
		local function fix(d, pr)
			local n = remap[d[pr]:ToHex()]
			if n then d[pr] = n end
		end
		for _, d in ipairs(gui:GetDescendants()) do
			if d:IsA("GuiObject") then
				fix(d, "BackgroundColor3")
				if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then fix(d, "TextColor3") end
				if d:IsA("TextBox") then fix(d, "PlaceholderColor3") end
				if d:IsA("ImageLabel") or d:IsA("ImageButton") then fix(d, "ImageColor3") end
				if d:IsA("ScrollingFrame") then fix(d, "ScrollBarImageColor3") end
			elseif d:IsA("UIStroke") then
				fix(d, "Color")
			end
		end
	end
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
		w:_header()
	end
end

-- Vurgu on ayari degistir (Sakura | Turquoise | Gold | Purple | Emerald | Crimson); acik arayuz canli yeniden boyanir.
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
		Glow = acc:Lerp(white, d.SealMix), Accent2 = Color3.fromHSV((h + 0.12) % 1, s, v),
	}, "Custom")
	return acc
end
function Library:GetAccentNames()
	local t = {}
	for k in pairs(T().Accents) do table.insert(t, k) end
	table.sort(t, function(a, b)
		if a == "Sakura" then return true end
		if b == "Sakura" then return false end
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

-- Bildirim (sag alt kose, yigin): sol 3px durum cubugu (info=Accent | ok | warn | error), Quint kayma.
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
	local c = th.Colors
	local col = (kind == "error" and c.Error) or (kind == "warn" and c.Warn) or ((kind == "ok" or kind == "success") and c.Ok) or c.Accent
	local outer = create("Frame", {
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = holder,
	})
	local card = create("CanvasGroup", {
		BackgroundColor3 = c.Card, BorderSizePixel = 0, GroupTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.fromOffset(th.NotifySlide, 0), Parent = outer,
	})
	corner(card, 8)
	local cst = stroke(card, col)
	cst.Transparency = th.NotifyStrokeAlpha
	create("Frame", {
		BackgroundColor3 = col, BorderSizePixel = 0, Size = UDim2.new(0, th.NotifyBar, 1, 0), Parent = card,
	})
	local inner = create("Frame", {
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = card,
	}, {
		create("UIPadding", {
			PaddingLeft = UDim.new(0, th.Padding + th.NotifyBar), PaddingRight = UDim.new(0, th.Padding),
			PaddingTop = UDim.new(0, th.Padding), PaddingBottom = UDim.new(0, th.Padding),
		}),
	})
	mkLabel(inner, text, {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextSize = dim("LabelSize"),
		TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top,
	})
	tween(card, th.Anim.ToastIn, { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) }, Enum.EasingStyle.Quint)
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
	local disc = on and c.Accent or (self._hover and c.Dim or c.Line2)
	local coreA = on and 1 or 0
	local ringA = on and 0 or 1
	if instant then
		self._sw.BackgroundColor3, self._core.BackgroundTransparency, self._core.BackgroundColor3 = disc, coreA, c.Card
		self._ringStroke.Transparency, self._ringStroke.Color = ringA, c.Card
	else
		local d = th.Anim.Toggle
		self._core.BackgroundColor3, self._ringStroke.Color = c.Card, c.Card
		tween(self._sw, d, { BackgroundColor3 = disc })
		tween(self._core, d, { BackgroundTransparency = coreA })
		tween(self._ringStroke, d, { Transparency = ringA })
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

-- ===== Slider: duz iz + Accent dolgu (knob yok) =====

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
	local name = self._name
	local hasName = name ~= nil and name ~= ""
	if hasName and self._meas and self._text.AbsoluteSize.X > 0 then -- tasma: once ad kirpilir (...), secim hep gorunur
		local meas = self._meas
		local function w(str) meas.Text = str; return meas.TextBounds.X end
		local sc = Library.Window and Library.Window.Scale.Scale or 1
		local avail = self._text.AbsoluteSize.X / (sc > 0 and sc or 1) - 2
		local vw = w((txt or "--") .. "  ")
		if w(name) + vw > avail then
			local lo, hi = 0, #name -- en uzun sigan onek
			while lo < hi do
				local mid = math.ceil((lo + hi) / 2)
				if w(string.sub(name, 1, mid) .. "...") + vw <= avail then lo = mid else hi = mid - 1 end
			end
			name = lo > 0 and (string.sub(name, 1, lo) .. "...") or nil
			hasName = name ~= nil
		end
	end
	local pre = hasName and string.format('<font color="#%s">%s</font>  ', c.Dim:ToHex(), esc(name)) or ""
	if txt then
		self._text.Text = pre .. string.format('<font color="#%s">%s</font>', c.Text:ToHex(), esc(txt))
	else
		self._text.Text = pre .. string.format('<font color="#%s">--</font>', c.Dim:ToHex())
	end
end
DropM._repaint = DropM._display
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
function DropM:_sync() self._fstroke.Transparency = (self._open or self._hov) and 0 or T().FieldStrokeAlpha end
function DropM:SetText(s) self._name = tostring(s); self:_display() end

-- Basis acik popup'in (list/panel) sinirlari icindeyse true. Mouse: GetMouseLocation (mutlak); dokunma: input.Position
-- hem ham hem GuiInset eklenmis haliyle denenir (inset uyumsuzluguna karsi cömert: yanlislikla kapatma olmasin).
function Library:_inPopup(input)
	local pop = self._popup
	if not pop or not pop.Parent then return false end
	local a, s = pop.AbsolutePosition - self.ScreenGui.AbsolutePosition, pop.AbsoluteSize -- ScreenGui kaymasi (CoreGui -58) dusulur
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
	local ap, as = field.AbsolutePosition - lib.ScreenGui.AbsolutePosition, field.AbsoluteSize -- ScreenGui kaymasi (CoreGui -58) dusulur
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
		Name = "List", Active = true, BackgroundColor3 = c.Rail, BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 101,
		Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(width / sc, 0), Parent = ov,
	}, { create("UIScale", { Scale = sc }) })
	corner(list, th.CornerField + 1)
	bind(stroke(list), "Color", "Accent")
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
		it.frame.BackgroundColor3 = sel and c.Accent or c.Hover
		it.frame.BackgroundTransparency = sel and th.ListSelAlpha or (it.hov and 0 or 1)
		it.label.TextColor3 = (sel or it.hov) and c.Text or c.Muted
	end
	local function refresh() for _, it in ipairs(items) do paint(it) end end
	self._refresh = refresh
	for i, val in ipairs(self.Values) do
		local frame = create("TextButton", { -- Active: girdi emilir, overlay'e ulasmaz
			Text = "", AutoButtonColor = false, Active = true,
			BorderSizePixel = 0, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, ih), LayoutOrder = i, Parent = sf,
		})
		corner(frame, th.CornerSmall)
		local it = { frame = frame, val = val, hov = false }
		it.label = mkLabel(frame, tostring(val), {
			Size = UDim2.new(1, -th.FieldPadX, 1, 0), Position = UDim2.fromOffset(th.FieldPadX / 2, 0), TextXAlignment = Enum.TextXAlignment.Center,
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
	self:_sync()
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
		pcall(self._sync, self)
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
		TextColor3 = c.Muted, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Center,
	})
	local sw = create("Frame", {
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, (rowH - th.ToggleH) / 2), Size = UDim2.fromOffset(th.ToggleW, th.ToggleH),
		BackgroundColor3 = c.Line2, BorderSizePixel = 0, Parent = row,
	})
	corner(sw, 99)
	local core = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(th.ToggleCore, th.ToggleCore),
		BackgroundColor3 = c.Card, BorderSizePixel = 0, Parent = sw,
	})
	corner(core, 99)
	local ring = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(th.ToggleRing, th.ToggleRing),
		BackgroundTransparency = 1, BorderSizePixel = 0, Parent = sw,
	})
	corner(ring, 99)
	local ringStroke = create("UIStroke", { Color = c.Card, Thickness = th.ToggleRingW, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Transparency = 1, Parent = ring })
	local obj = setmetatable({
		Type = "Toggle", Value = info.Default and true or false, Callback = info.Callback,
		_row = row, _label = lbl, _sw = sw, _core = core, _ringStroke = ringStroke, _hover = false,
	}, ToggleM)
	obj:_display(true)
	onClick(row, function() obj:SetValue(not obj.Value) end)
	hover(row, function()
		obj._hover = true
		lbl.TextColor3 = T().Colors.Text
		obj:_display(true)
	end, function()
		obj._hover = false
		lbl.TextColor3 = T().Colors.Muted
		obj:_display(true)
	end)
	attachTip(row, info.Tooltip)
	self.Library.Toggles[idx] = obj
	if Library._index then Library._index(info.Text or idx, row, self) end
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
	local areaH = Library._compact and dim("RowHeight") or dim("RowHeight") - 8 -- kompakt: iz alani >=36px dokunma hedefi
	local row = self:_row(0, { AutomaticSize = Enum.AutomaticSize.Y })
	create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = row })
	local head = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, lh), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = row })
	local val = mkLabel(head, "", { AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 6, 0, 0), Size = UDim2.new(0, 0, 0, lh),
		AutomaticSize = Enum.AutomaticSize.X, TextXAlignment = Enum.TextXAlignment.Right, TextSize = dim("ValueSize"), Mono = true, Active = true })
	create("UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), Parent = val }) -- daha buyuk dokunma hedefi
	local lbl = mkLabel(head, info.Text or idx, { Size = UDim2.new(1, -8, 0, lh), AutomaticSize = Enum.AutomaticSize.Y,
		TextColor3 = c.Muted, TextSize = dim("LabelSize"), TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top })
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
	local mn, mx = info.Min or 0, info.Max or 100
	local obj = setmetatable({
		Type = "Slider", Min = mn, Max = mx, Rounding = info.Rounding or 0, Suffix = info.Suffix or "", Callback = info.Callback,
		Value = math.clamp(info.Default or mn, mn, mx), _row = row, _label = lbl, _val = val, _bar = tr, _fill = fill, _drag = false,
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
	if Library._index then Library._index(info.Text or idx, row, self) end
	return obj
end

-- Etiket (otomatik yukseklik, sarilir) + alan: dropdown / input ortak yerlesimi. inline=true: etiket alanin icine girer (ustte satir yok).
-- Kutu: Field zemin + Accent kontur (FieldStrokeAlpha); fst'nin "sicak" hali (hover/acik/odak) tam Accent.
local function fieldRow(self, text, inline)
	local th = T()
	local fh = dim("FieldHeight")
	local row = self:_row(0, { AutomaticSize = Enum.AutomaticSize.Y })
	create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = row })
	local lbl
	if text ~= nil and not inline then
		lbl = mkLabel(row, text, { Size = UDim2.new(1, 0, 0, th.FieldLabelHeight), AutomaticSize = Enum.AutomaticSize.Y,
			TextColor3 = th.Colors.Muted, TextSize = dim("LabelSize"), TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 1 })
	end
	local field = create("Frame", {
		Size = UDim2.new(1, 0, 0, fh), LayoutOrder = 2, BackgroundColor3 = th.Colors.Field, BorderSizePixel = 0, Parent = row,
	})
	corner(field, th.CornerField)
	local fst = bind(stroke(field), "Color", "Accent")
	fst.Transparency = th.FieldStrokeAlpha
	return row, lbl, field, fst
end

function GroupM:AddDropdown(idx, info)
	info = info or {}
	local th = T()
	local c = th.Colors
	local row, _, field, fst = fieldRow(self, info.Text, true)
	local padX = th.ArrowWidth + th.FieldPadX -- simetrik: metin kutuda ortali kalir, ok sagda
	local txt = mkLabel(field, "", { Position = UDim2.fromOffset(padX, 0), Size = UDim2.new(1, -padX * 2, 1, 0),
		TextSize = dim("ValueSize"), TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, RichText = true })
	mkLabel(field, th.ArrowGlyph, {
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -th.FieldPadX / 2, 0, 0), Size = UDim2.new(0, th.ArrowWidth, 1, 0),
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
	local meas = mkLabel(field, "", { Name = "Measure", Visible = false, Size = UDim2.fromOffset(0, 0), TextSize = dim("ValueSize"), TextWrapped = false })
	local obj = setmetatable({
		Type = "Dropdown", Values = values, Value = value, Multi = multi, AllowNull = info.AllowNull and true or false,
		Callback = info.Callback, _row = row, _name = info.Text, _field = field, _fstroke = fst, _text = txt, _scroll = self.Scroll, _hov = false, _meas = meas,
	}, DropM)
	obj:_display()
	connect(txt:GetPropertyChangedSignal("AbsoluteSize"), function() obj:_display() end)
	onClick(field, function()
		if obj._open then Library._closeDrop() else obj:_openList() end
	end)
	hover(field, function() obj._hov = true; obj:_sync() end, function() obj._hov = false; obj:_sync() end)
	attachTip(row, info.Tooltip)
	self.Library.Options[idx] = obj
	if Library._index then Library._index(info.Text or idx, row, self) end
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
		fst.Transparency = 0
		lockScroll(scroll, true)
	end)
	connect(box.FocusLost, function(enter)
		fst.Transparency = T().FieldStrokeAlpha
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
	if Library._index then Library._index(info.Text or idx, row, self) end
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
	corner(btn, th.ButtonCorner)
	local lbl = mkLabel(btn, info.Text or "Button", {
		Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Bold = true,
		TextSize = th.ButtonSize, TextTruncate = Enum.TextTruncate.AtEnd,
	})
	if primary then
		bind(btn, "BackgroundColor3", "Accent")
		bind(lbl, "TextColor3", "AccentText")
	else
		btn.BackgroundTransparency = 1
		lbl.TextColor3 = th.Colors.Text
		local bst = stroke(btn)
		bind(bst, "Color", "Accent")
		bst.Transparency = th.GroupStrokeAlpha
	end
	local obj = setmetatable({ Type = "Button", Func = info.Func or info.Callback, _lbl = lbl, _row = row, _group = self }, ButtonM)
	local btns = {}
	for _, ch in ipairs(row:GetChildren()) do if ch:IsA("Frame") then table.insert(btns, ch) end end
	local n = #btns
	for _, ch in ipairs(btns) do
		ch.Size = UDim2.new(1 / n, -math.floor(th.ButtonGap * (n - 1) / n), 1, 0)
	end
	local function shade(mix, white)
		local c = T().Colors.Accent
		return c:Lerp(white and Color3.new(1, 1, 1) or Color3.new(0, 0, 0), mix)
	end
	local inside = false
	onClick(btn, function()
		if obj.Func then safe(obj.Func) end
	end, nil, function()
		if primary then btn.BackgroundColor3 = shade(T().BtnPressMix, false)
		else btn.BackgroundColor3 = T().Colors.Select; btn.BackgroundTransparency = 0 end
	end, function()
		if primary then btn.BackgroundColor3 = inside and shade(T().BtnHoverMix, true) or T().Colors.Accent
		else btn.BackgroundColor3 = T().Colors.Select; btn.BackgroundTransparency = inside and 0 or 1 end
	end)
	hover(btn, function()
		inside = true
		if primary then btn.BackgroundColor3 = shade(T().BtnHoverMix, true)
		else btn.BackgroundColor3 = T().Colors.Select; btn.BackgroundTransparency = 0 end
	end, function()
		inside = false
		if primary then btn.BackgroundColor3 = T().Colors.Accent else btn.BackgroundTransparency = 1 end
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
	local obj = self:_addButtonTo(row, info)
	if Library._index then Library._index(info.Text, row, self) end
	return obj
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
	local ap, as = sw.AbsolutePosition - lib.ScreenGui.AbsolutePosition, sw.AbsoluteSize -- ScreenGui kaymasi (CoreGui -58) dusulur (R5b ile ayni)
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
		local a, s = sv.AbsolutePosition - lib.ScreenGui.AbsolutePosition, sv.AbsoluteSize
		if s.X <= 0 or s.Y <= 0 then return end
		self:_hsv(self.Hue, math.clamp((px - a.X) / s.X, 0, 1), 1 - math.clamp((py - a.Y) / s.Y, 0, 1))
	end
	local function setHue(i)
		local px = guiPoint(i)
		local a, s = hue.AbsolutePosition - lib.ScreenGui.AbsolutePosition, hue.AbsoluteSize
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
	local obj = setmetatable({ _row = row, _scroll = self.Scroll, _lbl = mkLabel(row, text, {
		Size = UDim2.new(1, 0, 0, rowH), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
		TextYAlignment = Enum.TextYAlignment.Center, TextColor3 = th.Colors.Muted, TextSize = dim("LabelSize"),
	}) }, LabelM)
	if Library._index then Library._index(text, row, self) end
	return obj
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

function TabM:_group(scroll, name, opts)
	local th = T()
	self._n += 1
	local box = create("Frame", {
		Name = tostring(name), BackgroundColor3 = th.Colors.Card, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = self._n, Parent = scroll,
	}, {
		create("UIPadding", { PaddingTop = UDim.new(0, th.GroupPadY), PaddingBottom = UDim.new(0, th.GroupPadY),
			PaddingLeft = UDim.new(0, th.GroupPadX), PaddingRight = UDim.new(0, th.GroupPadX) }),
		create("UIListLayout", { Padding = UDim.new(0, th.Gap), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	corner(box, th.CornerCard)
	local bst = stroke(box)
	bind(bst, "Color", "Accent")
	bst.Transparency = th.GroupStrokeAlpha
	-- baslik panelin icinde: Accent GothamBold 12
	local cap = create("Frame", { Name = "Caption", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, th.CaptionHeight), LayoutOrder = -2, Parent = box })
	local ttl = mkLabel(cap, tostring(name), {
		Size = UDim2.fromScale(1, 1), Bold = true, TextSize = dim("GroupTitleSize"), TextTruncate = Enum.TextTruncate.AtEnd,
	})
	bind(ttl, "TextColor3", "Accent")
	if type(opts) == "table" and type(opts.Description) == "string" and opts.Description ~= "" then
		mkLabel(box, opts.Description, {
			Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextSize = th.DescSize, TextColor3 = th.Colors.Dim,
			TextWrapped = true, LineHeight = th.DescLine, TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = -1, Name = "Desc",
		})
	end
	local g = setmetatable({ Library = Library, Container = box, Scroll = scroll, _n = 0, Tab = self, Name = tostring(name) }, GroupM)
	if Library._index then Library._index(g.Name, box, g) end
	return g
end
function TabM:AddLeftGroupbox(name, opts) return self:_group(self.Left, name, opts) end
function TabM:AddRightGroupbox(name, opts) return self:_group(self.Right, name, opts) end

-- Ikon atlasi (assets/v2/icons.png, 26px hucre): ad -> {x, y, w, h}. Atlas Library._atlas'ta (getcustomasset id), yoksa nil.
Library.Icons = {}
do
	local grid = {
		join = { 0, 0 }, play = { 26, 0 }, place = { 52, 0 }, cards = { 78, 0 }, combat = { 104, 0 }, macro = { 130, 0 },
		dungeon = { 0, 26 }, events = { 26, 26 }, units = { 52, 26 }, summon = { 78, 26 }, shop = { 104, 26 }, utilities = { 130, 26 },
		webhook = { 0, 52 }, settings = { 26, 52 }, search = { 52, 52 }, quest = { 78, 52 }, gift = { 104, 52 }, misc = { 130, 52 },
	}
	for k, v in pairs(grid) do Library.Icons[k] = { x = v[1], y = v[2], w = 26, h = 26 } end
end

-- Ikon adini ya da tam asset yolunu ImageLabel'a uygular; ciziliyorsa true (atlas yok / ad bilinmiyorsa false -> cagiran yedek cizer).
function Library._setIcon(img, icon)
	if type(icon) ~= "string" or icon == "" then return false end
	if string.find(icon, "rbxasset", 1, true) then
		img.Image, img.ImageRectOffset, img.ImageRectSize = icon, Vector2.zero, Vector2.zero
		return true
	end
	local cell, id = Library.Icons[icon], Library._atlas
	if cell and id then
		img.Image, img.ImageRectOffset, img.ImageRectSize = id, Vector2.new(cell.x, cell.y), Vector2.new(cell.w, cell.h)
		return true
	end
	return false
end

function TabM:_paint(on)
	local th = T()
	local c, d = th.Colors, th.TabFade
	local hov = self._hover and not on
	tween(self.Button, d, { BackgroundTransparency = on and th.TabActiveAlpha or 1 })
	tween(self.BtnStroke, d, { Transparency = on and 0 or 1 })
	if self.Label then tween(self.Label, d, { TextColor3 = (on or hov) and c.Text or c.Muted }) end
	if self.IconImg then
		tween(self.IconImg, d, { ImageColor3 = on and c.Accent or c.Muted, ImageTransparency = on and 0 or (hov and 0.1 or 0.3) })
	else
		tween(self.IconText, d, { TextColor3 = on and c.Accent or c.Muted })
		tween(self.IconDot, d, { BackgroundTransparency = on and 0.7 or 1 })
	end
	self.Sep.Visible = not on and not self._last
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
	if self._frameStroke then self._frameStroke.Transparency = T().WindowStrokeAlpha end
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
	if Library.Fx then Library.Fx:setActive(v) end -- gizliyken sonsuz tween'ler durur (v2/Fx)
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
	if self._frameStroke then play(self._frameStroke, { Transparency = v and T().WindowStrokeAlpha or 1 }) end
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

function WindowMT:_header() -- baslik ortasi: secili sekmenin ikonu / adi / aciklamasi
	local t = self.Selected
	if not self.HdrName then return end
	local d = t and t.Description
	d = (type(d) == "string" and d ~= "") and d or ""
	self.HdrName.Text = t and t.Name or ""
	self.HdrDesc.Text = d
	self.HdrName.Position = UDim2.fromOffset(self._hdrNameX, d == "" and self._hdrNameY0 or self._hdrNameY1)
	if t and Library._setIcon(self.HdrIconImg, t.Icon) then
		self.HdrIconImg.Visible, self.HdrIconText.Visible = true, false
	else
		self.HdrIconImg.Visible, self.HdrIconText.Visible = false, true
		self.HdrIconText.Text = string.upper(string.sub(t and t.Name or "", 1, 1))
	end
end

-- Ray duzeni: kategori basliklari + ayirici cizgileri (kategori sonunda yok). AddTab sonunda cagrilir.
function WindowMT:_railLayout()
	local th, compact = T(), Library._compact
	local lastOf, firstKi = {}, nil
	for _, t in ipairs(self.Tabs) do
		local cur = lastOf[t._ki]
		if not cur or t._order > cur._order then lastOf[t._ki] = t end
		if not firstKi or t._ki < firstKi then firstKi = t._ki end
	end
	for _, t in ipairs(self.Tabs) do
		t._last = (lastOf[t._ki] == t)
		t:_paint(t == self.Selected)
	end
	for ki, h in pairs(self._catHdr) do
		local first = (ki == firstKi)
		if compact then
			h.Visible = not first
		else
			h.Size = UDim2.new(1, 0, 0, first and 15 or 22)
		end
	end
end

-- Kategori basligi (kompakt kipte ince cizgi); LayoutOrder = katIndex*1000
function WindowMT:_catHeader(name, ki)
	local th, compact = T(), Library._compact
	local h = create("Frame", { Name = "Cat_" .. tostring(name), BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, compact and 9 or 22), LayoutOrder = ki * 1000, Parent = self.TabBar })
	if compact then
		local ln = create("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1),
			BorderSizePixel = 0, BackgroundTransparency = th.HeaderLineAlpha, Parent = h })
		bind(ln, "BackgroundColor3", "Accent")
	else
		local spaced = string.gsub(string.upper(tostring(name)), utf8.charpattern, "%0\u{200A}\u{200A}")
		mkLabel(h, spaced, { Bold = true, TextSize = th.CatTitleSize, TextColor3 = th.Colors.Dim,
			Position = UDim2.fromOffset(6, 0), Size = UDim2.new(1, -12, 1, -3), TextYAlignment = Enum.TextYAlignment.Bottom,
			TextTruncate = Enum.TextTruncate.AtEnd })
	end
	return h
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
	self:_header()
end

function WindowMT:AddTab(name, opts)
	opts = type(opts) == "table" and opts or {}
	local th = T()
	local compact = Library._compact
	local rh = dim("TabHeight")
	local n = #self.Tabs + 1
	-- kategori: opts'suz = basliksiz ilk grup (0); digerleri ilk gorulme sirasina gore 1..k. Sira = katIndex*1000 + n
	local ki, cat = 0, opts.Category
	if type(cat) == "string" and cat ~= "" then
		ki = self._catIdx[cat]
		if not ki then
			ki = #self._catList + 1
			self._catIdx[cat], self._catList[ki] = ki, cat
			self._catHdr[ki] = self:_catHeader(cat, ki)
		end
	end
	local order = ki * 1000 + n
	local btn = create("Frame", {
		Name = tostring(name), BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, rh), LayoutOrder = order, Parent = self.TabBar,
	})
	bind(btn, "BackgroundColor3", "Accent")
	corner(btn, 5)
	local bst = create("UIStroke", { Thickness = 1, Transparency = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = btn })
	bind(bst, "Color", "Accent")
	local sep = create("Frame", { Name = "Sep", BorderSizePixel = 0, BackgroundTransparency = th.HeaderLineAlpha,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), Parent = btn })
	bind(sep, "BackgroundColor3", "Accent")
	-- ikon: atlas hucresi; yoksa ad bas harfi kucuk dairede
	local isz = th.TabIconSize
	local iconImg, iconText, iconDot
	local ipos = compact and UDim2.fromScale(0.5, 0.5) or UDim2.new(0, th.TabPadX + isz / 2, 0.5, 0)
	local probe = create("ImageLabel", { BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = ipos, Size = UDim2.fromOffset(isz, isz), Parent = btn })
	if Library._setIcon(probe, opts.Icon) then
		iconImg = probe
	else
		probe:Destroy()
		local dsz = isz + 3
		iconDot = create("Frame", { Name = "IconDot", BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = ipos, Size = UDim2.fromOffset(dsz, dsz), Parent = btn })
		corner(iconDot, dsz)
		bind(iconDot, "BackgroundColor3", "Accent")
		stroke(iconDot, th.Colors.Line2)
		iconText = mkLabel(iconDot, string.upper(string.sub(tostring(name), 1, 1)), { Bold = true, TextSize = math.max(8, isz - 5),
			Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = th.Colors.Muted })
	end
	local lbl
	if not compact then
		local lx = th.TabPadX + isz + 8
		lbl = mkLabel(btn, name, {
			Position = UDim2.fromOffset(lx, 0), Size = UDim2.new(1, -(lx + 6), 1, 0), TextSize = dim("TabSize"),
			TextColor3 = th.Colors.Muted, TextTruncate = Enum.TextTruncate.AtEnd,
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
		Name = tostring(name), Description = opts.Description, Category = (ki > 0) and cat or nil, Icon = opts.Icon, IsSettings = opts.Settings, Window = self, Button = btn, BtnStroke = bst, Sep = sep,
			IconImg = iconImg, IconText = iconText, IconDot = iconDot, Label = lbl, Page = page, _n = 0, _ki = ki, _order = order,
		Left = column(0, 0), Right = column(0.5, th.ColumnGap / 2),
	}, TabM)
	table.insert(self.Tabs, tab)
	self:_railLayout()
	onClick(btn, function() self:SelectTab(tab) end)
	hover(btn, function() tab._hover = true; if self.Selected ~= tab then tab:_paint(false) end end,
		function() tab._hover = false; if self.Selected ~= tab then tab:_paint(false) end end)
	if #self.Tabs == 1 then self:SelectTab(tab) end
	if Library._index then Library._index(tab.Name, btn, nil, tab) end
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
	bind(frameStroke, "Color", "Accent")
	frameStroke.Transparency = th.WindowStrokeAlpha
	local scale = create("UIScale", { Parent = frame })

	-- baslik: ust satir (logo yuvasi | ikon+sayfa adi+aciklama+surum | yuvarlak dugmeler+avatar) + PC'de alt arama hapi.
	-- Logo simdilik metin yedegi (PermanentMarker, katmanli parilti); asset/hale/doku R4'te.
	local hh = dim("HeaderHeight")
	local sr = compact and 0 or th.HeaderSearchRow
	local hTotal = hh + sr
	local brand, game_ = tostring(cfg.Title or "KaiHub"), cfg.Game
	do
		local l, r = string.match(brand, "^(.-)%s*|%s*(.-)%s*$")
		if l and l ~= "" then
			brand = l
			if (game_ == nil or game_ == "") and r ~= "" then game_ = r end
		end
	end
	game_ = (game_ ~= nil and game_ ~= "") and tostring(game_) or nil
	local header = create("Frame", {
		Name = "Header", BackgroundColor3 = th.Colors.Bg, BorderSizePixel = 0, ClipsDescendants = true,
		Size = UDim2.new(1, 0, 0, hTotal), Parent = frame,
	})
	corner(header, th.Corner) -- ust koseler pencereyle ayni yaricap
	create("Frame", { -- alt yariyi duzlestir (ust yuvarlak, alt duz)
		BackgroundColor3 = th.Colors.Bg, BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0.5, 0), Parent = header,
	})
	local row = create("Frame", { Name = "Row", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, hh), Parent = header })
	local hline = create("Frame", { -- baslik alt cizgisi
		Name = "HeaderLine", BorderSizePixel = 0, BackgroundTransparency = th.HeaderLineAlpha, ZIndex = 3,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), Parent = header,
	})
	bind(hline, "BackgroundColor3", "Accent")

	-- logo yuvasi (200x86, kirpmaz): icerigi src/v2/HeaderArt.luau cizer (wordmark + hale + doku, asset yoksa metin yedegi)
	local logoW = compact and 112 or 200
	local logo = create("Frame", { Name = "Logo", BackgroundTransparency = 1, ClipsDescendants = false,
		Position = UDim2.fromOffset(0, compact and 0 or 2), Size = UDim2.fromOffset(logoW, compact and hh or hh - 4), Parent = row })
	if Library._headerArt then
		Library._headerArt({ header = header, row = row, logo = logo, compact = compact, brand = brand, game = game_, cfg = cfg, hh = hh, logoW = logoW })
	end

	-- yuvarlak dugme: glif cizilir (font sembolune bagli degil), hover'da Accent
	local function roundBtn(parent, order, size, drawGlyph, fn)
		local b = create("Frame", { BackgroundColor3 = th.Colors.Field, BorderSizePixel = 0, Size = UDim2.fromOffset(size, size), LayoutOrder = order, Parent = parent })
		corner(b, size / 2)
		local st = stroke(b)
		bind(st, "Color", "Accent")
		local parts = drawGlyph(b)
		local function paint(on)
			local c = on and T().Colors.Accent or T().Colors.Muted
			for _, p in ipairs(parts) do p.BackgroundColor3 = c end
			st.Transparency = on and th.WindowStrokeAlpha or th.HeaderLineAlpha
		end
		paint(false)
		onClick(b, fn)
		hover(b, function() paint(true) end, function() paint(false) end)
		return b
	end
	local function bar(parent, w, h, x, y, rot)
		return create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, x or 0, 0.5, y or 0),
			Size = UDim2.fromOffset(w, h), Rotation = rot or 0, BorderSizePixel = 0, Parent = parent })
	end
	local function gearG(b)
		return { bar(b, 12, 2, 0, -4), bar(b, 12, 2, 0, 0), bar(b, 12, 2, 0, 4), bar(b, 3, 6, -3, -4), bar(b, 3, 6, 3, 0), bar(b, 3, 6, -2, 4) }
	end
	local function dashG(b) return { bar(b, 11, 2) } end
	local function crossG(b) return { bar(b, 14, 2, 0, 0, 45), bar(b, 14, 2, 0, 0, -45) } end

	local winRef -- win asagida olusur; dugme geri cagrilari onu okur
	local function goSettings()
		for _, t in ipairs(winRef.Tabs) do
			if t.IsSettings then return winRef:SelectTab(t) end
		end
		for _, t in ipairs(winRef.Tabs) do
			if string.lower(t.Name) == "settings" then return winRef:SelectTab(t) end
		end
	end
	local bs = compact and 36 or 28
	local rightW = compact and (bs * 3 + 14) or (bs * 3 + 56 + 7 * 3)
	local cluster = create("Frame", { Name = "Cluster", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.fromOffset(rightW, 56), Parent = row }, {
		create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center, HorizontalAlignment = Enum.HorizontalAlignment.Right }),
	})
	if compact then -- arama ikon dugmesi (buyutec): kutuyu src/v2/Search.luau acar
		roundBtn(cluster, 0, bs, function(b)
			local ring = create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, -2, 0.5, -2), Size = UDim2.fromOffset(12, 12), BorderSizePixel = 0, Parent = b })
			corner(ring, 6)
			create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(8, 8), BackgroundColor3 = th.Colors.Field, BorderSizePixel = 0, Parent = ring }, { create("UICorner", { CornerRadius = UDim.new(0, 4) }) })
			return { ring, bar(b, 6, 2, 5, 5, 45) }
		end, function() if winRef and winRef._searchToggle then winRef._searchToggle() end end).Name = "Search"
	end
	roundBtn(cluster, 1, bs, gearG, goSettings).Name = "Settings"
	if not compact then
		roundBtn(cluster, 2, bs, dashG, function() winRef:Minimize() end).Name = "Minimize"
	end
	roundBtn(cluster, 3, bs, crossG, function() winRef:Minimize() end).Name = "Close" -- x = launcher'a kucult (Unload degil)
	if not compact then -- 56px avatar: headshot, yuklenmezse K; yesil cevrimici noktasi
		local wrap = create("Frame", { Name = "Avatar", BackgroundTransparency = 1, Size = UDim2.fromOffset(56, 56), LayoutOrder = 4, Parent = cluster })
		local av = create("Frame", { BackgroundColor3 = th.Colors.Card, BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), Parent = wrap })
		corner(av, 12)
		local kf = create("Frame", { BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Parent = av })
		bind(kf, "BackgroundColor3", "Accent")
		local kl = mkLabel(kf, "K", { Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Black = true, TextSize = 26, TextColor3 = th.Colors.AccentText })
		bind(kl, "TextColor3", "AccentText")
		local img = create("ImageLabel", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, Parent = av })
		local ast = stroke(av)
		ast.Thickness = 2
		bind(ast, "Color", "Accent")
		local dot = create("Frame", { Name = "Online", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -3, 1, -3), Size = UDim2.fromOffset(9, 9),
			BorderSizePixel = 0, ZIndex = 3, Parent = wrap })
		corner(dot, 5)
		bind(dot, "BackgroundColor3", "Ok")
		local ds = stroke(dot, th.Colors.Bg)
		ds.Thickness = 1.5
		local lp = Services.Players.LocalPlayer
		if lp then
			pcall(function() img.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", lp.UserId) end)
			task.spawn(function()
				local t0 = os.clock()
				while img.Parent and not img.IsLoaded and os.clock() - t0 < 6 and not Library._unloaded do task.wait(0.2) end
				if not img.Parent then return end
				if img.IsLoaded then kf.Visible = false else img.Visible = false end
			end)
		else
			img.Visible = false
		end
	end

	-- orta: ikon dugmesi + sayfa adi + aciklama (+ surum hapi)
	local cx = logoW + 12
	local ctr = create("Frame", { Name = "Center", BackgroundTransparency = 1, Position = UDim2.fromOffset(cx, 0),
		Size = UDim2.new(1, -(cx + rightW + 24), 1, 0), Parent = row })
	local ver = cfg.Version
	local pill
	if ver ~= nil and tostring(ver) ~= "" and not compact then
		ver = tostring(ver)
		if string.match(ver, "^%d") then ver = "v" .. ver end
		pill = create("TextLabel", { Name = "Version", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(0, 18),
			AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = th.Colors.Field, BorderSizePixel = 0, FontFace = th.MonoFace, TextSize = 10,
			TextColor3 = th.Colors.Muted, Text = ver, Parent = ctr }, { create("UIPadding", { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9) }) })
		corner(pill, 9)
		local ps = stroke(pill)
		bind(ps, "Color", "Accent")
		ps.Transparency = th.HeaderLineAlpha
	end
	local icsz = compact and 0 or 34
	local ibtn = create("Frame", { Name = "PageIcon", BackgroundColor3 = th.Colors.Field, BorderSizePixel = 0, Visible = not compact,
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(34, 34), Parent = ctr })
	corner(ibtn, 17)
	local ist = stroke(ibtn)
	bind(ist, "Color", "Accent")
	ist.Transparency = th.WindowStrokeAlpha
	local itext = mkLabel(ibtn, "", { Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Bold = true, TextSize = 15 })
	bind(itext, "TextColor3", "Accent")
	local iimg = create("ImageLabel", { BackgroundTransparency = 1, Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(18, 18), Parent = ibtn })
	bind(iimg, "ImageColor3", "Accent")
	local nameX = icsz > 0 and icsz + 10 or 0
	local reserve = nameX + (pill and 76 or 0)
	local nameY1, nameY0 = hh / 2 - 19, hh / 2 - 10
	local pname = mkLabel(ctr, "", { Name = "PageName", Bold = true, TextSize = dim("TitleSize"), TextTruncate = Enum.TextTruncate.AtEnd,
		Position = UDim2.fromOffset(nameX, nameY1), Size = UDim2.new(1, -reserve, 0, 20) })
	local pdesc = mkLabel(ctr, "", { Name = "PageDesc", TextSize = 10, TextColor3 = th.Colors.Dim, TextTruncate = Enum.TextTruncate.AtEnd,
		Position = UDim2.fromOffset(nameX, hh / 2 + 3), Size = UDim2.new(1, -reserve, 0, 14) })

	local searchPill
	if not compact then -- alt satir: tam genislik hap arama kutusu (yazma/liste src/v2/Search.luau)
		local sch = create("Frame", { Name = "Search", BackgroundColor3 = th.Colors.Field, BorderSizePixel = 0,
			Position = UDim2.fromOffset(12, hh - 4), Size = UDim2.new(1, -24, 0, 26), Parent = header })
		corner(sch, 13)
		local ss = stroke(sch)
		bind(ss, "Color", "Accent")
		ss.Transparency = th.HeaderLineAlpha
		local mg = create("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, -1), Size = UDim2.fromOffset(9, 9), Parent = sch })
		corner(mg, 5)
		local mgs = stroke(mg, th.Colors.Dim)
		mgs.Thickness = 1.5
		create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 22, 0.5, 4), Size = UDim2.fromOffset(5, 1.5),
			Rotation = 45, BackgroundColor3 = th.Colors.Dim, BorderSizePixel = 0, Parent = sch })
		mkLabel(sch, "Search features", { Name = "Hint", Position = UDim2.fromOffset(30, 0), Size = UDim2.new(1, -90, 1, 0), TextSize = 11, TextColor3 = th.Colors.Dim })
		local kbd = create("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(40, 16), Parent = sch })
		corner(kbd, 4)
		stroke(kbd, th.Colors.Line2)
		mkLabel(kbd, "Ctrl K", { Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Mono = true, TextSize = 9, TextColor3 = th.Colors.Muted })
		searchPill = sch
	end
	local body = create("Frame", {
		Name = "Body", BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, hTotal),
		Size = UDim2.new(1, 0, 1, -hTotal),
		Parent = frame,
	})

	-- ikon atlasi (yoksa Library._atlas nil -> sekmeler bas harf dairesine duser)
	local assets = type(cfg.Assets) == "table" and cfg.Assets or {}
	local aFolder = type(assets.Folder) == "string" and assets.Folder or "KaiHub/assets/v2"
	Library._atlas = loadLogoAsset(aFolder .. "/icons.png", type(assets.Url) == "string" and (assets.Url .. "icons.png") or nil)

	-- sol ray: kabin kendisi Rail zemin + 1px soluk Accent kontur + kose 8 + ic bosluk; icinde kategorili sekme listesi
	local rw, pp = dim("RailWidth"), th.PagePad
	local rail = create("Frame", { Name = "Rail", BackgroundColor3 = th.Colors.Rail, BorderSizePixel = 0,
		Position = UDim2.fromOffset(pp, pp), Size = UDim2.new(0, rw, 1, -pp * 2), Parent = body })
	corner(rail, th.RailCorner)
	local railStroke = stroke(rail)
	bind(railStroke, "Color", "Accent")
	railStroke.Transparency = th.WindowStrokeAlpha
	local rp = th.RailPad
	local tabBar = create("ScrollingFrame", {
		Name = "TabBar", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y, Parent = rail,
	}, {
		create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
		create("UIPadding", { PaddingTop = UDim.new(0, rp), PaddingBottom = UDim.new(0, rp), PaddingLeft = UDim.new(0, rp), PaddingRight = UDim.new(0, rp) }),
	})
	local pages = create("Frame", { Name = "Pages", BackgroundTransparency = 1, Position = UDim2.fromOffset(rw + pp, 0),
		Size = UDim2.new(1, -(rw + pp), 1, 0), Parent = body })

	local win = setmetatable({
		Library = self, Frame = frame, Header = header, Body = body, Scale = scale,
		HdrName = pname, HdrDesc = pdesc, HdrIconText = itext, HdrIconImg = iimg, _hdrNameX = nameX, _hdrNameY0 = nameY0, _hdrNameY1 = nameY1,
		TabBar = tabBar, Pages = pages, Visible = false, Tabs = {}, BaseScale = 1, _frameStroke = frameStroke, _catIdx = {}, _catList = {}, _catHdr = {},
	}, WindowMT)
	self.Window = win

	makeDraggable(header, frame, nil, "window")

	winRef = win
	if Library._search then Library._search(win, { header = header, pill = searchPill, compact = compact, hh = hh }) end

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

-- v2 parcalari (src/v2/*.luau) icin yardimci sozlesmesi; gorsel etkisi yok
Library._u = {
	T = T, dim = dim, create = create, stroke = stroke, corner = corner, bind = bind,
	tween = tween, mkLabel = mkLabel, track = track, onClick = onClick, hover = hover,
	connect = connect, makeDraggable = makeDraggable, attachTip = attachTip, esc = esc,
	topInset = topInset, loadAsset = loadLogoAsset, Services = Services, Base = Base,
	class = class, GroupM = GroupM, TabM = TabM, WindowMT = WindowMT, lockScroll = lockScroll, mountGui = mountGui,
}

return Library

end)()
;(function()
-- Fx: sonsuz TweenService animasyonlari icin kayit defteri. Kare basi Lua dongusu YOK (motor tween'i).
-- Pencere gizlenince (WindowMT:SetVisible) ya da Reduce motion acilinca tween'ler Cancel edilir, nesne sabit orta degere alinir.
-- API: Library.Fx:add(tween, rest?, start?) / pauseAll() / resumeAll() / count() / clear(); Library:SetReduceMotion(b)
return function(Library, U)
	local Fx = { _list = {}, _vis = false, _n = 0 }

	local function reduced() return Library.ReduceMotion == true or U.T().ReduceMotion == true end
	local function running() return Fx._vis and not reduced() end

	-- rest: nesneyi sabit orta degere koyar (durdurulunca); start: tween baslangic degerine alir (oynatmadan once)
	function Fx:add(tw, rest, start)
		local e = { tw = tw, rest = rest, start = start, playing = false }
		table.insert(self._list, e)
		if running() then
			if start then pcall(start) end
			tw:Play()
			e.playing = true
		elseif rest then
			pcall(rest)
		end
		return tw
	end

	function Fx:_apply()
		local run = running()
		for _, e in ipairs(self._list) do
			if run and not e.playing then
				if e.start then pcall(e.start) end
				e.tw:Play()
				e.playing = true
			elseif not run and e.playing then
				e.tw:Cancel()
				e.playing = false
				if e.rest then pcall(e.rest) end
			end
		end
	end

	-- pencere gorunurlugu (core WindowMT:SetVisible cagirir)
	function Fx:setActive(v)
		self._vis = v and true or false
		self:_apply()
	end
	function Fx:pauseAll() self:setActive(false) end
	function Fx:resumeAll() self:setActive(true) end

	-- oynayan tween sayisi (test/olcum)
	function Fx:count()
		local n = 0
		for _, e in ipairs(self._list) do
			if e.playing then n += 1 end
		end
		return n
	end

	function Fx:clear()
		for _, e in ipairs(self._list) do pcall(function() e.tw:Cancel() end) end
		table.clear(self._list)
	end

	function Library:SetReduceMotion(b)
		Library.ReduceMotion = b and true or false
		Fx:_apply()
	end

	Library.Fx = Fx
	Library:OnUnload(function() Fx:clear() end)
end

end)()(Library, Library._u)
;(function()
-- HeaderArt: header B katmani (TASARIM 13). Neon wordmark + wallwash lekesi, isik halesi, seigaiha, yapraklar, kose cicegi.
-- Cekirdek CreateWindow `Library._headerArt(ctx)` cagirir; ctx = { header, row, logo, compact, brand, game, cfg, hh, logoW }.
-- Asset yoksa kod yedekleri: wordmark -> Merriweather metin + UIStroke, wash -> yuvarlak Frame+UIGradient, hale -> Frame+UIGradient, firca -> 2px Frame,
-- seigaiha/yaprak/cicek -> atlanir. Animasyon: yalniz sonsuz tween (Library.Fx), kare basi dongu yok.
return function(Library, U)
	local create, bind, corner, mkLabel, esc = U.create, U.bind, U.corner, U.mkLabel, U.esc
	local TS = U.Services.Tween
	local WORD_FILE, WASH_FILE = "logo-kaisel.png", "wallwash.png" -- asset adlari tek yerde
	local WORD_FONT = Enum.Font.Merriweather -- yedek serif
	local PULSE = TweenInfo.new(1.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)

	-- nabiz: prop a <-> b (Fx durdurunca orta deger)
	local function pulse(inst, prop, a, b)
		local tw = TS:Create(inst, PULSE, { [prop] = b })
		Library.Fx:add(tw, function() inst[prop] = (a + b) / 2 end, function() inst[prop] = a end)
	end

	function Library._headerArt(ctx)
		local th = U.T()
		local header, row, logo, compact = ctx.header, ctx.row, ctx.logo, ctx.compact
		local brand, game_, hh, logoW = ctx.brand, ctx.game, ctx.hh, ctx.logoW
		local cfg = ctx.cfg or {}
		local assets = type(cfg.Assets) == "table" and cfg.Assets or {}
		local folder = type(assets.Folder) == "string" and assets.Folder or "KaiHub/assets/v2"
		local function img(name)
			return U.loadAsset(folder .. "/" .. name, type(assets.Url) == "string" and (assets.Url .. name) or nil)
		end
		local wordId, haloId, brushId = img(WORD_FILE), img("halo.png"), img("brush.png")
		local seiId, petalId, flowerId = nil, nil, nil
		if not compact then seiId, petalId, flowerId = img("seigaiha.png"), img("petal.png"), img("flower.png") end

		-- doku katmani: header'in icinde (ClipsDescendants), Row'un altinda; arama hapi sonradan eklendigi icin ustte kalir
		local art = create("Frame", { Name = "Art", BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true,
			Size = UDim2.fromScale(1, 1), ZIndex = 1, Parent = header })
		row.ZIndex = 2

		-- logo merkezi (header koordinati): hale ve parilti buna oturur
		local cy = compact and hh / 2 or 40
		local cxLogo = compact and logoW / 2 or 108

		if seiId then -- seigaiha zemin: Accent %4, Tile 44x22
			local s = create("ImageLabel", { Name = "Seigaiha", BackgroundTransparency = 1, Image = seiId, ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(44, 22), ImageTransparency = 0.96, Size = UDim2.fromScale(1, 1), ZIndex = 1, Parent = art })
			bind(s, "ImageColor3", "Accent")
		end

		if not compact then -- hale: logonun arkasi, en altta (ZIndex Art icinde 2; seigaiha 1)
			local hs = UDim2.fromOffset(330, 170)
			local halo
			if haloId then
				halo = create("ImageLabel", { Name = "Halo", BackgroundTransparency = 1, Image = haloId, ImageTransparency = 0.7,
					AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(cxLogo, cy), Size = hs, ZIndex = 2, Parent = art })
				bind(halo, "ImageColor3", "Accent")
				pulse(halo, "ImageTransparency", 0.7, 0.86)
			else
				halo = create("Frame", { Name = "Halo", BorderSizePixel = 0, BackgroundTransparency = 0.8,
					AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(cxLogo, cy), Size = hs, ZIndex = 2, Parent = art })
				bind(halo, "BackgroundColor3", "Accent")
				corner(halo, 85)
				create("UIGradient", { Parent = halo, Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) }) })
				pulse(halo, "BackgroundTransparency", 0.78, 0.9)
			end
		end

		-- kose cicegi: cok soluk (%93 saydam)
		if flowerId then
			local f = create("ImageLabel", { Name = "Flower", BackgroundTransparency = 1, Image = flowerId, ImageTransparency = 0.93,
				AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 14, 0, -34), Size = UDim2.fromOffset(130, 130), Rotation = 14,
				ZIndex = 3, Parent = art })
			bind(f, "ImageColor3", "Accent")
		end

		-- yapraklar: 4 adet, 7 sn, rastgele gecikme. Sarmal Frame duser, ic ImageLabel salinir/doner, solarak biter.
		if petalId then
			local xs = { 0.14, 0.38, 0.62, 0.86 }
			for i, x in ipairs(xs) do
				local sz = 9 + (i % 3) * 2
				local wrap = create("Frame", { Name = "Leaf" .. i, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(x, 0, 0, -14), Size = UDim2.fromOffset(sz, sz), ZIndex = 4, Parent = art })
				local p = create("ImageLabel", { BackgroundTransparency = 1, Image = petalId, ImageTransparency = 0.4,
					AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, -9, 0.5, 0), Size = UDim2.fromScale(1, 1), Rotation = -30, Parent = wrap })
				bind(p, "ImageColor3", "Accent")
				local delay = math.random() * 5
				local fall = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, false, delay)
				local y0 = UDim2.new(x, 0, 0, -14)
				local y1 = UDim2.new(x + 0.05, 0, 1, 14)
				Library.Fx:add(TS:Create(wrap, fall, { Position = y1 }),
					function() wrap.Position = UDim2.new(x, 0, 0.5, 0) end, function() wrap.Position = y0 end)
				Library.Fx:add(TS:Create(p, TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, false, delay), { ImageTransparency = 1 }),
					function() p.ImageTransparency = 0.8 end, function() p.ImageTransparency = 0.4 end)
				Library.Fx:add(TS:Create(p, TweenInfo.new(1.8 + i * 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 0),
					{ Position = UDim2.new(0.5, 9, 0.5, 0), Rotation = 30 }),
					function() p.Position = UDim2.new(0.5, 0, 0.5, 0); p.Rotation = 0 end,
					function() p.Position = UDim2.new(0.5, -9, 0.5, 0); p.Rotation = -30 end)
			end
		end

		-- wordmark (neon) + arkasinda wallwash lekesi (D3). Logo PNG kendi egimli + glow gomulu (1008x280, oran 3.6): Rotation 0, ScaleType Fit.
		local mw, mh = compact and 110 or 176, compact and 31 or 49
		local mx, my = compact and 6 or 18, compact and (hh - 31) / 2 or 5.5
		local mcx, mcy = mx + mw / 2, my + mh / 2
		local ww, wh = mw * 1.8, mw * 1.8 / 2
		local wcy = mcy + wh * 0.08
		local washId = img(WASH_FILE)
		if washId then
			local w = create("ImageLabel", { Name = "Wash", BackgroundTransparency = 1, Image = washId, ImageTransparency = 0.7,
				AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(mcx, wcy), Size = UDim2.fromOffset(ww, wh), ZIndex = 1, Parent = logo })
			bind(w, "ImageColor3", "Accent")
			pulse(w, "ImageTransparency", 0.74, 0.62)
		else -- yedek: UIGradient'li yuvarlak leke
			local w = create("Frame", { Name = "Wash", BorderSizePixel = 0, BackgroundTransparency = 0.5,
				AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(mcx, wcy), Size = UDim2.fromOffset(ww, wh), ZIndex = 1, Parent = logo })
			bind(w, "BackgroundColor3", "Accent")
			corner(w, 999)
			create("UIGradient", { Parent = w, Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) }) })
			pulse(w, "BackgroundTransparency", 0.56, 0.44)
		end
		if wordId then
			create("ImageLabel", { Name = "Wordmark", BackgroundTransparency = 1, Image = wordId, ScaleType = Enum.ScaleType.Fit, Rotation = 0,
				AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(mcx, mcy), Size = UDim2.fromOffset(mw, mh), ZIndex = 3, Parent = logo }) -- UIStroke ImageLabel'de dikdortgen cizer: konmaz
		else -- yedek: serif metin + ince UIStroke
			local lsz = compact and 22 or 36
			local lh = lsz + 8
			local pre, post = brand, ""
			if #brand > 3 and string.lower(string.sub(brand, -3)) == "hub" then pre, post = string.sub(brand, 1, -4), string.sub(brand, -3) end
			local main = create("TextLabel", {
				Name = "Wordmark", BackgroundTransparency = 1, Font = WORD_FONT, TextSize = lsz, TextColor3 = th.Colors.Text, RichText = true,
				TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 3,
				Text = string.format('<font color="#FFD0E3">%s</font><font color="#FFFFFF">%s</font>', esc(pre), esc(post)),
				Position = UDim2.fromOffset(10, compact and (hh - lh) / 2 or 6), Size = UDim2.fromOffset(logoW - 10, lh), Rotation = -4, Parent = logo,
			})
			main:SetAttribute("KFont", "mono") -- SetFont yeniden boyamasin: serif yedek sabit kalir
			local ms = create("UIStroke", { Thickness = 1.2, Transparency = 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual, Parent = main })
			bind(ms, "Color", "Accent")
		end

		if compact then return end

		-- firca cizgisi (parlayan) + oyun adi + katakana
		local brush
		if brushId then
			brush = create("ImageLabel", { Name = "Brush", BackgroundTransparency = 1, Image = brushId, ImageTransparency = 0.15, Rotation = -3,
				Position = UDim2.fromOffset(14, 55), Size = UDim2.fromOffset(150, 9), ZIndex = 4, Parent = logo })
			bind(brush, "ImageColor3", "Accent")
			pulse(brush, "ImageTransparency", 0.3, 0.05)
		else
			brush = create("Frame", { Name = "Brush", BorderSizePixel = 0, BackgroundTransparency = 0.2,
				Position = UDim2.fromOffset(14, 56), Size = UDim2.fromOffset(150, 2), ZIndex = 4, Parent = logo })
			corner(brush, 1)
			bind(brush, "BackgroundColor3", "Accent")
		end
		local kx = 14
		if game_ then
			mkLabel(logo, game_, { Name = "Game", Position = UDim2.fromOffset(14, 65), Size = UDim2.fromOffset(104, 14), TextSize = 10,
				TextColor3 = th.Colors.Dim, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 4 })
			kx = 124
		end
		local kata = mkLabel(logo, "\227\130\171\227\130\164\227\131\143\227\131\150", { Name = "Kana", Position = UDim2.fromOffset(kx, 67), Size = UDim2.fromOffset(72, 12),
			TextSize = 9, TextTransparency = 0.35, ZIndex = 4 }) -- カイハブ
		bind(kata, "TextColor3", "Accent")
	end
end

end)()(Library, Library._u)
;(function()
-- Search: Ctrl+K ozellik arama (TASARIM 'Ctrl K arama'). Indeks = sekme adlari, groupbox basliklari, kontrol metinleri.
-- Cekirdek her Add* sonunda `Library._index(text, row, group)` cagirir (sekme: `_index(ad, btn, nil, tab)`); CreateWindow sonunda
-- `Library._search(win, { header, pill, compact, hh })`. PC: header'daki arama hapina TextBox eklenir; kompakt: buyutec dugmesi
-- (`win._searchToggle`) header uzerinde arama cubugu acar. Sonuc listesi ScreenGui'ye (pencere kirpmasinin disina) acilir.
-- Secim: SelectTab -> sutun CanvasPosition (UIScale'e bolunerek) -> 0.6 sn Accent kontur flasi (Library.SearchFlashTime).
return function(Library, U)
	local T, dim, create, stroke, corner, bind, tween, mkLabel, onClick, hover, connect, esc =
		U.T, U.dim, U.create, U.stroke, U.corner, U.bind, U.tween, U.mkLabel, U.onClick, U.hover, U.connect, U.esc
	local UIS = U.Services.UIS
	local MAX = 8
	local entries = {}
	Library.SearchFlashTime = 0.6

	local function clean(s)
		s = string.gsub(tostring(s), "<[^>]*>", "")
		s = string.gsub(s, "%s+", " ")
		return (string.gsub(s, "^ ", ""):gsub(" $", ""))
	end

	-- group yok + tab var: sekme kaydi; row == group.Container: groupbox basligi; digeri: kontrol satiri
	function Library._index(text, row, group, tab)
		if text == nil then return end
		text = clean(text)
		if text == "" then return end
		tab = tab or (group and group.Tab)
		if not tab then return end
		local kind = (group == nil) and "tab" or ((row == group.Container) and "group" or "item")
		local gname = group and group.Name or nil
		table.insert(entries, {
			text = text, lower = string.lower(text), row = row, tab = tab, group = gname, kind = kind, n = #entries + 1,
			plower = string.lower(tab.Name .. " " .. (gname or "")),
		})
	end

	local function find(q)
		q = string.lower(clean(q))
		local out = {}
		if q == "" then return out end
		for _, e in ipairs(entries) do
			if e.row == nil or e.row.Parent ~= nil then
				local s = string.find(e.lower, q, 1, true)
				local score = (s == 1 and 0) or (s and 1) or (string.find(e.plower, q, 1, true) and 2) or nil
				if score then table.insert(out, { e = e, k = score * 100000 + e.n }) end
			end
		end
		table.sort(out, function(a, b) return a.k < b.k end)
		local res = {}
		for i = 1, math.min(MAX, #out) do res[i] = out[i].e end
		return res
	end

	local function flash(target)
		if not target or not target.Parent then return end
		local made = target:FindFirstChildWhichIsA("UICorner") == nil and corner(target, 6) or nil
		local st = create("UIStroke", { Color = T().Colors.Accent, Thickness = 2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Transparency = 0, Parent = target })
		local d = Library.SearchFlashTime or 0.6
		tween(st, d, { Transparency = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		task.delay(d + 0.05, function()
			pcall(function() st:Destroy() end)
			if made then pcall(function() made:Destroy() end) end
		end)
	end

	local function reveal(e)
		local win = Library.Window
		if not win then return end
		win:SelectTab(e.tab)
		if e.kind == "tab" then return flash(e.row) end
		task.spawn(function()
			task.wait()
			task.wait() -- sayfa gorunur olunca yerlesim bir kare sonra oturur
			local row = e.row
			if not row or not row.Parent then return end
			local scroll = row:FindFirstAncestorWhichIsA("ScrollingFrame")
			if scroll then
				local sc = win.Scale.Scale
				if sc <= 0 then sc = 1 end
				-- CanvasPosition UIScale altinda EKRAN pikseli cinsinden (R7 bulgusu): tum olculer Abs* (ekran px), bolme yok
				local viewH = scroll.AbsoluteWindowSize.Y
				local y = row.AbsolutePosition.Y - scroll.AbsolutePosition.Y + scroll.CanvasPosition.Y
				local maxY = math.max(0, scroll.AbsoluteCanvasSize.Y - viewH)
				scroll.CanvasPosition = Vector2.new(0, math.clamp(y - math.max(8 * sc, viewH * 0.25 - row.AbsoluteSize.Y / 2), 0, maxY))
			end
			flash(row)
		end)
	end

	function Library._search(win, ctx)
		local th = T()
		local c = th.Colors
		local compact, header = ctx.compact, ctx.header
		local gui = Library.ScreenGui
		local host, box, hint, bar
		local list, bag, results, sel = nil, {}, {}, 0

		local function inside(g, input)
			if not g or not g.Parent then return false end
			local a, s = g.AbsolutePosition - gui.AbsolutePosition, g.AbsoluteSize
			local function hit(x, y) return x >= a.X and x <= a.X + s.X and y >= a.Y and y <= a.Y + s.Y end
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local m = UIS:GetMouseLocation()
				return hit(m.X, m.Y)
			end
			local p = input.Position
			local ok, ins = pcall(function() return U.Services.Gui:GetGuiInset() end)
			if not ok then ins = Vector2.new(0, 0) end
			return hit(p.X, p.Y) or hit(p.X + ins.X, p.Y + ins.Y)
		end

		if not compact then
			host = ctx.pill
			hint = host:FindFirstChild("Hint")
			box = create("TextBox", {
				Name = "Input", BackgroundTransparency = 1, BorderSizePixel = 0, ClearTextOnFocus = false, ClipsDescendants = true, ZIndex = 3,
				Position = UDim2.fromOffset(30, 0), Size = UDim2.new(1, -90, 1, 0), FontFace = th.FontFace, TextSize = 11,
				TextColor3 = c.Text, TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = "", Text = "", Parent = host,
			})
			onClick(host, function() box:CaptureFocus() end)
		else
			bar = create("Frame", {
				Name = "SearchBar", Visible = false, ZIndex = 20, BackgroundColor3 = c.Field, BorderSizePixel = 0,
				Position = UDim2.fromOffset(10, (ctx.hh - 34) / 2), Size = UDim2.new(1, -20, 0, 34), Parent = header,
			})
			corner(bar, 17)
			local bs = stroke(bar)
			bind(bs, "Color", "Accent")
			bs.Transparency = th.WindowStrokeAlpha
			host = bar
			box = create("TextBox", {
				Name = "Input", BackgroundTransparency = 1, BorderSizePixel = 0, ClearTextOnFocus = false, ClipsDescendants = true, ZIndex = 21,
				Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -56, 1, 0), FontFace = th.FontFace, TextSize = 13,
				TextColor3 = c.Text, TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = "Search features", PlaceholderColor3 = c.Dim,
				Text = "", Parent = bar,
			})
			local x = create("Frame", { Name = "Close", BackgroundTransparency = 1, ZIndex = 21, AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -4, 0.5, 0), Size = UDim2.fromOffset(30, 30), Parent = bar })
			for _, r in ipairs({ 45, -45 }) do
				create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(13, 2),
					Rotation = r, BackgroundColor3 = c.Muted, BorderSizePixel = 0, ZIndex = 22, Parent = x })
			end
			onClick(x, function() Library._searchClose() end)
		end

		local function dropList()
			for _, cn in ipairs(bag) do cn:Disconnect() end
			bag = {}
			if list then pcall(function() list:Destroy() end) end
			list, results, sel = nil, {}, 0
		end

		local function paintSel(rows)
			for i, r in ipairs(rows) do
				local on = (i == sel)
				r.frame.BackgroundColor3 = c.Accent
				r.frame.BackgroundTransparency = on and th.ListSelAlpha or 1
				r.label.TextColor3 = on and c.Text or c.Muted
			end
		end

		function Library._searchClose()
			dropList()
			if box then
				box.Text = ""
				if box:IsFocused() then box:ReleaseFocus() end
			end
			if bar then bar.Visible = false end
		end

		local function pick(e)
			Library._searchClose()
			reveal(e)
		end

		local function render()
			dropList()
			local q = box.Text
			if hint then hint.Visible = (q == "") end
			if clean(q) == "" or not win.Frame.Visible then return end
			results = find(q)
			local sc = win.Scale.Scale
			if sc <= 0 then sc = 1 end
			local ih = dim("DropdownItemHeight")
			local n = math.max(1, #results)
			local ap, as = host.AbsolutePosition - gui.AbsolutePosition, host.AbsoluteSize
			local vp = gui.AbsoluteSize
			local m = th.ScreenMargin
			local want = (n * ih + th.ListPad * 2) * sc
			local hs = math.min(want, math.max(vp.Y - (ap.Y + as.Y + 4 * sc) - m, ih * sc))
			local width = math.min(as.X, 460 * sc)
			local x = math.clamp(ap.X, m, math.max(m, vp.X - width - m))
			list = create("Frame", {
				Name = "SearchList", Active = true, BackgroundColor3 = c.Rail, BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 101,
				Position = UDim2.fromOffset(x, ap.Y + as.Y + 4 * sc), Size = UDim2.fromOffset(width / sc, 0), Parent = gui,
			}, { create("UIScale", { Scale = sc }) })
			corner(list, th.CornerField + 1)
			bind(stroke(list), "Color", "Accent")
			local sf = create("ScrollingFrame", {
				BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = th.ScrollBar, ScrollBarImageColor3 = c.Dim,
				ScrollingDirection = Enum.ScrollingDirection.Y, Parent = list,
			}, {
				create("UIPadding", { PaddingTop = UDim.new(0, th.ListPad), PaddingBottom = UDim.new(0, th.ListPad),
					PaddingLeft = UDim.new(0, th.ListPad), PaddingRight = UDim.new(0, th.ListPad) }),
				create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
			})
			local rows = {}
			if #results == 0 then
				mkLabel(sf, "No results", { Size = UDim2.new(1, 0, 0, ih), TextXAlignment = Enum.TextXAlignment.Center,
					TextSize = dim("LabelSize"), TextColor3 = c.Dim })
			else
				sel = 1
				local dim_ = c.Dim:ToHex()
				for i, e in ipairs(results) do
					local f = create("TextButton", { Text = "", AutoButtonColor = false, Active = true, BorderSizePixel = 0,
						BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, ih), LayoutOrder = i, Parent = sf })
					corner(f, th.CornerSmall)
					local path = (e.kind == "tab") and "" or (e.tab.Name .. " \u{203A} " .. ((e.kind == "item" and e.group) and (e.group .. " \u{203A} ") or ""))
					local name = e.text
					if #name > 56 then name = string.sub(name, 1, 55) .. "..." end
					local lab = mkLabel(f, string.format('<font color="#%s">%s</font>%s', dim_, esc(path), esc(name)), {
						Size = UDim2.new(1, -th.FieldPadX, 1, 0), Position = UDim2.fromOffset(th.FieldPadX / 2, 0), RichText = true,
						TextSize = dim("LabelSize"), TextTruncate = Enum.TextTruncate.AtEnd, TextColor3 = c.Muted,
					})
					rows[i] = { frame = f, label = lab }
					hover(f, function() sel = i; paintSel(rows) end, function() end, bag)
					onClick(f, function() pick(e) end, bag)
				end
				paintSel(rows)
			end
			list:SetAttribute("rows", #results)
			list.Size = UDim2.fromOffset(width / sc, 0)
			tween(list, th.Anim.Drop, { Size = UDim2.fromOffset(width / sc, hs / sc) })
			Library._searchRows = rows
		end

		local function open()
			if not win.Frame.Visible then return end
			if bar then bar.Visible = true end
			local before = box.Text
			box:CaptureFocus()
			task.spawn(function() -- Ctrl+K'nin 'k' harfi kutuya yazilmasin
				task.wait(); task.wait()
				if box.Text == before .. "k" or box.Text == before .. "K" then box.Text = before end
			end)
		end
		win._searchToggle = function()
			if bar and bar.Visible then Library._searchClose() else open() end
		end
		win._searchOpen = open

		connect(box:GetPropertyChangedSignal("Text"), render)
		connect(box.Focused, function() if box.Text ~= "" and not list then render() end end)
		connect(box.FocusLost, function(enter)
			if enter and results[sel] then pick(results[sel]) end
		end)
		connect(win.Frame:GetPropertyChangedSignal("Visible"), function()
			if not win.Frame.Visible then Library._searchClose() end
		end)
		connect(UIS.InputBegan, function(input, processed)
			if Library._unloaded then return end
			local kc = input.KeyCode
			if kc == Enum.KeyCode.Escape then
				if list or box:IsFocused() or (bar and bar.Visible) then Library._searchClose() end
				return
			end
			if list and box:IsFocused() and #results > 0 and (kc == Enum.KeyCode.Down or kc == Enum.KeyCode.Up) then
				sel = ((sel - 1 + (kc == Enum.KeyCode.Down and 1 or -1)) % #results) + 1
				paintSel(Library._searchRows or {})
				return
			end
			if processed then return end
			if kc == Enum.KeyCode.K and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
				open()
			end
		end)
		local sbtn = compact and header:FindFirstChild("Search", true) or nil -- buyutec dugmesi: kendi tiklamasi acip kapatir
		connect(UIS.InputBegan, function(input)
			if Library.IsPress(input) and (list or (bar and bar.Visible)) then
				if inside(list, input) or inside(host, input) or inside(sbtn, input) then return end
				Library._searchClose()
			end
		end)
	end
end

end)()(Library, Library._u)
;(function()
-- PriorityList: surukle-sirala oncelik listesi (TASARIM bolum 4 + 12). GroupM:AddPriorityList(idx, info)
-- info = { Text, Items = {..}, Default = { order = {..}, enabled = { Ad = true } }, Search = false, Height = 8, Tags = { Ad = "Ok"|"Warn"|"Error" }, Tooltip, Callback }
-- Options[idx].Value = { order = {tum ogeler, sirali}, enabled = { Ad = true } }; :SetValue(v) :SetItems(list) :SetTags(map) :Reset() :SetAll(bool) :OnChanged(fn)
-- Satir 24px (kompakt 40): sira rozeti (kapaliysa "-"), `::` tutamac, (etiket noktasi), ad, sagda mini daire toggle.
-- Surukleme yalniz tutamactan (track: mouse + touch). Surukleme sirasinda sutun + liste kaydirmasi kilitli, kenarda otomatik kaydirma.
-- OnChanged: birakinca / toggle / Reset / SetValue basina TEK tetik. Arama suzgeci aktifken surukleme kapali (siralama ancak tam listede anlamli).
return function(Library, U)
	local T, dim, create, stroke, corner, bind, tween, mkLabel, track, onClick, hover, attachTip, lockScroll =
		U.T, U.dim, U.create, U.stroke, U.corner, U.bind, U.tween, U.mkLabel, U.track, U.onClick, U.hover, U.attachTip, U.lockScroll
	local Run = U.Services.Run
	local PL = U.class()
	local GAP, PADX, PADY, MOVE_T, SCALE_UP = 3, 2, 1, 0.12, 1.03

	local function rowH() return Library._compact and 40 or 24 end
	local function copyList(t)
		local o = {}
		for i, v in ipairs(t) do o[i] = v end
		return o
	end
	local function posOf(slot) return UDim2.fromOffset(PADX, PADY + (slot - 1) * (rowH() + GAP)) end

	-- Degisim imzasi (OnChanged yalniz gercek degisimde tetiklenir)
	local function sig(self)
		local on = {}
		for _, n in ipairs(self._order) do on[#on + 1] = self._on[n] and "1" or "0" end
		return table.concat(self._order, "\0") .. "|" .. table.concat(on)
	end

	function PL:_commit()
		local en = {}
		for _, n in ipairs(self._order) do
			if self._on[n] then en[n] = true end
		end
		self.Value = { order = copyList(self._order), enabled = en }
	end

	local function paintRow(self, r, instant)
		local th = T()
		local c = th.Colors
		local on = self._on[r.name] and true or false
		local disc = on and c.Accent or (r.hov and c.Dim or c.Line2)
		local coreA, ringA = on and 1 or 0, on and 0 or 1
		r.ringStroke.Color, r.core.BackgroundColor3 = c.Field, c.Field
		if instant then
			r.sw.BackgroundColor3, r.core.BackgroundTransparency, r.ringStroke.Transparency = disc, coreA, ringA
		else
			local d = th.Anim.Toggle
			tween(r.sw, d, { BackgroundColor3 = disc })
			tween(r.core, d, { BackgroundTransparency = coreA })
			tween(r.ringStroke, d, { Transparency = ringA })
		end
		r.nameLbl.TextColor3 = on and c.Text or c.Dim
		r.badge.BackgroundColor3 = c.Accent
		r.badge.BackgroundTransparency = on and th.ListSelAlpha or 1
		r.badgeTxt.TextColor3 = on and c.Accent or c.Dim
		if r.dot then
			r.dot.BackgroundColor3 = c[r.tag] or c.Ok
			r.dot.BackgroundTransparency = on and 0 or 0.55
		end
		r.handle.TextColor3 = r.hhov and c.Accent or c.Dim
		if self._dr == nil or self._dr.name ~= r.name then r.fs.Color = c.Accent end
	end

	function PL:_paintAll(instant)
		for _, r in pairs(self._rows) do paintRow(self, r, instant) end
	end
	PL._repaint = PL._paintAll -- SetAccent canli boyama

	-- Konumlar + rozetler + suzgec. order: gecici sira (surukleme), skip: surukleneni konumlama.
	function PL:_layout(animate, skip, order)
		order = order or self._order
		local rank, slot = 0, 0
		local vis = {}
		local q = self._filter
		for _, n in ipairs(order) do
			local r = self._rows[n]
			if r then
				local on = self._on[n]
				if on then rank += 1 end
				r.badgeTxt.Text = on and tostring(rank) or "-"
				local show = (q == "") or (string.find(r.lower, q, 1, true) ~= nil)
				r.frame.Visible = show
				if show then
					slot += 1
					vis[slot] = n
					if n ~= skip and r.slot ~= slot then
						r.slot = slot
						if r.tw then r.tw:Cancel() end
						if animate then
							r.tw = tween(r.frame, MOVE_T, { Position = posOf(slot) })
						else
							r.frame.Position = posOf(slot)
						end
					end
				end
			end
		end
		self._vis = vis
		self._list.CanvasSize = UDim2.fromOffset(0, math.max(0, slot * (rowH() + GAP) - GAP + PADY * 2))
	end

	function PL:_fitHeight()
		local n = math.max(1, math.min(self.Height, #self._order))
		self._list.Size = UDim2.new(1, 0, 0, n * (rowH() + GAP) - GAP + PADY * 2)
	end

	-- ---- Surukleme -------------------------------------------------------------------------------
	function PL:_dragLine()
		local dr = self._dr
		if not dr then return end
		local pitch = dr.pitch
		local top = PADY + (dr.cur - 1) * pitch
		local y = (dr.cur > dr.from) and (top + rowH() + GAP / 2 - 1) or (top - GAP / 2 - 1)
		self._line.Position = UDim2.fromOffset(PADX, math.max(0, y))
		self._line.Visible = true
	end

	function PL:_dragStep()
		local dr = self._dr
		if not dr then return end
		local list = self._list
		local n = #self._order
		local dy = (dr.py - dr.p0 + list.CanvasPosition.Y - dr.cp0) / dr.s -- CanvasPosition: ekran pikseli (UIScale dahil)
		local y = math.clamp(dr.y0 + dy, PADY, PADY + (n - 1) * dr.pitch)
		dr.y = y
		dr.r.frame.Position = UDim2.fromOffset(PADX, y)
		local slot = math.clamp(math.floor((y - PADY) / dr.pitch + 0.5) + 1, 1, n)
		if slot ~= dr.cur then
			dr.cur = slot
			local prov = copyList(self._order)
			table.remove(prov, dr.from)
			table.insert(prov, slot, dr.name)
			self:_layout(true, dr.name, prov)
			self:_dragLine()
		end
	end

	function PL:_dragBegin(name, y)
		if self._dr or self._filter ~= "" then return false end
		local r = self._rows[name]
		local from = r and table.find(self._order, name)
		if not from then return false end
		local list = self._list
		local ab = r.frame.AbsoluteSize.Y
		local dr = {
			name = name, r = r, from = from, cur = from, pitch = rowH() + GAP, s = (ab > 0) and ab / rowH() or 1,
			y0 = PADY + (from - 1) * (rowH() + GAP), p0 = y, py = y, cp0 = list.CanvasPosition.Y,
		}
		dr.y = dr.y0
		self._dr = dr
		lockScroll(self._scroll, true)
		lockScroll(list, true)
		if r.tw then r.tw:Cancel() end
		r.slot = nil
		r.frame.ZIndex = 10
		r.us = r.us or create("UIScale", { Parent = r.frame })
		tween(r.us, 0.1, { Scale = SCALE_UP })
		r.fs.Color, r.fs.Transparency = T().Colors.Accent, 0
		self:_dragLine()
		dr.hb = Run.Heartbeat:Connect(function(dt)
			if list.Parent == nil or self._dr ~= dr then
				dr.hb:Disconnect()
				return
			end
			local vh = list.AbsoluteSize.Y / dr.s
			local vy = dr.y - list.CanvasPosition.Y / dr.s
			local edge = rowH() * 1.2
			local d = 0
			if vy < edge then
				d = -(edge - vy) / edge
			elseif vy + rowH() > vh - edge then
				d = (vy + rowH() - (vh - edge)) / edge
			end
			if d ~= 0 then
				d = math.clamp(d, -1.5, 1.5)
				local maxC = math.max(0, list.AbsoluteCanvasSize.Y - list.AbsoluteWindowSize.Y)
				local cy = math.clamp(list.CanvasPosition.Y + d * dt * 420 * dr.s, 0, maxC)
				if cy ~= list.CanvasPosition.Y then
					list.CanvasPosition = Vector2.new(0, cy)
					self:_dragStep()
				end
			end
		end)
		return true
	end

	function PL:_dragMove(y)
		local dr = self._dr
		if not dr then return end
		dr.py = y
		self:_dragStep()
	end

	function PL:_dragEnd()
		local dr = self._dr
		if not dr then return end
		self._dr = nil
		if dr.hb then dr.hb:Disconnect() end
		local r = dr.r
		local before = sig(self)
		table.remove(self._order, dr.from)
		table.insert(self._order, dr.cur, dr.name)
		self._line.Visible = false
		lockScroll(self._scroll, false)
		lockScroll(self._list, false)
		if r.frame.Parent then
			r.slot = nil -- _layout dragged satiri mevcut konumdan yerine oturtur
			self:_layout(true)
			tween(r.us, 0.1, { Scale = 1 })
			r.fs.Color, r.fs.Transparency = T().Colors.Accent, T().FieldStrokeAlpha
			task.delay(MOVE_T, function()
				if r.frame.Parent and not (self._dr and self._dr.name == r.name) then r.frame.ZIndex = 1 end
			end)
		end
		if sig(self) ~= before then
			self:_commit()
			self:_fire(self.Value)
		end
	end

	-- ---- Satir ---------------------------------------------------------------------------------------
	function PL:_makeRow(name)
		local th = T()
		local c = th.Colors
		local h = rowH()
		local compact = Library._compact
		local bag = {}
		local f = create("Frame", { Name = "Row", Size = UDim2.new(1, -(PADX * 2 + 4), 0, h), Position = posOf(1), BackgroundColor3 = c.Field, BorderSizePixel = 0, Parent = self._list })
		corner(f, th.CornerField)
		local fs = stroke(f)
		bind(fs, "Color", "Accent")
		fs.Transparency = th.FieldStrokeAlpha
		local bw = compact and 22 or 15
		local badge = create("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.fromOffset(bw, bw), BackgroundColor3 = c.Accent, BackgroundTransparency = th.ListSelAlpha, BorderSizePixel = 0, Parent = f })
		corner(badge, 99)
		local badgeTxt = mkLabel(badge, "-", { Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Mono = true, TextSize = compact and 12 or 10, TextColor3 = c.Accent })
		local hw = compact and 40 or 20
		local hx = 6 + bw + 2
		local handle = create("TextButton", {
			Name = "Handle", AutoButtonColor = false, Text = "::", FontFace = th.FontFaceBold, TextSize = 12, TextColor3 = c.Dim,
			BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(hx, 0), Size = UDim2.fromOffset(hw, h), Parent = f,
		})
		local r = { name = name, lower = string.lower(name), frame = f, fs = fs, badge = badge, badgeTxt = badgeTxt, handle = handle, bag = bag, hov = false, hhov = false }
		local tag = self._tags[name]
		local nx = hx + hw + 2
		if tag then
			r.tag = tag
			r.dot = create("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, nx, 0.5, 0), Size = UDim2.fromOffset(6, 6), BackgroundColor3 = c[tag] or c.Ok, BorderSizePixel = 0, Parent = f })
			corner(r.dot, 99)
			nx += 10
		end
		local hitW = compact and 44 or 34
		r.nameLbl = mkLabel(f, name, { Position = UDim2.fromOffset(nx, 0), Size = UDim2.new(1, -(nx + hitW), 1, 0), TextSize = dim("TextSize"), TextTruncate = Enum.TextTruncate.AtEnd })
		local hit = create("Frame", { Name = "Hit", AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, hitW, 1, 0), BackgroundTransparency = 1, Active = true, Parent = f })
		local sz = compact and 18 or 14
		r.sw = create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(sz, sz), BackgroundColor3 = c.Line2, BorderSizePixel = 0, Parent = hit })
		corner(r.sw, 99)
		r.core = create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(sz - 3, sz - 3), BackgroundColor3 = c.Field, BorderSizePixel = 0, Parent = r.sw })
		corner(r.core, 99)
		local ring = create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(sz - 7, sz - 7), BackgroundTransparency = 1, BorderSizePixel = 0, Parent = r.sw })
		corner(ring, 99)
		r.ringStroke = create("UIStroke", { Color = c.Field, Thickness = 2.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Transparency = 1, Parent = ring })
		-- toggle
		onClick(hit, function() self:_toggle(name) end, bag)
		hover(hit, function() r.hov = true; paintRow(self, r, true) end, function() r.hov = false; paintRow(self, r, true) end, bag)
		-- tutamac: surukleme
		hover(handle, function() r.hhov = true; handle.TextColor3 = T().Colors.Accent end, function() r.hhov = false; handle.TextColor3 = T().Colors.Dim end, bag)
		local on = false
		track(handle, function(i)
			on = self:_dragBegin(name, i.Position.Y)
		end, function(i)
			if on then self:_dragMove(i.Position.Y) end
		end, function()
			if on then
				on = false
				self:_dragEnd()
			end
		end, bag)
		self._rows[name] = r
		paintRow(self, r, true)
		return r
	end

	local function killRow(r)
		for _, cn in ipairs(r.bag) do pcall(function() cn:Disconnect() end) end
		pcall(function() r.frame:Destroy() end)
	end

	function PL:_toggle(name)
		self._on[name] = not self._on[name] or nil
		self:_layout(false)
		paintRow(self, self._rows[name], false)
		self:_commit()
		self:_fire(self.Value)
	end

	-- v = { order?, enabled? }: bilinmeyen adlar atilir, order'da olmayanlar mevcut sirayla sona. enabled yoksa mevcut korunur.
	function PL:_apply(v)
		if type(v) ~= "table" then return end
		local ord, seen = {}, {}
		if type(v.order) == "table" then
			for _, n in ipairs(v.order) do
				n = tostring(n)
				if self._rows[n] and not seen[n] then
					seen[n] = true
					ord[#ord + 1] = n
				end
			end
		end
		for _, n in ipairs(self._order) do
			if not seen[n] then
				seen[n] = true
				ord[#ord + 1] = n
			end
		end
		self._order = ord
		if type(v.enabled) == "table" then
			local on = {}
			for k, val in pairs(v.enabled) do
				if type(k) == "number" then
					local n = tostring(val)
					if self._rows[n] then on[n] = true end
				elseif val and self._rows[k] then
					on[k] = true
				end
			end
			self._on = on
		end
	end

	function PL:_change(fn)
		local before = sig(self)
		fn()
		self:_layout(true)
		self:_paintAll(false)
		self:_commit()
		if sig(self) ~= before then self:_fire(self.Value) end
	end

	function PL:SetValue(v)
		self:_change(function() self:_apply(v) end)
	end

	function PL:Reset()
		self:_change(function() self:_apply(self._default) end)
	end

	-- Gorunen (suzgecten gecen) tum ogeleri ac/kapat
	function PL:SetAll(state)
		self:_change(function()
			for _, n in ipairs(self._vis) do self._on[n] = state and true or nil end
		end)
	end

	function PL:SetTags(map)
		self._tags = type(map) == "table" and map or {}
		for n, r in pairs(self._rows) do
			local tag = self._tags[n]
			if tag and not r.dot then
				r.dot = create("Frame", { AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(6, 6), BorderSizePixel = 0, Parent = r.frame })
				corner(r.dot, 99)
				local x = r.nameLbl.Position.X.Offset
				r.dot.Position = UDim2.new(0, x, 0.5, 0)
				r.nameLbl.Position = UDim2.fromOffset(x + 10, 0)
				r.nameLbl.Size = UDim2.new(1, -(x + 10 + (Library._compact and 44 or 34)), 1, 0)
			end
			r.tag = tag
			if r.dot then r.dot.Visible = tag ~= nil end
			paintRow(self, r, true)
		end
	end

	-- Yeni ogeler sona, kaybolanlar cikar, sira ve acik durumu korunur
	function PL:SetItems(list)
		list = type(list) == "table" and list or {}
		local seen, add = {}, {}
		for _, n in ipairs(list) do
			n = tostring(n)
			if not seen[n] then
				seen[n] = true
				add[#add + 1] = n
			end
		end
		local before = self._order and sig(self) or nil
		for n, r in pairs(self._rows) do
			if not seen[n] then
				killRow(r)
				self._rows[n] = nil
				self._on[n] = nil
			end
		end
		local ord, kept = {}, {}
		for _, n in ipairs(self._order) do
			if seen[n] then
				kept[n] = true
				ord[#ord + 1] = n
			end
		end
		for _, n in ipairs(add) do
			if not kept[n] then
				ord[#ord + 1] = n
				self:_makeRow(n)
			end
		end
		self._order = ord
		self:_fitHeight()
		self:_layout(false)
		self:_commit()
		if before and sig(self) ~= before then self:_fire(self.Value) end
	end

	-- ---- Bilesen -----------------------------------------------------------------------------------
	local function miniBtn(parent, text, order, fn, h)
		local th = T()
		local c = th.Colors
		local b = create("TextButton", {
			AutoButtonColor = false, Text = text, FontFace = th.FontFaceBold, TextSize = 11, TextColor3 = c.Text, BackgroundColor3 = c.Field,
			BorderSizePixel = 0, Size = UDim2.fromOffset(0, h), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = order, Parent = parent,
		})
		corner(b, th.CornerField)
		create("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), Parent = b })
		local st = stroke(b)
		bind(st, "Color", "Accent")
		st.Transparency = th.GroupStrokeAlpha
		hover(b, function() b.BackgroundColor3 = T().Colors.Hover end, function() b.BackgroundColor3 = T().Colors.Field end)
		onClick(b, fn)
		return b
	end

	function U.GroupM:AddPriorityList(idx, info)
		info = info or {}
		local th = T()
		local c = th.Colors
		local compact = Library._compact
		local btnH = compact and 36 or 22
		local row = self:_row(0, { AutomaticSize = Enum.AutomaticSize.Y })
		create("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = row })
		local head = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, btnH), LayoutOrder = 1, Parent = row })
		local search = info.Search == true
		local btns = create("Frame", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(0, btnH), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Parent = head })
		create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = btns })
		local lbl = mkLabel(head, info.Text or idx, { Size = UDim2.new(1, -(search and 168 or 64), 1, 0), TextColor3 = c.Muted, TextTruncate = Enum.TextTruncate.AtEnd })
		local obj = setmetatable({
			Type = "PriorityList", Height = math.max(1, tonumber(info.Height) or 8), _row = row, _label = lbl,
			_rows = {}, _order = {}, _on = {}, _vis = {}, _filter = "", _tags = type(info.Tags) == "table" and info.Tags or {}, _scroll = self.Scroll,
		}, PL)
		if search then
			miniBtn(btns, "All on", 1, function() obj:SetAll(true) end, btnH)
			miniBtn(btns, "All off", 2, function() obj:SetAll(false) end, btnH)
		end
		miniBtn(btns, "Reset", 3, function() obj:Reset() end, btnH)
		if search then
			local fh = compact and 36 or 24
			local field = create("Frame", { BackgroundColor3 = c.Field, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, fh), LayoutOrder = 2, Parent = row })
			corner(field, th.CornerField)
			local fst = stroke(field)
			bind(fst, "Color", "Accent")
			fst.Transparency = th.FieldStrokeAlpha
			local box = create("TextBox", {
				BackgroundTransparency = 1, BorderSizePixel = 0, ClearTextOnFocus = false, ClipsDescendants = true, Position = UDim2.fromOffset(th.FieldPadX, 0),
				Size = UDim2.new(1, -th.FieldPadX * 2, 1, 0), FontFace = th.FontFace, TextSize = dim("ValueSize"), TextColor3 = c.Text, TextXAlignment = Enum.TextXAlignment.Left,
				PlaceholderText = "Search", PlaceholderColor3 = c.Dim, Text = "", Parent = field,
			})
			obj._box = box
			Library:Connect(box:GetPropertyChangedSignal("Text"), function()
				obj._filter = string.lower((string.gsub(box.Text, "^%s*(.-)%s*$", "%1")))
				obj._list.CanvasPosition = Vector2.new(0, 0)
				obj:_layout(false)
			end)
			Library:Connect(box.Focused, function() fst.Transparency = 0; lockScroll(obj._scroll, true) end)
			Library:Connect(box.FocusLost, function() fst.Transparency = T().FieldStrokeAlpha; lockScroll(obj._scroll, false) end)
		end
		local list = create("ScrollingFrame", {
			Name = "List", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 40), LayoutOrder = 3, ClipsDescendants = true,
			ScrollBarThickness = 3, ScrollBarImageColor3 = c.Accent, ScrollingDirection = Enum.ScrollingDirection.Y,
			AutomaticCanvasSize = Enum.AutomaticSize.None, CanvasSize = UDim2.new(), Parent = row,
		})
		bind(list, "ScrollBarImageColor3", "Accent")
		obj._list = list
		obj._line = create("Frame", { Name = "DropLine", Size = UDim2.new(1, -(PADX * 2 + 4), 0, 2), BackgroundColor3 = c.Accent, BorderSizePixel = 0, Visible = false, ZIndex = 12, Parent = list })
		corner(obj._line, 1)
		bind(obj._line, "BackgroundColor3", "Accent")
		local items = type(info.Items) == "table" and info.Items or {}
		obj:SetItems(items)
		local def = type(info.Default) == "table" and info.Default or {}
		obj:_apply({ order = def.order, enabled = def.enabled or {} })
		obj:_layout(false)
		obj:_paintAll(true)
		obj:_commit()
		obj._default = { order = copyList(obj._order), enabled = (function() local e = {} for n in pairs(obj._on) do e[n] = true end return e end)() }
		obj.Callback = info.Callback -- kurulum sirasinda tetiklenmesin
		if info.Tooltip then attachTip(head, info.Tooltip) end
		self.Library.Options[idx] = obj
		if Library._index then Library._index(info.Text or idx, row, self) end
		return obj
	end
end

end)()(Library, Library._u)
;(function()
-- Stats: canli mini pencere (TASARIM 5 + 13). Ana pencereden bagimsiz ayri ScreenGui, sol ust, surukleneblir (6px esik).
-- API: Library:CreateStats({ Title = "KAIHUB" }) -> Stats; Stats:Set(key, value[, color]) / Remove(key) / SetVisible(b) / Destroy()
-- Hazir satirlar FPS, Ping, Time. Olcum: tek Heartbeat sayaci + 1 sn'lik task dongusu (kare basi metin yok).
-- Kalicilik: ThemeManager.Pref (statsX/statsY/statsShow/statsOp) -> kaiui-theme.json. Kopya yok: Carti kaynagina bakilmadi.
return function(Library, U)
	local T, create, stroke, corner, bind, tween, connect, topInset =
		U.T, U.create, U.stroke, U.corner, U.bind, U.tween, U.connect, U.topInset
	local UIS, Run, TweenSvc = U.Services.UIS, U.Services.Run, U.Services.Tween
	local NetStats = game:GetService("Stats")
	local WIDTH, DRAG_PX = 176, 6
	local STATS_FONT = Font.fromEnum(Enum.Font.GothamMedium) -- okunakli sans (D1); sayilar Gotham'da sabit genislikli
	local COMPACT_KEYS = { FPS = true, Ping = true, Wave = true }

	local function pref()
		local tm = Library.ThemeManager
		return tm and tm.Pref or nil
	end
	local function savePref()
		local tm = Library.ThemeManager
		if tm and tm.SavePreference then pcall(function() tm:SavePreference() end) end
	end

	local function fmtTime(s)
		s = math.floor(s)
		local h, m = s // 3600, (s // 60) % 60
		if h > 0 then return string.format("%d:%02d:%02d", h, m, s % 60) end
		return string.format("%02d:%02d", m, s % 60)
	end

	local function readPing()
		local ok, v = pcall(function() return NetStats.Network.ServerStatsItem["Data Ping"]:GetValue() end)
		if ok and type(v) == "number" and v > 0 then return v end
		ok, v = pcall(function() return U.Services.Players.LocalPlayer:GetNetworkPing() * 2000 end)
		return (ok and type(v) == "number") and v or nil
	end

	local StatsM = {}
	StatsM.__index = StatsM

	function Library:CreateStats(cfg)
		cfg = cfg or {}
		if Library.Stats then Library.Stats:Destroy() end
		local th = T()
		local self = setmetatable({ _rows = {}, _alive = true, _api = true, _show = true, _conns = {}, _t0 = os.clock() }, StatsM)
		Library.Stats = self

		local tm = Library.ThemeManager
		if tm and not tm._prefLoaded then tm._prefLoaded = true; pcall(function() tm:LoadPreference() end) end
		local p = pref() or {}
		local compact = Library._compact or Library:IsMobile()
		local ts = compact and 12 or 13
		self._ts = ts

		local gui = create("ScreenGui", {
			Name = "KaiStats", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			IgnoreGuiInset = true, DisplayOrder = th.DisplayOrder + 1,
		})
		self._mounted = U.mountGui and U.mountGui(gui)
		if not gui.Parent then
			-- mountGui cekirdekte yerel; ayni sirayla basit yedek: ana pencerenin ebeveyni
			local host = Library.ScreenGui and Library.ScreenGui.Parent
			if host then gui.Parent = host else pcall(function() gui.Parent = U.Services.CoreGui end) end
		end
		self.Gui = gui

		local op = (p.statsOp or 94) / 100
		local f = create("Frame", {
			Name = "Stats", Size = UDim2.fromOffset(WIDTH, 0), AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1 - op, BorderSizePixel = 0, Active = true, Parent = gui,
		})
		bind(f, "BackgroundColor3", "Rail")
		corner(f, 7)
		local st = stroke(f)
		bind(st, "Color", "Accent")
		st.Thickness = 1
		st.Transparency = 0.66
		create("UIPadding", { PaddingTop = UDim.new(0, 7), PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = f })
		create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3), Parent = f })
		self.Frame = f

		-- baslik: nabiz noktasi + Title
		local head = create("Frame", { Name = "Head", Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, LayoutOrder = 0, Parent = f })
		local dot = create("Frame", { Size = UDim2.fromOffset(7, 7), Position = UDim2.new(0, 0, 0.5, -3), BackgroundColor3 = th.Colors.Ok or Color3.fromRGB(92, 214, 138), BorderSizePixel = 0, Parent = head })
		corner(dot, 4)
		self._dot = dot
		local title = create("TextLabel", {
			Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -14, 1, 0), BackgroundTransparency = 1,
			Text = string.upper(tostring(cfg.Title or "KAIHUB")), FontFace = th.FontFaceBold or Font.fromEnum(Enum.Font.GothamBold),
			TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = head,
		})
		bind(title, "TextColor3", "Accent")

		-- canli nokta: sonsuz tween (Fx pencere gizlenince / Reduce motion'da durdurur)
		local tw = TweenSvc:Create(dot, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { BackgroundTransparency = 0.7 })
		self._pulse = tw
		if Library.Fx then
			Library.Fx:add(tw, function() dot.BackgroundTransparency = 0.3 end, function() dot.BackgroundTransparency = 0 end)
		end

		-- konum: kayitli ya da (10, 10 + topInset); ekran icine sikistir
		self._defaultY = 10 + topInset()
		self:_place(p.statsX, p.statsY)

		-- surukleme (6px esik, mouse + touch)
		local dragging, startIn, startPos, dragInput, moved
		table.insert(self._conns, f.InputBegan:Connect(function(input)
			if dragging or not Library.IsPress(input) then return end
			dragging, moved, dragInput = true, false, input
			startIn, startPos = input.Position, f.AbsolutePosition
			local c
			c = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					c:Disconnect()
					if moved then
						local pr = pref()
						if pr then
							pr.statsX, pr.statsY = f.AbsolutePosition.X, f.AbsolutePosition.Y
							savePref()
						end
					end
				end
			end)
		end))
		table.insert(self._conns, UIS.InputChanged:Connect(function(input)
			if not dragging or not Library.IsMove(input) then return end
			if dragInput.UserInputType == Enum.UserInputType.Touch then
				if input ~= dragInput then return end
			elseif input.UserInputType ~= Enum.UserInputType.MouseMovement then
				return
			end
			local d = input.Position - startIn
			if not moved and Vector2.new(d.X, d.Y).Magnitude < DRAG_PX then return end
			moved = true
			self:_place(startPos.X + d.X, startPos.Y + d.Y)
		end))

		-- hazir satirlar
		self:_ensure("FPS", 1, "--")
		self:_ensure("Ping", 2, "--")
		self:_ensure("Time", 3, "00:00")
		self._rows.FPS.auto, self._rows.Ping.auto, self._rows.Time.auto = true, true, true

		-- olcum: tek Heartbeat sayaci, metin 1 sn'lik dongude
		local frames, last = 0, os.clock()
		connect(Run.Heartbeat, function() frames += 1 end)
		task.spawn(function()
			while self._alive and not Library._unloaded do
				task.wait(1)
				if not (self._alive and gui.Parent) then break end
				local now = os.clock()
				local fps = frames / math.max(now - last, 1e-3)
				frames, last = 0, now
				if gui.Enabled then
					local r = self._rows
					if r.FPS and r.FPS.auto then
						self:_write("FPS", tostring(math.floor(fps + 0.5)), fps < 25 and "Error" or (fps < 45 and "Warn" or nil))
					end
					if r.Ping and r.Ping.auto then
						local ms = readPing()
						local c = ms and (ms < 80 and "Ok" or (ms < 150 and "Warn" or "Error")) or nil
						self:_write("Ping", ms and (math.floor(ms + 0.5) .. " ms") or "--", c)
					end
					if r.Time and r.Time.auto then self:_write("Time", fmtTime(now - self._t0)) end
				end
			end
		end)

		Library:OnUnload(function() self:Destroy() end)
		self._show = p.statsShow ~= false
		self:_refresh()
		return self
	end

	-- konum EKRAN koordinatindadir (kayit da oyle): CoreGui/gethui ScreenGui'sinin AbsolutePosition'i (0,-58) olabilir,
	-- bu yuzden Position = ekran - gui.AbsolutePosition. Ust cubugun (topInset) altinda ve ekran icinde tut.
	function StatsM:_place(x, y)
		local f, g = self.Frame, self.Gui
		if not (f and g) then return end
		local ap, vp, sz = g.AbsolutePosition, g.AbsoluteSize, f.AbsoluteSize
		local top = topInset()
		x = type(x) == "number" and x or 10
		y = type(y) == "number" and y or self._defaultY
		x = math.clamp(x, ap.X, math.max(ap.X, ap.X + vp.X - math.max(sz.X, WIDTH)))
		local lo = math.max(top, ap.Y)
		y = math.clamp(y, lo, math.max(lo, ap.Y + vp.Y - math.max(sz.Y, 40)))
		f.Position = UDim2.fromOffset(x - ap.X, y - ap.Y)
	end

	function StatsM:_color(c)
		local C = T().Colors
		if typeof(c) == "Color3" then return c end
		if type(c) == "string" and C[c] then return C[c] end
		return C.Text
	end

	function StatsM:_ensure(key, order, value, color)
		local r = self._rows[key]
		if r then return r end
		local th, ts = T(), self._ts
		local row = create("Frame", { Name = key, Size = UDim2.new(1, 0, 0, self._ts + 5), BackgroundTransparency = 1, LayoutOrder = order, Parent = self.Frame })
		local lw = math.ceil(#key * ts * 0.64) + 4 -- sans etiket genisligi
		local lab = create("TextLabel", {
			Size = UDim2.new(0, lw, 1, 0), BackgroundTransparency = 1, Text = key, FontFace = STATS_FONT, TextSize = ts,
			TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = th.Colors.Muted, Parent = row,
		})
		local val = create("TextLabel", {
			Position = UDim2.fromOffset(lw + 6, 0), Size = UDim2.new(1, -(lw + 6), 1, 0), BackgroundTransparency = 1,
			Text = tostring(value), FontFace = STATS_FONT, TextSize = ts, TextXAlignment = Enum.TextXAlignment.Right,
			TextTruncate = Enum.TextTruncate.AtEnd, TextColor3 = self:_color(color), Parent = row,
		})
		r = { row = row, lab = lab, val = val, text = tostring(value), color = color }
		self._rows[key] = r
		return r
	end

	-- deger yaz: degisince Accent -> hedef renk 0.3 sn gecis
	function StatsM:_write(key, text, color)
		local r = self._rows[key]
		if not r then return end
		text = tostring(text)
		local changed = text ~= r.text
		r.text, r.color = text, color
		r.val.Text = text
		local target = self:_color(color)
		if changed and not T().ReduceMotion and not Library.ReduceMotion then
			r.val.TextColor3 = T().Colors.Accent
			tween(r.val, 0.3, { TextColor3 = target })
		else
			r.val.TextColor3 = target
		end
	end

	-- kompakt kip: yalniz FPS / Ping / Wave (Wave yoksa FPS / Ping / Time)
	function StatsM:_refresh()
		local compact = Library._compact or Library:IsMobile()
		local hasWave = self._rows.Wave ~= nil
		for key, r in pairs(self._rows) do
			r.row.Visible = (not compact) or COMPACT_KEYS[key] == true or (key == "Time" and not hasWave)
		end
		if self.Gui then self.Gui.Enabled = self._api and self._show end
	end

	function StatsM:Set(key, value, color)
		if not self._alive then return end
		key = tostring(key)
		local r = self._rows[key]
		if not r then
			r = self:_ensure(key, 10 + #self.Frame:GetChildren(), value, color)
			self:_refresh()
		end
		r.auto = false
		self:_write(key, value, color)
	end

	function StatsM:Remove(key)
		local r = self._rows[tostring(key)]
		if not r then return end
		self._rows[tostring(key)] = nil
		r.row:Destroy()
		self:_refresh()
	end

	-- oyun scripti gorunurlugu (kullanicinin Show stats tercihi ile birlikte degerlendirilir)
	function StatsM:SetVisible(b)
		self._api = b and true or false
		self:_refresh()
	end

	-- kullanici tercihi (ThemeManager): goster/gizle + saydamlik (0.3-1)
	function StatsM:SetShown(b)
		self._show = b and true or false
		self:_refresh()
	end
	function StatsM:SetOpacity(o)
		if self.Frame then self.Frame.BackgroundTransparency = 1 - math.clamp(o, 0, 1) end
	end
	function StatsM:ApplyPref(p)
		if not (p and self._alive) then return end
		self._show = p.statsShow ~= false
		self:SetOpacity((p.statsOp or 94) / 100)
		self:_place(p.statsX, p.statsY)
		self:_refresh()
	end

	function StatsM:Destroy()
		if not self._alive then return end
		self._alive = false
		for _, c in ipairs(self._conns) do pcall(function() c:Disconnect() end) end
		table.clear(self._conns)
		pcall(function() self._pulse:Cancel() end)
		if self.Gui then pcall(function() self.Gui:Destroy() end) end
		if Library.Stats == self then Library.Stats = nil end
	end
end

end)()(Library, Library._u)
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
		PriorityList = {
			-- { type, idx, order = {...}, enabled = { Ad = true } }; JSON bos tablo [] olabilir -> Load tolere eder
			Save = function(idx, obj)
				local v = obj.Value or {}
				local en = {}
				for k, on in pairs(v.enabled or {}) do if on then en[k] = true end end
				return { type = "PriorityList", idx = idx, order = v.order or {}, enabled = en }
			end,
			Load = function(idx, data)
				local o = Library.Options[idx]
				if not o or type(data.order) ~= "table" then return end
				o:SetValue({ order = data.order, enabled = type(data.enabled) == "table" and data.enabled or {} })
			end,
		},
	}

	function SaveManager:SetLibrary(lib) self.Library = lib end

	function SaveManager:IgnoreThemeSettings()
		-- Linoria renk secici indeksleri; yeni temada kayda girmez (ThemeManager kendi dosyasini tutar)
		self:SetIgnoreIndexes({ "BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", "ThemeManager_ThemeList", "ThemeManager_CustomThemeList", "ThemeManager_CustomThemeName", "KaiUI_Accent", "KaiUI_AccentColor", "KaiUI_Font", "KaiUI_UIScale", "KaiUI_ShowStats", "KaiUI_StatsOpacity" })
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
		Accents = { "Sakura", "Turquoise", "Gold", "Purple", "Emerald", "Crimson" }, -- Library:SetAccent adlari; ilki varsayilan
		Pref = { accent = "Sakura", color = nil, font = nil, scale = nil, statsX = nil, statsY = nil, statsShow = nil, statsOp = nil },
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
			-- Stats mini penceresi (R8): konum, goster, saydamlik
			if type(d.statsX) == "number" and type(d.statsY) == "number" then self.Pref.statsX, self.Pref.statsY = d.statsX, d.statsY end
			if type(d.statsShow) == "boolean" then self.Pref.statsShow = d.statsShow end
			if type(d.statsOp) == "number" and d.statsOp >= 30 and d.statsOp <= 100 then self.Pref.statsOp = d.statsOp end
		end)
	end

	function ThemeManager:SavePreference()
		if not hasFiles() then return end
		pcall(function()
			ensurePath(self.Folder)
			writefile(self:_file(), HttpService:JSONEncode({ accent = self.Pref.accent, color = self.Pref.color, font = self.Pref.font, scale = self.Pref.scale,
				statsX = self.Pref.statsX, statsY = self.Pref.statsY, statsShow = self.Pref.statsShow, statsOp = self.Pref.statsOp }))
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
		self._prefLoaded = true
		self:Apply()
		if Library.Stats then Library.Stats:ApplyPref(self.Pref) end -- CreateStats ThemeManager klasoru ayarlanmadan once calismis olabilir

		local box = tab:AddLeftGroupbox("Theme")
		local fonts = type(Library.GetFontNames) == "function" and Library:GetFontNames() or {}
		local loading = true -- OnChanged kurulurken hemen cagrilir: o turda dosyaya yazma

		local function presetColor(name)
			local t = Library.Theme and Library.Theme.Accents and Library.Theme.Accents[name]
			return t and t.Accent or Color3.fromRGB(255, 127, 176)
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

		-- Stats mini penceresi: goster + saydamlik (konum surukleme sonunda Stats tarafindan yazilir)
		box:AddToggle("KaiUI_ShowStats", { Text = "Show stats", Default = self.Pref.statsShow ~= false })
		Library.Toggles.KaiUI_ShowStats:OnChanged(function()
			local v = Library.Toggles.KaiUI_ShowStats.Value
			if Library.Stats then Library.Stats:SetShown(v) end
			if loading or v == (self.Pref.statsShow ~= false) then return end
			self.Pref.statsShow = v
			self:SavePreference()
		end)
		box:AddSlider("KaiUI_StatsOpacity", { Text = "Stats opacity", Min = 30, Max = 100, Default = self.Pref.statsOp or 94, Rounding = 0, Suffix = "%", Finished = true })
		Library.Options.KaiUI_StatsOpacity:OnChanged(function()
			local v = Library.Options.KaiUI_StatsOpacity.Value
			if Library.Stats then Library.Stats:SetOpacity(v / 100) end
			if loading or v == (self.Pref.statsOp or 94) then return end
			self.Pref.statsOp = v
			self:SavePreference()
		end)
		loading = false
	end

	Library.SaveManager = SaveManager
	Library.ThemeManager = ThemeManager
	return Library
end

end)()
installManagers(Library)
return Library
