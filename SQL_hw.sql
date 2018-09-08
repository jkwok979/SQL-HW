USE sakila; 
select * from actor;

#1a
select first_name, last_name from actor;

#1b
select concat(first_name, ' ', last_name) as ACTOR_NAME from actor;
select * from actor;

#2a
select first_name, last_name, actor_id from actor where first_name = "Joe";

#2b
select first_name, last_name 
from actor 
where last_name like '%gen%'; 

#2c
select * 
from actor 
where last_name like '%li%'
order by last_name, actor.first_name;

#2dselect * from country;
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
alter table actor
add description blob(30); 

#3b
ALTER TABLE actor DROP COLUMN description;

#4a
select last_name, count(*)
from actor
group by last_name;

#4b
select last_name, count(*)
from actor
group by last_name
having count(*) > 1;

#4c
UPDATE actor
SET first_name = 'HARPO' where first_name = 'GROUCHO';

#4d
UPDATE actor
SET first_name = 'GROUCHO' where first_name = 'HARPO';

#5a
SHOW CREATE TABLE address;

#6a
SELECT staff.first_name, staff.last_name, address.address, staff.address_id
FROM address
INNER JOIN staff ON
address.address_id = staff.address_id;

#6b
SELECT staff.staff_id, SUM(payment.amount) as payment_sum, staff.first_name, staff.last_name
FROM staff
JOIN payment ON
payment.staff_id = staff.staff_id
where payment.payment_date like '2005-08%'
group by staff.staff_id;

#6c
SELECT film.film_id, film.title, count(film_actor.actor_id) as actor_count
FROM film as film
JOIN film_actor as film_actor
ON film.film_id = film_actor.film_id
group by film_actor.film_id;

#6d
SELECT film.film_id, film.title, COUNT(inventory.inventory_id) as inventory_cnt
FROM film as film
JOIN inventory as inventory
ON film.film_id = inventory.film_id and film.title like 'Hunchb%'
GROUP BY inventory.film_id;

#6e 
select payment.customer_id, customer.last_name, customer.first_name, sum(payment.amount) as payment_sum
from customer
join payment
on payment.customer_id = customer.customer_id
group by payment.customer_id
order by customer.last_name;

#7a
SELECT title
	FROM film
	WHERE title like 'K%'
    or title like 'Q%'
    and film.language_id = '1';
    
#7b
select first_name, last_name
	FROM actor
    where actor_id
    IN(
		select actor_id
        from film_actor
        where film_id
        in (
			select film_id
            from film
            where film.title = 'Alone Trip'
            )
				)

#7c
select first_name, last_name, email
	from customer
	join address
		on customer.address_id = address.address_id
    join city 
		on address.city_id = city.city_id
	join country 
		on city.country_id = city.country_id
        where country = 'Canada';
 
#7d
select title 
from film
where film_id
in(
	select film_id
    from film_category
    where category_id
    in(
		select category_id
        from category
        where name = 'Family'
        )
        )

#7e
select title, count(rental.rental_id) as rental_count
	from film
    join inventory
		on inventory.film_id = film.film_id
	join rental
		on inventory.inventory_id = rental.inventory_id
	group by film.title
    order by rental_count desc;

#7f
SELECT store.store_id, sum(payment.amount) as 'Total Sales per Store'
FROM payment
JOIN rental
	ON (rental.rental_id = payment.rental_id)
JOIN inventory
	ON (inventory.inventory_id = rental.inventory_id)
JOIN store
	ON (store.store_id = inventory.store_id)
GROUP BY store.store_id;

#7g
SELECT
	store.store_id,
	address.address,
	address.address2,
	address.district,
	address.city_id,
	address.postal_code
FROM store
JOIN address on store.address_id = address.address_id;

#7h
SELECT
	T1.name, SUM(payment.amount) AS grossrevenue
FROM
	category AS T1
    	JOIN
	film_category AS film_category ON T1.category_id = film_category.category_id
    	JOIN
	inventory AS inventory ON film_category.film_id = inventory.film_id
    	JOIN
	rental AS rental ON inventory.inventory_id = rental.inventory_id
    	JOIN
	payment AS payment ON rental.rental_id = payment.rental_id
GROUP BY T1.name
ORDER BY grossrevenue DESC
LIMIT 0 , 5;

#8a
CREATE VIEW `top_grossing_genres` AS
SELECT
	T1.name, SUM(payment.amount) AS grossrevenue
	FROM
	category AS T1
    	JOIN
	film_category AS film_category ON T1.category_id = film_category.category_id
    	JOIN
	inventory AS inventory ON film_category.film_id = inventory.film_id
    	JOIN
	rental AS rental ON inventory.inventory_id = rental.inventory_id
    	JOIN
	payment AS payment ON rental.rental_id = payment.rental_id
	GROUP BY T1.name
	ORDER BY grossrevenue DESC
	LIMIT 0 , 5;

#8b
select * from top_grossing_genres;

#8c
DROP VIEW `top_grossing_genres`;





