/* create tables */

create table vaccine(
	vaccine_id serial not null,
	name varchar(100) not null unique,
	origin varchar(100) not null,
	CONSTRAINT "pk_vaccine_id" PRIMARY KEY("vaccine_id")
);


create table medical_center(
	center_id serial not null,
	name varchar(100) not null unique,
	city varchar(100) not null,
	district varchar(100) not null,
	full_address varchar(200) not null,
	CONSTRAINT "pk_center_id" PRIMARY KEY("center_id")
);


create table healthcare_professional(
	center_id int not null,
	professional_id serial not null,
	name varchar(100) not null,
	surname varchar(100) not null,
	CONSTRAINT "pk_professional_id" PRIMARY KEY("professional_id"),
	CONSTRAINT "for_key_center_id" FOREIGN KEY("center_id")
	REFERENCES medical_center("center_id") match simple
	ON UPDATE CASCADE ON DELETE CASCADE
);


create table person(
	person_id serial not null,
	name varchar(100) not null,
	surname varchar(100) not null,
	gender varchar(100) not null,
	age int not null,
	hes_code varchar(100) not null unique,
	city varchar(100) not null,
	district varchar(100) not null,
	full_address varchar(200) not null,
	CONSTRAINT "pk_person_id" PRIMARY KEY("person_id")
);


create table hes(
	hes_id serial not null,
	person_id int not null,
	phone_number varchar(100) not null unique,
	hes_code varchar(100) not null unique,
	vaccination_info varchar(100) not null,
	state_of_health varchar(100) not null,
	CONSTRAINT "pk_hes_id" PRIMARY KEY("hes_id"),
	CONSTRAINT "for_key_person_id" FOREIGN KEY("person_id")
	REFERENCES person("person_id") match simple
	ON UPDATE CASCADE ON DELETE CASCADE
);


create table vaccination_record(
	record_id serial not null,
	person_id int not null,
	vaccine_id int not null,
	professional_id int not null,
	vaccination_date date not null default current_date,
	CONSTRAINT "pk_record_id" PRIMARY KEY("record_id"),
	CONSTRAINT "for_key_person_id" FOREIGN KEY("person_id")
	REFERENCES person("person_id") match simple
	ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT "for_key_vaccine_id" FOREIGN KEY("vaccine_id")
	REFERENCES vaccine("vaccine_id") match simple
	ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT "for_key_professional_id" FOREIGN KEY("professional_id")
	REFERENCES healthcare_professional("professional_id") match simple
	ON UPDATE CASCADE ON DELETE CASCADE
);

/* insert values into tables */

INSERT into vaccine(name, origin)
VALUES
	('Biontech', 'Germany'),
	('Sinovac', 'China');


INSERT into medical_center(name, city, district, full_address)
VALUES
	('Dokuz Eyl??l University Hospital', '??zmir', 'Bal??ova', '??nciralt??, Mithatpa??a Cd. no:56, 35330 Bal??ova/??zmir'),
	('Ege University Hospital', '??zmir', 'Bornova', 'Kaz??mdirik, 35100 Bornova/??zmir'),
	('Tepecik Hospital', '??zmir', 'Konak', 'Yeni??ehir, Gaziler Cd No:468, 35020 Konak/??zmir'),
	('Cerrahpa??a Hospital', '??stanbul', 'Fatih', 'Cerrahpa??a, Koca Mustafapa??a Cd. No:53, 34098 Fatih/??stanbul'),
	('??i??li Etfal Hospital', '??stanbul', '??i??li', 'Etfal Hastanesi, Halaskargazi Cd., 34371 ??i??li/??stanbul');


INSERT into healthcare_professional(center_id, name, surname)
VALUES
	(1, 'Hande', '??zdinler'),
	(1 , '??mer', '??zkan'),
	(2 , 'Tayfun', 'Aybek'),
	(2 , 'Murat', 'G??nel'),
	(3 , 'Canan', 'Karatay'),
	(3 , 'Mehmet', '??z'),
	(4 , 'Oytun', 'Erba??'),
	(4 , '??zlem', 'T??reci'),
	(5 , 'U??ur', '??ahin'),
	(5 , '??brahim', 'Sara??o??lu');


