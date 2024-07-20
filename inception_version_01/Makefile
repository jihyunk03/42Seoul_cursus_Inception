.PHONY: all re fclean down clean

all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re: clean
	@docker compose -f srcs/docker-compose.yml up -d --build

clean:
	@docker stop $$(docker ps -qa);
	@docker rm $$(docker ps -qa);
	@docker rmi -f $$(docker images -qa);
	@docker volume rm $$(docker volume ls -q);

fclean: clean
	@sudo rm -rf /home/jihykim2/data/mysql/*
	@sudo rm -rf /home/jihykim2/data/wordpress/*