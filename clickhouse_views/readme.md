# Trino Monitoring System - ClickHouse Materialized Views

This repository contains the SQL definitions for ClickHouse materialized views and regular views used in the Trino monitoring system. These views process and structure Trino log data to enable comprehensive monitoring and analytics through Grafana dashboards.

## Overview

The monitoring system is built on the following components:
- Raw Trino logs stored in the `trino-logs.logs` table
- Materialized views that extract, transform, and structure this data
- Regular views that provide additional abstractions
- Grafana dashboards that visualize the data

## Materialized Views

### mv_query_metrics

**Purpose**: Extracts comprehensive metrics about query execution from Trino logs.

**Key Features**:
- Captures query metadata (ID, state, user, source)
- Extracts performance metrics (CPU time, wall time, memory usage)
- Tracks I/O statistics (bytes/rows read/written)
- Stores timing information for different phases of query execution
- Includes target table information for write operations

**Storage Engine**: MergeTree partitioned by month, ordered by creation time and query ID.

**Source**: `trino-logs.logs` where query_state is 'FINISHED' or 'FAILED'.

```sql
CREATE MATERIALIZED VIEW `trino-logs-experiment`.mv_query_metrics
ENGINE = MergeTree
PARTITION BY toYYYYMM(create_time)
ORDER BY (create_time, query_id, query_type)
-- Additional fields and implementation details...
```

### mv_source_tables

**Purpose**: Tracks which tables are accessed by Trino queries and the amount of data read.

**Key Features**:
- Extracts information about source tables used in queries
- Records the amount of data read from each table (bytes and rows)
- Links to the query ID for correlation with query metrics
- Includes user information for access pattern analysis

**Storage Engine**: MergeTree partitioned by month, ordered by query ID and table identifiers.

**Source**: `trino-logs.logs` with query_state 'FINISHED' or 'FAILED', using array join to explode the inputs array.

```sql
CREATE MATERIALIZED VIEW `trino-logs-experiment`.mv_source_tables
ENGINE = MergeTree
PARTITION BY toYYYYMM(event_time)
ORDER BY (query_id, source_catalog, source_schema, source_table)
-- Additional fields and implementation details...
```

### mv_query_errors

**Purpose**: Captures detailed error information for failed Trino queries.

**Key Features**:
- Extracts failure type and messages
- Preserves the full failure JSON for detailed diagnosis
- Includes user and environment context
- Links to query ID for correlation with other metrics

**Storage Engine**: MergeTree partitioned by month, ordered by time, failure type, and query ID.

**Source**: `trino-logs.logs` with query_state 'FAILED' and containing failure information.

```sql
CREATE MATERIALIZED VIEW `trino-logs-experiment`.mv_query_errors
ENGINE = MergeTree
PARTITION BY toYYYYMM(time_create_time)
ORDER BY (time_create_time, failure_type, query_id)
-- Additional fields and implementation details...
```

## Views

### v_unique_table_references

**Purpose**: Provides a unified view of all tables referenced in the system, either as sources or targets.

**Key Features**:
- Combines source tables (read operations) and target tables (write operations)
- Removes duplicates with UNION DISTINCT
- Creates a hierarchical structure (catalog > schema > table)
- Generates a full table name for easy reference

**Source**: Combines distinct tables from `mv_source_tables` and `mv_query_metrics`.

```sql
CREATE VIEW `trino-logs-experiment`.v_unique_table_references
-- Fields and implementation details...
```

## Integration

These views work together to provide a complete picture of Trino query execution:

1. `mv_query_metrics` captures overall query performance
2. `mv_source_tables` tracks data source access patterns
3. `mv_query_errors` provides detailed error information
4. `v_unique_table_references` creates a unified catalog of all tables

The Grafana dashboards leverage these views to visualize query performance, resource utilization, and data access patterns, enabling effective monitoring and optimization of the Trino environment.

## Usage Notes

- The materialized views automatically process new data as it arrives in the `trino-logs.logs` table
- Performance considerations:
  - Views are partitioned by month for efficient historical queries
  - Sorting keys are optimized for common query patterns
  - `LowCardinality` type is used for fields with low distinct value counts

---

