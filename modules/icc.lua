-- $Id: icc.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, t = ...
local lord_marrowgar = 36612
local coldflame_elapsed = 0
-- This frame will not be here in final version.
local event_frame = CreateFrame("Frame")
event_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
-- enrage @ 600
event_frame:SetScript("OnEvent", function(self, event, ...)

--	if event == "CHAT_MSG_MONSTER_YELL" then
--		if select(1, ...) == "This meaningless exertion bores me. I'll incinerate you all from above!" then
--			recBossTimers:warning("PHASE 2")
--		end
--	end
	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		if event == "SPELL_CAST_START" then
			if spell_id == 69057 or spell_id == 70826 then
				t:warning("Bone Spike")
				t:create_timer(18, "Bone Spike CD", 0, 0)
			end
		elseif event == "SPELL_PERIODIC_DAMAGE" then
			if spell_id == 69146 or spell_id == 70823 or spell_id == 70824 or spell_id == 70825 then
				if dest_guid == UnitGUID("player") and GetTime() - coldflame_elapsed > 2 then
					t:warning("COLDFLAME MOVE!")
					coldflame_elapsed = GetTime()
				end
			end
		elseif event == "SPELL_SUMMON" then
			if spell_id == 69062 or spell_id == 72669 or spell_id == 72670 then
				t:warning("Impaled!")
			end
		elseif event == "SPELL_AURA_APPLIED" then
			if spell_id == 69076 then
				t:warning("WHIRLWIND")
				t:create_timer(90, "Whirlwind CD", 0, 0)
				t:create_timer(20, "Whirlwind", 0, 0) -- 40s on heroic mode
				-- 10 normal, stop bonespike timer
			end
		elseif event == "SPELL_AURA_REMOVED" then
			if spell_id == 69065 then
				-- end ww
			end
			if spell_id == 69076 then
				-- 10 mornal, start bonespike again, every 15s
			end
		end
	end
end)

--function mod:OnCombatStart(delay)
--	timerWhirlwindCD:Start(45-delay)
--	timerBoneSpike:Start(15-delay)
--	berserkTimer:Start(-delay)
--end

---------------------------
--  Trash - Lower Spire  --
---------------------------
--
--L:SetWarningLocalization{
--	specWarnTrap		= "Trap Activated! - Deathbound Ward released"--creatureid 37007
--}
--L:SetOptionLocalization{
--	specWarnTrap		= "Show special warning for trap activation",
--	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
--	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
--}
--L:SetMiscLocalization{
--	WarderTrap1		= "Who... goes there...?",
--	WarderTrap2		= "I... awaken!",
--	WarderTrap3		= "The master's sanctum has been disturbed!"
--}