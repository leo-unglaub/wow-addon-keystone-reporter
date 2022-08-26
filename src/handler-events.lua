KeystoneReporter.HandlerEvents = {}
KeystoneReporter.HandlerEvents.eventFrame = CreateFrame("EventFrame")


-- Reply to "!keys" and "!key" chat messages in a party. This responds only yo the
-- current party itself.
KeystoneReporter.HandlerEvents.ReplyToKey = function (text)
	if text == "!keys" or text == "!key" then
		KeystoneReporter.Sender.party()	
	end
end

-- A catch-all handler for all registered events
KeystoneReporter.HandlerEvents.eventFrame.MassEventHandler = function (self, event, ...)
	self[event](self, event, ...)
end

-- Event Handler: CHAT_MSG_PARTY
KeystoneReporter.HandlerEvents.eventFrame.CHAT_MSG_PARTY = function (self, text)
	KeystoneReporter.HandlerEvents.ReplyToKey(text)
end

-- Event Handler: CHAT_MSG_PARTY_LEADER
KeystoneReporter.HandlerEvents.eventFrame.CHAT_MSG_PARTY_LEADER = function (self, text)
	KeystoneReporter.HandlerEvents.ReplyToKey(text)
end


-- Event Handler: CHAT_MSG_ADDON
KeystoneReporter.HandlerEvents.eventFrame.CHAT_MSG_ADDON = function (self, text)
	-- stop if we are not interrested in the ADDON MSG
	if prefix ~= "KeystoneReporter" then
		return
	end
end



-- Event Handler: BAG_UPDATE_DELAYED
KeystoneReporter.HandlerEvents.eventFrame.BAG_UPDATE_DELAYED = function ()
end


KeystoneReporter.HandlerEvents.eventFrame:RegisterEvent("CHAT_MSG_PARTY")
KeystoneReporter.HandlerEvents.eventFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER")
KeystoneReporter.HandlerEvents.eventFrame:RegisterEvent("CHAT_MSG_ADDON")
KeystoneReporter.HandlerEvents.eventFrame:RegisterEvent("BAG_UPDATE_DELAYED")

KeystoneReporter.HandlerEvents.eventFrame:SetScript("OnEvent", KeystoneReporter.HandlerEvents.eventFrame.MassEventHandler)
