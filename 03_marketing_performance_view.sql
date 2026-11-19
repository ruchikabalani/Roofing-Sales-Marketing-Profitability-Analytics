-- View: roofing.vw_marketing_performance

-- DROP VIEW roofing.vw_marketing_performance;

CREATE OR REPLACE VIEW roofing.vw_marketing_performance
 AS
 WITH monthly_leads AS (
         SELECT date_trunc('month'::text, leads.inquiry_date::timestamp with time zone)::date AS report_month,
            leads.marketing_channel,
            count(*) AS total_leads,
            count(leads.conversion_date) AS converted_leads
           FROM roofing.leads
          GROUP BY (date_trunc('month'::text, leads.inquiry_date::timestamp with time zone)::date), leads.marketing_channel
        ), monthly_spend AS (
         SELECT marketing_spend.spend_month AS report_month,
            marketing_spend.marketing_channel,
            sum(marketing_spend.spend_amount) AS total_marketing_spend
           FROM roofing.marketing_spend
          GROUP BY marketing_spend.spend_month, marketing_spend.marketing_channel
        )
 SELECT COALESCE(l.report_month, s.report_month) AS report_month,
    COALESCE(l.marketing_channel, s.marketing_channel) AS marketing_channel,
    COALESCE(l.total_leads, 0::bigint) AS total_leads,
    COALESCE(l.converted_leads, 0::bigint) AS converted_leads,
    COALESCE(s.total_marketing_spend, 0::numeric) AS total_marketing_spend,
    round(s.total_marketing_spend / NULLIF(l.total_leads, 0)::numeric, 2) AS cost_per_lead,
    round(s.total_marketing_spend / NULLIF(l.converted_leads, 0)::numeric, 2) AS cost_per_conversion,
    round(l.converted_leads::numeric * 100.0 / NULLIF(l.total_leads, 0)::numeric, 2) AS conversion_rate_pct
   FROM monthly_leads l
     FULL JOIN monthly_spend s ON l.report_month = s.report_month AND l.marketing_channel = s.marketing_channel;

ALTER TABLE roofing.vw_marketing_performance
    OWNER TO postgres;

