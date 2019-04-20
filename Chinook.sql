-- Question 1
SELECT
CustomerId, FirstName, LastName, Country
FROM
Customer
WHERE Country != 'USA'

-- Question 2
SELECT
CustomerId, FirstName, LastName, Country
FROM
Customer
WHERE
Country = 'Brazil'

-- Question 3
/* 
brazil_customers_invoices.sql: 
Provide a query showing the Invoices of customers who are from Brazil. 
The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country. 
*/

SELECT
InvoiceId, FirstName, LastName, InvoiceDate, BillingCountry
FROM
Customer
JOIN Invoice ON Invoice.CustomerId = Customer.CustomerId
WHERE
Country = 'Brazil'

-- Question 4
/*
sales_agents.sql: 
Provide a query showing only the Employees who are Sales Agents.
*/

SELECT
*
FROM
Employee
WHERE
Title = 'Sales Support Agent'

-- Question 5
/*
unique_invoice_countries.sql:
Provide a query showing a unique/distinct list of billing countries from the Invoice table.
*/

SELECT

DISTINCT BillingCountry

FROM
Invoice

-- Question 6
/*
sales_agent_invoices.sql:
Provide a query that shows the invoices associated with each sales agent. 
The resultant table should include the Sales Agent's full name.
*/

SELECT
e.EmployeeId, e.FirstName, e.LastName, i.*
FROM
Customer c
JOIN Employee e ON e.EmployeeId = c.SupportRepId
JOIN Invoice i On i.CustomerId = c.CustomerId

-- Question 7
/*
invoice_totals.sql:
Provide a query that shows the Invoice Total, Customer name, Country and 
Sale Agent name for all invoices and customers.
*/
SELECT
i.total Total, c.FirstName + ' ' + c.LastName as Customer, c.Country Country, e.FirstName + ' ' + e.LastName as Employee
FROM
Customer c
JOIN Employee e ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON i.CustomerId = c.CustomerId

-- Question 8
/*
total_invoices_year.sql:
How many Invoices were there in 2009 and 2011?
*/
SELECT
COUNT(*)
FROM
Invoice i
WHERE
YEAR(InvoiceDate) = 2009 OR YEAR(InvoiceDate) = 2011

-- Question 9
--`total_sales_year.sql`: 
--What are the respective total sales for each of those years?
SELECT
SUM(i.Total)
FROM
Invoice i
GROUP BY
YEAR(InvoiceDate)
HAVING
YEAR(InvoiceDate) = 2009 OR YEAR(InvoiceDate) = 2011

--10. `invoice_37_line_item_count.sql`:
--Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT
COUNT(il.InvoiceId)
FROM
InvoiceLine il
WHERE
InvoiceId = 37

--11. `line_items_per_invoice.sql`:
--Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
--HINT: [GROUP BY](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql)
SELECT
COUNT(*) InvoiceId
FROM
InvoiceLine il
GROUP BY
il.InvoiceId

--12. `line_item_track.sql`:
--Provide a query that includes the purchased track name with each invoice line item.
SELECT
il.TrackId, t.Name
FROM
InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId

--13. `line_item_track_artist.sql`:
--Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT
il.TrackId, t.Name, t.Composer Artist
FROM
InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId

--14. `country_invoices.sql`:
--Provide a query that shows the # of invoices per country.
--HINT: [GROUP BY](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql)
SELECT
i.BillingCountry, SUM(i.InvoiceId)
FROM
Invoice i
GROUP BY
i.BillingCountry

--15. `playlists_track_count.sql`:
--Provide a query that shows the total number of tracks in each playlist.
--The Playlist name should be include on the resulant table.
SELECT
p.Name, SUM(pt.TrackId)
FROM
Playlist p
JOIN PlaylistTrack pt ON pt.PlaylistId = p.PlaylistId
GROUP BY
p.Name

--16. `tracks_no_id.sql`:
--Provide a query that shows all the Tracks, but displays no IDs.
--The result should include the Album name, Media type and Genre.
SELECT
t.Name, a.Title, mt.Name, g.Name
FROM
Track t
JOIN Album a ON a.AlbumId = t.AlbumId
JOIN MediaType mt ON mt.MediaTypeId = t.MediaTypeId
JOIN Genre g ON g.GenreId = t.GenreId

