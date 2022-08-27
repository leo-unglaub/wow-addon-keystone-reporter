-- our Addon namespace
KeystoneReporter = {}
KeystoneReporter.Sender = {}


-- A short helper to count the number of entries in
-- a table
KeystoneReporter.countTable = function(table)
	local counter = 0

	for key, value in pairs(KeystoneReporter.findKeysInBag) do
		counter = counter + 1
	end

	return counter
end


-- Find all keys in all bags
--
-- How does this work? We start by going over all the bags we have. In
-- every bag we get the amound of slots and then check the item on every
-- slot. We use `GetItemInfo()` to get informations about the type of item.
-- We use that information to check what type it is and if it actually is a
-- keystone. If it is, we use `GetContainerItemInfo()` to get informations
-- about the actual item itself. This is also the information we use to display
-- in the link.
KeystoneReporter.findKeysInBag = function()
	local allFoundKeys = {}

	-- go over all bags, including the base backpack
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do

		-- get all slots in "bag"
		for bagSlots = 1, GetContainerNumSlots(bag) do
			local _, _, _, _, _, _, itemLink, _, _, itemID, _ = GetContainerItemInfo(bag, bagSlots)

			-- check if there is an item at this position in the bag
			if itemID ~= nil then
				local _, _, _, _, _, _, _, _, _, _, _, classID, subclassID, _, _, _, _ = GetItemInfo(itemID)

				-- check if the item is actually a keystone
				if classID == Enum.ItemClass.Reagent and subclassID == Enum.ItemReagentSubclass.Keystone then
					table.insert(allFoundKeys, itemLink)
				end
			end
		end
	end

	return allFoundKeys
end


-- Send a message with all the keystones to the current party
KeystoneReporter.Sender.party = function()
	for key, value in pairs(KeystoneReporter.findKeysInBag()) do
		SendChatMessage(value, "PARTY")
	end
end


-- Send a message with all the keystones to the current guild
KeystoneReporter.Sender.guild = function()
	for key, value in pairs(KeystoneReporter.findKeysInBag()) do
		SendChatMessage(value, "GUILD")
	end
end


-- Send a message wit all the keystones to all friends (online only)
KeystoneReporter.Sender.friends = function()
	for friendId = 1, BNGetNumFriends() do
		local friend = C_BattleNet.GetAccountInfoByID(friendId)

		if friend
			and friend.gameAccountInfo.clientProgram == BNET_CLIENT_WOW
			and friend.gameAccountInfo.isOnline == true
			and friend.gameAccountInfo.isGameAFK == false
			and friend.gameAccountInfo.isGameBusy == false then
			for _, value in pairs(KeystoneReporter.findKeysInBag()) do
				BNSendWhisper(friendId, value)
			end
		end
	end
end
