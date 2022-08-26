KeystoneReporter.HandlerSlashCommands = {}

-- Handle the following slash commands:
--  * /keys
--  * /mykeys
--  * /reportkeys
KeystoneReporter.HandlerSlashCommands.Party = function ()
	KeystoneReporter.Sender.party()
end

-- Handle the following slash commands:
--  * /reportkeysguild
KeystoneReporter.HandlerSlashCommands.Guild = function ()
	KeystoneReporter.Sender.guild()
end

-- Handle the following slash commands:
--  * /reportkeysfirends
KeystoneReporter.HandlerSlashCommands.Friends = function ()
	KeystoneReporter.Sender.friends()
end



-- Register all slash commands
SLASH_KEYSTONE_REPORTER1 = "/keys"
SLASH_KEYSTONE_REPORTER2 = "/mykeys" -- just an alias
SLASH_KEYSTONE_REPORTER3 = "/reportkeys" -- just an alias
SLASH_KEYSTONE_REPORTER4 = "/reportkeysparty" -- just an alias
SLASH_KEYSTONE_REPORTER_GUILD1 = "/reportkeysguild"
SLASH_KEYSTONE_REPORTER_FRIENDS1 = "/reportkeysfriends"


-- Register all handlers
SlashCmdList.KEYSTONE_REPORTER = KeystoneReporter.HandlerSlashCommands.Party
SlashCmdList.KEYSTONE_REPORTER_GUILD = KeystoneReporter.HandlerSlashCommands.Guild
SlashCmdList.KEYSTONE_REPORTER_FRIENDS = KeystoneReporter.HandlerSlashCommands.Friends
