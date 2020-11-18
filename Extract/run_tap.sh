#!/bin/bash
cd /home/danielavancini/Projects/analytics-engineering/Extract/
~/.virtualenvs/tap-postgres/bin/tap-postgres --config config.json --properties properties.json | ~/.virtualenvs/singer-target-postgres/bin/target-postgres --config dw_postgres_config.json 