### Packaging
Keycloak est packagé dans un custom buildpack pour Scalingo

### Config
Keycloak est configuré via un provider terraform

### Poste local

`make start`: lance keycloak avec son postgres et applique la configuration terraform  
`make clean`: supprime tous les volumes et images

### Déploiement sur Scalingo

1. Créer une application sur Scalingo
2. Ajouter l'addon postgres
3. Ajouter la variable d'environnement `BUILDPACK_URL=https://github.com/SocialGouv/pass-emploi-auth#main`
4. Ajiuter toutes les variables dans scalingo du fichier `.env.template` avec les bonnes valeurs
5. Lancer un déploiement manuel

### Appliquer la configuration du keycloak sur un env de scalingo

1. Lancer le tunnel ssh vers la db `tf_state`. Cette db permet de sauvegarder le tfstate.  

`scalingo --region osc-secnum-fr1 -a pa-tfstate db-tunnel -p 10030 SCALINGO_POSTGRESQL_URL`
> Il y a un schema par environnement. (staging & prod)
2. Déchiffrer le vault correspondant à l'environnement souhaité
```
cd config/vault
make run run-vault
make decrypt-staging
```
3. Lancer le provisionning de l'environnement depuis la racine
`make provision-staging`


> Pour mettre à jour les secrets: `make edit-staging`
