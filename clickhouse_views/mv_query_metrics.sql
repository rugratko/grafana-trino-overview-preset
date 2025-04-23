CREATE MATERIALIZED VIEW `trino-logs-experiment`.mv_query_metrics
(

    `query_id` String,

    `query_state` LowCardinality(String),

    `user` LowCardinality(String),

    `user_agent` LowCardinality(String),

    `source` LowCardinality(String),

    `environment` LowCardinality(String),

    `query_type` LowCardinality(String),

    `retry_policy` LowCardinality(String),

    `target_catalog` LowCardinality(String),

    `target_schema` LowCardinality(String),

    `target_table` String,

    `cpu_time` Float64,

    `wall_time` Float64,

    `queued_time` Float64,

    `analysis_time` Float64,

    `planning_time` Float64,

    `starting_time` Float64,

    `execution_time` Float64,

    `input_blocked_time` Float64,

    `output_blocked_time` Float64,

    `physical_input_read_time` Float64,

    `peak_user_memory_bytes` UInt64,

    `peak_task_user_memory` UInt64,

    `peak_task_total_memory` UInt64,

    `physical_input_bytes` UInt64,

    `physical_input_rows` UInt64,

    `processed_input_bytes` UInt64,

    `processed_input_rows` UInt64,

    `internal_network_bytes` UInt64,

    `internal_network_rows` UInt64,

    `total_bytes` UInt64,

    `total_rows` UInt64,

    `output_bytes` UInt64,

    `output_rows` UInt64,

    `written_bytes` UInt64,

    `written_rows` UInt64,

    `cumulative_memory` Float64,

    `create_time` DateTime64(3),

    `execution_start_time` DateTime64(3),

    `end_time` DateTime64(3)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(create_time)
ORDER BY (create_time,
 query_id,
 query_type)
SETTINGS index_granularity = 8192
AS SELECT
    l.query_id AS query_id,

    l.query_state AS query_state,

    JSONExtractString(l.logs,
 'eventPayload',
 'context',
 'user') AS user,

    JSONExtractString(l.logs,
 'eventPayload',
 'context',
 'userAgent') AS user_agent,

    JSONExtractString(l.logs,
 'eventPayload',
 'context',
 'source') AS source,

    JSONExtractString(l.logs,
 'eventPayload',
 'context',
 'environment') AS environment,

    JSONExtractString(l.logs,
 'eventPayload',
 'context',
 'queryType') AS query_type,

    JSONExtractString(l.logs,
 'eventPayload',
 'context',
 'retryPolicy') AS retry_policy,

    JSONExtractString(l.logs,
 'eventPayload',
 'ioMetadata',
 'output',
 'catalogName') AS target_catalog,

    JSONExtractString(l.logs,
 'eventPayload',
 'ioMetadata',
 'output',
 'schema') AS target_schema,

    JSONExtractString(l.logs,
 'eventPayload',
 'ioMetadata',
 'output',
 'table') AS target_table,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'cpuTime')) AS cpu_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'wallTime')) AS wall_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'queuedTime')) AS queued_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'analysisTime')) AS analysis_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'planningTime')) AS planning_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'startingTime')) AS starting_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'executionTime')) AS execution_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'inputBlockedTime')) AS input_blocked_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'outputBlockedTime')) AS output_blocked_time,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'physicalInputReadTime')) AS physical_input_read_time,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'peakUserMemoryBytes')) AS peak_user_memory_bytes,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'peakTaskUserMemory')) AS peak_task_user_memory,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'peakTaskTotalMemory')) AS peak_task_total_memory,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'physicalInputBytes')) AS physical_input_bytes,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'physicalInputRows')) AS physical_input_rows,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'processedInputBytes')) AS processed_input_bytes,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'processedInputRows')) AS processed_input_rows,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'internalNetworkBytes')) AS internal_network_bytes,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'internalNetworkRows')) AS internal_network_rows,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'totalBytes')) AS total_bytes,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'totalRows')) AS total_rows,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'outputBytes')) AS output_bytes,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'outputRows')) AS output_rows,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'writtenBytes')) AS written_bytes,

    toUInt64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'writtenRows')) AS written_rows,

    toFloat64OrZero(JSONExtractString(l.logs,
 'eventPayload',
 'statistics',
 'cumulativeMemory')) AS cumulative_memory,

    parseDateTime64BestEffortOrNull(JSONExtractString(l.logs,
 'eventPayload',
 'createTime'),
 3) AS create_time,

    parseDateTime64BestEffortOrNull(JSONExtractString(l.logs,
 'eventPayload',
 'executionStartTime'),
 3) AS execution_start_time,

    parseDateTime64BestEffortOrNull(JSONExtractString(l.logs,
 'eventPayload',
 'endTime'),
 3) AS end_time
FROM `trino-logs`.logs AS l
WHERE l.query_state IN ('FINISHED',
 'FAILED');