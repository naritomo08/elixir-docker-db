UNAME=$(shell uname)
PREFIX=winpty
# for Mac
ifeq (${UNAME}, Darwin)
	PREFIX=
endif


setup:
	sudo bin/setup.sh

up:
	docker-compose up -d

login:
	docker-compose exec web /bin/bash

stop:
	docker-compose stop

down:
	docker-compose down