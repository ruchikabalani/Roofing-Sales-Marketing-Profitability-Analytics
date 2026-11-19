
-- ==================================================
-- STEP 54: MARKETING ANALYSIS SQL
-- Project: Roofing Sales, Marketing & Profitability
-- Objective: Analyze marketing spend, lead costs,
-- conversion rates, and marketing ROI.
-- ==================================================


-- STEP 9: CUSTOMER ACQUISITION COST BY CHANNEL

WITH channel_conversions AS (
    SELECT
        marketing_channel,
        COUNT(*) AS total_leads,
        COUNT(conversion_date) AS converted_leads
    FROM roofing.leads
    GROUP BY marketing_channel
),
channel_spend AS (
    SELECT
        marketing_channel,
        SUM(spend_amount) AS total_spend
    FROM roofing.marketing_spend
    GROUP BY marketing_channel
)
SELECT
    c.marketing_channel,
    c.total_leads,
    c.converted_leads,
    s.total_spend,
    ROUND(
        s.total_spend /
        NULLIF(c.converted_leads, 0), 2
    ) AS cost_per_conversion
FROM channel_conversions c
LEFT JOIN channel_spend s
    ON c.marketing_channel = s.marketing_channel
ORDER BY cost_per_conversion ASC NULLS LAST;


-- STEP 11: MARKETING ROI BY CHANNEL

WITH channel_profit AS (
    SELECT
        l.marketing_channel,
        COUNT(DISTINCT p.project_id) AS total_projects,
        COALESCE(SUM(p.contract_revenue), 0)
            AS total_revenue,
        COALESCE(SUM(
            p.contract_revenue
            - COALESCE(p.material_cost, 0)
            - COALESCE(p.labor_cost, 0)
            - COALESCE(p.other_direct_cost, 0)
        ), 0) AS gross_profit
    FROM roofing.leads l
    LEFT JOIN roofing.projects p
        ON l.lead_id = p.lead_id
    GROUP BY l.marketing_channel
),
channel_spend AS (
    SELECT
        marketing_channel,
        SUM(spend_amount) AS total_spend
    FROM roofing.marketing_spend
    GROUP BY marketing_channel
)
SELECT
    p.marketing_channel,
    p.total_projects,
    ROUND(p.total_revenue, 2) AS total_revenue,
    ROUND(p.gross_profit, 2) AS gross_profit,
    ROUND(s.total_spend, 2) AS marketing_spend,
    ROUND(
        (p.gross_profit - s.total_spend)
        * 100.0 /
        NULLIF(s.total_spend, 0),
        2
    ) AS marketing_roi_pct
FROM channel_profit p
LEFT JOIN channel_spend s
    ON p.marketing_channel = s.marketing_channel
ORDER BY marketing_roi_pct DESC NULLS LAST;


-- STEP 15: MONTHLY MARKETING PERFORMANCE

SELECT
    report_month,
    marketing_channel,
    total_leads,
    converted_leads,
    total_marketing_spend,
    cost_per_lead,
    cost_per_conversion,
    conversion_rate_pct
FROM roofing.vw_marketing_performance
ORDER BY report_month, marketing_channel;
