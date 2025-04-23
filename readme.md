# Trino Monitoring System with ClickHouse & Grafana

A powerful, ready-to-use monitoring solution for Trino that transforms cryptic query logs into actionable dashboards. Built with ClickHouse for high-performance storage and Grafana for visualization, this system helps you understand what's happening in your Trino cluster without the headache of building monitoring from scratch.

## What's Inside

- **Real-time performance tracking** — See query patterns, resource usage, and bottlenecks as they happen
- **Historical analysis** — Understand trends over time to make informed scaling decisions
- **Deep query inspection** — Troubleshoot problematic queries with detailed execution metrics
- **User activity monitoring** — Track who's using what and how much

## Dashboards

### DLH Overview

![DLH Overview Dashboard][2]

Your command center for Trino operations:
- Query success/failure rates with time-based trends
- Data I/O metrics showing read/write patterns
- Memory and CPU utilization across the cluster
- Query latency breakdown and queue metrics
- Top resource consumers (users and tables)

Perfect for daily monitoring and quickly spotting unusual activity or performance degradation.

### DLH Query Details

![DLH Query Details Dashboard][3]

The query detective tool:
- Full SQL text with syntax highlighting for easy reading
- Visual query execution plan — see exactly how Trino processes each query
- Comprehensive performance metrics breakdown
- Memory and I/O statistics with peak usage tracking
- Parallelism and efficiency metrics
- Detailed error information for failed queries

### DLH User Details

![DLH User Details Dashboard][4]

Know your users and their habits:
- Query patterns and history by user
- Resource consumption trends over time
- Performance metrics broken down by query type
- Tables most frequently accessed
- Success/failure rates for each user

Great for understanding user behavior and identifying opportunities for query optimization training.

### DLH Data Storage Details

![DLH Data Storage Details Dashboard][5]

Table-level insights for data engineers:
- Performance metrics for specific tables
- User access patterns showing who's using what data
- Resource utilization trends by table
- Query distribution by type and application source

Essential for data engineering teams to understand access patterns and optimize table designs.

## How It Works

The system leverages four key ClickHouse components:

### Materialized Views

- **mv_query_metrics**: All the query execution metrics you need, from CPU time to bytes processed
- **mv_source_tables**: Detailed statistics about table access and data volumes
- **mv_query_errors**: Comprehensive error information for troubleshooting

### Regular Views

- **v_unique_table_references**: A clean catalog of all tables accessed in your Trino environment

These views automatically process Trino logs and transform them into structured, queryable metrics that power the dashboards.

## Getting Started

Here's what you'll need:

1. **A Trino Cluster** with JSON logging enabled
2. **ClickHouse Database** for the metrics storage
3. **Grafana Server** (v11.x or later works best)
4. **Log Collection** setup to get logs from Trino to ClickHouse

## Quick Setup Guide

1. **Configure your logs**:
   ```
   # In your Trino config
   http-server.log.format=json
   ```

2. **Set up ClickHouse tables and views**:
   - Create the raw logs table first
   - Apply the materialized view scripts in order:
     1. mv_query_metrics.sql
     2. mv_source_tables.sql
     3. mv_query_errors.sql
   - Finally, create the v_unique_table_references view

3. **Import Grafana dashboards**:
   - Add your ClickHouse as a data source in Grafana
   - Import the dashboard JSON files
   - Customize time ranges and auto-refresh settings to your needs

## Components Description

| Component | Description |
|-----------|-------------|
| **Trino Cluster** | Source of query execution data in JSON format |
| **Log Collection Pipeline** | System for collecting and forwarding logs (e.g., Filebeat, Fluentd, Logstash) |
| **ClickHouse Raw Logs Table** | Primary storage for unprocessed Trino logs |
| **mv_query_metrics** | Materialized view for query performance metrics |
| **mv_source_tables** | Materialized view for table access statistics |
| **mv_query_errors** | Materialized view for detailed error information |
| **v_unique_table_references** | Regular view providing a unified catalog of tables |
| **Grafana Dashboards** | Visualization layer presenting metrics in user-friendly format |

## Data Flow

1. Trino generates detailed JSON logs for each query execution
2. Log collection pipeline transports logs to ClickHouse
3. ClickHouse stores raw logs and processes them through materialized views
4. Grafana queries the materialized views to populate dashboards
5. For specific details (SQL text, query plans), Grafana queries the raw logs table directly

This architecture provides both high-performance aggregated metrics and access to detailed raw data when needed.

## Things to Know

- **Direct Log Access**: Some dashboard panels need direct access to the raw logs table. Make sure your Grafana has the right permissions.

- **Sizing Guidance**: For busy clusters (1000+ queries/hour), consider:
  - 4+ CPU cores for ClickHouse
  - 16GB+ RAM
  - SSD storage sized for your retention needs (typically 50-100GB for 30 days)

- **Data Retention**: Set up a TTL on your tables based on how much history you need. Most teams find 30-60 days sufficient for troubleshooting.

- **Time Zone Configuration**: Double-check that Trino, ClickHouse, and Grafana all use consistent time zones to avoid confusion in your dashboards.

## License

This project is available under the MIT License. See the LICENSE file for more details.

[2]: https://i.imgur.com/TSyI7Fu.png
[3]: https://i.imgur.com/R86XxP0.png
[4]: https://i.imgur.com/qVYFilp.png
[5]: https://i.imgur.com/0O82hIp.png

---

# Система мониторинга Trino на базе ClickHouse и Grafana

## Обзор системы

