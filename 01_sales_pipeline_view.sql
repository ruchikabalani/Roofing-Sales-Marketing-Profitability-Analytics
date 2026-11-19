-- View: roofing.vw_sales_pipeline

-- DROP VIEW roofing.vw_sales_pipeline;

CREATE OR REPLACE VIEW roofing.vw_sales_pipeline
 AS
 SELECT lead_id,
    inquiry_date,
    marketing_channel,
    sales_stage,
    conversion_date,
    zip_code,
        CASE
            WHEN conversion_date IS NOT NULL THEN 1
            ELSE 0
        END AS converted_flag,
        CASE
            WHEN conversion_date IS NOT NULL THEN conversion_date - inquiry_date
            ELSE NULL::integer
        END AS days_to_conversion
   FROM roofing.leads;

ALTER TABLE roofing.vw_sales_pipeline
    OWNER TO postgres;

