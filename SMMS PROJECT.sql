use smms;
create table products( 
product_id int primary key,
product_name varchar(100),
price decimal(10,2),
Quantity int,
category varchar(100)
);
alter table products rename column quantity to Quantity_KG;
insert into products
value (101,"Apple",100,150,"Fruits"),
	  (102,"Orange",200,200,"Fruits"),
      (103,"Pineapple",150,300,"Fruits"),
      (104,"Banana",40,100,"Fruits"),
      (105,"Guava",90,170,"Fruits"),
      (106,"Lychee",190,50,"Fruits"),
      (107,"Watermelon",200,100,"Fruits"),
      (108,"Pomogranate",100,150,"Fruits"),
      (109,"Muskmelon",150,200,"Fruits"),
      (110,"Jackfruit",250,150,"Fruits"),
      (201,"Onion",100,150,"Vegetables"),
      (202,"Tomato",56,150,"Vegetables"),
      (203,"Brinjal",76,230,"Vegetables"),
      (204,"Cabbage",89,130,"Vegetables"),
      (205,"Potato",49,150,"Vegetables"),
      (206,"Carrot",68,90,"Vegetables"),
      (207,"Beans",47,130,"Vegetables"),
      (208,"Capcicum",89,140,"Vegetables"),
      (209,"Zukini",200,50,"Vegetables"),
      (210,"Lettuce",210,60,"Vegetables"),
      (301,"Rice",70,500,"Grocery"),
      (302,"Dal",117,200,"Grocery"),
      (303,"Chilli Powder",36,100,"Grocery"),
      (304,"Sugar",44,200,"Grocery"),
      (305,"Ragi",68,90,"Grocery"),
      (306,"Pepper",25,100,"Grocery"),
      (307,"Tea Powder",150,300,"Grocery"),
      (308,"Cooking Oil",129,140,"Grocery"),
      (309,"Almond",300,50,"Grocery"),
      (310,"Wheat",68,100,"Grocery");
      select * from products;
create table customers(
customer_id int primary key,
name varchar(100),
phone varchar(100),
Email varchar(200)
);
insert into customers 
values(901,"Vijay","7672039245","vijay@gmail.com"),
      (902,"Vikram","7583892742","vikram@gmail.com"),
      (903,"Dhanush","9747202612","dhanush@gmail.com"),
      (904,"Tharun","9837426744","tharun@gmail.com"),
      (905,"Vignesh","8179403608","vicky@gmail.com");
    
      update customers set phone="7583892743"
      where customer_id=902;
      update customers set phone="9837426743"
      where customer_id=904;
      
        select * from customers;
create table orders(
order_id int primary key,
customer_id int,
order_date datetime,
Total decimal(10,2),
foreign key (customer_id) references customers(customer_id)
);
alter table orders change column order_date order_date date;
insert into orders 
values(1001,902,"2024-09-25",129),
	  (1002,905,"2024-08-12",49),
      (1003,903,"2024-04-29",200),
      (1004,904,"2024-12-01",150),
      (1005,901,"2024-11-30",210),
      (1006,905,"2024-02-28",90),
      (1007,902,"2024-03-31",36),
      (1008,904,"2024-07-11",100),
      (1009,903,"2024-06-28",129),
      (1010,901,"2024-05-30",89);
insert into orders 
values(1011,902,"2024-09-25",129,"cancelled");
      alter table orders add column Status varchar(30);
      insert into orders(status) values("ordered"),
					 ("Cancel"),
                                       ("Cancel"),
                                       ("ordered"),
                                       ("ordered"),
					("Cancel"),
                                         ("ordered"),
                                         ("Cancel"),
                                         ("Cancel"),
                                         ("ordered");
   update orders 
   set status="ordered"
   where order_id in (1001,1003,1004,1006,1007,1008);
	update orders 
    set status="cancel"
    where order_id in (1002,1005,1009,1010);
    update orders set order_date = null
where order_id=1011;
                    
      select * from orders;
create table orderItems(
orderitems_id int primary key,
order_id int,
product_id int,
Quantity int,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);

alter table orderItems rename column quantity to Quantity_KG;
insert into orderItems values(501,1001,103,10),
			     (502,1004,201,15),
                             (503,1008,302,20),
                             (504,1009,109,31),
                             (505,1005,205,21),
                             (506,1003,310,15),
                             (507,1006,108,17),
                             (508,1002,207,19),
                             (509,1007,305,21),
                             (510,1010,210,32);
                             
	select * from orderItems;
    
create table sales(
sales_id int primary key,
order_id int,
product_id int,
seller_price decimal(10,2),
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);

 insert into sales 
 values(21,1001,103,140),
       (22,1004,201,130),
       (23,1008,302,185),
       (24,1009,109,125),
       (25,1005,205,113),
       (26,1003,310,89),
       (27,1006,108,119),
       (28,1002,207,111),
       (29,1007,305,89),
       (30,1010,210,199);
       
 insert into sales 
 values(11,1001,103,140),
       (12,1004,201,130),
       (13,1008,302,185),
       (14,1009,109,125),
       (15,1005,205,113),
       (16,1003,310,89),
       (17,1006,108,119),
       (18,1002,207,111),
       (19,1007,305,89),
       (20,1010,210,199);
       
   insert into sales value(31,1009,109,125);  
       
-- 1. Get customer names and order dates?

select orders.order_id,customers.name,orders.order_date 
from customers
join orders 
on customers.customer_id=orders.customer_id
order by order_id;

-- Products Table --

