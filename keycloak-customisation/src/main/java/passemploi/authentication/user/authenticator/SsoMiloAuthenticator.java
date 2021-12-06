package passemploi.authentication.user.authenticator;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.broker.provider.IdentityBrokerException;
import org.keycloak.models.FederatedIdentityModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.representations.AccessTokenResponse;
import org.keycloak.util.JsonSerialization;
import passemploi.authentication.user.model.*;
import passemploi.authentication.user.repository.FetchUtilisateurException;
import passemploi.authentication.user.repository.UserRepository;

import java.io.IOException;
import java.util.Base64;
import java.util.List;

public class SsoMiloAuthenticator implements Authenticator {
    protected static final Logger logger = Logger.getLogger(SsoMiloAuthenticator.class);
    private final UserRepository userRepository;
    private final Base64.Decoder decoder = Base64.getDecoder();
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final Structure structure;
    private final Type type;

    public SsoMiloAuthenticator(Structure structure, Type type) {
        this.structure = structure;
        this.type = type;
        userRepository = new UserRepository(System.getenv("API_BASE_URL"));
    }

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        FederatedIdentityModel federatedIdentityModel = context.getSession().users().getFederatedIdentity(context.getRealm(), context.getUser(), "similo-conseiller");
        AccessTokenResponse federatedToken;
        try {
            federatedToken = JsonSerialization.readValue(federatedIdentityModel.getToken(), AccessTokenResponse.class);
            String[] chunks = federatedToken.getToken().split("\\.");
            String tokenContent = new String(decoder.decode(chunks[1]));
            MiloToken miloToken = objectMapper.readValue(tokenContent, MiloToken.class);
            UtilisateurSso utilisateurSso = new UtilisateurSso(
                    miloToken.getGiven_name(),
                    miloToken.getFamily_name(),
                    miloToken.getEmail(),
                    this.structure,
                    this.type
            );
            Utilisateur utilisateur = userRepository.createOrFetch(utilisateurSso, miloToken.getSub());
            context.getUser().setAttribute("id_user", List.of(utilisateur.getId()));
            context.getUser().setAttribute("type", List.of(utilisateur.getType().toString()));
            context.getUser().setAttribute("structure", List.of(utilisateur.getStructure().toString()));
            context.getUser().setEmail(utilisateur.getEmail());
            context.getUser().setFirstName(utilisateur.getPrenom());
            context.getUser().setLastName(utilisateur.getNom());
        } catch (IOException e) {
            logger.error(e.getMessage());
            throw new IdentityBrokerException("Could not decode access token response.", e);
        } catch (FetchUtilisateurException e) {
            logger.error(e.getMessage());
            throw new IdentityBrokerException(e.getMessage());
        }
        context.success();

    }


    @Override
    public void action(AuthenticationFlowContext context) {
    }

    @Override
    public void close() {
    }

    @Override
    public boolean requiresUser() {
        return true;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }


    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
    }
}
