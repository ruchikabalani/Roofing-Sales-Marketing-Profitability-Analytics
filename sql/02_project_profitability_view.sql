-- View: roofing.vw_project_profitability

-- DROP VIEW roofing.vw_project_profitability;

CREATE OR REPLACE VIEW roofing.vw_project_profitability
 AS
 SELECT p.project_id,
    p.lead_id,
    p.contract_date,
    p.service_type,
    l.marketing_channel,
    l.zip_code,
    p.contract_revenue,
    COALESCE(p.material_cost, 0::numeric) AS material_cost,
    COALESCE(p.labor_cost, 0::numeric) AS labor_cost,
    COALESCE(p.other_direct_cost, 0::numeric) AS other_direct_cost,
    COALESCE(p.material_cost, 0::numeric) + COALESCE(p.labor_cost, 0::numeric) + COALESCE(p.other_direct_cost, 0::numeric) AS total_project_cost,
    p.contract_revenue - COALESCE(p.material_cost, 0::numeric) - COALESCE(p.labor_cost, 0::numeric) - COALESCE(p.other_direct_cost, 0::numeric) AS gross_profit,
    round((p.contract_revenue - COALESCE(p.material_cost, 0::numeric) - COALESCE(p.labor_cost, 0::numeric) - COALESCE(p.other_direct_cost, 0::numeric)) * 100.0 / NULLIF(p.contract_revenue, 0::numeric), 2) AS gross_margin_pct
   FROM roofing.projects p
     LEFT JOIN roofing.leads l ON p.lead_id = l.lead_id;

ALTER TABLE roofing.vw_project_profitability
    OWNER TO postgres;

