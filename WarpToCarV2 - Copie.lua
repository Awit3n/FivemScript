local changeDriverKey = 306
local changeDriverKeys = 73
local displayTime = 1000
local display = false
local DriverDistance = 0
function DrawTextOnScreen(text, x, y, scale, color)
SetTextFont(4)
SetTextProportional(0)
SetTextScale(scale, scale)
SetTextColour(color[1], color[2], color[3], color[4]) 
SetTextDropShadow(0, 0, 0, 0, 255)
SetTextEdge(1, 0, 0, 0, 255)
SetTextEntry("STRING")
SetTextCentre(true)
AddTextComponentString(text)
DrawText(x, y)
end
function DrawRectOnScreen(x, y, width, height, color)
DrawRect(x, y, width, height, color[1], color[2], color[3], color[4])
end
Citizen.CreateThread(function()
    local startTime = GetGameTimer()
    while true do
        Citizen.Wait(0)
        if display and (GetGameTimer() - startTime < displayTime) then
            DrawRectOnScreen(0.5, 0.5, 0.4, 0.1, { 0, 0, 0, 150 })
            DrawTextOnScreen("! DISCLAIMER !", 0.5, 0.45, 1.0, { 255, 255, 0, 255 })
            DrawTextOnScreen("CE SCRIPT EST FAIT PAR AWITEN ON TOP", 0.5, 0.50, 0.6, { 255, 255, 255, 255 })
        else
            display = false
        end
    end
end)

function RequestControl(entity)
if not DoesEntityExist(entity) then
    return false
    end
    local attempt = 0
    while not NetworkHasControlOfEntity(entity) and attempt < 150 do
        NetworkRequestControlOfEntity(entity)
        Citizen.Wait(4)
        attempt = attempt + 1
    end
    return NetworkHasControlOfEntity(entity)
end


function UnlockAll(vehicle)
    local vehicle = GetClosestVehicleCustom()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    SetVehicleDoorsLocked(vehicle, 1)
end


function ForceDriverOut(vehicle)
    if not DoesEntityExist(vehicle) then return end
    local driver = GetPedInVehicleSeat(vehicle, -1)
    if DoesEntityExist(driver) then
        SetEntityAsMissionEntity(driver, true, true)
        DeleteEntity(driver)
    end
    if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end
end


function ForcePassengerOut(vehicle)
    if not DoesEntityExist(vehicle) then return end
    local driver = GetPedInVehicleSeat(vehicle, 0)
    if DoesEntityExist(driver) then
        SetEntityAsMissionEntity(driver, true, true)
        DeleteEntity(driver)
    end
    if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, 0) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 0)
    end
end


function ForcePassengerDriverOut(vehicle)
    if not DoesEntityExist(vehicle) then return end
    local driver = GetPedInVehicleSeat(vehicle, 1)
    if DoesEntityExist(driver) then
        SetEntityAsMissionEntity(driver, true, true)
        DeleteEntity(driver)
    end
    if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, 1) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 1)
    end
end


function ForceBackPassengerOut(vehicle)
    if not DoesEntityExist(vehicle) then return end
    local driver = GetPedInVehicleSeat(vehicle, 2)
    if DoesEntityExist(driver) then
        SetEntityAsMissionEntity(driver, true, true)
        DeleteEntity(driver)
    end
    if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, 2) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 2)
    end
end


function Force3Out(vehicle)
    if not DoesEntityExist(vehicle) then return end
    local driver = GetPedInVehicleSeat(vehicle, 3)
    if DoesEntityExist(driver) then
        SetEntityAsMissionEntity(driver, true, true)
        DeleteEntity(driver)
    end
    if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, 3) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 3)
    end
end

function Force4Out(vehicle)
    if not DoesEntityExist(vehicle) then return end
    local driver = GetPedInVehicleSeat(vehicle, 4)
    if DoesEntityExist(driver) then
        SetEntityAsMissionEntity(driver, true, true)
        DeleteEntity(driver)
    end
    if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, 4) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 4)
    end
end

function Force5Out(vehicle)
    if not DoesEntityExist(vehicle) then return end
    local driver = GetPedInVehicleSeat(vehicle, 5)
    if DoesEntityExist(driver) then
        SetEntityAsMissionEntity(driver, true, true)
        DeleteEntity(driver)
    end
    if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, 5) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 5)
    end
end




function changeDriver(vehicle)
    ForcePassengerOut(vehicle)
    Citizen.Wait(50)
    ForcePassengerDriverOut(vehicle)
    Citizen.Wait(50)
    ForceBackPassengerOut(vehicle)
    Citizen.Wait(50)
    ForceDriverOut(vehicle)
    Citizen.Wait(50)
    Force3Out(vehicle)
    Citizen.Wait(50)
    Force4Out(vehicle)
    Citizen.Wait(50)
    Force5Out(vehicle)
end
function changeDrivers(vehicle)
    if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
        print("Omg T'es déjà A la place du conducteur")
    elseif IsVehicleSeatFree(vehicle, -1) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

    elseif IsVehicleSeatFree(vehicle, 0) then
        ForcePassengerOut(vehicle)
        Citizen.Wait(75)
        ForceDriverOut(vehicle)

    elseif IsVehicleSeatFree(vehicle, 1) then
        ForcePassengerDriverOut(vehicle)
        Citizen.Wait(75)
        ForceDriverOut(vehicle)

    elseif IsVehicleSeatFree(vehicle, 2) then
        ForceBackPassengerOut(vehicle)
        Citizen.Wait(75)
        ForceDriverOut(vehicle)
    elseif IsPedInAnyVehicle(PlayerPedId(), false) then
        ForceDriverOut(vehicle)
    else
        print("Definitivement cooked")
    end
end
function GetClosestVehicleCustom()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local closestVehicle = nil
    local closestDistance = 10.0  -- Rayon de recherche ajustable
    local handle, vehicle = FindFirstVehicle()
    local success
    repeat
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = #(coords - vehicleCoords)
        if distance < closestDistance then
            closestDistance = distance
            closestVehicle = vehicle
        end
        success, vehicle = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return closestVehicle
end
function ChangeDriverNearby()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle == 0 then
        vehicle = GetClosestVehicleCustom()
    end
    if vehicle ~= 0 and DoesEntityExist(vehicle) then
        changeDriver(vehicle)
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0}, 
            multiline = true,
            args = {"^1No Vehicles Nearby^7"}
        })
    end
end
function ChangeDriversNearby()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle == 0 then
        vehicle = GetClosestVehicleCustom()
    end
    if vehicle ~= 0 and DoesEntityExist(vehicle) then
        changeDrivers(vehicle)
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0}, 
            multiline = true,
            args = {"^1No Vehicles Nearby^7"}
        })
    end
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, changeDriverKey) then
            UnlockAll()
            ChangeDriverNearby()
        end
        if IsControlJustReleased(1, changeDriverKeys) then
            UnlockAll()
            ChangeDriversNearby()
            print("key pressed")
        end
    end
end)