CREATE MATERIALIZED VIEW `trino-logs-experiment`.mv_source_tables
(

    `query_id` String,

    `event_time` DateTime64(3),

    `user` LowCardinality(String),

    `source_catalog` String,

    `source_schema` String,

    `source_table` String,

    `source_physical_input_bytes` UInt64,

    `source_physical_input_rows` UInt64
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(event_time)
ORDER BY (query_id,
 source_catalog,
 source_schema,
 source_table)
SETTINGS index_granularity = 8192
AS WITH expanded_inputs AS
    (
        SELECT
            l.query_id,

            l.event_time,

            JSONExtractString(l.logs,
 'eventPayload',
 'context',
 'user') AS user,

            arrayJoin(JSONExtractArrayRaw(l.logs,
 'eventPayload',
 'ioMetadata',
 'inputs')) AS input_data
        FROM `trino-logs`.logs AS l
        WHERE query_state IN ('FINISHED',
 'FAILED')
    )
SELECT
    query_id,

    event_time,

    user,

    JSONExtractString(input_data,
 'catalogName') AS source_catalog,

    JSONExtractString(input_data,
 'schema') AS source_schema,

    JSONExtractString(input_data,
 'table') AS source_table,

    toUInt64OrZero(JSONExtractString(input_data,
 'physicalInputBytes')) AS source_physical_input_bytes,

    toUInt64OrZero(JSONExtractString(input_data,
 'physicalInputRows')) AS source_physical_input_rows
FROM expanded_inputs;