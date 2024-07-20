# =====================================================================
# set env values and export required values
# =====================================================================

# folders
SRC_FOLDER				:= srcs
REQ_FOLDER				:= requirements
DATA_FOLDER				:= data
VOLUMES_FOLDER			:= volumes
export REQ_FOLDER

# files
ENV_FILE				:= .env
DOCKER_COMPOSE_FILE		:= $(SRC_FOLDER)/docker-compose.yml
export ENV_FILE

# directories
VOLUMES_DIR				:= $(HOME)/$(DATA_FOLDER)/$(VOLUMES_FOLDER)
MARIADB_VOLUME_DIR		:= $(VOLUMES_DIR)/mariadb
WORDPRESS_VOLUME_DIR	:= $(VOLUMES_DIR)/wordpress
export VOLUMES_DIR


# =====================================================================
# commands for using docker
# =====================================================================

# build and run docker-containers
all:
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build
#	@mkdir -p $(MARIADB_VOLUME_DIR) $(WORDPRESS_VOLUME_DIR) 상단으로 올리기!

# down docker-containers
down:
	@docker compose -f $(DOCKER_COMPOSE_FILE) down

# remove and re-build docker-containers
re: clean
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

# stop containers and remove images and volumes
clean:
	@docker ps -q | xargs -r docker stop
	@docker ps -aq | xargs -r docker rm
	@docker images -q | xargs -r docker rmi -f
	@docker volume ls -q | xargs -r docker volume rm

# stop and remove mounted-volumes
fclean: clean
	@sudo rm -rf $(MARIADB_VOLUME_DIR)/*
	@sudo rm -rf $(WORDPRESS_VOLUME_DIR)/*

# show status(logs)
status: ps images volume network top

ps logs images top:
	docker compose -f $(DOCKER_COMPOSE_FILE) $@

network volume:
	docker $@ ls

# phony
.PHONY: all re fclean down clean status
.PHONY: ps logs images top
.PHONY: network volume