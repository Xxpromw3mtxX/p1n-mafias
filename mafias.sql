SET @society_name = 'society_cartel'
SET @society_money = 'society_cartel_money'
SET @society_blackMoney = 'society_cartel_blackMoney'
SET @society_label = 'Cartel'
SET @society_money_label = 'Cartel Money'
SET @society_blackMoney_label = 'Cartel Black Money'
SET @society_job_name = 'cartel'

INSERT INTO `addon_account` (name, label, shared) VALUES
	(@society_name, @society_label, 1),
    (@society_money, @society_money_label, 1),
    (@society_blackMoney, @society_blackMoney_label, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	(@society_name, @society_label, 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	(@society_name, @society_label, 1)
;

INSERT INTO `jobs` (name, label) VALUES
	(@society_job_name, @society_label)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	(@society_job_name,0,'recruit','Recruit',100,'{}','{}'),
	(@society_job_name,1,'expert','Official',100,'{}','{}'),
    (@society_job_name,2,'viceboss','Co-Manager',100,'{}','{}'),
    (@society_job_name,3,'boss','Boss',100,'{}','{}'),
;