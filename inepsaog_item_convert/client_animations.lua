local Animations = exports.vorp_animations.initiate() -- Vorp animations

RegisterNetEvent('gilded_custom:playAnimation')
AddEventHandler('gilded_custom:playAnimation', function(animation, duration)
	Animations.playAnimation(animation, duration)
	Citizen.Wait(duration)
	Animations.endAnimation(animation)
end)