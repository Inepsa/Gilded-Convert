# Shared for the VORP community

This script is incredibly handy and we use it for literally hundreds of items on our live server. 
Makes an item usable, upon use it takes a set list of items from the inventory, and then gives a set list of items.
Provided in the CFG is a tiny snippet of what we use to give you ideas. Any ideas to improve the code are more than welcome!

Feel free to edit or use any part of the script as long as you give credit where due. 
This is totally inspired by mercury developments script which I loved, however is escrow locked. 
I wanted animations so wrote this one and cant imagine running a server without it

# Requirements
Vorp Core - Newest

Vorp_Inventory - Newest

Vorp_animations - Newest

Ensure that vorp_animations is started before inepsaog_item_convert in your resources or server cfg files

# Features
Open cigarette packs, crates, pack cigarettes into packages, sacks of flour, saloon meal boxes etc (limitless)

Turn an item or a list of items into a weapon with a double click

Animations for each item in your cfg

Random item option for things like grab bags

Notifications for everything taken, given etc.

# Future plans, when free time
- Create deployable objects/items from taken items in a conversion. Like a blueprint to create a chest/chair/whatever that takes all the requirements listed in cfg
- Breaking down the item/object would consume a tool, and return all the items originally taken
- Add optional storage (vorp exports) to those deployed objects with lockpicking mini game
- Take in actual weapons to break down into parts
- Add option to create a serial number scratch tool to alter weapon serials and consume the tool

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