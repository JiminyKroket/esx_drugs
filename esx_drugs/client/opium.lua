local spawnedPoppy = 0
local poppyPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.PoppyField.coords, true) < 50 then
			SpawnPoppyPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.PoppyProcessing.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('opium_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then

				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							ProcessPoppy()
						else
							OpenBuyLicenseMenu('opium_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'opium_processing')
				else
					ProcessPoppy()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessPoppy()
	isProcessing = true

	ESX.ShowNotification(_U('opium_processingstarted'))
	TriggerServerEvent('esx_drugs:processPoppy')
	local timeLeft = Config.Delays.PoppyProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.PoppyProcessing.coords, false) > 4 then
			ESX.ShowNotification(_U('opium_processingtoofar'))
			TriggerServerEvent('esx_drugs:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #poppyPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(poppyPlants[i]), false) < 1 then
				nearbyObject, nearbyID = poppyPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('opium_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(poppyPlants, nearbyID)
						spawnedPoppy = spawnedPoppy - 1
		
						TriggerServerEvent('esx_drugs:pickedUpPoppy')
					else
						ESX.ShowNotification(_U('opium_inventoryfull'))
					end

					isPickingUp = false

				end, 'opium')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(poppyPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnPoppyPlants()
	while spawnedPoppy < 25 do
		Citizen.Wait(0)
		local poppyCoords = GeneratePoppyCoords()

		ESX.Game.SpawnLocalObject('prop_plant_group_03', poppyCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(poppyPlants, obj)
			spawnedPoppy = spawnedPoppy + 1
		end)
	end
end

function ValidatePoppyCoord(plantCoord)
	if spawnedPoppy > 0 then
		local validate = true

		for k, v in pairs(poppyPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.PoppyField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratePoppyCoords()
	while true do
		Citizen.Wait(1)

		local poppyCoordX, poppyCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		poppyCoordX = Config.CircleZones.PoppyField.coords.x + modX
		poppyCoordY = Config.CircleZones.PoppyField.coords.y + modY

		local coordZ = GetCoordZ(poppyCoordX, poppyCoordY)
		local coord = vector3(poppyCoordX, poppyCoordY, coordZ)

		if ValidatePoppyCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 115.0, 116.0, 117.0, 118.0, 119.0, 120.0, 121.0, 122.0, 123.0, 124.0, 125.0, 126., 127.0, 128.0, 129.0, 130.0, 131.0, 132.0, 133.0, 134.0, 135.0, 136.0, 137.0, 138.0, 139.0, 140.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 128.0
end