CREATE VIEW `trino-logs-experiment`.v_unique_table_references
(

    `catalog` String,

    `schema` String,

    `table` String,

    `full_table_name` String
)
AS WITH
    source_tables AS
    (
        SELECT DISTINCT
            source_catalog AS catalog,

            source_schema AS schema,

            source_table AS `table`
        FROM `trino-logs-experiment`.mv_source_tables
        WHERE (source_catalog != '') AND (source_schema != '') AND (source_table != '')
    ),

    target_tables AS
    (
        SELECT DISTINCT
            target_catalog AS catalog,

            target_schema AS schema,

            target_table AS `table`
        FROM `trino-logs-experiment`.mv_query_metrics
        WHERE (target_catalog != '') AND (target_schema != '') AND (target_table != '')
    )
SELECT
    catalog,

    schema,

    `table`,

    concat(catalog,
 '.',
 schema,
 '.',
 `table`) AS full_table_name
FROM
(
    SELECT *
    FROM source_tables
    UNION DISTINCT
    SELECT *
    FROM target_tables
)
ORDER BY
    catalog ASC,

    schema ASC,

    `table` ASC;