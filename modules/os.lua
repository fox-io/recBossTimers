-- $Id: os.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, t = ...

-- SARTHARION
local sartharion = 28860

-- This frame will not be here in final version.
local event_frame = CreateFrame("Frame")
event_frame:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
event_frame:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
event_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
-- tenebron, 30s
-- shadron, 80s
-- vesperon, 120s

event_frame:SetScript("OnEvent", function(self, event, ...)
	local msg = select(1, ...)

	if event == "CHAT_MSG_RAID_BOSS_EMOTE" or event == "CHAT_MSG_MONSTER_EMOTE" then
		if msg:find("The lava surrounding %s churns!") then
			t:warning("Fire Wall")
			t:create_timer(30, "Next Fire Wall", 0, 34)
			PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav")
		elseif msg:find("%s begins to open a Twilight Portal!") then
			if msg:find("Tenebron") then
				-- Whelps from this portal.
				t:warning("Portal")
			--elseif msg:find("Vesperon") then
				-- No one goes into this portal anymore - warning needed?
				--t:warning("Portal")
			elseif msg:find("Shadron") then
				-- Boss is immune during this portal.
				t:warning("Portal")
				PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav")
			end
		end
	end
	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		if event == "SPELL_CAST_SUCCESS" then
			if spell_id == 57579 or spell_id == 59127 then
				-- Void zone created
				t:warning("Void Zone")
				PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav")
				-- Void zone collapse
				t:create_timer(5, "Void Zone Collapse", 0, 51)
			end
		end
	end
end)