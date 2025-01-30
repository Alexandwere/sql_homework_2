/*3.1. Посчитать количество заказов за все время. Смотри таблицу orders. 
 Вывод: количество заказов.*/

select count(*) as quantity_of_orders
from orders o;

/*3.2. Посчитать сумму денег по всем заказам за все время (учитывая скидки).  
Смотри таблицу order_details. Вывод: id заказа, итоговый чек (сумма стоимостей
 всех  продуктов со скидкой)*/
 
 select order_id, sum(round((od.unit_price * (1 - od.discount) * od.quantity)::numeric, 2)) as summary_price
 from order_details od
 group by order_id
 order by order_id;
 
/* 3.3. Показать сколько сотрудников работает в каждом городе. Смотри таблицу
 employee. Вывод: наименование города и количество сотрудников*/
 
select city , count(*)
from employees e
group by e.city;

/*3.4. Показать фио сотрудника (одна колонка) и сумму всех его заказов */
select t1.full_name, sum(round((od.unit_price * od.quantity)::numeric , 2)) as summary_price
from (select concat(e.last_name, ' ', e.first_name) as full_name, e.employee_id
	from employees e) as t1 inner join orders o on t1.employee_id = o.employee_id 
							inner join order_details od on od.order_id = o.order_id
group by t1.full_name;
	
/*3.5. Показать перечень товаров от самых продаваемых до самых непродаваемых 
(в штуках). - Вывести наименование продукта и количество проданных штук.*/

select product_name, sum(od.quantity) 
from products p inner join order_details od on p.product_id = od.product_id
group by p.product_name 
order by sum(od.quantity) desc ;