-- 1.Which product has the highest price?
select Max(price) as High_price from products;
-- 2.What is the total quantity of products in the 'Fruits' category?
select sum(quantity_kg) from products 
where category="Fruits";
-- 3.Find all products with quantity_KG less than 100?
select * from products
where quantity_kg<100;
-- 4.Which product category has the most products?
select count(*) as count from products 
group by category
order by count desc
limit 1;
-- 5.What is the average price of products in the 'Vegetables' category?
select avg(price) from products
where category="vegetables";

-- Customers Table --
 
 select * from customers;
 -- 1.How many customers are in the database?
 select count(*) from customers;
 -- 2.Find the customer with the phone number '9837426744'?
 select * from customers
 where phone="9837426744";
 -- 3.Retrieve all customer names and emails?
 select name,email from customers;
 -- 4. Which customer has placed the most orders?
 select c.name,count(o.customer_id) as order_count
 from customers c
 join orders o
 on c.customer_id=o.customer_id
 group by o.customer_id
 order by order_count desc
 limit 1;
 -- OR --
 SELECT c.name, COUNT(o.order_id) 
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.name 
ORDER BY COUNT(o.order_id) DESC 
LIMIT 1;
-- 5. Update the phone number of customer 904.
	  update customers 
      set phone="9837426744"
      where customer_id=904;

-- Orders Table

select * from orders;
-- 1. What is the total value of all orders?
select sum(total) as total from orders;
-- 2. Find all orders placed in the year 2024.
select * from orders
where month (order_date)="04";
-- 3. Retrieve the order ID and date for customer 902.
select order_id,order_date from orders
where customer_id=902;
-- 4. Which customer has the highest total order value?
select sum(o.total) as high_value,c1.name 
from orders o
join customers c1
on o.customer_id=c1.customer_id
group by c1.name
order by high_value desc
limit 1;

SELECT c.name, SUM(o.Total) 
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.name 
ORDER BY SUM(o.Total) DESC 
LIMIT 1;
-- 5. Cancel an order (update order status).
UPDATE orders 
SET status = "cancelled" 
WHERE status= "cancel";

set sql_safe_updates=0; -- safe update disable
set sql_safe_updates=1; -- safe update enable 

-- OrderItems Table

select * from orderItems;
-- 1. What is the total quantity of products ordered?
select sum(quantity_kg) from orderItems;
-- 2. Find all order items with quantity_KG greater than 20.
select * from orderItems
where quantity_kg>20;
-- 3. Retrieve product names and quantities for order 1001.
select o1.order_id,o2.product_name,o1.quantity_kg,o2.product_id,o1.product_id
from orderItems o1
join products o2
on o2.product_id=o1.product_id
where o1.order_id=1001;  
-- 4. Which product is most frequently ordered?
select o2.order_id,o1.product_id,p1.product_name,o2.order_date
from orderitems o1 
join products p1
on o1.product_id=p1.product_id
join orders o2
on o1.order_id=o2.order_id
where o2.order_date<now()
order by order_date desc
limit 1;

-- 5. Calculate the total value of each order.
select o1.order_id,o1.orderitems_id,o2.total
from orderitems o1
join orders o2
on o1.order_id=o2.order_id;


-- Sales Table
select * from sales;
-- 1. What is the total sales revenue?
select sum(seller_price) from sales;

-- 2. Find the top-selling product?

-- select s1.sales_id,s1.product_id ,p1.product_name as top_sell
-- from sales s1
-- join products p1
-- on s1.product_id=p1.product_id
-- where p1.product_id=(select product_id from sales
-- group by product_id
-- having count(product_id) 
-- order by count(product_id) desc
-- limit 1
-- );

SELECT p.product_name, SUM(s.seller_price) 
FROM sales s 
JOIN products p 
ON s.product_id = p.product_id 
GROUP BY p.product_name 
ORDER BY SUM(s.seller_price) DESC ;



-- select p1.product_name,s1.seller_price as price 
-- from sales s1
-- join products p1
-- on s1.product_id=p1.product_id
-- where s1.seller_price=(select max(seller_price) from sales); 

-- 3. Retrieve sales data for order 1005.
select * from sales
where order_id=1005;

-- 4. Which customer has generated the most sales revenue?

SELECT c.name, SUM(s.seller_price) 
FROM sales s 
JOIN orders o 
ON s.order_id = o.order_id 
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.name 
ORDER BY SUM(s.seller_price) DESC 
LIMIT 1;

-- 5. Calculate the profit for each product.

SELECT p.product_name, SUM(s.seller_price- p.price) 
FROM sales s 
JOIN products p 
ON s.product_id = p.product_id 
GROUP BY p.product_name;

-- Join and Subquery Questions

-- 1. Retrieve customer names and order dates.
select c1.name,o1.order_date 
from orders o1
join customers c1
on o1.customer_id=c1.customer_id;
-- 2. Find products with no sales data.
select p1.product_id,p1.product_name
from products p1
left join sales s1
on p1.product_id=s1.product_id
where s1.product_id is null;
use smms;
select p.*
from products p
left join sales s
on p.product_id=s.product_id
where s.product_id is null;

-- 3. Get order IDs and dates for customers from 'Fruits' category.
select o.order_id,o.order_date
from orders o
-- join customers c
-- on o.customer_id=c.customer_id
join orderitems oi
on o.order_id=oi.order_id
join products p
on oi.product_id=p.product_id
where p.category="fruits";
-- 4. Calculate total sales revenue for each customer.
select customer_id,sum(total) from orders
group by customer_id;
-- 5. Find customers who ordered products from multiple categories.
SELECT c.name 
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id 
JOIN orderItems oi 
ON o.order_id = oi.order_id 
JOIN products p 
ON oi.product_id = p.product_id 
GROUP BY c.name 
HAVING COUNT(DISTINCT p.category) > 1;