--17. `invoices_line_item_count.sql`:
--Provide a query that shows all Invoices but includes the # of invoice line items.

--FIX THIS!!!! ----------------------------------------------------------------
SELECT
i.*, COUNT(il.InvoiceId)
FROM
Invoice i
JOIN InvoiceLine il ON il.InvoiceId = i.InvoiceId
GROUP BY
i.InvoiceId
--------------------------------------------------------------------------------

--18. `sales_agent_total_sales.sql`:
--Provide a query that shows total sales made by each sales agent.
SELECT
e.EmployeeId, e.FirstName + ' ' + e.LastName 'Sales Agent', SUM(i.total) 'Total Sales'
FROM
Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i On i.CustomerId = c.CustomerId
GROUP BY
e.EmployeeId, e.FirstName, e.LastName

--19. `top_2009_agent.sql`:
--Which sales agent made the most in sales in 2009?
--HINT: [MAX](https://docs.microsoft.com/en-us/sql/t-sql/functions/max-transact-sql)

SELECT
TOP 1 e.EmployeeId, e.FirstName + ' ' + e.LastName 'Sales Agent', SUM(i.total) 'Total Sales'
FROM
Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i On i.CustomerId = c.CustomerId
GROUP BY
e.EmployeeId, e.FirstName, e.LastName, i.InvoiceDate
HAVING
YEAR(i.InvoiceDate) = 2009
ORDER BY
SUM(i.total) desc

--20. `top_agent.sql`:
--Which sales agent made the most in sales over all?
SELECT
TOP 1 e.EmployeeId, e.FirstName + ' ' + e.LastName 'Sales Agent', SUM(i.total) 'Total Sales'
FROM
Employee e
	JOIN Customer c
		ON c.SupportRepId = e.EmployeeId
	JOIN Invoice i
		ON i.CustomerId = c.CustomerId
GROUP BY
e.EmployeeId, e.FirstName, e.LastName
ORDER BY
SUM(i.total) desc

--21. `sales_agent_customer_count.sql`:
--Provide a query that shows the count of customers assigned to each sales agent.

SELECT
e.FirstName + ' ' + e.LastName 'Sales Agent', COUNT(c.CustomerId) 'Customer Count'
FROM
Customer c
JOIN Employee e On e.EmployeeId = c.SupportRepId
GROUP BY
e.FirstName, e.LastName

--22. `sales_per_country.sql`:
--Provide a query that shows the total sales per country.

SELECT
i.BillingCountry, SUM(i.Total) 'Country Total Sales'
FROM
Invoice i
GROUP BY
i.BillingCountry

--23. `top_country.sql`:
--Which country's customers spent the most?

SELECT
TOP 1 i.BillingCountry, SUM(i.Total) 'Country Total Sales'
FROM
Invoice i
GROUP BY
i.BillingCountry
ORDER BY
SUM(i.Total) desc


--24. `top_2013_track.sql`:
--Provide a query that shows the most purchased track of 2013.

declare @invoiceYear int = 2013

SELECT
TOP 1 t.TrackId, t.Name, COUNT(il.Quantity) 'Track Purchases'
FROM
InvoiceLine il
	JOIN Track t 
		ON t.TrackId = il.TrackId
	JOIN Invoice i
		ON i.InvoiceId = il.InvoiceId
GROUP BY
	t.TrackId, t.Name, i.InvoiceDate
HAVING
	YEAR(i.InvoiceDate) = @invoiceYear
ORDER BY
	COUNT(il.TrackId) desc

/*
Must declare the scalar variable "@invoiceYear".
*/

--25. `top_5_tracks.sql`:
--Provide a query that shows the top 5 most purchased songs.

SELECT
TOP 5 t.Name, COUNT(il.Quantity) 'Track Purchases'
FROM
InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
JOIN Invoice i ON i.InvoiceId = il.InvoiceId 
GROUP BY
t.Name
ORDER BY
COUNT(il.TrackId) desc



--26. `top_3_artists.sql`:
--Provide a query that shows the top 3 best selling artists.



--27. `top_media_type.sql`:
--Provide a query that shows the most purchased Media Type.
