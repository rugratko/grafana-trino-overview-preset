CREATE MATERIALIZED VIEW `trino-logs-experiment`.mv_query_errors
(

    `query_id` String,

    `failure_type` LowCardinality(String),

    `failure_message` String,

    `failures_json` String,

    `user` LowCardinality(String),

    `user_agent` LowCardinality(String),

    `environment` LowCardinality(String),

    `time_create_time` DateTime64(3)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(time_create_time)
ORDER BY (time_create_time,
 failure_type,
 query_id)
SETTINGS index_granularity = 8192
AS SELECT
    l.query_id,

    JSONExtractString(l.logs,
 'eventPayload',
 'failureInfo',
 'failureType') AS failure_type,

    JSONExtractString(l.logs,
 'eventPayload',
 'failureInfo',
 'failureMessage') AS failure_message,

    JSONExtractString(l.logs,
 'eventPayload',
 'failureInfo',
 'failuresJson') AS failures_json,

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
 'environment') AS environment,

    parseDateTime64BestEffortOrNull(JSONExtractString(l.logs,
 'eventPayload',
 'createTime'),
 3) AS time_create_time
FROM `trino-logs`.logs AS l
WHERE (l.query_state = 'FAILED') AND JSONHas(l.logs,
 'eventPayload',
 'failureInfo');