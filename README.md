Keycloak est packagé avec le [buildpack Scalingo MTES-MCT](https://github.com/MTES-MCT/keycloak-buildpack)

### Appliquer la configuration du keycloak sur Scalingo

Keycloak est configuré via un provider terraform

> Si vous avez un Linux, décommenter les lignes dans `deploy/docker-compose.yml`

1. Lancer le tunnel ssh vers la db `tf_state`. Cette db permet de sauvegarder le tfstate.

`scalingo --region osc-secnum-fr1 -a pa-tfstate db-tunnel -p 10030 SCALINGO_POSTGRESQL_URL`

> Il y a un schema par environnement (staging & prod)

2. Déchiffrer le vault correspondant à l'environnement souhaité

```
cd config/vault
make run-vault
make decrypt-staging
```

3. Lancer le provisionning de l'environnement depuis la racine
   `make provision-staging`

> Pour mettre à jour les secrets: `make edit-staging`

### Poste local (pas encore testé)

1. Récupérer les password des vault de stagin et de prod dans Dashlane
2. Mettre le password dans `config/vault/<env>.key`
3. Déchiffrer le `.secret` pour obtenir un `.env` pour les tf vars

```
cd config/vault
make run-vault
make decrypt-staging-f
```

2. Générer le fichier `.env` à partir du `.env.template`
3. Créer un fichier local.env dans le dossier vault avec les TF_VARs
4. Lancer le tout

```
make start #lance keycloak avec son postgres et applique la configuration terraform
make clean #supprime tous les volumes et images
```
