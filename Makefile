STAGE ?=
PROFILE ?=
FLAGS ?=

start:
	@echo "Starting with stage: $(STAGE), profile: $(PROFILE)"
	docker-compose \
		-f docker/compose/docker-compose.yaml \
		$(if $(STAGE),-f docker/compose/docker-compose.$(STAGE).yaml,) \
		$(if $(PROFILE),--profile $(PROFILE),) \
		up $(FLAGS)

stop:
	@echo "Stop process with stage: $(STAGE), profile: $(PROFILE)"
	docker-compose \
		-f docker/compose/docker-compose.yaml \
		$(if $(STAGE),-f docker/compose/docker-compose.$(STAGE).yaml,) \
		$(if $(PROFILE),--profile $(PROFILE),) \
		down $(FLAGS)

killall:
	@echo "Force stop all  process"
	docker compose down