# Gilded Convert Script
# Created by InepsaOG and shared for the VORP community

This script is incredibly handy and we use it for literally hundreds of items on our live server. 
Provided in the CFG is a tiny snippet of what we use to give you ideas

Feel free to edit or use any part of the script as long as you give credit where due

# Requirements
Vorp Core - Newest

Vorp_Inventory - Newest

Vorp_animations - Newest

Ensure that vorp_animations is started before gilded_convert in your resources or server cfg files

# Features
Open cigarette packs, crates that carry ore, pack cigarettes into packages

Turn an item or a list of items into a weapon with a double click

Animations for each item in your cfg

Random item option for things like grab bags

Notifications for everything taken, given etc.

# Potenitally adding in
Webhooks. Used to have them but not incredibly useful information so im 50/50 on them
Take in actual weapons to break down into parts

# REQUIREMENTS Part 2

You will need to add some code to your vorp_animations script in the Config.Animations {} table if you want to use the animation in the cfg

    ["inspection1"] = {
        dict = "mech_inspection@cigarette_card_multiple@satchel",
        name = "enter", 
        flag = 17,
        type = 'standard'
	},
    ["inspection2"] = {
        dict = "mech_inventory@item@_templates@cylinder@d6-5_h1-5_inspectz@unarmed@base",
        name = "inspect_sweep_extents", 
        flag = 17,
        type = 'standard'
	},