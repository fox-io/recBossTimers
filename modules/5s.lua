-- $Id: 5s.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, recBossTimers = ...

local event_frame = CreateFrame("Frame")
event_frame:RegisterEvent("LFG_PROPOSAL_SHOW")
event_frame:RegisterEvent("LFG_PROPOSAL_FAILED")
event_frame:RegisterEvent("LFG_UPDATE")
event_frame:SetScript("OnEvent", function(self, event, ...)
	if event == "LFG_PROPOSAL_SHOW" then
		recBossTimers:create_timer(40, "LFG Invitation", 0, 0)
	elseif event == "LFG_PROPOSAL_FAILED" then
		recBossTimers:cancel_timer("LFG Invitation")
	elseif event == "LFG_UPDATE" then
		local _, joined = GetLFGInfoServer()
		if not joined then
			recBossTimers:cancel_timer("LFG Invitation")
		end
	end
end)