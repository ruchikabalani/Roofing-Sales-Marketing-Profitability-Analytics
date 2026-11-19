
-- ==================================================
-- STEP 55: PROJECT PROFITABILITY ANALYSIS
-- Project: Roofing Sales, Marketing & Profitability
-- Objective: Analyze project revenue, costs,
-- gross profit, and profitability trends.
-- ==================================================


-- STEP 10: PROFITABILITY BY SERVICE TYPE

SELECT
    service_type,
    COUNT(*) AS total_projects,
    ROUND(SUM(contract_revenue), 2)
        AS total_revenue,
    ROUND(SUM(
        COALESCE(material_cost, 0) +
        COALESCE(labor_cost, 0) +
        COALESCE(other_direct_cost, 0)
    ), 2) AS total_project_cost,
    ROUND(SUM(
        contract_revenue -
        COALESCE(material_cost, 0) -
        COALESCE(labor_cost, 0) -
        COALESCE(other_direct_cost, 0)
    ), 2) AS gross_profit,
    ROUND(
        SUM(
            contract_revenue -
            COALESCE(material_cost, 0) -
            COALESCE(labor_cost, 0) -
            COALESCE(other_direct_cost, 0)
        ) * 100.0 /
        NULLIF(SUM(contract_revenue), 0),
        2
    ) AS gross_margin_pct
FROM roofing.projects
GROUP BY service_type
ORDER BY gross_profit DESC;


-- STEP 12: MONTHLY REVENUE & PROFIT TRENDS

SELECT
    DATE_TRUNC('month', contract_date)::DATE
        AS sales_month,
    COUNT(*) AS total_projects,
    ROUND(SUM(contract_revenue), 2)
        AS total_revenue,
    ROUND(SUM(
        contract_revenue -
        COALESCE(material_cost, 0) -
        COALESCE(labor_cost, 0) -
        COALESCE(other_direct_cost, 0)
    ), 2) AS gross_profit
FROM roofing.projects
GROUP BY 1
ORDER BY sales_month;


-- STEP 14: PROFITABILITY BY ZIP CODE

SELECT
    l.zip_code,
    COUNT(DISTINCT l.lead_id) AS total_leads,
    COUNT(DISTINCT p.project_id) AS total_projects,
    ROUND(
        COALESCE(SUM(p.contract_revenue), 0),
        2
    ) AS total_revenue,
    ROUND(
        COALESCE(SUM(
            p.contract_revenue -
            COALESCE(p.material_cost, 0) -
            COALESCE(p.labor_cost, 0) -
            COALESCE(p.other_direct_cost, 0)
        ), 0),
        2
    ) AS gross_profit
FROM roofing.leads l
LEFT JOIN roofing.projects p
    ON l.lead_id = p.lead_id
GROUP BY l.zip_code
ORDER BY gross_profit DESC;


-- STEP 38: TOP 10 MOST PROFITABLE PROJECTS

SELECT
    project_id,
    service_type,
    contract_date,
    contract_revenue,
    total_project_cost,
    gross_profit,
    gross_margin_pct
FROM roofing.vw_project_profitability
ORDER BY gross_profit DESC NULLS LAST
LIMIT 10;
