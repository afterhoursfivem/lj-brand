local showCheck = false
local showBrand = false

local function updateBrand(data)
    SendNUIMessage({
    action = 'brand',
    showBrand = data[1],
})
end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    if Config.showBrand == true then
        showBrand = true
        updateBrand({
            showBrand,
        })
    end
end)

RegisterNetEvent("lj-brand:client:Logo", function()
    showBrand = not showBrand
    if showBrand == true and Config.showBrand == true then
        showBrand = true
        updateBrand({
            showBrand,
        })
    elseif showBrand == false then
        updateBrand({
            showBrand,
        })
        showBrand = false
    end
end)

AddEventHandler('lj-brand:client:open', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open"}) 
    showCheck = true
    if Config.Sound == true then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.5)
    end
end)

RegisterCommand('checklist', function()
    if not showCheck then
        SetNuiFocus(true, true)
        SendNUIMessage({ action = "open"}) 
        showCheck = true
    if Config.Sound == true then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.5)
    end
end
end)

RegisterNUICallback('closeCheckList', function()
    showCheck = false
    SetNuiFocus(false, false)
    TriggerEvent('QBCore:Notify', "Welcome to the server!", "success")
end) 

RegisterKeyMapping('checklist', 'Open Checklist', 'keyboard', Config.OpenKey)