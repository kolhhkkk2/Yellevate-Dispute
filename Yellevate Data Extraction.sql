-->Getting the Average Days to Settle Invoices per Country
SELECT country, ROUND(AVG(days_to_settle)) AS ave_settled_days
FROM yellevate_invoices
GROUP BY country
ORDER BY ave_settled_days DESC

-->Getting the Average Days to Settle Invoice Disputes per Country
SELECT country, ROUND(AVG(days_to_settle)) AS ave_settled_days
FROM yellevate_invoices
GROUP BY country, disputed
HAVING disputed = 1
ORDER BY ave_settled_days DESC

-->Getting the percentage of Dispute Lost per Country
SELECT country,
       COUNT(disputed) AS dispute_request,
       SUM(dispute_lost) AS lost_dispute,
       ROUND(SUM(dispute_lost) / COUNT(disputed)*100,2) AS dispute_lost_percentage
FROM yellevate_invoices
WHERE disputed = 1
GROUP BY country
ORDER BY lost_dispute DESC

-->Getting the disputed Cases percentage per Country
SELECT country,
	SUM(disputed) AS total_disputed,
	COUNT(DISTINCT invoice_number) AS total_invoice,
	ROUND(SUM(disputed)/COUNT(DISTINCT invoice_number)*100,2)
AS disputed_cases_percentage
FROM yellevate_invoices
GROUP BY country
ORDER BY disputed_cases_percentage DESC

-->Getting the Revenue Lost per Country for dispute lost
SELECT country, SUM(invoice_amount_usd) AS revenue_loss
FROM yellevate_invoices
WHERE dispute_lost = 1
GROUP BY country
ORDER BY revenue_loss DESC

