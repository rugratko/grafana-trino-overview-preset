# DLH Data Storage Details Dashboard

## Overview

![Dashboard Overview Image][1]

This dashboard provides detailed analytics for Trino data storage access patterns. It allows data engineers and administrators to monitor how specific tables and schemas are being accessed, helping to optimize data organization, identify performance bottlenecks, and track usage patterns across the data platform.

The dashboard focuses on table-level metrics and allows drill-down from catalog to schema to table, making it easy to investigate specific data access patterns.

## Key Features

- **Performance Monitoring**: Track query execution times, queue times, and planning times for specific tables
- **Resource Usage Analysis**: Monitor bytes and rows read from tables over time
- **Query Distribution**: Analyze query types and sources accessing specific tables
- **User Activity Tracking**: Identify top users accessing particular tables
- **Query Performance Analysis**: Examine the most resource-intensive queries for specific tables

## Technical Details

The dashboard leverages several ClickHouse materialized views:
- `mv_source_tables`: Tracks detailed table access statistics
- `mv_query_metrics`: Stores query execution metrics
- `v_unique_table_references`: Provides the catalog/schema/table hierarchy for navigation

Integration with other dashboards (Query Details, User Details) provides drill-down capabilities for deeper investigation of specific queries or user behaviors.

---

# Дашборд детализации хранилища данных DLH

## Обзор

![Изображение обзора дашборда][1]

Этот дашборд предоставляет детальную аналитику шаблонов доступа к хранилищу данных Trino. Он позволяет инженерам данных и администраторам отслеживать, как происходит доступ к конкретным таблицам и схемам, помогая оптимизировать организацию данных, выявлять узкие места производительности и отслеживать шаблоны использования по всей платформе данных.

Дашборд фокусируется на метриках уровня таблиц и позволяет детализировать информацию от каталога до схемы и таблицы, что облегчает исследование конкретных шаблонов доступа к данным.

## Ключевые возможности

- **Мониторинг производительности**: Отслеживание времени выполнения запросов, времени в очереди и времени планирования для конкретных таблиц
- **Анализ использования ресурсов**: Мониторинг байтов и строк, считанных из таблиц с течением времени
- **Распределение запросов**: Анализ типов запросов и источников, обращающихся к конкретным таблицам
- **Отслеживание активности пользователей**: Определение ведущих пользователей, обращающихся к конкретным таблицам
- **Анализ производительности запросов**: Изучение наиболее ресурсоемких запросов для конкретных таблиц

## Технические детали

Дашборд использует несколько материализованных представлений ClickHouse:
- `mv_source_tables`: Отслеживает детальную статистику доступа к таблицам
- `mv_query_metrics`: Хранит метрики выполнения запросов
- `v_unique_table_references`: Предоставляет иерархию каталог/схема/таблица для навигации

Интеграция с другими дашбордами (Детали запроса, Детали пользователя) обеспечивает возможности детализации для более глубокого исследования конкретных запросов или поведения пользователей.