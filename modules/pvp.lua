-- $Id: pvp.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, recBossTimers = ...

-- This frame will not be here in final version.
--local event_frame = CreateFrame("Frame")
--event_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

--event_frame:SetScript("OnEvent", function(self, event, ...)

--	if event == "CHAT_MSG_MONSTER_YELL" then
--		if select(1, ...) == "This meaningless exertion bores me. I'll incinerate you all from above!" then
--			recBossTimers:warning("PHASE 2")
--		end
--	end
	
--	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
--		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		
--		if event == "SPELL_CAST_START" then
--			if spell_id == 68958 then
--				recBossTimers:warning("Blast Nova")
--			elseif spell_id == 17086 or spell_id == 18351 or spell_id == 18564 or spell_id == 18576 or spell_id == 18584 or spell_id == 18596 or spell_id == 18609 or spell_id == 18617 then -- Aparently there is a different id for each direction she faces.
--				recBossTimers:warning("DEEP BREATH!")
--				recBossTimers:create_timer(8, "Deep Breath", 0, 17)
--			end
--		end
--	end
--end)