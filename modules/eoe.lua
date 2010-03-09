-- $Id: eoe.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, t = ...
-- malygos = 28859
-- This frame will not be here in final version.
local event_frame = CreateFrame("Frame")
event_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
event_frame:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
event_frame:RegisterEvent("CHAT_MSG_MONSTER_YELL")

event_frame:SetScript("OnEvent", function(self, event, ...)
	if event == "CHAT_MSG_MONSTER_YELL" or "CHAT_MSG_RAID_BOSS_EMOTE" then
		local msg = select(1, ...)
		if not msg or type(msg) ~= "string" then return end -- grr
		if msg:find("My patience has reached its limit. I will be rid of you!") then
			t:create_timer(615, "Enrage", 0, 17)
		end
		if msg:find("A Power Spark forms from a nearby rift!") then
			t:warning("Spark")
			t:create_timer(30, "Next Spark", 0, 30)
		end
		if msg:find("I had hoped to end your lives quickly") then
			t:warning("PHASE 2")
		end
		if msg:find("Now your benefactors make their") then
			t:warning("PHASE 3")
		end
		if msg:find("You will not succeed while I draw breath!") then
			t:warning("Breath")
			t:create_timer(59, "Next Breath", 0, 13)
		end
	end
	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		
		if event == "SPELL_CAST_SUCCESS" then
			if spell_id == 56105 then
				t:create_timer(60, "Vortex CD", 0, 0)
				t:create_timer(11, "Vortex", 0, 13)
			end
		end
		if event == "SPELL_AURA_APPLIED" then
		end
	end
end)