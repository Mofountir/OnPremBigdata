COMPOSE := docker compose
NOSQL := $(COMPOSE) exec nosql
DIST := $(COMPOSE) -f docker-compose.yaml -f docker-compose.dist.yaml
DEV := $(COMPOSE) -f docker-compose.dev.yaml

.DEFAULT_GOAL := help

.PHONY: help start status logs shell admin sql stop \
	dist-start dist-status hdfs hive pyspark r-start r dist-stop \
	dev-start dev-shell dev-stop

help:
	@printf '%s\n' \
	  'Oracle NoSQL — TP M4.2 et M4.3' \
	  'make start   Démarrer Oracle NoSQL' \
	  'make status  Afficher l’état du service' \
	  'make logs    Suivre les journaux Oracle NoSQL' \
	  'make shell   Ouvrir le dossier des TP dans le conteneur' \
	  'make admin   Ouvrir la CLI d’administration' \
	  'make sql     Ouvrir la CLI SQL' \
	  'make stop    Arrêter Oracle NoSQL' \
	  '' \
	  'Hadoop, Hive et Spark — TP M4.6.2 et M4.6.3.1 à M4.6.3.3' \
	  'make dist-start   Démarrer la plateforme complète' \
	  'make dist-status  Afficher l’état des services' \
	  'make hdfs         Ouvrir un terminal Hadoop' \
	  'make hive         Ouvrir la CLI Hive' \
	  'make pyspark      Ouvrir la CLI PySpark' \
	  'make r-start      Démarrer R en option' \
	  'make r            Ouvrir la console R' \
	  'make dist-stop    Arrêter la plateforme complète' \
	  '' \
	  'Développement' \
	  'make dev-start  Démarrer Java et Python' \
	  'make dev-shell  Ouvrir le terminal de développement' \
	  'make dev-stop   Arrêter l’environnement de développement'

start:
	$(COMPOSE) up -d --build --wait

status:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f nosql

shell:
	$(COMPOSE) exec --workdir /vagrant/TpBigData nosql bash

admin:
	$(NOSQL) bash -lc 'exec java -jar "$$KVHOME/lib/kvstore.jar" runadmin -host localhost -port 5000 -store kvstore'

sql:
	$(NOSQL) bash -lc 'exec java -jar "$$KVHOME/lib/sql.jar" -helper-hosts localhost:5000 -store kvstore'

stop:
	$(COMPOSE) down

dist-start:
	$(DIST) up -d --build --wait

dist-status:
	$(DIST) ps

hdfs:
	$(DIST) exec --workdir /vagrant/TpBigData namenode bash

hive:
	$(DIST) exec hive beeline -u jdbc:hive2://localhost:10000/default -n root

pyspark:
	$(DIST) exec spark-master pyspark --master spark://spark-master:7077

r-start:
	$(DIST) --profile r up -d --build --wait r

r:
	$(DIST) --profile r exec r R

dist-stop:
	$(DIST) --profile r down

dev-start:
	$(DEV) up -d --build --wait

dev-shell:
	$(DEV) exec dev bash

dev-stop:
	$(DEV) down
