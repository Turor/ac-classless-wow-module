-- this is a UI for displaying energy/rage




local MainFrame = CreateFrame("Frame","MainFrame",UIParent,nil)
MainFrame:SetSize(100,63)
MainFrame:SetPoint("TOPLEFT", 258, -25)
MainFrame:SetMovable(true)
MainFrame:EnableMouse(true)
MainFrame:RegisterForDrag("LeftButton")
MainFrame:SetClampedToScreen(true)
--MainFrame:SetUserPlaced(true)
local MainFrameTexture = MainFrame:CreateTexture()
MainFrameTexture:SetAllPoints(MainFrame)
MainFrameTexture:SetTexture(.1,.1,.1,1)
MainFrame:SetScript("OnDragStart", MainFrame.StartMoving)
MainFrame:SetScript("OnHide", MainFrame.StopMovingOrSizing)
MainFrame:SetScript("OnDragStop", MainFrame.StopMovingOrSizing)
	
MainFrame:Show()

MainFrame:RegisterEvent("ADDON_LOADED")
MainFrame:RegisterEvent("PLAYER_LOGOUT")








current_energy = UnitPower("player", 3)
max_energy = UnitPowerMax("player", 3)

local EnergyFrame = CreateFrame("Frame","EnergyFrame",MainFrame,nil)
EnergyFrame:SetSize(100,20)


local EnergyStatusBar = CreateFrame("StatusBar", nil, EnergyFrame)
EnergyStatusBar:SetPoint("TOPLEFT")
EnergyStatusBar:SetPoint("TOPRIGHT",0,0)
EnergyStatusBar:SetMinMaxValues(0, 100)


local EnergyFont = EnergyStatusBar:CreateFontString("EnergyF")
EnergyFont:SetFont("Fonts\\FRIZQT__.TTF", 11)
EnergyFont:SetShadowOffset(1, -1)
EnergyFont:SetPoint("CENTER")
EnergyFont:SetText(current_energy.."/"..max_energy)

EnergyFrame:RegisterEvent("UNIT_ENERGY")
EnergyFrame:RegisterEvent("UNIT_RAGE")
EnergyFrame:RegisterEvent("UNIT_MANA")
EnergyFrame:RegisterEvent("UNIT_HEALTH")
EnergyFrame:RegisterEvent("UNIT_POWER")
EnergyFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

EnergyFrame:SetScript("OnUpdate", function(self, sinceLastUpdate) EnergyFrame:onUpdate(sinceLastUpdate); end);


function EnergyFrame:onUpdate(sinceLastUpdate)
	self.sinceLastUpdate = (self.sinceLastUpdate or 0) + sinceLastUpdate;
	if ( self.sinceLastUpdate >= .1 ) then -- in seconds
		EnergyFrame_eventHandler()
		self.sinceLastUpdate = 0;
	end
end

function EnergyFrame_eventHandler(self, event, ...)
	current_energy = UnitPower("player",3)
	max_energy = UnitPowerMax("player",3)
	
	if current_energy == 0 then
		current_energy_percent = 1
	else
        current_energy_percent = current_energy / max_energy * 100
    end
	
	EnergyStatusBar:SetValue(current_energy_percent)
	if Energy_ShowText == true then
		EnergyFont:SetText(current_energy.."/"..max_energy)
	else
		EnergyFont:SetText("")
	end
	
end





current_rage = UnitPower("player",1)
max_rage = UnitPowerMax("player",1)

local RageFrame = CreateFrame("Frame","RageFrame",MainFrame,nil)
RageFrame:SetSize(100,20)


local RageStatusBar = CreateFrame("StatusBar", nil, RageFrame)
RageStatusBar:SetPoint("BOTTOMLEFT")
RageStatusBar:SetPoint("BOTTOMRIGHT",0,0)
RageStatusBar:SetMinMaxValues(0, 100)
RageStatusBar:SetStatusBarColor(1,0,0)

local RageFont = RageStatusBar:CreateFontString("RageF")
RageFont:SetFont("Fonts\\FRIZQT__.TTF", 11)
RageFont:SetShadowOffset(1, -1)
RageFont:SetPoint("CENTER")

RageFrame:RegisterEvent("UNIT_RAGE")
RageFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

RageFrame:SetScript("OnUpdate", function(self, sinceLastUpdate) RageFrame:onUpdate(sinceLastUpdate); end);


function RageFrame:onUpdate(sinceLastUpdate)
	self.sinceLastUpdate = (self.sinceLastUpdate or 0) + sinceLastUpdate;
	if ( self.sinceLastUpdate >= .1 ) then -- in seconds
		RageFrame_eventHandler()
		self.sinceLastUpdate = 0;
	end
end




function RageFrame_eventHandler(self, event, ...)
	current_rage = UnitPower("player",1)
	max_rage = UnitPowerMax("player",1)
	
	current_rage_percent = current_rage / max_rage * 100
	
	if current_rage == 0 then
		current_rage_percent = 1
	end
	
	RageStatusBar:SetValue(current_rage_percent)
	if Rage_ShowText == true then
		RageFont:SetText(current_rage.."/"..max_rage)
	else
		RageFont:SetText("")
	end
end





current_mana = UnitPower("player",0)
max_mana = UnitPowerMax("player",0)

local ManaFrame = CreateFrame("Frame","ManaFrame",MainFrame,nil)
ManaFrame:SetSize(100,20)


local ManaStatusBar = CreateFrame("StatusBar", nil, ManaFrame)
ManaStatusBar:SetPoint("LEFT")
ManaStatusBar:SetPoint("RIGHT",0,0)
ManaStatusBar:SetMinMaxValues(0, 100)
ManaStatusBar:SetStatusBarColor(0,0,1)