Готовое к использованию решение для мониторинга Trino, которое превращает сложные для понимания логи запросов в информативные дашборды. Построенная на ClickHouse для высокопроизводительного хранения и Grafana для визуализации, эта система помогает понять, что происходит в вашем кластере Trino, без необходимости создавать мониторинг с нуля.

## Что внутри

- **Отслеживание производительности в реальном времени** — Видите шаблоны запросов, использование ресурсов и узкие места по мере их возникновения
- **Исторический анализ** — Понимаете тенденции со временем для принятия обоснованных решений о масштабировании
- **Глубокий анализ запросов** — Устраняете проблемные запросы с помощью детальных метрик выполнения
- **Мониторинг активности пользователей** — Отслеживаете, кто что использует и в каком объеме

## Дашборды

### DLH Overview

![Дашборд обзора DLH][2]

Ваш командный центр для операций Trino:
- Соотношение успешных/неудачных запросов с тенденциями по времени
- Метрики ввода-вывода данных, показывающие шаблоны чтения/записи
- Использование памяти и CPU по всему кластеру
- Разбивка задержек запросов и метрики очередей
- Основные потребители ресурсов (пользователи и таблицы)

Идеально подходит для ежедневного мониторинга и быстрого выявления необычной активности или снижения производительности.

### DLH Query Details

![Дашборд деталей запроса DLH][3]

Инструмент для детективной работы с запросами:
- Полный текст SQL с подсветкой синтаксиса для удобного чтения
- Визуальный план выполнения запроса — видите точно, как Trino обрабатывает каждый запрос
- Комплексная разбивка метрик производительности
- Статистика памяти и ввода-вывода с отслеживанием пиковой нагрузки
- Метрики параллелизма и эффективности
- Подробная информация об ошибках для неудачных запросов

### DLH User Details

![Дашборд деталей пользователя DLH][4]

Знайте своих пользователей и их привычки:
- Шаблоны запросов и история по пользователям
- Тенденции потребления ресурсов со временем
- Метрики производительности с разбивкой по типам запросов
- Наиболее часто используемые таблицы
- Соотношение успешных/неудачных запросов для каждого пользователя

Отлично подходит для понимания поведения пользователей и выявления возможностей для обучения оптимизации запросов.

### DLH Data Storage Details

![Дашборд деталей хранилища данных DLH][5]

Информация на уровне таблиц для инженеров данных:
- Метрики производительности для конкретных таблиц
- Шаблоны доступа пользователей, показывающие, кто какие данные использует
- Тенденции использования ресурсов по таблицам
- Распределение запросов по типу и источнику приложения

Необходимо для команд инженеров данных, чтобы понимать шаблоны доступа и оптимизировать дизайн таблиц.

## Как это работает

Система использует четыре ключевых компонента ClickHouse:

### Материализованные представления

- **mv_query_metrics**: Все необходимые метрики выполнения запросов, от времени CPU до обработанных байтов
- **mv_source_tables**: Подробная статистика о доступе к таблицам и объемах данных
- **mv_query_errors**: Исчерпывающая информация об ошибках для устранения проблем

### Обычные представления

- **v_unique_table_references**: Чистый каталог всех таблиц, к которым обращаются в вашей среде Trino

Эти представления автоматически обрабатывают логи Trino и преобразуют их в структурированные, доступные для запросов метрики, которые предоставляют информацию дашбордам.

## Начало работы

Вот что вам понадобится:

1. **Кластер Trino** с включенным JSON-логированием
2. **База данных ClickHouse** для хранения метрик
3. **Сервер Grafana** (лучше всего работает v11.x или новее)
4. **Сбор логов** для передачи логов из Trino в ClickHouse

## Краткое руководство по настройке

1. **Настройте ваши логи**:
   ```
   # В вашей конфигурации Trino
   http-server.log.format=json
   ```

2. **Настройте таблицы и представления ClickHouse**:
   - Сначала создайте таблицу сырых логов
   - Примените скрипты материализованных представлений по порядку:
     1. mv_query_metrics.sql
     2. mv_source_tables.sql
     3. mv_query_errors.sql
   - Наконец, создайте представление v_unique_table_references

3. **Импортируйте дашборды Grafana**:
   - Добавьте ваш ClickHouse как источник данных в Grafana
   - Импортируйте JSON-файлы дашбордов
   - Настройте временные диапазоны и параметры автообновления по вашим потребностям

## Что нужно знать

- **Прямой доступ к логам**: Некоторым панелям дашбордов нужен прямой доступ к таблице сырых логов. Убедитесь, что у вашей Grafana есть соответствующие разрешения.

- **Рекомендации по размеру**: Для загруженных кластеров (1000+ запросов/час) рассмотрите:
  - 4+ ядра CPU для ClickHouse
  - 16GB+ RAM
  - SSD-хранилище, размер которого соответствует вашим потребностям в хранении (обычно 50-100 ГБ на 30 дней)

- **Хранение данных**: Настройте TTL на ваших таблицах в зависимости от того, сколько истории вам нужно. Большинство команд считают достаточным 30-60 дней для устранения проблем.

- **Настройка часового пояса**: Дважды проверьте, что Trino, ClickHouse и Grafana используют согласованные часовые пояса, чтобы избежать путаницы в ваших дашбордах.

## Лицензия

Этот проект доступен по лицензии MIT. См. файл LICENSE для получения дополнительной информации.

[2]: https://i.imgur.com/TSyI7Fu.png
[3]: https://i.imgur.com/R86XxP0.png
[4]: https://i.imgur.com/qVYFilp.png
[5]: https://i.imgur.com/0O82hIp.png