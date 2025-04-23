# DLH Query Details Dashboard

## Overview

![Dashboard Overview Image][1]

This dashboard provides detailed analysis of individual Trino queries executed within your data platform. It offers comprehensive insights into query execution metrics, resource utilization, and performance characteristics to help with troubleshooting and optimization.

The dashboard is built on ClickHouse materialized views that capture and process Trino query logs, making it possible to examine every aspect of query execution from SQL text to execution plans and performance metrics.

## Key Features

- **Query Analysis**: View the full SQL text with syntax highlighting and execution plan details
- **Performance Metrics**: Analyze detailed time breakdown across query phases (queue, planning, execution)
- **Resource Utilization**: Monitor memory consumption, CPU efficiency, and data I/O metrics
- **Data Source Analysis**: Identify tables being accessed and their contribution to query complexity
- **Error Diagnostics**: Examine detailed error messages when queries fail
- **Historical Context**: Compare current query performance against similar historical queries

## Technical Details

The dashboard leverages several materialized views in ClickHouse:
- `mv_query_metrics`: Core query performance metrics
- `mv_source_tables`: Source table access statistics
- `mv_query_errors`: Detailed error information

Custom HTML panels provide enhanced visualization capabilities for SQL text, query plans, and metrics presentation.

---

# Дашборд детализации запросов DLH

## Обзор

![Изображение обзора дашборда][1]

Этот дашборд предоставляет детальный анализ отдельных запросов Trino, выполняемых в вашей платформе данных. Он предлагает исчерпывающую информацию о метриках выполнения запросов, использовании ресурсов и характеристиках производительности для помощи в отладке и оптимизации.

Дашборд построен на материализованных представлениях ClickHouse, которые захватывают и обрабатывают логи запросов Trino, что позволяет изучить каждый аспект выполнения запроса от SQL-текста до планов выполнения и метрик производительности.

## Ключевые возможности

- **Анализ запросов**: Просмотр полного SQL-текста с подсветкой синтаксиса и деталями плана выполнения
- **Метрики производительности**: Анализ детального распределения времени по фазам запроса (очередь, планирование, выполнение)
- **Использование ресурсов**: Мониторинг потребления памяти, эффективности ЦП и метрик ввода-вывода данных
- **Анализ источников данных**: Определение таблиц, к которым осуществляется доступ, и их вклада в сложность запроса
- **Диагностика ошибок**: Изучение подробных сообщений об ошибках при сбоях запросов
- **Исторический контекст**: Сравнение производительности текущего запроса с аналогичными историческими запросами

## Технические детали

Дашборд использует несколько материализованных представлений в ClickHouse:
- `mv_query_metrics`: Основные метрики производительности запросов
- `mv_source_tables`: Статистика доступа к исходным таблицам
- `mv_query_errors`: Подробная информация об ошибках

Пользовательские HTML-панели обеспечивают расширенные возможности визуализации для SQL-текста, планов запросов и представления метрик.