local ManaFont = ManaStatusBar:CreateFontString("ManaF")
ManaFont:SetFont("Fonts\\FRIZQT__.TTF", 11)
ManaFont:SetShadowOffset(1, -1)
ManaFont:SetPoint("CENTER")

ManaFrame:RegisterEvent("UNIT_MANA")
ManaFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

ManaFrame:SetScript("OnUpdate", function(self, sinceLastUpdate) ManaFrame:onUpdate(sinceLastUpdate); end);


function ManaFrame:onUpdate(sinceLastUpdate)
	self.sinceLastUpdate = (self.sinceLastUpdate or 0) + sinceLastUpdate;
	if ( self.sinceLastUpdate >= .1 ) then -- in seconds
		ManaFrame_eventHandler()
		self.sinceLastUpdate = 0;
	end
end




function ManaFrame_eventHandler(self, event, ...)
	current_mana = UnitPower("player",0)
	max_mana = UnitPowerMax("player",0)
	
	current_mana_percent = current_mana / max_mana * 100
	
	if current_mana == 0 then
		current_mana_percent = 1
	end
	
	ManaStatusBar:SetValue(current_mana_percent)
	if Mana_ShowText == true then
		ManaFont:SetText(current_mana.."/"..max_mana)
	else
		ManaFont:SetText("")
	end
end






-- below is used for displaying the drop down menu on right click

local DropDownMenu = CreateFrame("Frame","MainFrameDropDownMenu")
DropDownMenu.displayMode = "MENU"

local info = {}
DropDownMenu.initialize = function(self, level)
	if not level then return end
	wipe(info)
	if level == 1 then
		-- Create the title of the menu
		info.isTitle = 1
		info.text = "Energy/Rage/Mana Options"
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		
		info.disabled = nil
		info.isTitle = nil
		info.notCheckable = nil
		
		info.text = "Energy Config"
		info.func = function()
			EnergyConfigFrame:Show()
			end
		UIDropDownMenu_AddButton(info, level)
		
		info.text = "Rage Config"
		info.func = function()
			RageConfigFrame:Show()
			end
		UIDropDownMenu_AddButton(info, level)
		
		info.text = "Mana Config"
		info.func = function()
			ManaConfigFrame:Show()
			end
		UIDropDownMenu_AddButton(info, level)
		
		info.text = "All Bars Config"
		info.func = function()
			ConfigFrame:Show()
			end
		UIDropDownMenu_AddButton(info, level)
	end
end

function OnMouseDown_MainFrame(self, button)

	if button == "RightButton" then
		ToggleDropDownMenu(1, nil, DropDownMenu, self:GetName(), 0, 0)
	end

end

MainFrame:SetScript("OnMouseDown", OnMouseDown_MainFrame)

-- below is the config frames

EnergyConfigFrame = CreateFrame("Frame","EnergyConfigFrame",UIParent,nil)
EnergyConfigFrame:SetSize(250,200)
EnergyConfigFrame:SetPoint("CENTER")
EnergyConfigFrame:EnableMouse(true)
EnergyConfigFrame:SetMovable(true)
EnergyConfigFrame:RegisterForDrag("LeftButton")
EnergyConfigFrame:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark",
	edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
	edgeSize = 15,
})
EnergyConfigFrame:SetScript("OnDragStart", EnergyConfigFrame.StartMoving)
EnergyConfigFrame:SetScript("OnHide", EnergyConfigFrame.StopMovingOrSizing)
EnergyConfigFrame:SetScript("OnDragStop", EnergyConfigFrame.StopMovingOrSizing)

EnergyConfigFrame_CloseButton = CreateFrame("Button", "EnergyConfigFrame_CloseButton", EnergyConfigFrame, "UIPanelCloseButton")
		EnergyConfigFrame_CloseButton:SetPoint("TOPRIGHT", -5, -5)
		EnergyConfigFrame_CloseButton:EnableMouse(true)
		EnergyConfigFrame_CloseButton:SetSize(27, 27)
EnergyConfigFrame:Hide()

