--Comparative Analysis of City Populations for 2023 and 2024
--Country Table
CREATE TABLE country(
	Serial_Number INT PRIMARY KEY,
	Country VARCHAR(200)
);

--Population 2023 Table
CREATE TABLE population_2023(
	Serial_Number INT,
	City VARCHAR(200),
	Population_2023 INT
);

--Population 20234 Table
CREATE TABLE population_2024(
	Serial_Number INT,
	City VARCHAR(200),
	Population_2024 INT,
	Growth_Rate NUMERIC
);

--ADD foreign key to table
ALTER TABLE project.population_2023
	ADD CONSTRAINT fk_country
	FOREIGN KEY (serial_number) REFERENCES project.country(serial_number);

ALTER TABLE project.population_2024
	ADD CONSTRAINT fk_country
	FOREIGN KEY (serial_number) REFERENCES project.country(serial_number);

--Exploring the data
Select *
FROM project.country AS Co
JOIN project.population_2024 AS pop24
	ON co.serial_number = pop24.serial_number
JOIN project.population_2023 AS pop24
	ON co.serial_number = pop24.serial_number;

--Finding top 5 cities with largest population in 2024
SELECT city,
	SUM(population_2024) AS Population_2024
FROM project.population_2024 pop24
GROUP BY city
ORDER BY Population_2024 DESC
LIMIT 5;
		--finding the diferent population between 2023 and 2024 in the largest city 2024
		SELECT pop24.city, 
			SUM(population_2023) AS Population_In_2023,
			SUM(population_2024) AS Population_In_2024,
			SUM(Growth_rate) AS Growth_rate
		FROM project.population_2024 AS pop24
		JOIN project.population_2023 AS pop23
			ON pop24.serial_number = pop23.serial_number
		GROUP BY pop24.city
		ORDER BY Population_In_2024 DESC
		LIMIT 5;
					
--Finding the top 5 Countries with largest population in 2024 
Select Country, 
	SUM(population_2024) AS Population_In_2024
FROM project.country AS Co
JOIN project.population_2024 AS pop24 
	ON co.serial_number = pop24.serial_number
GROUP BY Country
ORDER BY Population_In_2024 DESC
LIMIT 5;
		--finding the diferent population between 2023 and 2024 in the largest country 2024
		SELECT Country, 
			SUM(population_2023) AS Population_In_2023,
			SUM(population_2024) AS Population_In_2024,
			SUM(Growth_rate) AS Growth_rate
		FROM project.country AS Co
		JOIN project.population_2024 AS pop24 
			ON co.serial_number = pop24.serial_number
		JOIN project.population_2023 AS pop23
			ON co.serial_number = pop23.serial_number
		GROUP BY Country
		ORDER BY Population_In_2024 DESC
		LIMIT 5;


--Finding the top 5 countries with largest population in 2023
Select Country, 
	SUM(population_2023) AS Population_In_2023
FROM project.country AS Co
JOIN project.population_2023 AS pop23 
	ON co.serial_number = pop23.serial_number
GROUP BY Country
ORDER BY Population_In_2023 DESC
LIMIT 5;

--Finding the top 5 countries with highest growth rate
SELECT Country,
	SUM(Growth_rate) AS Growth_rate
FROM project.country AS Co
JOIN project.population_2024 AS pop24 
	ON co.serial_number = pop24.serial_number
GROUP BY Country
ORDER BY Growth_rate DESC
LIMIT 5;

-- Population country comparison between 2023 to 2024
SELECT Country,
	SUM(population_2023) AS population_2023,
	SUM(population_2024) AS population_2024
FROM project.country AS Co
JOIN project.population_2024 AS pop24 
	ON co.serial_number = pop24.serial_number
JOIN project.population_2023 AS pop23
	ON co.serial_number = pop23.serial_number
GROUP BY Country
ORDER BY Country;

-- Population city comparison between 2023 to 2024
SELECT pop24.city,
	SUM(population_2023) AS population_2023,
	SUM(population_2024) AS population_2024
FROM project.country AS Co
JOIN project.population_2024 AS pop24 
	ON co.serial_number = pop24.serial_number
JOIN project.population_2023 AS pop23
	ON co.serial_number = pop23.serial_number
GROUP BY pop24.city
ORDER BY pop24.city;

-- Average Growth Rate per Country
Select Country, 
	SUM(growth_rate) AS Growth_rate_2024
FROM project.country AS Co
JOIN project.population_2024 AS pop24 
	ON co.serial_number = pop24.serial_number
GROUP BY Country
ORDER BY Growth_rate_2024 DESC
;

-- Average growth rate per city
Select City, 
	SUM(growth_rate) AS Growth_rate_2024
FROM project.population_2024
GROUP BY City
ORDER BY Growth_rate_2024 DESC
;

-- Country with significant growth
Select Country, 
	SUM(Population_2023) AS Population2023,
	SUM(Population_2024) AS Population2024,
	SUM(Population_2024) - SUM(Population_2023) AS Population_Change
FROM project.country AS co
JOIN project.population_2023 AS pop23
	ON co.serial_number = pop23.serial_number
JOIN project.population_2024 AS pop24
	ON co.serial_number = pop24.serial_number
GROUP BY Country
ORDER BY Population_Change DESC
;

-- City with significant growth
Select pop24.City, 
	population_2023,
	population_2024,
	(population_2024 - population_2023) AS Population_Change
FROM project.population_2024 AS pop24
JOIN project.population_2023 AS pop23
	ON pop24.serial_number = pop23.serial_number
GROUP BY pop24.City, 
	population_2023, 
	population_2024
ORDER BY Population_Change DESC

;

-- VIEW
--Comparison populations in country
CREATE VIEW Population_Comparison AS
	SELECT country,
		SUM(population_2023) AS population_2023,
		SUM(population_2024) AS population_2024
	FROM project.country AS co
	JOIN project.population_2023 AS pop23 
		ON co.serial_number = pop23.serial_number
	JOIN project.population_2024 AS pop24 
		ON co.serial_number = pop24.serial_number
	GROUP BY country
	ORDER BY country
	;
		
-- Declining population in country
CREATE VIEW Declining_Population AS
	SELECT country,
		SUM(population_2023) AS population2023,
		SUM(population_2024) AS population2024,
		SUM(population_2024) - SUM(population_2023) AS Population_Change
	FROM project.country AS co
	JOIN project.population_2023 AS pop23 
		ON co.serial_number = pop23.serial_number
	JOIN project.population_2024 AS pop24 
		ON co.serial_number = pop24.serial_number
	WHERE pop24.population_2024 < pop23.population_2023
	GROUP BY country
	ORDER BY Population_Change DESC
	;


-- Increasing population in country
CREATE VIEW Increasing_Population AS
	SELECT country,
		SUM(population_2023) AS population2023,
		SUM(population_2024) AS population2024,
		SUM(population_2024) - SUM(population_2023) AS Population_Change
	FROM project.country AS co
	JOIN project.population_2023 AS pop23 
		ON co.serial_number = pop23.serial_number
	JOIN project.population_2024 AS pop24 
		ON co.serial_number = pop24.serial_number
	WHERE pop24.population_2024 > pop23.population_2023
	GROUP BY country
	ORDER BY Population_Change DESC
	;