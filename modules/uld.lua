-- $Id: uld.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local _, recBossTimers = ...

-- FLAME LEVIATHAN
local event_frame = CreateFrame("Frame")
event_frame:RegisterEvent("CHAT_MSG_MONSTER_YELL")
event_frame:RegisterEvent("CHAT_MSG_MONSTER_SAY")

event_frame:SetScript("OnEvent", function(self, event, ...)

	if event == "CHAT_MSG_MONSTER_YELL" or event == "CHAT_MSG_MONSTER_SAY" then
		if select(1, ...) == "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation." then
			event_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end
	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name, spell_type = ...
		if event == "SPELL_SUMMON" and spell_id == 62907 then
			recBossTimers:warning("Ward of Life spawned")
			
		elseif event == "SPELL_AURA_APPLIED" then
			if spell_id == 62396 then
				recBossTimers:create_timer(10, "Flame Vents", 0, 17)
			elseif spell_id == 62475 then
				recBossTimers:warning("System Overload")
				recBossTimers:create_timer(20, "System Overload", 0, 34)
			elseif spell_id == 62374 then
				if dest_guid == UnitGUID("player") then
					recBossTimers:warning("PURSUING YOU!")
				else
					recBossTimers:warning("Pursuing: "..dest_name)
				end
				recBossTimers:create_timer(30, "Next Pursuit", 0, 0)
			elseif spell_id == 62297 then
				recBossTimers:warning("Hodir's Fury: "..dest_name)
			end
			
		elseif event == "SPELL_AURA_REMOVED" and spell_id == 62396 then
			recBossTimers:cancel_timer("Flame Vents")
		end
	end
end)

-- IGNIS
--[[
local mod	= DBM:NewMod("Ignis", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2516 $"):sub(12, -3))
mod:SetCreatureID(33118)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local announceSlagPot			= mod:NewAnnounce("WarningSlagPot", 3, 63477)

local warnFlameJetsCast			= mod:NewSpecialWarning("SpecWarnJetsCast")

local timerFlameJetsCast		= mod:NewCastTimer(2.7, 63472)
local timerFlameJetsCooldown	= mod:NewCDTimer(35, 63472)
local timerScorchCooldown		= mod:NewNextTimer(25, 63473)
local timerScorchCast			= mod:NewCastTimer(3, 63473)
local timerSlagPot				= mod:NewTargetTimer(10, 63477)
local timerAchieve				= mod:NewAchievementTimer(240, 2930, "TimerSpeedKill")

mod:AddBoolOption("SlagPotIcon")

function mod:OnCombatStart(delay)
	timerAchieve:Start()
	timerScorchCooldown:Start(12-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62680, 63472) then		-- Flame Jets
		timerFlameJetsCast:Start()
		warnFlameJetsCast:Show()
		timerFlameJetsCooldown:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62548, 63474) then	-- Scorch
		timerScorchCast:Start()
		timerScorchCooldown:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62717, 63477) then		-- Slag Pot
		announceSlagPot:Show(args.destName)
		timerSlagPot:Start(args.destName)
		if self.Options.SlagPotIcon then
			self:SetIcon(args.destName, 8, 10)
		end
	end
end--]]