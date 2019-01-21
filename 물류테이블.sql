select * from tab;
DROP table Employees;
CREATE TABLE Customers(
customer_id VARCHAR2(15) PRIMARY KEY,
customer_name VARCHAR2(15) NOT NULL,
contact_name VARCHAR2(15) NOT NULL,
address VARCHAR2(15) NOT NULL,
city VARCHAR2(15) NOT NULL,
postalcode VARCHAR2(15) NOT NULL,
country VARCHAR2(15) NOT NULL
);
CREATE TABLE Employees(
employee_id VARCHAR2(15) PRIMARY KEY,
last_name VARCHAR2(15) NOT NULL,
first_name VARCHAR2(15) NOT NULL,
birth_date VARCHAR2(15) NOT NULL,
photo VARCHAR2(15) NOT NULL,
notes VARCHAR2(15) NOT NULL
);

CREATE TABLE Shippers(
shipper_id VARCHAR2(15) PRIMARY KEY,
shipper_Name VARCHAR2(15) NOT NULL,
phone VARCHAR2(15) NOT NULL
);

CREATE SEQUENCE order_id
START WITH 1000
INCREMENT BY 1;

CREATE TABLE Orders(
order_id NUMBER(15) PRIMARY KEY,
customer_id VARCHAR2(15)UNIQUE NOT NULL,
employee_id VARCHAR2(15)UNIQUE NOT NULL,
order_date DATE DEFAULT SYSDATE,
shipper_id VARCHAR2(15) NOT NULL,
CONSTRAINT customer_id_fK_Orders FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
CONSTRAINT employee_id_fK_Orders FOREIGN KEY(employee_id) REFERENCES employees(employee_id),
CONSTRAINT shipper_id_fk_orders FOREIGN KEY (shipper_id) REFERENCES shippers(shipper_id)
);
CREATE TABLE Suppliers(
supplier_id VARCHAR2(15) PRIMARY KEY,
supplier_name VARCHAR2(15) NOT NULL,
contact_name VARCHAR2(15) NOT NULL,
address VARCHAR2(15) NOT NULL,
city VARCHAR2(15) NOT NULL,
postal_code VARCHAR2(15) NOT NULL,
country VARCHAR2(15) NOT NULL,
phone VARCHAR2(15)
);
CREATE SEQUENCE category_id
START WITH 1000
INCREMENT BY 1;
CREATE TABLE Categories(
category_id NUMBER PRIMARY KEY,
category_name VARCHAR2(15),
description VARCHAR2(15)
);
CREATE SEQUENCE product_id
START WITH 1000
INCREMENT BY 1;
CREATE TABLE Products(
product_id NUMBER PRIMARY KEY,
product_name VARCHAR2(15),
supplier_id VARCHAR2(15),
category_id NUMBER,
unit VARCHAR2(15),
price NUMBER,
CONSTRAINT supplier_id_fk_products FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
CONSTRAINT category_id_fk_products FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
CREATE SEQUENCE order_detail_id
START WITH 1000
INCREMENT BY 1;
CREATE TABLE Orderdetails(
order_detail_id NUMBER PRIMARY KEY,
order_id NUMBER,
product_id NUMBER,
quantity NUMBER,
CONSTRAINT orderdetailis_fk_order_id FOREIGN KEY(order_id) REFERENCES orders(order_id),
CONSTRAINT orderproductid_fk_product_id FOREIGN KEY(product_id) REFERENCES products(product_id)
);
SELECT * FROM CATEGORIES;
