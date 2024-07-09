## dcape-app-coroot Makefile
## This file extends Makefile.app from dcape
#:

SHELL             = /bin/bash
CFG              ?= .env
CFG_BAK          ?= $(CFG).bak

#- App name
APP_NAME         ?= coroot

#- Docker image name
IMAGE            ?= ghcr.io/coroot/coroot
#- Docker image tag
IMAGE_VER        ?= 1.3.0

#- Agent docker image name
AGENT_IMAGE      ?= ghcr.io/coroot/coroot-node-agent
#- Agent docker image tag
AGENT_IMAGE_VER  ?= 1.20.3

# Hostname for external access
APP_SITE         ?= coroot.dev.test

#- docker compose profile (all|server|agent)
DC_PROFILE       ?= all

#- server url for agent
COLLECTOR        ?= http://app:8080

#- Refresh interval
REFRESH_INTERVAL ?= 15s

#- Clickhouse
CH_ADDR          ?= clickhouse:9000

#- Prometheus
P8S_ADDR         ?= http://prometheus:9090

# PgSQL used as DB
USE_DB            = yes

# Sample admin user data
ADD_USER          = no

CONTAINER_ID     ?= $(APP_TAG)-app-1

# ------------------------------------------------------------------------------

# if exists - load old values
-include $(CFG_BAK)
export

-include $(CFG)
export

# ------------------------------------------------------------------------------
# Find and include DCAPE_ROOT/Makefile
DCAPE_COMPOSE   ?= dcape-compose
DCAPE_ROOT      ?= $(shell docker inspect -f "{{.Config.Labels.dcape_root}}" $(DCAPE_COMPOSE))

ifeq ($(shell test -e $(DCAPE_ROOT)/Makefile.app && echo -n yes),yes)
  include $(DCAPE_ROOT)/Makefile.app
else
  include /opt/dcape/Makefile.app
endif

# ------------------------------------------------------------------------------
stat-user:
# \c - postgres
# create extension pg_stat_statements;
# grant pg_monitor to coroot;


addon:
	x=$(shell $(MAKE) -n add &> /dev/null) ; [ "$x" ] || echo "none"
