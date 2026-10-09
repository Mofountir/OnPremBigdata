# Big Data On-Prem

Environnement Docker pour les TP Oracle NoSQL, Hadoop, Hive et Spark.

## 1. Préparer le dépôt

Prérequis : Docker Desktop démarré.

```bash
cp .env.example .env
```

Dans `.env`, renseigner le chemin absolu du dossier `TpBigData` fourni avec le
cours :

```env
PROJECT_PATH=/chemin/vers/TpBigData
DATA_PATH=./data
ORACLE_NOSQL_CLIENT_PATH=./vendor/oracle-nosql-client-22.3.52

MYSQL_PASSWORD=hive
MYSQL_ROOT_PASSWORD=root_tp_local
```

## 2. Démarrer Oracle NoSQL

```bash
docker compose up -d --build
docker compose ps
```

Attendre que le service `nosql` soit `healthy`, puis ouvrir un terminal dans le
conteneur :

```bash
docker compose exec --workdir /vagrant/TpBigData nosql bash
```

Le terminal s'ouvre dans les fichiers des TP montés depuis `PROJECT_PATH` :

```bash
pwd
ls
```

Le même chemin est disponible avec la variable du cours :

```bash
cd "$MYTPHOME"
```

Les chemins du cours sont déjà disponibles :

```bash
echo "$KVHOME"
echo "$KVROOT"
echo "$MYTPHOME"
```

## 3. TP M4.2 — interface d'administration

Dans le conteneur :

```bash
java -jar "$KVHOME/lib/kvstore.jar" runadmin \
  -host localhost \
  -port 5000 \
  -store kvstore
```

Test rapide au prompt `kv->` :

```text
help
show topology
exit
```

Si la topologie s'affiche, commencer le sujet à **M4.2.1.1**.

## 4. TP M4.3

### M4.3.1 — tables avec l'interface d'administration

Relancer l'interface utilisée pour M4.2 :

```bash
java -jar "$KVHOME/lib/kvstore.jar" runadmin \
  -host localhost \
  -port 5000 \
  -store kvstore
```

Si la connexion fonctionne, commencer le sujet à **M4.3.1.1**.

### M4.3.2 — tables avec l'interface SQL

Dans le conteneur :

```bash
java -jar "$KVHOME/lib/sql.jar" \
  -helper-hosts localhost:5000 \
  -store kvstore
```

Test rapide au prompt `sql->` :

```sql
SHOW TABLES;
EXIT;
```

Si la commande répond, continuer le sujet à **M4.3.2.2**.

## 5. Arrêter l'environnement

Quitter d'abord le conteneur :

```bash
exit
```

Puis, depuis le Mac :

```bash
docker compose down
```

Les données Oracle NoSQL restent dans `${DATA_PATH}/nosql`.

## Suivi des TP

- [TP M4.2](tp/m42/README.md)
- [TP M4.3](tp/m43/README.md)

## Autres environnements

```bash
# Hadoop, YARN, Hive et Spark
docker compose -f docker-compose.dist.yaml up -d --build

# Java et Python uniquement
docker compose -f docker-compose.dev.yaml up -d --build
```

Pour le TP M4.6.2, démarrer Oracle NoSQL et l'environnement distribué ensemble :

```bash
docker compose \
  -f docker-compose.yaml \
  -f docker-compose.dist.yaml \
  up -d --build
```
