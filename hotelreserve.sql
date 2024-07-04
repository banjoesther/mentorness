select * from hotelreserve;

#total number of reservations in dataset
select count(Booking_ID) from hotelreserve;


#most popular meal plan
select type_of_meal_plan from hotelreserve;
select distinct type_of_meal_plan from hotelreserve;
select type_of_meal_plan, count(*) as meal_plan_counts from hotelreserve 
group by type_of_meal_plan;
select type_of_meal_plan, count(*) as most_popular 
from hotelreserve
group by type_of_meal_plan
limit 1;


#avg price per room with children
select distinct no_of_children from hotelreserve;
select avg_price_per_room, no_of_children from hotelreserve
 where no_of_children = 1 or no_of_children =2;
 select avg_price_per_room, no_of_children from hotelreserve 
 where no_of_children in(1,2);


#reservations made for 2018
select arrival_date from hotelreserve;
#change text date datatype to date
UPDATE hotelreserve
SET arrival_date = STR_TO_DATE(arrival_date, '%d-%m-%Y');
ALTER TABLE hotelreserve MODIFY arrival_date DATE;

select year(arrival_date) from hotelreserve;
select distinct year(arrival_date) from hotelreserve;
SELECT year(arrival_date) as desired_year, COUNT(*) AS reservation_count
FROM hotelreserve
WHERE YEAR(arrival_date) = 2017
group by desired_year;


#most booked room type
select distinct room_type_reserved from hotelreserve;
select room_type_reserved, count(*) as commonly_booked
from hotelreserve group by room_type_reserved
limit 1;


#reservations on weekend
select distinct no_of_weekend_nights from hotelreserve;
select sum(no_of_weekend_nights) as total_weekend_reservations from hotelreserve
where no_of_weekend_nights > 0;


#highest and lowest lead time for reservations
select max(lead_time) as highest_leadtime from hotelreserve;
select min(lead_time) as lowest_leadtime from hotelreserve;


#most common market segment type for reservations
select count(distinct market_segment_type) from hotelreserve;
select distinct market_segment_type from hotelreserve;
select distinct market_segment_type, count(*) as count_market from hotelreserve
group by market_segment_type
order by count_market desc
limit 1;


-- booking status of "Confirmed"
select count(distinct booking_status) from hotelreserve;
select distinct booking_status from hotelreserve;
-- update booking_status of 'not_canceled' to "confirmed"
update hotelreserve
set booking_status = "Confirmed"
where booking_status = "Not_Canceled";

select distinct booking_status, count(*) as confirmed_reservations from hotelreserve
where booking_status = "Confirmed"
group by booking_status;


#total number of adults and children across all reservations
select sum(no_of_children) as ChildrenTotal, sum(no_of_adults) as AdultsTotal
from hotelreserve;

#average number of weekend nights for reservations involving children
select avg(no_of_weekend_nights) as avg_weekend_nights_Children from hotelreserve
where no_of_children > 0;


#reservations were made in each month of the year
select monthname(arrival_date) as month, count(*) as reservations_by_months
from hotelreserve
group by month(arrival_date), month
order by month(arrival_date);


/*average number of nights (both weekend and weekday) spent by guests for each room
type*/
select room_type_reserved, avg(no_of_weekend_nights) as avg_weekend, 
avg(no_of_week_nights) as avg_weekday
from hotelreserve
group by room_type_reserved
order by room_type_reserved;


/*the most common room type, the average price for that room type 
for reservations involving children*/
select avg(avg_price_per_room) as avg_room_type from hotelreserve 
where no_of_children > 0
and room_type_reserved = (
select room_type_reserved
from hotelreserve
where no_of_children > 0
group by room_type_reserved
order by count(*)
);


# market segment type that generates the highest average price per room
select count(distinct market_segment_type) as segment_type, avg_price_per_room 
from hotelreserve
group by market_segment_type;