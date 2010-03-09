-- $Id: timer.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, recBossTimers = ...
recBossTimers.timers = {}

local function pretty_time(seconds)
	local hours		= floor(seconds / 3600)
	hours = (hours > 0) and format("%d:", hours) or ""
	local minutes	= floor(mod(seconds / 60, 60))
	minutes = ((minutes > 0) and (hours ~= "")) and format("%02d:", minutes) or format("%d:", minutes) or ""
	seconds	= floor(mod(seconds / 1, 60))
	seconds = ((seconds > 0) and (minutes ~= "")) and format("%02d", seconds) or format("%d", seconds)
	return format("%s%s%s", hours, minutes, seconds)
end

recBossTimers.cancel_timer = function(timer_name)
	if recBossTimers.timers[timer_name] then
		recBossTimers.timers[timer_name]:Hide()
	end
end

local function on_update(self, elapsed)
	self.update = self.update - elapsed
	
	if self.update > 0 then return end
	self.update = 0.01
	
	if self.expires >= GetTime() then
		self:SetValue(self.expires - GetTime())
		self:SetMinMaxValues(0, self.duration)
		self.lbl:SetText(format("%s - %s", self.timer_name, pretty_time(self.expires - GetTime())))
	else
		self:Hide()
	end
end

recBossTimers.create_timer = function(self, duration, timer_name, x_offset, y_offset, r, g, b, width, height, attach_point, relative_point, x_offset, y_offset)
	local timer
	if not recBossTimers.timers[timer_name] then
		timer = CreateFrame("StatusBar", format("RBT_%s", timer_name), UIParent)
		timer:SetHeight(10)
		timer:SetWidth(200)
		timer.timer_name = timer_name
		timer.active = true
		timer.duration = duration
		timer.expires = GetTime() + duration
		timer.update = 0
		
		timer.tx = timer:CreateTexture(nil, "ARTWORK")
		timer.tx:SetAllPoints()
		timer.tx:SetTexture([=[Interface\AddOns\recMedia\caellian\normtexa.tga]=])
		timer.tx:SetVertexColor(1, 0, 0, 1)
		timer:SetStatusBarTexture(timer.tx)

		timer.soft_edge = CreateFrame("Frame", nil, timer)
		timer.soft_edge:SetPoint("TOPLEFT", -4, 3.5)
		timer.soft_edge:SetPoint("BOTTOMRIGHT", 4, -4)
		timer.soft_edge:SetBackdrop({
			bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
			edgeFile = [=[Interface\Addons\recMedia\caellian\glowtex]=], edgeSize = 4,
			insets = {left = 3, right = 3, top = 3, bottom = 3}
		})
		timer.soft_edge:SetFrameStrata("BACKGROUND")
		timer.soft_edge:SetBackdropColor(0.15, 0.15, 0.15, 1)
		timer.soft_edge:SetBackdropBorderColor(0, 0, 0)
	
		timer.bg = timer:CreateTexture(nil, "BORDER")
		timer.bg:SetPoint("TOPLEFT")
		timer.bg:SetPoint("BOTTOMRIGHT")
		timer.bg:SetTexture([=[Interface\AddOns\recMedia\caellian\normtexa.tga]=])
		timer.bg:SetVertexColor(0.25, 0.25, 0.25, 1)
	
		timer.icon = timer:CreateTexture(nil, "BORDER")
		timer.icon:SetHeight(10)
		timer.icon:SetWidth(10)
		timer.icon:SetPoint("TOPRIGHT", timer, "TOPLEFT", 0, 0)
		timer.icon:SetTexture(nil)
		
		timer.lbl = timer:CreateFontString(nil, "OVERLAY")
		timer.lbl:SetFont(recMedia.fontFace.SMALL, 8, "OUTLINE")
		timer.lbl:SetPoint("CENTER", timer, "CENTER", 0, 1)
		
		timer:SetPoint("CENTER", UIParent, "CENTER", x_offset, y_offset)
		
		timer:SetScript("OnUpdate", on_update)
		
		recBossTimers.timers[timer_name] = timer
	else
		timer = recBossTimers.timers[timer_name]
		timer.active = true
		timer.duration = duration
		timer.expires = GetTime() + duration
		timer.update = 0
	end
	
	timer:Show()
end