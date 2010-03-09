-- $Id: ony.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, recBossTimers = ...

-- ONYXIA
local onyxia = 10184

-- This frame will not be here in final version.
local event_frame = CreateFrame("Frame")
event_frame:RegisterEvent("CHAT_MSG_MONSTER_YELL")
event_frame:RegisterEvent("UNIT_DIED")
event_frame:RegisterEvent("UNIT_HEALTH")
event_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

event_frame:SetScript("OnEvent", function(self, event, ...)

	if event == "CHAT_MSG_MONSTER_YELL" then
		if select(1, ...) == "This meaningless exertion bores me. I'll incinerate you all from above!" then
			-- Start P2
			recBossTimers:warning("PHASE 2")
		elseif select(1, ...) == "It seems you'll need another lesson, mortals!" then
			-- Start P3
			recBossTimers:warning("PHASE 3")
		end
	end
	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		
		if event == "SPELL_CAST_START" then
			if spell_id == 68958 then
				recBossTimers:warning("Blast Nova")
			elseif spell_id == 17086 or spell_id == 18351 or spell_id == 18564 or spell_id == 18576 or spell_id == 18584 or spell_id == 18596 or spell_id == 18609 or spell_id == 18617 then -- Aparently there is a different id for each direction she faces.
				recBossTimers:warning("DEEP BREATH!")
				recBossTimers:create_timer(8, "Deep Breath", 0, 17)
				recBossTimers:create_timer(35, "Next Deep Breath", 0, 34)
			elseif spell_id == 18435 or spell_id == 68970 then
				recBossTimers:create_timer(20, "Next Flame Breath", 0, 51)
			end
		end
		
		-- Seriously, does this even need to be in here =/
		-- I mean if you're gettin tail swiped, you fail pretty bad.
		if event == "SPELL_DAMAGE" then
			if dest_guid == UnitGUID("player") and (spell_id == 68867 or spell_id == 69286) then
				recBossTimers:warning("Watch the tail!")
			end
		end
	end
end)