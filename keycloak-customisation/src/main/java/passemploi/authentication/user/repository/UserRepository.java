package passemploi.authentication.user.repository;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.jboss.logging.Logger;
import org.keycloak.util.JsonSerialization;
import passemploi.authentication.user.model.Utilisateur;
import passemploi.authentication.user.model.UtilisateurSso;

import java.io.IOException;
import java.net.URI;

public class UserRepository {
    private final CloseableHttpClient httpClient;
    private final String apiBaseUrl;
    private final Logger logger = Logger.getLogger(UserRepository.class);

    public UserRepository(String apiBaseUrl) {
        this.httpClient = HttpClientBuilder.create().build();
        this.apiBaseUrl = apiBaseUrl;
    }

    public Utilisateur createOrFetch(UtilisateurSso utilisateurSso, String idUtilisateur) throws FetchUtilisateurException {
        try {
            URI uri = URI.create(String.format("%s/auth/users/%s", this.apiBaseUrl, idUtilisateur));
            HttpPut httpPut = new HttpPut(uri);
            String body = JsonSerialization.writeValueAsString(utilisateurSso);
            StringEntity requestEntity = new StringEntity(body, ContentType.APPLICATION_JSON);
            httpPut.setEntity(requestEntity);
            HttpResponse response = httpClient.execute(httpPut);
            if (response.getStatusLine().getStatusCode() == 200) {
                return JsonSerialization.readValue(response.getEntity().getContent(), Utilisateur.class);
            } else {
                logger.error("Une erreur est survenue lors de la récupération de l'utilisateur. Code HTTP : " + response.getStatusLine().getStatusCode());
                logger.error("Une erreur est survenue lors de la récupération de l'utilisateur. Message : " + response.getEntity().getContent().toString());
                throw new FetchUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur. Code HTTP : " + response.getStatusLine().getStatusCode());
            }
        } catch (IOException e) {
            logger.error("error while fetching user: " + idUtilisateur, e);
            throw new FetchUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur");
        }
    }
}
