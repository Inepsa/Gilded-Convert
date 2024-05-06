Config = {}


Config.ConvertItems = {

    -- UsableItem is your database item that you double click to use. 
    -- All taken items and reward items must be in your databse
    
    --------------------------------------------------------
    --Crates
    --------------------------------------------------------
    {
		UsableItem = "whetstone_crate_empty",
		ErrorMsg = "Not enough space",
		SuccessMsg = "You Packed up 50 Whetstone",
		WebhookName = "",
		TakenItems = {
			{ item = "whetstone_crate_empty", count = 1 },
			{ item = "whetstone", count = 50 },
		},
		RewardItemsRarity = false,
        RewardItems = {
			{ item = "whetstone_crate_full", count = 1 },
		},
		WeaponReward = false,
		WeaponRewardAmt = 0,
		WeaponItems = { { weapon = "" } },
        animation = "inspection2",
		duration = 2000,
	},
	{
		UsableItem = "whetstone_crate_full",
		ErrorMsg = "Not enough space",
		SuccessMsg = "You Took Out 50 Whetstone",
		WebhookName = "",
		TakenItems = {
			{ item = "whetstone_crate_full", count = 1 },
		},
		RewardItemsRarity = false,
        RewardItems = {
			{ item = "whetstone", count = 50 },
		},
		WeaponReward = false,
		WeaponRewardAmt = 0,
		WeaponItems = { { weapon = "" } },
        animation = "inspection2", 
		duration = 2000,
	},

    --------------------------------------------------------
    --Random Items
    --------------------------------------------------------
	{
		UsableItem = "bag_paper",
		ErrorMsg = "You need at least 1",
		SuccessMsg = "You found something out of that dirty bag",
		WebhookName = "",
		TakenItems = {
			{ item = "bag_paper", count = 1 },
		},
		RewardItemsRarity = true,
		RewardItems = {
			{ item = "paper", count = 1, rarity = 150 },            -- 18.2% chance 
			{ item = "bread", count = 1, rarity = 120 },            -- 14.6% chance 
			{ item = "cash_1", count = math.random(1,5), rarity = 110 }, -- 13.4% chance 
			{ item = "beeswax", count = 1, rarity = 100 },          -- 12.2% chance
			{ item = "nails", count = 1, rarity = 90 },             -- 10.9% chance
			{ item = "fat", count = 1, rarity = 80 },               -- 9.7% chance
			{ item = "pen", count = 1, rarity = 70 },               -- 8.5% chance
			{ item = "cash_5", count = 1, rarity = 50 },            -- 6.1% chance
			{ item = "meat_venison", count = 1, rarity = 40 },      -- 4.9% chance
			{ item = "seed_marijuana", count = 1, rarity = 6 },     -- 0.7% chance
			{ item = "splint", count = 1, rarity = 5 },             -- 0.6% chance
			{ item = "goldnugget", count = 1, rarity = 2 },         -- 0.2% chance
			{ item = "weed_sell", count = 1, rarity = 1 },          -- 0.1% chance
		},
		WeaponReward = false,
		WeaponRewardAmt = 0,
		WeaponItems = { { weapon = "" } },
		animation = "inspection2", 
		duration = 2000, 
	},

    --------------------------------------------------------
    -- Convert an item into a weapon
    --------------------------------------------------------
    {
		UsableItem = "weapon_shotgun_sawedoff", 
		ErrorMsg = "You need more", 
		SuccessMsg = "Equipped", 
		WebhookName = "", 
		TakenItems = {
			{ item = "weapon_shotgun_sawedoff", count = 1 },
		},

		RewardItemsRarity = false,
        RewardItems = {},
		WeaponReward = true, 
		WeaponRewardAmt = 1, 
		WeaponItems = { { weapon = "WEAPON_SHOTGUN_SAWEDOFF" } },
		CashReward = 0, 
		GoldReward = 0,
        animation = "inspection2", -- relates to vorp_animations anim name
		duration = 2000,	 -- duration you want the anim to play 
	},
}