# Система мониторинга Trino - Материализованные представления ClickHouse

Этот репозиторий содержит SQL-определения для материализованных и обычных представлений ClickHouse, используемых в системе мониторинга Trino. Эти представления обрабатывают и структурируют данные логов Trino для обеспечения комплексного мониторинга и аналитики через дашборды Grafana.

## Обзор

Система мониторинга построена на следующих компонентах:
- Исходные логи Trino, хранящиеся в таблице `trino-logs.logs`
- Материализованные представления, которые извлекают, трансформируют и структурируют эти данные
- Обычные представления, предоставляющие дополнительные абстракции
- Дашборды Grafana, визуализирующие данные

## Материализованные представления

### mv_query_metrics

**Назначение**: Извлекает комплексные метрики о выполнении запросов из логов Trino.

**Ключевые особенности**:
- Захватывает метаданные запросов (ID, состояние, пользователь, источник)
- Извлекает метрики производительности (время CPU, общее время выполнения, использование памяти)
- Отслеживает статистику ввода-вывода (прочитанные/записанные байты/строки)
- Хранит информацию о времени для различных фаз выполнения запроса
- Включает информацию о целевых таблицах для операций записи

**Движок хранения**: MergeTree с разбиением по месяцам, упорядоченный по времени создания и ID запроса.

**Источник**: `trino-logs.logs`, где query_state равно 'FINISHED' или 'FAILED'.

### mv_source_tables

**Назначение**: Отслеживает, к каким таблицам обращаются запросы Trino и количество прочитанных данных.

**Ключевые особенности**:
- Извлекает информацию об исходных таблицах, используемых в запросах
- Записывает количество данных, прочитанных из каждой таблицы (байты и строки)
- Связывает с ID запроса для корреляции с метриками запросов
- Включает информацию о пользователе для анализа шаблонов доступа

**Движок хранения**: MergeTree с разбиением по месяцам, упорядоченный по ID запроса и идентификаторам таблиц.

**Источник**: `trino-logs.logs` с query_state 'FINISHED' или 'FAILED', используя array join для развертывания массива inputs.

### mv_query_errors

**Назначение**: Захватывает детальную информацию об ошибках для неудачных запросов Trino.

**Ключевые особенности**:
- Извлекает тип ошибки и сообщения
- Сохраняет полный JSON ошибки для детальной диагностики
- Включает контекст пользователя и окружения
- Связывает с ID запроса для корреляции с другими метриками

**Движок хранения**: MergeTree с разбиением по месяцам, упорядоченный по времени, типу ошибки и ID запроса.

**Источник**: `trino-logs.logs` с query_state 'FAILED' и содержащие информацию об ошибке.

## Представления

### v_unique_table_references

**Назначение**: Предоставляет унифицированное представление всех таблиц, упоминаемых в системе, как источников, так и целей.

**Ключевые особенности**:
- Объединяет исходные таблицы (операции чтения) и целевые таблицы (операции записи)
- Удаляет дубликаты с помощью UNION DISTINCT
- Создает иерархическую структуру (каталог > схема > таблица)
- Генерирует полное имя таблицы для удобства ссылки

**Источник**: Объединяет уникальные таблицы из `mv_source_tables` и `mv_query_metrics`.

## Интеграция

Эти представления работают вместе, чтобы обеспечить полную картину выполнения запросов Trino:

1. `mv_query_metrics` захватывает общую производительность запросов
2. `mv_source_tables` отслеживает шаблоны доступа к источникам данных
3. `mv_query_errors` предоставляет детальную информацию об ошибках
4. `v_unique_table_references` создает единый каталог всех таблиц

Дашборды Grafana используют эти представления для визуализации производительности запросов, использования ресурсов и шаблонов доступа к данным, обеспечивая эффективный мониторинг и оптимизацию среды Trino.

## Примечания по использованию

- Материализованные представления автоматически обрабатывают новые данные по мере их поступления в таблицу `trino-logs.logs`
- Соображения производительности:
  - Представления разбиты по месяцам для эффективных исторических запросов
  - Ключи сортировки оптимизированы для распространенных шаблонов запросов
  - Тип `LowCardinality` используется для полей с низким количеством уникальных значений