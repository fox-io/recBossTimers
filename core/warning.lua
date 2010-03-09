-- $Id: warning.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, recBossTimers = ...

recBossTimers.warning_frame = CreateFrame("Frame")
recBossTimers.warning_frame.warning_timer = 5
recBossTimers.warning_frame:SetWidth(500)
recBossTimers.warning_frame:SetHeight(50)
recBossTimers.warning_frame:SetPoint("CENTER", UIParent, "CENTER", 0, 50)

recBossTimers.warning_frame.warning_message = recBossTimers.warning_frame:CreateFontString(nil, "OVERLAY")
recBossTimers.warning_frame.warning_message:SetFont(recMedia.fontFace.LARGE, 18, "OUTLINE")
recBossTimers.warning_frame.warning_message:SetPoint("CENTER")

recBossTimers.warning = function(self, message)
	if not message then return end
	
	self.warning_frame.warning_message:SetText(message)
	self.warning_frame.warning_timer = 5
	self.warning_frame:Show()
	self.warning_frame:SetScript("OnUpdate", function(self, elapsed)
		self.warning_timer = self.warning_timer - elapsed
		if self.warning_timer <= 0 then
			self:SetScript("OnUpdate", nil)
			self:Hide()
		end
	end)
end