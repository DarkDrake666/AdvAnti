--[[

Credits:
Exunys - for the original idea and basic hookmetamethod layouts

]]

repeat task.wait() until game:IsLoaded()
getgenv().SendNotifications = true

local OldNameCall; OldNameCall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
	local NameCallMethod = getnamecallmethod()

	local args = {...}
	
	local CallingScript = rawget(getfenv(2),"script") or getcallingscript()

	if tostring(string.lower(NameCallMethod)) ~= "kick" then
		return OldNameCall(Self, ...)
	end

	if checkcaller() and string.lower(tostring(NameCallMethod)) == "kick" then
		if getgenv().SendNotifications == true then
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Advanti's Services",
				Text = "Script attempted to kick.",
				Duration = 3,
			})
			print("Script attempted to kick: \nReason: "..tostring(args[1]).."\nFrom Script: "..tostring(CallingScript.Name))
		end
		return nil
	end

	if string.lower(tostring(NameCallMethod)) == "kick" then
		if getgenv().SendNotifications == true then
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Advanti's Services",
				Text = "Game attempted to kick.",
				Duration = 3,
			})
			print("Game attempted to kick: \nReason: "..tostring(args[1]).."\nFrom Script: "..tostring(CallingScript.Name).."Script Path: game."..tostring(CallingScript:GetFullName()))
		end

		return nil
	end

	return OldNameCall(Self, ...)
end))

if getgenv().SendNotifications == true then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Advanti's Services",
        Text = "Anti-Kick script loaded",
        Duration = 5,
    })
    print("Anti-Kick script loaded!")
end
