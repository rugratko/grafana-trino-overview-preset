# DLH User Details Dashboard

## Overview

![Dashboard Overview Image][1]

This dashboard provides comprehensive user activity monitoring for Trino query execution. It allows administrators and data platform engineers to track individual user performance metrics, resource utilization, and access patterns across the data platform.

The dashboard is designed to help identify problematic query patterns, optimize resource allocation, and understand how different users interact with the data platform.

## Key Features

- **Query Success Rate**: Track successful and failed queries over time
- **Performance Tracking**: Monitor query execution times, CPU utilization, and memory consumption
- **Resource Usage Patterns**: Analyze resource consumption trends and identify optimization opportunities
- **Data Access Patterns**: Discover which tables are most frequently accessed by users
- **Query Type Analysis**: Understand the types of queries being executed and their performance characteristics

## Technical Details

The dashboard leverages several ClickHouse materialized views:
- `mv_query_metrics`: Stores detailed metrics about query execution
- `mv_source_tables`: Tracks table access patterns for read operations

Integration with other dashboards (Query Details, Data Storage Details) provides drill-down capabilities for deeper investigation of specific queries or data sources.
---

# Дашборд пользовательской активности DLH

## Обзор

![Изображение обзора дашборда][1]

Этот дашборд предоставляет комплексный мониторинг активности пользователей при выполнении запросов Trino. Он позволяет администраторам и инженерам данных отслеживать индивидуальные показатели производительности пользователей, использование ресурсов и шаблоны доступа к данным.

Дашборд разработан для помощи в выявлении проблемных шаблонов запросов, оптимизации распределения ресурсов и понимания того, как различные пользователи взаимодействуют с платформой данных.

## Ключевые возможности

- **Отслеживание успешности запросов**: Мониторинг успешных и неудачных запросов во времени
- **Отслеживание производительности**: Мониторинг времени выполнения запросов, использования ЦП и потребления памяти
- **Шаблоны использования ресурсов**: Анализ тенденций потребления ресурсов и выявление возможностей оптимизации
- **Шаблоны доступа к данным**: Определение наиболее часто используемых пользователями таблиц
- **Анализ типов запросов**: Понимание типов выполняемых запросов и их характеристик производительности

## Технические детали

Дашборд использует несколько материализованных представлений ClickHouse:
- `mv_query_metrics`: Хранит подробные метрики о выполнении запросов
- `mv_source_tables`: Отслеживает шаблоны доступа к таблицам для операций чтения

Интеграция с другими дашбордами (Детали запроса, Детали хранилища данных) обеспечивает возможности детализации для более глубокого исследования конкретных запросов или источников данных.