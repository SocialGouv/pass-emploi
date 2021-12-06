package passemploi.authentication.user.repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.jboss.logging.Logger;
import passemploi.authentication.user.model.Utilisateur;
import passemploi.authentication.user.model.UtilisateurSso;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;

public class UserRepository {
    private final CloseableHttpClient httpClient;
    private final String apiBaseUrl;
    private final ObjectMapper objectMapper;
    private final Logger logger = Logger.getLogger(UserRepository.class);

    public UserRepository(String apiBaseUrl) {
        this.httpClient = HttpClientBuilder.create().build();
        this.apiBaseUrl = apiBaseUrl;
        this.objectMapper = new ObjectMapper();
        this.objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    }

    public Utilisateur createOrFetch(UtilisateurSso utilisateurSso, String idUtilisateur) throws FetchUtilisateurException, JsonProcessingException, UnsupportedEncodingException {
        URI uri = URI.create(String.format("%s/auth/users/%s", this.apiBaseUrl, idUtilisateur));
        HttpPut httpPut = new HttpPut(uri);
        ObjectMapper mapper = new ObjectMapper();
        String body = mapper.writeValueAsString(utilisateurSso);
        StringEntity requestEntity = new StringEntity(body, ContentType.APPLICATION_JSON);
        httpPut.setEntity(requestEntity);
        try (CloseableHttpResponse response = httpClient.execute(httpPut)) {
            if (response.getStatusLine().getStatusCode() == 200) {
                return objectMapper.readValue(response.getEntity().getContent(), new TypeReference<>() {
                });
            } else {
                logger.error("Une erreur est survenue lors de la récupération de l'utilisateur. Code HTTP : " + response.getStatusLine().getStatusCode());
                throw new FetchUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur. Code HTTP : " + response.getStatusLine().getStatusCode());
            }
        } catch (IOException e) {
            logger.error("error while fetching user: " + idUtilisateur, e);
            throw new FetchUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur");
        }
    }
}
