
-- ==================================================
-- STEP 53: SALES ANALYSIS SQL
-- Project: Roofing Sales, Marketing & Profitability
-- Objective: Analyze lead conversion, sales pipeline,
-- and monthly lead generation.
-- ==================================================


-- STEP 8: LEAD CONVERSION BY MARKETING CHANNEL

SELECT
    marketing_channel,
    COUNT(*) AS total_leads,
    COUNT(conversion_date) AS converted_leads,
    ROUND(
        COUNT(conversion_date) * 100.0 /
        NULLIF(COUNT(*), 0), 2
    ) AS conversion_rate_pct
FROM roofing.leads
GROUP BY marketing_channel
ORDER BY conversion_rate_pct DESC;


-- STEP 13: SALES PIPELINE PERFORMANCE

SELECT
    sales_stage,
    COUNT(*) AS total_leads,
    COUNT(conversion_date) AS converted_leads,
    ROUND(
        AVG(
            CASE
                WHEN conversion_date IS NOT NULL
                THEN conversion_date - inquiry_date
            END
        ), 1
    ) AS avg_days_to_conversion
FROM roofing.leads
GROUP BY sales_stage
ORDER BY total_leads DESC;


-- STEP 27: MONTHLY LEAD GENERATION

SELECT
    DATE_TRUNC('month', inquiry_date)::DATE
        AS inquiry_month,
    COUNT(*) AS total_leads
FROM roofing.leads
GROUP BY 1
ORDER BY inquiry_month;
