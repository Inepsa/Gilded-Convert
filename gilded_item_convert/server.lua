
local VORPcore = exports.vorp_core:GetCore()

local function selectRewardItem(rewardItems)
    local totalWeight = 0
    for _, item in ipairs(rewardItems) do
        totalWeight = totalWeight + item.rarity
    end

    local randomWeight = math.random() * totalWeight
    local cumulativeWeight = 0

    for _, item in ipairs(rewardItems) do
        cumulativeWeight = cumulativeWeight + item.rarity
        if randomWeight <= cumulativeWeight then
            return item
        end
    end
end

local function canPlayerCarryItems(source, rewardItems)
    local _source = source
    local User = VORPcore.getUser(_source)
    local Character = User.getUsedCharacter
    local inventoryLimit = Character.invCapacity

    local inventoryItems, err = exports['vorp_inventory']:getUserInventoryItems(_source, nil)
    if not inventoryItems then
        print("Error retrieving inventory items: " .. err)
        return false
    end

    local itemCounts = {}
    for _, inventoryItem in ipairs(inventoryItems) do
        itemCounts[inventoryItem.name] = (itemCounts[inventoryItem.name] or 0) + inventoryItem.count
    end

    for _, rewardItem in ipairs(rewardItems) do
        local itemName = rewardItem.item
        local itemCount = rewardItem.count
        local itemLimit = exports['vorp_inventory']:getItemDB(itemName, nil).limit
        local totalCount = (itemCounts[itemName] or 0) + itemCount

        if totalCount > itemLimit then
            return false
        end

        itemCounts[itemName] = totalCount
    end

    local totalItems = 0
    for _, count in pairs(itemCounts) do
        totalItems = totalItems + count
    end

    return totalItems <= inventoryLimit
end

local function takeItemsFromPlayer(source, takenItems)
    local takenItemsText = ""
    for _, takenItem in pairs(takenItems) do
        local success, err = exports.vorp_inventory:subItem(source, takenItem.item, takenItem.count, {})
        if not success then
            print("Error taking item from player: " .. err)
            TriggerClientEvent('vorp:TipRight', source, 'Failed to take item!', 5000)
            return ""
        end
        takenItemsText = takenItemsText .. takenItem.item .. " x" .. takenItem.count .. "\n"
        Wait(100) 
    end
    return takenItemsText
end

local function giveRewardItemsToPlayer(source, rewardItems, isRarityBased)
    local rewardItemsText = ""
    local addedRewardItems = 0

    if isRarityBased then
        local selectedRewardItem = selectRewardItem(rewardItems)
        local hasSpace, err = exports['vorp_inventory']:canCarryItem(source, selectedRewardItem.item,
            selectedRewardItem.count)
        if not hasSpace then
            print("Error checking if player can carry item: " .. err)
            TriggerClientEvent('vorp:TipRight', source, 'You can\'t hold any more!', 5000)
            return false
        end

        if hasSpace then
            local success, err = exports['vorp_inventory']:addItem(source, selectedRewardItem.item,
                selectedRewardItem.count, {})
            if not success then
                print("Error giving reward item to player: " .. err)
                return false
            end
            rewardItemsText = rewardItemsText .. selectedRewardItem.item .. " x" .. selectedRewardItem.count .. "\n"
            addedRewardItems = addedRewardItems + 1
        end
    else
        local hasSpace = canPlayerCarryItems(source, rewardItems)

        if hasSpace then
            for _, rewardItem in pairs(rewardItems) do
                local success, err = exports['vorp_inventory']:addItem(source, rewardItem.item, rewardItem.count, {})
                if not success then
                    print("Error giving reward item to player: " .. err)
                else
                    rewardItemsText = rewardItemsText .. rewardItem.item .. " x" .. rewardItem.count .. "\n"
                    addedRewardItems = addedRewardItems + 1
                end
                Wait(100)
            end
        else
            TriggerClientEvent('vorp:TipRight', source, 'You can\'t hold any more!', 5000)
        end
    end

    return addedRewardItems > 0
