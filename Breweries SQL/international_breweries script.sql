SELECT DISTINCT
    COUNT(*)
FROM
    international_breweries;
SELECT 
    *
FROM
    international_breweries;
    
-- PROFIT ANALYSIS
-- Within the space of the last three years, what was the profit worth of the breweries, 
-- inclusive of the anglophone and the francophone territories?

SELECT 
    SUM(profit) AS profitworth
FROM
    international_breweries;

-- profit made by each territory at every given year
SELECT 
    profit,
    years,
    CASE
        WHEN countries = ('Nigeria') THEN 'anglophone'
        WHEN countries = ('Ghana') THEN 'anglophone'
        ELSE 'francophone'
    END AS territories
FROM
    international_breweries
;
    
    -- total profit worth for the anglophone territory= 42389260
SELECT 
    SUM(profit) AS profitworth
FROM
    international_breweries
WHERE
    countries = 'Nigeria'
        OR countries = 'Ghana';
    
    -- total profit worth for the francophone territory = 63198160
SELECT 
    SUM(profit) AS profitworth
FROM
    international_breweries
WHERE
    countries = 'Senegal'
        OR countries = 'Togo'
        OR countries = 'Benin';
    
    -- Q2. country that generated the highest profit in 2019 
SELECT 
    countries, years, SUM(profit)
FROM
    international_breweries
WHERE
    years = '2019'
GROUP BY countries;
    
    -- Q3. find the year with the highest profit
SELECT 
    years, SUM(profit) AS highestprofit
FROM
    international_breweries
GROUP BY years;
    
    -- Q4. which month in the three years was the least profit generated?
SELECT 
    months, SUM(profit) AS leastprofit
FROM
    international_breweries
GROUP BY 1
ORDER BY 2 ASC;
    
    -- Q4. What was the minimum profit in the month of december 2018?
    
SELECT 
    months, years, MIN(profit) AS min_profit
FROM
    international_breweries
WHERE
    months = 'december' AND years = '2018';
    
    -- Q5. Compare the profit percentage for each of the month in 2019
    select months,ROUND((total_profit / sum(total_profit) over ()) * 100, 2) as profit_percentage
    from ( 
           select months,sum(profit) as total_profit
               from international_breweries
                   where years = '2019'
                     group by months
                        order by months) as monthly_profits
                        order by profit_percentage desc;
    
 -- Q6. Which particular brand generated the highest profit in senegal?
SELECT 
    brands, countries, SUM((profit)) AS highest_profit
FROM
    international_breweries
WHERE
    countries = 'senegal'
GROUP BY brands
ORDER BY highest_profit DESC
LIMIT 1;

-- BRAND ANALYSIS
    
-- Top three brands consumed within the last two years in francophone countries
select brands,countries,sum(quantity) as total_consumed
FROM
    international_breweries
    where years <= 2018 and countries <> 'Nigeria' and countries <> 'Ghana'
    group by countries, brands
    order by total_consumed
    limit 3;
    
    -- top two choice of customer brands in ghana
SELECT 
    brands, SUM(quantity) AS quantity
FROM
    international_breweries
WHERE
    countries = 'Ghana'
GROUP BY brands
ORDER BY quantity DESC
LIMIT 2;
    
    -- find out the details of beers consumed in the past three years in the oil rich county in west Africa 
SELECT 
    brands, SUM(quantity) AS quantity_consumed
FROM
    international_breweries
WHERE
    brands <> 'beta malt'
        AND brands <> 'grand malt'
        AND countries = 'Nigeria'
GROUP BY brands
ORDER BY quantity_consumed DESC;
    
    -- favorite malt brand in anglophone region between 2018 and 2019
SELECT 
    brands, SUM(quantity) AS quantity
FROM
    international_breweries
WHERE
    countries IN ('Nigeria' , 'Ghana')
        AND years >= 2018
        AND brands LIKE '%malt%'
GROUP BY 1
ORDER BY quantity;
      
    -- which brand sold the highest in 2019 in Nigeria?
SELECT 
    brands, SUM(quantity) AS quantity
FROM
    international_breweries
WHERE
    countries IN ('nigeria') OR years = 2019
GROUP BY brands
ORDER BY quantity DESC;
    
    -- Favorites brand in South_South region in Nigeria

SELECT 
    brands, SUM(quantity) AS NO_OF_UNIT_SOLD
FROM
     international_breweries
WHERE
 countries = 'Nigeria'
        AND region = 'southsouth'
GROUP BY brands
ORDER BY SUM(quantity) DESC
LIMIT 1;

-- Bear consumption in Nigeria

SELECT brands, SUM(quantity) AS amount_consumed
FROM  international_breweries
WHERE (brands <> ('beta malt') AND brands <> ('grand malt')) AND countries = 'Nigeria'
GROUP BY brands
ORDER BY amount_consumed DESC;

-- Level of consumption of Budweiser in the regions in Nigeria

SELECT region, SUM(QUANTITY) AS amount_consumed
FROM international_breweries
WHERE brands = 'budweiser' AND  countries = 'Nigeria'
GROUP BY region
ORDER BY amount_consumed DESC;

-- Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)

SELECT region, SUM(quantity) AS amount_consumed
FROM international_breweries
WHERE brands = 'budweiser' AND  countries = 'Nigeria' AND YEARS= 2019
GROUP BY region
ORDER BY amount_consumed;

-- COUNTRIES ANALYSIS

-- Country with the highest consumption of beer

SELECT countries, SUM(quantity) AS beer_consumed
FROM international_breweries
WHERE brands <> 'beta malt' AND brands <> 'grand malt'
GROUP BY countries
ORDER BY beer_consumed DESC
LIMIT 1;

-- Highest sales personnel of Budweiser in Senegal base on profit

SELECT sales_rep, SUM(profit)as profit_made
FROM international_breweries
WHERE brands = 'budweiser' AND countries = 'Senegal'
GROUP BY sales_rep
ORDER BY profit_made DESC
LIMIT 1;


-- Country with the highest profit of the fourth quarter in 2019

SELECT countries, SUM(profit) AS FOURTH_QUARTER_PROFIT
FROM international_breweries
WHERE years = 2019 and months in ('october', 'november', 'december')
GROUP BY countries
ORDER BY fourth_quarter_profit DESC;

