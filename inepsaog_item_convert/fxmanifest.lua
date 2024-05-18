
fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author "InepsaOG"
games {"rdr3"}
description 'A script that converts items and weapons, with optional animations using vorp_animations'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client_animations.lua',
}

server_scripts {
    'server.lua',
}