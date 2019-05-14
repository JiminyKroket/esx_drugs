USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cannabis', 'Cannabis', 50, 0, 1),
	('marijuana', 'Marijuana', 50, 0, 1),
	('coca', 'CocaPlant', 150, 0, 1),
	('cocaine', 'Coke', 50, 0, 1),
	('ephedra', 'Ephedra', 100, 0, 1),
	('ephedrine', 'Ephedrine', 100, 0, 1),
	('poppy', 'Poppy', 100, 0, 1),
	('opium', 'Opium', 50, 0, 1),
	('meth', 'Meth', 25, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('weed_processing', 'Weed Processing License'),
	('cocaine_processing', 'Coke Processing License'),
	('ephedrine_processing', 'Ephedrine Processing License'),
	('meth_processing', 'Meth Processing License'),
	('opium_processing', 'Opium Processing License')
;