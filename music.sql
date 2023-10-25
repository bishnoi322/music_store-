USE music_stores;

# Senior most employee based on job title:
SELECT * FROM employee;
SELECT * FROM employee
ORDER BY levels DESC LIMIT 1;

# Countries that have most invoices:
SELECT * FROM invoice;
SELECT COUNT(*) AS c, billing_country FROM invoice
Group by billing_country ORDER BY c DESC;

# Top 3 values of total invoice:
SELECT total FROM invoice
ORDER BY total DESC LIMIT 3;

# City that has the best customers with the name of city and invoice totals:
SELECT * FROM invoice;
SELECT * FROM customer;
SELECT SUM(total) AS invoice_total, billing_city
FROM invoice
GROUP BY billing_city ORDER BY invoice_total DESC;

# The best customer that is the person who has spent the most money:
SELECT first_name , last_name , c.customer_id, SUM(i.total) AS total
FROM customer c JOIN invoice i 
ON c.customer_id = i.customer_id
GROUP BY c.customer_id ORDER BY total DESC LIMIT 1;

# A query to return the email, first name, last name and genre of all Rock music listeners ordered alphabetically 
# with email starting by 'A':
SELECT c.email, c.first_name, c.last_name, c.customer_id
FROM customer c JOIN invoice i 
ON c.customer_id = i.customer_id
JOIN invoice_line l ON i.invoice_id = l.invoice_id
WHERE track_id IN (
SELECT t.track_id FROM track t JOIN genre g 
ON t.genre_id = g.genre_id
WHERE g.name LIKE 'Rock')
GROUP BY c.customer_id ORDER BY c.email ;

# To enable group by clause in mysql:
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

# A query that returns the Artist name and total track count of the top 10 rock bands:
SELECT a.artist_id, a.name, COUNT(a.artist_id) AS Total_recs
FROM artist a JOIN album2 b ON a.artist_id = b.artist_id
JOIN track t ON b.album_id = t.album_id
WHERE b.artist_id IN (SELECT album_id FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name LIKE 'Rock')
GROUP BY a.artist_id  ORDER BY total_recs DESC limit 10 ; 

# Another query to reach the same conclusion:
SELECT * FROM genre;
SELECT a.artist_id, a.name, COUNT(a.artist_id) AS number_of_songs
FROM track t
JOIN album2 b ON b.album_id = t.album_id
JOIN artist a ON a.artist_id = b.artist_id
JOIn genre g ON g.genre_id = t.genre_id
WHERE g.name LIKE 'Rock'
GROUP BY a.artist_id ORDER BY number_of_songs DESC
LIMIT 10;

# The name and milliseconds for each track that have a song length 
# longer than the average song length with the longest song listed first:
SELECT * FROM track;
SELECT name, milliseconds FROM track 
WHERE milliseconds > (SELECT avg(milliseconds) AS avg_length
FROM track)
ORDER BY milliseconds DESC;


 



