# pghero in Docker

[![RSpec](https://github.com/evemonk/pghero/actions/workflows/rspec.yml/badge.svg)](https://github.com/evemonk/pghero/actions/workflows/rspec.yml)
[![DeepSource](https://static.deepsource.io/deepsource-badge-light-mini.svg)](https://deepsource.io/gh/evemonk/pghero/?ref=repository-badge)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)

Service container for running [pghero](https://github.com/ankane/pghero).

## Configure

| Environment variable                 | Description                                                                    | Default             | Default in container |
|--------------------------------------|--------------------------------------------------------------------------------|---------------------|----------------------|
| `RAILS_ENV`                          | Rails environment                                                              | `development`       | `production`         |
| `SECRET_KEY_BASE`                    | Rails secret                                                                   | not set             | not set              |
| `WEB_CONCURRENCY`                    | Number of CPU                                                                  | not set             | not set              |
| `RAILS_MAX_THREADS`                  | Rails max threads                                                              | `3`                 | as default           |
| `DATABASE_URL`                       | Database configuration. Example: `postgres://user:password@localhost/database` | not set             | not set              |
| `PGHERO_USERNAME`                    | User name for auth. Always set!                                                | not set             | not set              |
| `PGHERO_PASSWORD`                    | User password for auth. Always set!                                            | not set             | not set              |
| `PGHERO_STATS_DATABASE_URL`          | When `pghero_query_stats` table in another database                            | not set             | not set              |
| `PGHERO_LONG_RUNNING_QUERY_SEC`      | Minimum time for long running queries. In seconds.                             | `60`                | as default           |
| `PGHERO_SLOW_QUERY_MS`               | Minimum average time for slow queries. In milliseconds.                        | `20`                | as default           |
| `PGHERO_SLOW_QUERY_CALLS`            | Minimum calls for slow queries                                                 | `100`               | as default           |
| `PGHERO_EXPLAIN_TIMEOUT_SEC`         | Statement timeout for explain. In seconds.                                     | `10`                | as default           |
| `PGHERO_TOTAL_CONNECTIONS_THRESHOLD` | Minimum connections for high connections warning                               | `500`               | as default           |
| `PGHERO_CONFIG_PATH`                 | Path to config                                                                 | `config/pghero.yml` | as default           |
| `PGHERO_FILTER_DATA`                 | Filter data                                                                    | not set             | as default           |

## Example `docker-compose.yml`

```yaml
services:
  pghero:
    image: "docker.io/biow0lf/evemonk-pghero:main"
    container_name: "evemonk_pghero"
    restart: "unless-stopped"
    environment:
      SECRET_KEY_BASE: "secret-key-base" # run `rails secret` for generate new
      DATABASE_URL: "postgres://user:password@localhost/database"
      RAILS_MAX_THREADS: "1"
```