end

local function giveWeaponRewardToPlayer(source, weaponData)
    local weaponName = string.upper(weaponData.weapon)
    local weaponAmount = weaponData.count or 1

    if string.sub(weaponName, 1, string.len("WEAPON_")) == "WEAPON_" then
        for i = 1, weaponAmount do
            exports.vorp_inventory:createWeapon(source, weaponName, {}, {}, {}, function(success)
                if success then
                    TriggerClientEvent('vorp:Notify', source, "You received: " .. weaponName .. " x" .. weaponAmount, 5000)
                else
                    print("Error giving weapon reward to player: " .. weaponName)
                    TriggerClientEvent('vorp:TipRight', source, 'Failed to give weapon reward!', 5000)
                end
            end)
        end
    else
        print("Invalid weapon name: " .. weaponName)
        TriggerClientEvent('vorp:TipRight', source, 'Invalid weapon reward!', 5000)
        end
end

-- Register usable items for item conversion, main logic
for _, item in pairs(Config.ConvertItems) do
    exports['vorp_inventory']:registerUsableItem(item.UsableItem, function(data)
        local _source = data.source
        if not _source then
            print("Error: _source is nil")
            return
        end

        local canCarry = canPlayerCarryItems(_source, item.RewardItems)
        if not canCarry then
            TriggerClientEvent('vorp:TipRight', _source, item.ErrorMsg, 5000)
            return
        end

        local inventoryItems = exports['vorp_inventory']:getUserInventoryItems(_source, nil)

        local missingItems = {}
        for _, takenItem in pairs(item.TakenItems) do
            local itemFound = false
            for _, inventoryItem in pairs(inventoryItems) do
                if inventoryItem.name == takenItem.item and inventoryItem.count >= takenItem.count then
                    itemFound = true
                    break
                end
            end
            if not itemFound then
                table.insert(missingItems, takenItem)
            end
        end

        if #missingItems > 0 then
            local missingItemsList = "Missing items:\n"
            for _, missingItem in ipairs(missingItems) do
                missingItemsList = missingItemsList .. "- " .. missingItem.item .. " x" .. missingItem.count .. "\n"
            end
            TriggerClientEvent('vorp:TipRight', _source, missingItemsList, 8000)
            return
        end

        -- Take items from the player's inventory
        local takenItemsText = takeItemsFromPlayer(_source, item.TakenItems)
        local rewardItemsGiven = false
        local selectedRewardItem = nil

        if item.RewardItemsRarity then
            selectedRewardItem = selectRewardItem(item.RewardItems)
            local hasSpace = exports['vorp_inventory']:canCarryItem(_source, selectedRewardItem.item, selectedRewardItem.count)

            if hasSpace then
                local success = exports['vorp_inventory']:addItem(_source, selectedRewardItem.item, selectedRewardItem.count)
                if success then
                    rewardItemsGiven = true
                end
            end
        else
            rewardItemsGiven = giveRewardItemsToPlayer(_source, item.RewardItems, false)
        end
        if item.WeaponReward then
            for _, weaponData in ipairs(item.WeaponItems) do
                giveWeaponRewardToPlayer(_source, weaponData)
            end
        end

       local takenItemsList = "Items taken:\n"
       for _, takenItem in ipairs(item.TakenItems) do
           takenItemsList = takenItemsList .. "- " .. takenItem.item .. " x" .. takenItem.count .. "\n"
       end
       TriggerClientEvent('vorp:TipRight', _source, takenItemsList, 5000)

       if item.RewardItemsRarity and rewardItemsGiven then
           local rewardItemText = "You received: " .. selectedRewardItem.item .. " x" .. selectedRewardItem.count
           TriggerClientEvent('vorp:TipRight', _source, rewardItemText, 5000)
       elseif not rewardItemsGiven then
           TriggerClientEvent('vorp:TipRight', _source, "You didn't receive any reward item.", 5000)
       end

        TriggerClientEvent('gilded_custom:playAnimation', _source, item.animation, item.duration)

    end)
end