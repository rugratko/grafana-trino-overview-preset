# DLH Overview Dashboard

## Overview

![Dashboard Overview Image][1]

This Grafana dashboard provides a comprehensive view of Trino cluster performance metrics. Built on ClickHouse materialized views, it offers real-time monitoring of query execution, resource utilization, and data access patterns.

The dashboard is designed for data platform engineers and administrators who need to monitor Trino cluster health, identify performance bottlenecks, and analyze usage patterns across different environments.

## Key Features

- **Data I/O Monitoring**: Track read/write operations and their proportions over time
- **Query Performance Analysis**: Monitor execution times, memory usage, and CPU utilization
- **Resource Utilization**: Visualize memory consumption and processing times
- **User Activity Tracking**: Identify top users by query count and resource consumption
- **Data Storage Analysis**: Monitor top accessed tables for read and write operations

## Technical Details

The dashboard uses ClickHouse materialized views to efficiently store and query Trino metrics data:
- `mv_query_metrics`: Stores detailed query execution metrics
- `mv_source_tables`: Tracks table access statistics

Environment filtering allows monitoring multiple Trino clusters from a single dashboard.

---

# Дашборд обзора DLH

## Обзор

![Изображение обзора дашборда][1]

Этот дашборд Grafana предоставляет комплексное представление метрик производительности кластера Trino. Построенный на материализованных представлениях ClickHouse, он обеспечивает мониторинг выполнения запросов, использования ресурсов и шаблонов доступа к данным в режиме реального времени.

Дашборд предназначен для инженеров данных и администраторов, которым необходимо отслеживать состояние кластера Trino, выявлять узкие места производительности и анализировать шаблоны использования в различных средах.

## Ключевые возможности

- **Мониторинг ввода-вывода данных**: Отслеживание операций чтения/записи и их пропорций во времени
- **Анализ производительности запросов**: Мониторинг времени выполнения, использования памяти и загрузки ЦП
- **Использование ресурсов**: Визуализация потребления памяти и времени обработки
- **Отслеживание активности пользователей**: Определение ведущих пользователей по количеству запросов и потреблению ресурсов
- **Анализ хранилища данных**: Мониторинг наиболее часто используемых таблиц для операций чтения и записи

## Технические детали

Дашборд использует материализованные представления ClickHouse для эффективного хранения и запроса данных метрик Trino:
- `mv_query_metrics`: Хранит детальные метрики выполнения запросов
- `mv_source_tables`: Отслеживает статистику доступа к таблицам

Фильтрация по окружению позволяет мониторить несколько кластеров Trino с одного дашборда.