INSERT into person(name, surname, gender, age, hes_code, city, district, full_address)
VALUES
	('Ahmet', 'Bulur', 'Male', 12, 'A1B2-1234-12', '??zmir', 'Buca', 'Atat??rk Mah. 35390 Buca/??zmir'),
	('G??lse', 'G??ler', 'Female', 23, 'B2C3-2345-23', '??zmir', 'Bornova', 'Ergene Mah. 35030 Bornova/??zmir'),
	('Ayberk', 'K??l????aslan', 'Male', 34, 'C3D4-3456-34', '??zmir', 'Bayrakl??', 'Bayrakl?? Mah. 35530 Bayrakl??/??zmir'),
	('Volkan', 'Patlar', 'Male', 45, 'D4E5-4567-45', '??zmir', 'Kar????yaka', 'Cumhuriyet Mah. 35570 Kar????yaka/??zmir'),
	('Hazar', '??zya??c??', 'Male', 56, 'E5F6-5678-56', '??zmir', 'Konak', ' Alsancak Mah. 35220 Konak/??zmir'),
	('YA??mur', 'Ya??ar', 'Female', 67, 'F6G7-6789-67', '??stanbul', 'Be??ikta??', 'Etiler Mah. 34337 Be??ikta??/??stanbul'),
	('Arif Mert', 'Aslan', 'Male', 78, 'G7H8-7890-78', '??stanbul', 'Kad??k??y', 'Caddebostan Mah. 34728 Kad??k??y/??stanbul'),
	('Y??ld??z', 'Kayar', 'Female', 89, 'H8I9-8901-89', '??stanbul', 'Beylikd??z??', 'Bar???? Mah. 34520 Beylikd??z??/??stanbul'),
	('Halil ??brahim', 'Do??an', 'Male', 90, 'I9J0-9012-90', '??stanbul', '??sk??dar', 'Ac??badem Mah. 34660 ??sk??dar/??stanbul'),
	('Ali', 'Aslan', 'Male', 72, 'J0K1-0123-01', '??stanbul', 'Zeytinburnu', 'Maltepe Mah. 34010 Zeytinburnu/??stanbul');


INSERT into hes(person_id, phone_number, hes_code, vaccination_info, state_of_health)
VALUES
	(1, '05123456789', 'A1B2-1234-12', 'unvaccinated', 'risk-free'),
	(2, '05234567890', 'B2C3-2345-23', 'vaccinated', 'risk-free'),
	(3, '05345678901', 'C3D4-3456-34', 'unvaccinated', 'risky'),
	(4, '05456789012', 'D4E5-4567-45', 'vaccinated', 'risk-free'),
	(5, '05567890123', 'E5F6-5678-56', 'unvaccinated', 'risky'),
	(6, '05678901234', 'F6G7-6789-67', 'vaccinated', 'risk-free'),
	(7, '05789012345', 'G7H8-7890-78', 'unvaccinated', 'risky'),
	(8, '05890123456', 'H8I9-8901-89', 'vaccinated', 'risk-free'),
	(9, '05534849876', 'I9J0-9012-90', 'unvaccinated', 'risk-free'),
	(10,'05555555555', 'J0K1-0123-01', 'vaccinated', 'risk-free');


INSERT into vaccination_record(person_id, vaccine_id, professional_id, vaccination_date)
VALUES
	(2, 2, 1, '2021-06-14'),
	(4, 2, 2, '2021-06-19'),
	(6, 1, 4, '2021-06-21'),
	(8, 1, 7, '2021-06-11'),
	(10, 1, 9, '2021-06-23');

/* QUERIES */

/* 1. query */

SELECT * FROM person 
WHERE person_id IN (SELECT person_id FROM vaccination_record WHERE vaccination_date > '2021-06-16') AND (name like 'G%' OR name like 'V%');

/* 2. query */

SELECT * FROM healthcare_professional 
WHERE professional_id IN(SELECT professional_id FROM vaccination_record WHERE person_id IN(SELECT person_id FROM person WHERE age > 50) AND vaccine_id IN(SELECT vaccine_id FROM vaccine WHERE name='Biontech')) 
ORDER BY professional_id;

/* 3. query */

ALTER TABLE vaccination_record
ADD country_code varchar(10) not null default 'TR';

/* 4. query */

SELECT vaccine_id, COUNT(*) as number_of_vaccinated_people FROM vaccination_record GROUP BY vaccine_id 
ORDER BY vaccine_id ASC;

/* 5. query */

SELECT * FROM person 
WHERE person_id IN(SELECT person_id FROM vaccination_record WHERE vaccine_id IN(SELECT vaccine_id FROM vaccine WHERE name='Sinovac') AND professional_id IN(SELECT professional_id FROM healthcare_professional WHERE center_id IN(SELECT center_id FROM medical_center WHERE name='Dokuz Eyl??l University Hospital')))
ORDER BY age LIMIT 1;

/* 6. query */

SELECT name FROM vaccine 
WHERE vaccine_id IN(SELECT vaccine_id FROM vaccination_record WHERE person_id IN(SELECT person_id FROM person WHERE name='Ali' AND surname='Aslan'));

SELECT vaccination_date FROM vaccination_record 
WHERE person_id IN(SELECT person_id FROM person WHERE name='Ali' AND surname='Aslan');

SELECT name FROM medical_center 
WHERE center_id IN(SELECT center_id FROM healthcare_professional WHERE professional_id IN(SELECT professional_id FROM vaccination_record WHERE person_id IN(SELECT person_id FROM person WHERE name='Ali' AND surname='Aslan')));

/* 7. query */

SELECT city, COUNT(*) AS number_of_people_at_risk FROM person 
WHERE person_id IN(SELECT person_id FROM hes WHERE state_of_health='risky') GROUP BY city
ORDER BY number_of_people_at_risk DESC LIMIT 1;

/* 8. query */

UPDATE hes
SET state_of_health = 'risky' 
WHERE phone_number='05534849876';

/* 9. query */

DELETE FROM person
WHERE age > 65 AND person_id IN(SELECT person_id FROM hes WHERE vaccination_info='unvaccinated');

/* 10. query */

INSERT into vaccine(name, origin)
VALUES
	('Sputnik V', 'Russia');
