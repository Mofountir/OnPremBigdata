# Big Data On-Prem

## Setup

Prérequis : Docker Desktop et `make`.

```bash
cp .env.example .env
```

Configurer `.env` :

```env
PROJECT_PATH=/chemin/vers/TpBigData
DATA_PATH=./data
ORACLE_NOSQL_CLIENT_PATH=./vendor/oracle-nosql-client-22.3.52

MYSQL_PASSWORD=hive
MYSQL_ROOT_PASSWORD=root_tp_local
```

Pour M4.6.2, télécharger **kv-client-22.3.52** dans la section
**Oracle NoSQL Database, Client Driver — Java** de la
[page officielle Oracle](https://www.oracle.com/database/technologies/nosql-database-server-prev-downloads.html),
puis l'extraire dans :

```text
vendor/oracle-nosql-client-22.3.52/
└── lib/kvclient.jar
```

Toutes les commandes suivantes sont à lancer depuis la racine du dépôt. `make`
affiche la liste complète.

## Oracle NoSQL — TP M4.2 et M4.3

```bash
make start    # démarre Oracle NoSQL et attend qu'il soit prêt
make admin    # ouvre la CLI kv-> pour M4.2 et M4.3.1
make sql      # ouvre la CLI sql-> pour M4.3.2
make shell    # ouvre /vagrant/TpBigData
make status   # affiche l'état du service
make logs     # affiche les logs
make stop     # arrête Oracle NoSQL
```

## Hadoop, Hive et Spark — TP M4.6

```bash
make dist-start   # démarre Oracle NoSQL, Hadoop, YARN, Hive et Spark
make dist-status  # affiche l'état des services
make hdfs         # ouvre un terminal Hadoop dans /vagrant/TpBigData
make hive         # ouvre la CLI Hive
make pyspark      # ouvre la CLI PySpark
make r-start      # démarre R en option
make r            # ouvre la console R
make dist-stop    # arrête la plateforme complète
```

Ce socle couvre M4.6.2 et M4.6.3.1 à M4.6.3.3. À partir de M4.6.3.4,
Oracle Database EE avec Big Data SQL nécessite la VM du cours.

## Développement Java et Python

```bash
make dev-start  # démarre l'environnement Java 8 et Python 3.9
make dev-shell  # ouvre le terminal dans /workspace
make dev-stop   # arrête l'environnement de développement
```

## Suivi des TP

- [TP M4.2](tp/m42/README.md)
- [TP M4.3](tp/m43/README.md)
