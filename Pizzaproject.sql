**Phase 1: Foundation & Inspection**

1. Install IDC_Pizza.dump as IDC_Pizza server
--------2. List all unique pizza categories (`DISTINCT`).
select distinct category from pizza_types


------3. Display `pizza_type_id`, `name`, and ingredients, replacing NULL ingredients with `"Missing Data"`. Show first 5 rows.
select top 5 pizza_type_id,name,coalesce(ingredients,'Missingdata') as Ingredients
from pizza_types


-----4. Check for pizzas missing a price (`IS NULL`).
select * from pizzas
where price is null


-**Phase 2: Filtering & Exploration**



------------1. Orders placed on `'2015-01-01'` (`SELECT` + `WHERE`).
select * from orders
where date='2015-01-01'


------------2. List pizzas with `price` descending.
select * from pizzas order by price desc


------------3. Pizzas sold in sizes `'L'` or `'XL'`.
select * from pizzas
where size in ('L','XL')


----------4. Pizzas priced between $15.00 and $17.00.
select * from pizzas
where price between 15 and 17


---------5. Pizzas with `"Chicken"` in the name.
SELECT *
FROM pizza_types
WHERE name LIKE '%Chicken%';

---------6. Orders on `'2015-02-15'` or placed after 8 PM.
SELECT *
FROM orders
WHERE date = '2015-02-15'
   OR DATEPART(HOUR, time) >= 20;




**Phase 3: Sales Performance**

--------1. Total quantity of pizzas sold (`SUM`).
select sum(quantity) as totalqty from order_details



-----------2. Average pizza price (`AVG`).
select avg(price) as avgpizzaprice from pizzas




----------3. Total order value per order (`JOIN`, `SUM`, `GROUP BY`).
select o.order_id,sum(od.quantity) as totalqty,sum(p.price) as totalprice
from orders o
left join order_details od on o.order_id=od.order_id
left join pizzas p on od.pizza_id=p.pizza_id
group by o.order_id
order by o.order_id


--------4. Total quantity sold per pizza category (`JOIN`, `GROUP BY`).
select  pt.category,sum(od.quantity) as totalqtysold from pizza_types pt
left join pizzas p on pt.pizza_type_id=p.pizza_type_id
left join order_details od on p.pizza_id=od.pizza_id
group by pt.category



--------5. Categories with more than 5,000 pizzas sold (`HAVING`).
select pt.category,sum(o.quantity) as totalqty from pizza_types pt
left join pizzas p on pt.pizza_type_id=p.pizza_type_id
left join order_details o on p.pizza_id=o.pizza_id
group by pt.category
having sum(o.quantity)>5000



-------------6. Pizzas never ordered (`LEFT/RIGHT JOIN`).
SELECT p.pizza_id
FROM pizzas p
LEFT JOIN order_details od
    ON p.pizza_id = od.pizza_id
WHERE od.pizza_id IS NULL;


----------------7. Price differences between different sizes of the same pizza (`SELF JOIN`).
select p1.pizza_type_id,
p1.size as size1,
p2.size as size2,
(p2.price-p1.price) as diff 
from pizzas p1
 join pizzas p2
on p1.pizza_type_id=p2.pizza_type_id
and p1.size<p2.size