local EnergyConfigFrame_TitleBar = CreateFrame("Frame", "EnergyConfigFrame_TitleBar", EnergyConfigFrame, nil)
        EnergyConfigFrame_TitleBar:SetSize(100, 25)
        EnergyConfigFrame_TitleBar:SetBackdrop({
            bgFile = "Interface/CHARACTERFRAME/UI-Party-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            edgeSize = 15,
            tileSize = 15,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
		EnergyConfigFrame_TitleBar:SetPoint("TOP", 20, 9)
		local EnergyConfigFrame_TitleText = EnergyConfigFrame_TitleBar:CreateFontString("EnergyConfigFrame_TitleText")
        EnergyConfigFrame_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 13)
        EnergyConfigFrame_TitleText:SetSize(225, 5)
        EnergyConfigFrame_TitleText:SetPoint("CENTER", 0, 0)
        EnergyConfigFrame_TitleText:SetText("|cffFFC125Energy Bar|r")


EnergyConfigFrame_SubmitButton = CreateFrame("Button","EnergyConfigFrame_SubmitButton",EnergyConfigFrame,nil)
EnergyConfigFrame_SubmitButton:SetSize(50,20)
EnergyConfigFrame_SubmitButton:SetPoint("BOTTOM", 20, 5)
EnergyConfigFrame_SubmitButton_Text = EnergyConfigFrame_SubmitButton:CreateFontString("EnergyConfigFrame_SubmitButton_FS")
EnergyConfigFrame_SubmitButton_Text:SetFont("Fonts\\FRIZQT__.TTF", 11)
EnergyConfigFrame_SubmitButton_Text:SetShadowOffset(1, -1)
EnergyConfigFrame_SubmitButton_Text:SetPoint("Center")
EnergyConfigFrame_SubmitButton:SetFontString(EnergyConfigFrame_SubmitButton_Text)
EnergyConfigFrame_SubmitButton:SetText("Apply")
EnergyConfigFrame_SubmitButton_Texture = EnergyConfigFrame_SubmitButton:CreateTexture("EnergyConfigFrame_SubmitButton_texture")
EnergyConfigFrame_SubmitButton_Texture:SetTexture(.9,.2,0,.8)
EnergyConfigFrame_SubmitButton_Texture:SetAllPoints(EnergyConfigFrame_SubmitButton)
EnergyConfigFrame_SubmitButton:SetNormalTexture(EnergyConfigFrame_SubmitButton_Texture)

function init_loadUp()

	if ConfigFrame_varis[4] == 1 then
		EnergyStatusBar:SetStatusBarTexture("Interface\\AddOns\\ClasslessUIAddons\\textures\\normTex.tga")
		RageStatusBar:SetStatusBarTexture("Interface\\AddOns\\ClasslessUIAddons\\textures\\normTex.tga")
		ManaStatusBar:SetStatusBarTexture("Interface\\AddOns\\ClasslessUIAddons\\textures\\normTex.tga")
	elseif ConfigFrame_varis[4] == 2 then
		EnergyStatusBar:SetStatusBarTexture("Interface\\AddOns\\ClasslessUIAddons\\textures\\Minimalist.tga")
		RageStatusBar:SetStatusBarTexture("Interface\\AddOns\\ClasslessUIAddons\\textures\\Minimalist.tga")
		ManaStatusBar:SetStatusBarTexture("Interface\\AddOns\\ClasslessUIAddons\\textures\\Minimalist.tga")
	end

	EnergyStatusBar:SetStatusBarColor(Energy_Textures[1],Energy_Textures[2],Energy_Textures[3])
	EnergyRSlider:SetValue(Energy_Textures[1] * 100)
	EnergyGSlider:SetValue(Energy_Textures[2] * 100)
	EnergyBSlider:SetValue(Energy_Textures[3] * 100)

	RageStatusBar:SetStatusBarColor(Rage_Textures[1],Rage_Textures[2],Rage_Textures[3])
	RageRSlider:SetValue(Rage_Textures[1] * 100)
	RageGSlider:SetValue(Rage_Textures[2] * 100)
	RageBSlider:SetValue(Rage_Textures[3] * 100)

	ManaStatusBar:SetStatusBarColor(Mana_Textures[1],Mana_Textures[2],Mana_Textures[3])
	ManaRSlider:SetValue(Mana_Textures[1] * 100)
	ManaGSlider:SetValue(Mana_Textures[2] * 100)
	ManaBSlider:SetValue(Mana_Textures[3] * 100)

	MainFrame:SetSize(ConfigFrame_varis[2],ConfigFrame_varis[3] * 3 + 2)
	EnergyFrame:SetSize(ConfigFrame_varis[2],ConfigFrame_varis[3])
	EnergyStatusBar:SetHeight(ConfigFrame_varis[3])
	RageFrame:SetSize(ConfigFrame_varis[2],ConfigFrame_varis[3])
	RageStatusBar:SetHeight(ConfigFrame_varis[3])
	ManaFrame:SetSize(ConfigFrame_varis[2],ConfigFrame_varis[3])
	ManaStatusBar:SetHeight(ConfigFrame_varis[3])


	WidthSlider:SetValue(ConfigFrame_varis[2])
	HeightSlider:SetValue(ConfigFrame_varis[3])
	TextureChoseSlider:SetValue(ConfigFrame_varis[4])


	if ConfigFrame_varis[1] == true then
		EnergyFrame:SetPoint("TOP")
		ManaFrame:SetPoint("CENTER")
		RageFrame:SetPoint("BOTTOM")
	else
		EnergyFrame:SetPoint("BOTTOM")
		ManaFrame:SetPoint("CENTER")
		RageFrame:SetPoint("TOP")
	end
end

local function apply_energy_changes(self, button)
	Energy_Textures[1] = EnergyRSlider:GetValue() / 100
	Energy_Textures[2] = EnergyGSlider:GetValue() / 100
	Energy_Textures[3] = EnergyBSlider:GetValue() / 100
	if EnergyTextChecker:GetChecked() == 1 then
		Energy_ShowText = true
	else
		Energy_ShowText = false
	end
	init_loadUp()
end
EnergyConfigFrame_SubmitButton:SetScript("OnMouseDown", apply_energy_changes)

local EnergyRedFontString = EnergyConfigFrame:CreateFontString("EnergyRedFontString")
EnergyRedFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
EnergyRedFontString:SetShadowOffset(1, -1)
EnergyRedFontString:SetPoint("Center",-55,52)
EnergyRedFontString:SetText("Red:")

local EnergyRSlider = CreateFrame("Slider", "EnergyRSlider", EnergyConfigFrame, "OptionsSliderTemplate")
EnergyRSlider:SetSize(100, 17)
EnergyRSlider:SetPoint("CENTER", EnergyConfigFrame, "CENTER", 20, 50)
EnergyRSlider:SetValueStep(0.5)
EnergyRSlider:SetMinMaxValues(0, 100)
EnergyRSlider.tooltipText = 'Percentage of red'
_G[EnergyRSlider:GetName() .."Text"]:SetText(50)
EnergyRSlider:SetScript("OnValueChanged", function(self) _G[EnergyRSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[EnergyRSlider:GetName().."High"]:Hide()
_G[EnergyRSlider:GetName().."Low"]:Hide()
EnergyRSlider:Show()


local EnergyGreenFontString = EnergyConfigFrame:CreateFontString("EnergyGreenFontString")
EnergyGreenFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
EnergyGreenFontString:SetShadowOffset(1, -1)
EnergyGreenFontString:SetPoint("Center",-62,17)
EnergyGreenFontString:SetText("Green:")

local EnergyGSlider = CreateFrame("Slider", "EnergyGSlider", EnergyConfigFrame, "OptionsSliderTemplate")
EnergyGSlider:SetSize(100, 17)
EnergyGSlider:SetPoint("CENTER", EnergyConfigFrame, "CENTER", 20, 15)
EnergyGSlider:SetValueStep(0.5)
EnergyGSlider:SetMinMaxValues(0, 100)
EnergyGSlider.tooltipText = 'Percentage of green'
_G[EnergyGSlider:GetName() .."Text"]:SetText(50)
EnergyGSlider:SetScript("OnValueChanged", function(self) _G[EnergyGSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[EnergyGSlider:GetName().."High"]:Hide()
_G[EnergyGSlider:GetName().."Low"]:Hide()
EnergyGSlider:Show()


local EnergyBlueFontString = EnergyConfigFrame:CreateFontString("EnergyBlueFontString")
EnergyBlueFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
EnergyBlueFontString:SetShadowOffset(1, -1)
EnergyBlueFontString:SetPoint("Center",-56,-18)
EnergyBlueFontString:SetText("Blue:")


local EnergyBSlider = CreateFrame("Slider", "EnergyBSlider", EnergyConfigFrame, "OptionsSliderTemplate")
EnergyBSlider:SetSize(100, 17)
EnergyBSlider:SetPoint("CENTER", EnergyConfigFrame, "CENTER", 20, -20)
EnergyBSlider:SetValueStep(0.5)
EnergyBSlider:SetMinMaxValues(0, 100)
EnergyBSlider.tooltipText = 'Percentage of blue'
_G[EnergyBSlider:GetName() .."Text"]:SetText(50)
EnergyBSlider:SetScript("OnValueChanged", function(self) _G[EnergyBSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[EnergyBSlider:GetName().."High"]:Hide()
_G[EnergyBSlider:GetName().."Low"]:Hide()
EnergyBSlider:Show()


local EnergyTextFontString = EnergyConfigFrame:CreateFontString("EnergyTextFontString")
EnergyTextFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
EnergyTextFontString:SetShadowOffset(1, -1)
EnergyTextFontString:SetPoint("Center",-77,-48)
EnergyTextFontString:SetText("Show Text:")

local EnergyTextChecker = CreateFrame("CheckButton","EnergyTextChecker",EnergyConfigFrame, "ChatConfigCheckButtonTemplate")
EnergyTextChecker:SetPoint("CENTER", -20, -50)
EnergyTextChecker.tooltip = "Show text over resource"




RageConfigFrame = CreateFrame("Frame","RageConfigFrame",UIParent,nil)
RageConfigFrame:SetSize(250,200)
RageConfigFrame:SetPoint("CENTER")
RageConfigFrame:EnableMouse(true)
RageConfigFrame:SetMovable(true)
RageConfigFrame:RegisterForDrag("LeftButton")
RageConfigFrame:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark",
	edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
	edgeSize = 15,
})
RageConfigFrame:SetScript("OnDragStart", RageConfigFrame.StartMoving)
RageConfigFrame:SetScript("OnHide", RageConfigFrame.StopMovingOrSizing)
RageConfigFrame:SetScript("OnDragStop", RageConfigFrame.StopMovingOrSizing)

RageConfigFrame_CloseButton = CreateFrame("Button", "RageConfigFrame_CloseButton", RageConfigFrame, "UIPanelCloseButton")
		RageConfigFrame_CloseButton:SetPoint("TOPRIGHT", -5, -5)
		RageConfigFrame_CloseButton:EnableMouse(true)
		RageConfigFrame_CloseButton:SetSize(27, 27)
RageConfigFrame:Hide()


local RageConfigFrame_TitleBar = CreateFrame("Frame", "RageConfigFrame_TitleBar", RageConfigFrame, nil)
        RageConfigFrame_TitleBar:SetSize(100, 25)
        RageConfigFrame_TitleBar:SetBackdrop({
            bgFile = "Interface/CHARACTERFRAME/UI-Party-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            edgeSize = 15,
            tileSize = 15,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
		RageConfigFrame_TitleBar:SetPoint("TOP", 20, 9)
		local RageConfigFrame_TitleText = RageConfigFrame_TitleBar:CreateFontString("RageConfigFrame_TitleText")
        RageConfigFrame_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 13)
        RageConfigFrame_TitleText:SetSize(225, 5)
        RageConfigFrame_TitleText:SetPoint("CENTER", 0, 0)
        RageConfigFrame_TitleText:SetText("|cffFFC125Rage Bar|r")


RageConfigFrame_SubmitButton = CreateFrame("Button","RageConfigFrame_SubmitButton",RageConfigFrame,nil)
RageConfigFrame_SubmitButton:SetSize(50,20)
RageConfigFrame_SubmitButton:SetPoint("BOTTOM", 20, 5)
RageConfigFrame_SubmitButton_Text = RageConfigFrame_SubmitButton:CreateFontString("RageConfigFrame_SubmitButton_FS")
RageConfigFrame_SubmitButton_Text:SetFont("Fonts\\FRIZQT__.TTF", 11)
RageConfigFrame_SubmitButton_Text:SetShadowOffset(1, -1)
RageConfigFrame_SubmitButton_Text:SetPoint("Center")
RageConfigFrame_SubmitButton:SetFontString(RageConfigFrame_SubmitButton_Text)
RageConfigFrame_SubmitButton:SetText("Apply")
RageConfigFrame_SubmitButton_Texture = RageConfigFrame_SubmitButton:CreateTexture("RageConfigFrame_SubmitButton_texture")
RageConfigFrame_SubmitButton_Texture:SetTexture(.9,.2,0,.8)
RageConfigFrame_SubmitButton_Texture:SetAllPoints(RageConfigFrame_SubmitButton)
RageConfigFrame_SubmitButton:SetNormalTexture(RageConfigFrame_SubmitButton_Texture)

local function apply_rage_changes(self, button)
	Rage_Textures[1] = RageRSlider:GetValue() / 100
	Rage_Textures[2] = RageGSlider:GetValue() / 100
	Rage_Textures[3] = RageBSlider:GetValue() / 100
	if RageTextChecker:GetChecked() == 1 then
		Rage_ShowText = true
	else
		Rage_ShowText = false
	end
	init_loadUp()
end
RageConfigFrame_SubmitButton:SetScript("OnMouseDown", apply_rage_changes)

local RageRedFontString = RageConfigFrame:CreateFontString("RageRedFontString")
RageRedFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
RageRedFontString:SetShadowOffset(1, -1)
RageRedFontString:SetPoint("Center",-55,52)
RageRedFontString:SetText("Red:")

local RageRSlider = CreateFrame("Slider", "RageRSlider", RageConfigFrame, "OptionsSliderTemplate")
RageRSlider:SetSize(100, 17)
RageRSlider:SetPoint("CENTER", RageConfigFrame, "CENTER", 20, 50)
RageRSlider:SetValueStep(0.5)
RageRSlider:SetMinMaxValues(0, 100)
RageRSlider.tooltipText = 'Percentage of red'
_G[RageRSlider:GetName() .."Text"]:SetText(50)
RageRSlider:SetScript("OnValueChanged", function(self) _G[RageRSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[RageRSlider:GetName().."High"]:Hide()
_G[RageRSlider:GetName().."Low"]:Hide()
RageRSlider:Show()


local RageGreenFontString = RageConfigFrame:CreateFontString("RageGreenFontString")
RageGreenFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
RageGreenFontString:SetShadowOffset(1, -1)
RageGreenFontString:SetPoint("Center",-62,17)
RageGreenFontString:SetText("Green:")

local RageGSlider = CreateFrame("Slider", "RageGSlider", RageConfigFrame, "OptionsSliderTemplate")
RageGSlider:SetSize(100, 17)
RageGSlider:SetPoint("CENTER", RageConfigFrame, "CENTER", 20, 15)
RageGSlider:SetValueStep(0.5)
RageGSlider:SetMinMaxValues(0, 100)
RageGSlider.tooltipText = 'Percentage of green'
_G[RageGSlider:GetName() .."Text"]:SetText(50)
RageGSlider:SetScript("OnValueChanged", function(self) _G[RageGSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[RageGSlider:GetName().."High"]:Hide()
_G[RageGSlider:GetName().."Low"]:Hide()
RageGSlider:Show()


local RageBlueFontString = RageConfigFrame:CreateFontString("RageBlueFontString")
RageBlueFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
RageBlueFontString:SetShadowOffset(1, -1)
RageBlueFontString:SetPoint("Center",-56,-18)
RageBlueFontString:SetText("Blue:")


local RageBSlider = CreateFrame("Slider", "RageBSlider", RageConfigFrame, "OptionsSliderTemplate")
RageBSlider:SetSize(100, 17)
RageBSlider:SetPoint("CENTER", RageConfigFrame, "CENTER", 20, -20)
RageBSlider:SetValueStep(0.5)
RageBSlider:SetMinMaxValues(0, 100)
RageBSlider.tooltipText = 'Percentage of blue'
_G[RageBSlider:GetName() .."Text"]:SetText(50)
RageBSlider:SetScript("OnValueChanged", function(self) _G[RageBSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[RageBSlider:GetName().."High"]:Hide()
_G[RageBSlider:GetName().."Low"]:Hide()
RageBSlider:Show()


local RageTextFontString = RageConfigFrame:CreateFontString("RageTextFontString")
RageTextFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
RageTextFontString:SetShadowOffset(1, -1)
RageTextFontString:SetPoint("Center",-77,-48)
RageTextFontString:SetText("Show Text:")

local RageTextChecker = CreateFrame("CheckButton","RageTextChecker",RageConfigFrame, "ChatConfigCheckButtonTemplate")
RageTextChecker:SetPoint("CENTER", -20, -50)
RageTextChecker.tooltip = "Show text over resource"

-- Begin Mana Frame

ManaConfigFrame = CreateFrame("Frame","ManaConfigFrame",UIParent,nil)
ManaConfigFrame:SetSize(250,200)
ManaConfigFrame:SetPoint("CENTER")
ManaConfigFrame:EnableMouse(true)
ManaConfigFrame:SetMovable(true)
ManaConfigFrame:RegisterForDrag("LeftButton")
ManaConfigFrame:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark",
	edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
	edgeSize = 15,
})
ManaConfigFrame:SetScript("OnDragStart", ManaConfigFrame.StartMoving)
ManaConfigFrame:SetScript("OnHide", ManaConfigFrame.StopMovingOrSizing)
ManaConfigFrame:SetScript("OnDragStop", ManaConfigFrame.StopMovingOrSizing)

ManaConfigFrame_CloseButton = CreateFrame("Button", "ManaConfigFrame_CloseButton", ManaConfigFrame, "UIPanelCloseButton")
		ManaConfigFrame_CloseButton:SetPoint("TOPRIGHT", -5, -5)
		ManaConfigFrame_CloseButton:EnableMouse(true)
		ManaConfigFrame_CloseButton:SetSize(27, 27)
ManaConfigFrame:Hide()


local ManaConfigFrame_TitleBar = CreateFrame("Frame", "ManaConfigFrame_TitleBar", ManaConfigFrame, nil)
        ManaConfigFrame_TitleBar:SetSize(100, 25)
        ManaConfigFrame_TitleBar:SetBackdrop({
            bgFile = "Interface/CHARACTERFRAME/UI-Party-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            edgeSize = 15,
            tileSize = 15,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
		ManaConfigFrame_TitleBar:SetPoint("TOP", 20, 9)
		local ManaConfigFrame_TitleText = ManaConfigFrame_TitleBar:CreateFontString("ManaConfigFrame_TitleText")
        ManaConfigFrame_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 13)
        ManaConfigFrame_TitleText:SetSize(225, 5)
        ManaConfigFrame_TitleText:SetPoint("CENTER", 0, 0)
        ManaConfigFrame_TitleText:SetText("|cffFFC125Mana Bar|r")


ManaConfigFrame_SubmitButton = CreateFrame("Button","ManaConfigFrame_SubmitButton",ManaConfigFrame,nil)
ManaConfigFrame_SubmitButton:SetSize(50,20)
ManaConfigFrame_SubmitButton:SetPoint("BOTTOM", 20, 5)
ManaConfigFrame_SubmitButton_Text = ManaConfigFrame_SubmitButton:CreateFontString("ManaConfigFrame_SubmitButton_FS")
ManaConfigFrame_SubmitButton_Text:SetFont("Fonts\\FRIZQT__.TTF", 11)
ManaConfigFrame_SubmitButton_Text:SetShadowOffset(1, -1)
ManaConfigFrame_SubmitButton_Text:SetPoint("Center")
ManaConfigFrame_SubmitButton:SetFontString(ManaConfigFrame_SubmitButton_Text)
ManaConfigFrame_SubmitButton:SetText("Apply")
ManaConfigFrame_SubmitButton_Texture = ManaConfigFrame_SubmitButton:CreateTexture("ManaConfigFrame_SubmitButton_texture")
ManaConfigFrame_SubmitButton_Texture:SetTexture(.9,.2,0,.8)
ManaConfigFrame_SubmitButton_Texture:SetAllPoints(ManaConfigFrame_SubmitButton)
ManaConfigFrame_SubmitButton:SetNormalTexture(ManaConfigFrame_SubmitButton_Texture)

local function apply_Mana_changes(self, button)
	Mana_Textures[1] = ManaRSlider:GetValue() / 100
	Mana_Textures[2] = ManaGSlider:GetValue() / 100
	Mana_Textures[3] = ManaBSlider:GetValue() / 100
	if ManaTextChecker:GetChecked() == 1 then
		Mana_ShowText = true
	else
		Mana_ShowText = false
	end
	init_loadUp()
end
ManaConfigFrame_SubmitButton:SetScript("OnMouseDown", apply_Mana_changes)

local ManaRedFontString = ManaConfigFrame:CreateFontString("ManaRedFontString")
ManaRedFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
ManaRedFontString:SetShadowOffset(1, -1)
ManaRedFontString:SetPoint("Center",-55,52)
ManaRedFontString:SetText("Red:")

local ManaRSlider = CreateFrame("Slider", "ManaRSlider", ManaConfigFrame, "OptionsSliderTemplate")
ManaRSlider:SetSize(100, 17)
ManaRSlider:SetPoint("CENTER", ManaConfigFrame, "CENTER", 20, 50)
ManaRSlider:SetValueStep(0.5)
ManaRSlider:SetMinMaxValues(0, 100)
ManaRSlider.tooltipText = 'Percentage of red'
_G[ManaRSlider:GetName() .."Text"]:SetText(50)
ManaRSlider:SetScript("OnValueChanged", function(self) _G[ManaRSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[ManaRSlider:GetName().."High"]:Hide()
_G[ManaRSlider:GetName().."Low"]:Hide()
ManaRSlider:Show()


local ManaGreenFontString = ManaConfigFrame:CreateFontString("ManaGreenFontString")
ManaGreenFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
ManaGreenFontString:SetShadowOffset(1, -1)
ManaGreenFontString:SetPoint("Center",-62,17)
ManaGreenFontString:SetText("Green:")

local ManaGSlider = CreateFrame("Slider", "ManaGSlider", ManaConfigFrame, "OptionsSliderTemplate")
ManaGSlider:SetSize(100, 17)
ManaGSlider:SetPoint("CENTER", ManaConfigFrame, "CENTER", 20, 15)
ManaGSlider:SetValueStep(0.5)
ManaGSlider:SetMinMaxValues(0, 100)
ManaGSlider.tooltipText = 'Percentage of green'
_G[ManaGSlider:GetName() .."Text"]:SetText(50)
ManaGSlider:SetScript("OnValueChanged", function(self) _G[ManaGSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[ManaGSlider:GetName().."High"]:Hide()
_G[ManaGSlider:GetName().."Low"]:Hide()
ManaGSlider:Show()


local ManaBlueFontString = ManaConfigFrame:CreateFontString("ManaBlueFontString")
ManaBlueFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
ManaBlueFontString:SetShadowOffset(1, -1)
ManaBlueFontString:SetPoint("Center",-56,-18)
ManaBlueFontString:SetText("Blue:")


local ManaBSlider = CreateFrame("Slider", "ManaBSlider", ManaConfigFrame, "OptionsSliderTemplate")
ManaBSlider:SetSize(100, 17)
ManaBSlider:SetPoint("CENTER", ManaConfigFrame, "CENTER", 20, -20)
ManaBSlider:SetValueStep(0.5)
ManaBSlider:SetMinMaxValues(0, 100)
ManaBSlider.tooltipText = 'Percentage of blue'
_G[ManaBSlider:GetName() .."Text"]:SetText(50)
ManaBSlider:SetScript("OnValueChanged", function(self) _G[ManaBSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[ManaBSlider:GetName().."High"]:Hide()
_G[ManaBSlider:GetName().."Low"]:Hide()
ManaBSlider:Show()


local ManaTextFontString = ManaConfigFrame:CreateFontString("ManaTextFontString")
ManaTextFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
ManaTextFontString:SetShadowOffset(1, -1)
ManaTextFontString:SetPoint("Center",-77,-48)
ManaTextFontString:SetText("Show Text:")

local ManaTextChecker = CreateFrame("CheckButton","ManaTextChecker",ManaConfigFrame, "ChatConfigCheckButtonTemplate")
ManaTextChecker:SetPoint("CENTER", -20, -50)
ManaTextChecker.tooltip = "Show text over resource"

-- End Mana Frame


ConfigFrame = CreateFrame("Frame","ConfigFrame",UIParent,nil)
ConfigFrame:SetSize(250,200)
ConfigFrame:SetPoint("CENTER")
ConfigFrame:EnableMouse(true)
ConfigFrame:SetMovable(true)
ConfigFrame:RegisterForDrag("LeftButton")
ConfigFrame:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark",
	edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
	edgeSize = 15,
})
ConfigFrame:SetScript("OnDragStart", ConfigFrame.StartMoving)
ConfigFrame:SetScript("OnHide", ConfigFrame.StopMovingOrSizing)
ConfigFrame:SetScript("OnDragStop", ConfigFrame.StopMovingOrSizing)

ConfigFrame_CloseButton = CreateFrame("Button", "ConfigFrame_CloseButton", ConfigFrame, "UIPanelCloseButton")
		ConfigFrame_CloseButton:SetPoint("TOPRIGHT", -5, -5)
		ConfigFrame_CloseButton:EnableMouse(true)
		ConfigFrame_CloseButton:SetSize(27, 27)
ConfigFrame:Hide()

local ConfigFrame_TitleBar = CreateFrame("Frame", "ConfigFrame_TitleBar", ConfigFrame, nil)
        ConfigFrame_TitleBar:SetSize(100, 25)
        ConfigFrame_TitleBar:SetBackdrop({
            bgFile = "Interface/CHARACTERFRAME/UI-Party-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            edgeSize = 15,
            tileSize = 15,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
		ConfigFrame_TitleBar:SetPoint("TOP", 20, 9)
		local ConfigFrame_TitleText = ConfigFrame_TitleBar:CreateFontString("ConfigFrame_TitleText")
        ConfigFrame_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 13)
        ConfigFrame_TitleText:SetSize(225, 5)
        ConfigFrame_TitleText:SetPoint("CENTER", 0, 0)
        ConfigFrame_TitleText:SetText("|cffFFC125All Bars|r")


ConfigFrame_SubmitButton = CreateFrame("Button","ConfigFrame_SubmitButton",ConfigFrame,nil)
ConfigFrame_SubmitButton:SetSize(50,20)
ConfigFrame_SubmitButton:SetPoint("BOTTOM", 20, 5)
ConfigFrame_SubmitButton_Text = ConfigFrame_SubmitButton:CreateFontString("ConfigFrame_SubmitButton_FS")
ConfigFrame_SubmitButton_Text:SetFont("Fonts\\FRIZQT__.TTF", 11)
ConfigFrame_SubmitButton_Text:SetShadowOffset(1, -1)
ConfigFrame_SubmitButton_Text:SetPoint("Center")
ConfigFrame_SubmitButton:SetFontString(ConfigFrame_SubmitButton_Text)
ConfigFrame_SubmitButton:SetText("Apply")
ConfigFrame_SubmitButton_Texture = ConfigFrame_SubmitButton:CreateTexture("ConfigFrame_SubmitButton_texture")
ConfigFrame_SubmitButton_Texture:SetTexture(.9,.2,0,.8)
ConfigFrame_SubmitButton_Texture:SetAllPoints(ConfigFrame_SubmitButton)
ConfigFrame_SubmitButton:SetNormalTexture(ConfigFrame_SubmitButton_Texture)


local function apply_all_changes(self, button)

	ConfigFrame_varis[2] = WidthSlider:GetValue()
	ConfigFrame_varis[3] = HeightSlider:GetValue()
	ConfigFrame_varis[4] = TextureChoseSlider:GetValue()

	if FirstTextChecker:GetChecked() == 1 then
		ConfigFrame_varis[1] = true
	elseif FirstTextChecker:GetChecked() == nil then
		ConfigFrame_varis[1] = false
	end

	init_loadUp()
end
ConfigFrame_SubmitButton:SetScript("OnMouseDown", apply_all_changes)


local TextureChoseFontString = ConfigFrame:CreateFontString("TextureChoseFontString")
TextureChoseFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
TextureChoseFontString:SetShadowOffset(1, -1)
TextureChoseFontString:SetPoint("Center",-55,52)
TextureChoseFontString:SetText("Texture:")

local TextureChoseSlider = CreateFrame("Slider", "TextureChoseSlider", ConfigFrame, "OptionsSliderTemplate")
TextureChoseSlider:SetSize(100, 17)
TextureChoseSlider:SetPoint("CENTER", RageConfigFrame, "CENTER", 20, 50)
TextureChoseSlider:SetValueStep(1)
TextureChoseSlider:SetMinMaxValues(1, 2)
TextureChoseSlider.tooltipText = 'Texture to use.'
_G[TextureChoseSlider:GetName() .."Text"]:SetText(50)
TextureChoseSlider:SetScript("OnValueChanged", function(self) _G[TextureChoseSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[TextureChoseSlider:GetName().."High"]:Hide()
_G[TextureChoseSlider:GetName().."Low"]:Hide()
TextureChoseSlider:Show()


local HeightFontString = ConfigFrame:CreateFontString("HeightFontString")
HeightFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
HeightFontString:SetShadowOffset(1, -1)
HeightFontString:SetPoint("Center",-56,17)
HeightFontString:SetText("Height:")


local HeightSlider = CreateFrame("Slider", "HeightSlider", ConfigFrame, "OptionsSliderTemplate")
HeightSlider:SetSize(100, 17)
HeightSlider:SetPoint("CENTER", ConfigFrame, "CENTER", 20, 15)
HeightSlider:SetValueStep(3)
HeightSlider:SetMinMaxValues(10, 100)
HeightSlider.tooltipText = 'Height of bars.\nMay Require a reload.'
_G[HeightSlider:GetName() .."Text"]:SetText(50)
HeightSlider:SetScript("OnValueChanged", function(self) _G[HeightSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[HeightSlider:GetName().."High"]:Hide()
_G[HeightSlider:GetName().."Low"]:Hide()
HeightSlider:Show()


local WidthFontString = ConfigFrame:CreateFontString("WidthFontString")
WidthFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
WidthFontString:SetShadowOffset(1, -1)
WidthFontString:SetPoint("Center",-56,-18)
WidthFontString:SetText("Width:")


local WidthSlider = CreateFrame("Slider", "WidthSlider", ConfigFrame, "OptionsSliderTemplate")
WidthSlider:SetSize(100, 17)
WidthSlider:SetPoint("CENTER", ConfigFrame, "CENTER", 20, -20)
WidthSlider:SetValueStep(5)
WidthSlider:SetMinMaxValues(10, 300)
WidthSlider.tooltipText = 'Width of bars.\nMay Require a reload.'
_G[WidthSlider:GetName() .."Text"]:SetText(50)
WidthSlider:SetScript("OnValueChanged", function(self) _G[WidthSlider:GetName() .."Text"]:SetText(self:GetValue()) end)
_G[WidthSlider:GetName().."High"]:Hide()
_G[WidthSlider:GetName().."Low"]:Hide()
WidthSlider:Show()


local FirstTextFontString = ConfigFrame:CreateFontString("FirstTextFontString")
FirstTextFontString:SetFont("Fonts\\FRIZQT__.TTF", 14)
FirstTextFontString:SetShadowOffset(1, -1)
FirstTextFontString:SetPoint("Center",-77,-48)
FirstTextFontString:SetText("Energy First:")

local FirstTextChecker = CreateFrame("CheckButton","FirstTextChecker",ConfigFrame, "ChatConfigCheckButtonTemplate")
FirstTextChecker:SetPoint("CENTER", -20, -50)
FirstTextChecker.tooltip = "Whether energy is first or not.\nmay require reload"

function MainFrame:OnEvent(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "ClasslessUIAddons" then
		if Energy_Textures == nil then
			Energy_Textures = {1,1,0}
		end
		if Energy_ShowText == nil then
			Energy_ShowText = true
			EnergyTextChecker:SetChecked(true)
		else
			if Energy_ShowText == true then
				EnergyTextChecker:SetChecked(true)
			else
				EnergyTextChecker:SetChecked(false)
			end
		end

		if Rage_Textures == nil then
			Rage_Textures = {1,0,0}
		end
		if Rage_ShowText == nil then
			Rage_ShowText = true
			RageTextChecker:SetChecked(true)
		else
			if Rage_ShowText == true then
				RageTextChecker:SetChecked(true)
			else
				RageTextChecker:SetChecked(false)
			end
		end

		if Mana_Textures == nil then
			Mana_Textures = {0,0,1}
		end
		if Mana_ShowText == nil then
			Mana_ShowText = true
			ManaTextChecker:SetChecked(true)
		else
			if Mana_ShowText == true then
				ManaTextChecker:SetChecked(true)
			else
				ManaTextChecker:SetChecked(false)
			end
		end

		if ConfigFrame_varis == nil then
			ConfigFrame_varis = {}
			ConfigFrame_varis[1] = true
			ConfigFrame_varis[2] = 100
			ConfigFrame_varis[3] = 20
			ConfigFrame_varis[4] = 1
			FirstTextChecker:SetChecked(true)
			WidthSlider:SetValue(ConfigFrame_varis[2])
			HeightSlider:SetValue(ConfigFrame_varis[3])
			TextureChoseSlider:SetValue(ConfigFrame_varis[4])
		elseif ConfigFrame_varis[1] == nil or ConfigFrame_varis[2] == nil or ConfigFrame_varis[3] == nil or ConfigFrame_varis[4] == nil then
			ConfigFrame_varis = {}
			ConfigFrame_varis[1] = true
			ConfigFrame_varis[2] = 100
			ConfigFrame_varis[3] = 20
			ConfigFrame_varis[4] = 1
			FirstTextChecker:SetChecked(true)
			WidthSlider:SetValue(ConfigFrame_varis[2])
			HeightSlider:SetValue(ConfigFrame_varis[3])
			TextureChoseSlider:SetValue(ConfigFrame_varis[4])
		elseif ConfigFrame_varis[1] == true then
			FirstTextChecker:SetChecked(true)
		end
	init_loadUp()
	end
end

MainFrame:SetScript("OnEvent", MainFrame.OnEvent)
ManaFrame:SetScript("OnEvent", ManaFrame_eventHandler)
RageFrame:SetScript("OnEvent", RageFrame_eventHandler)
EnergyFrame:SetScript("OnEvent", EnergyFrame_eventHandler)