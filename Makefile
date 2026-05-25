.PHONY: bootstrap install sync

bootstrap:
	@bash scripts/bootstrap.sh

install:
	@bash scripts/install.sh

sync:
	@bash scripts/sync.sh
