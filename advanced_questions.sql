-- Q1) Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category,
round(sum(orders_details.quantity*pizzas.price)/(select round(sum(orders_details.quantity*pizzas.price),2) as total_sales
from orders_details join pizzas
on pizzas.pizza_id = orders_details.pizza_id) *100,2) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by revenue desc;


-- Q2) Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select name, revenue from
( select category, name,revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category,pizza_types.name,
sum(orders_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category ,pizza_types.name) as a) as b
where rn<=3;


