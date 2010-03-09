-- $Id: naxx.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
-- ANUB'REKHAN
local anubrekhan = 15956
local combar_start
local f = CreateFrame("Frame")
f:RegisterEvent("UNIT_DIED")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
-- @90s on 10/91 on 25, first swarm

f:SetScript("OnEvent", function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		if event == "SPELL_CAST_START" then
			if spell_id == 28785 or spell_id == 54021 then
				t:warning("Locust Swarm")
				t:create_timer(26, "Locust Swarm", 0, 17)
				-- 25 man t:create_timer(19, "Locust Swarm", 0, 17)
			end
		end
		if event == "SPELL_AURA_REMOVED" then
			if spell_id == 28785 or spell_id == 54021 then
				t:cancel_timer("Locust Swarm")
				t:create_timer(80, "Next Locust Swarm", 0, 34)
			end
		end
	end
end)

-- FAERLINA
local faerlina = 15953

local g = CreateFrame("Frame")
g:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
g:SetScript("OnEvent", function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		if event == "SPELL_CAST_SUCCESS" then
			if spell_id == 28732 or spell_id == 54097 then
				-- Widow's Embrace
				t:create_timer(30, "Widow's Embrace", 0, 34)
				t:warning("Embrace Active")
			end
		end
		if event == "SPELL_AURA_APPLIED" then
			if spell_id == 28798 or spell_id == 54100 then
				t:warning("ENRAGED")
			end
		end
	end
end)

-- MAEXXNA
local maexxna = 15952
local h = CreateFrame("Frame")
h:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
h:SetScript("OnEvent", function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		if event == "SPELL_CAST_SUCCESS" then
			if spell_id == 29484 or spell_id == 54125 then
				-- Web Spray
				t:warning("Web Spray")
				t:cancel_timer("BABIES")
				t:create_timer(30, "BABIES", 0, 34)
				t:cancel_timer("Next Web Spray")
				t:create_timer(40.5, "Next Web Spray", 0, 17)
				t:warning("Embrace Active")
			end
		end
		if event == "SPELL_AURA_APPLIED" then
			if spell_id == 28622 then
				t:warning("Web Wrap")
			end
		end
	end
end)
