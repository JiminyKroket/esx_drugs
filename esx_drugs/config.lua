Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 10,
	CocaineProcessing = 2000 * 10,
	EphedrineProcessing = 2000 * 10,
	MethProcessing = 2000 * 10,
	PoppyProcessing = 2000 * 10
}

Config.DrugDealerItems = {
	marijuana = 5,
	cocaine = 15,
	meth = 40,
	opium = 15
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000},
	cocaine_processing = {label = _U('license_cocaine'), price = 15000},
	ephedrine_processing = {label = _U('license_ephedrine'), price = 15000},
	meth_processing = {label = _U('license_meth'), price = 15000},
	opium_processing = {label = _U('license_opium'), price = 15000}
}

Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(310.91, 4290.87, 45.15), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(2329.02, 2571.29, 46.68)},
	
	CocaineField = {coords = vector3(1849.8, 4914.2, 44.92), name = _U('blip_cocainefield'), color = 62, sprite = 310, radius = 100.0},
	CocaineProcessing = {coords = vector3(974.72, -100.91, 74.87)},
	
	EphedrineField = {coords = vector3(1591.18, -1982.81, 95.12), name = _U('blip_ephedrinefield'), color = 62, sprite = 310, radius = 100.0},
	EphedrineProcessing = {coords = vector3(-1078.62, -1679.62, 4.58)},
	
	MethProcessing = {coords = vector3(1391.94, 3605.94, 38.94)},
	
	PoppyField = {coords = vector3(-1815.83, 1972.43, 132.71), name = _U('blip_poppyfield'), color = 62, sprite = 310, radius = 50.0},
	PoppyProcessing ={coords = vector3(3559.76, 3674.54, 28.12)}, 
	

	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = _U('blip_drugdealer'), color = 25, sprite = 140, radius = 10},
}