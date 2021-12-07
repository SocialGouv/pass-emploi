package passemploi.authentication.user.authenticator;

import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.authentication.Authenticator;
import org.keycloak.broker.provider.IdentityBrokerException;
import org.keycloak.models.FederatedIdentityModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.representations.AccessTokenResponse;
import org.keycloak.util.JsonSerialization;
import passemploi.authentication.user.model.*;
import passemploi.authentication.user.repository.FetchPEUtilisateurException;
import passemploi.authentication.user.repository.FetchUtilisateurException;
import passemploi.authentication.user.repository.PoleEmploiRepository;
import passemploi.authentication.user.repository.UserRepository;

import java.io.IOException;
import java.util.List;

public class SsoPEConseillerAuthenticator implements Authenticator {
    protected static final Logger logger = Logger.getLogger(SsoPEConseillerAuthenticator.class);
    private final UserRepository userRepository;
    private final PoleEmploiRepository poleEmploiRepository;
    private final String socialProvider;

    public SsoPEConseillerAuthenticator(String provider) {
        userRepository = new UserRepository();
        poleEmploiRepository = new PoleEmploiRepository();
        socialProvider = provider;
    }

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        FederatedIdentityModel federatedIdentityModel = context.getSession().users().getFederatedIdentity(context.getRealm(), context.getUser(), socialProvider);
        try {
            AccessTokenResponse federatedToken = JsonSerialization.readValue(federatedIdentityModel.getToken(), AccessTokenResponse.class);
            UtilisateurSsoPe utilisateurSsoPe = poleEmploiRepository.get(federatedToken.getToken());
            UtilisateurSso utilisateurSso = new UtilisateurSso(
                    utilisateurSsoPe.getGiven_name(),
                    utilisateurSsoPe.getFamily_name(),
                    utilisateurSsoPe.getEmail(),
                    Structure.POLE_EMPLOI,
                    Type.CONSEILLER
            );
            Utilisateur utilisateur = userRepository.createOrFetch(utilisateurSso, utilisateurSsoPe.getSub());
            context.getUser().setAttribute("id_user", List.of(utilisateur.getId()));
            context.getUser().setAttribute("type", List.of(utilisateur.getType().toString()));
            context.getUser().setAttribute("structure", List.of(utilisateur.getStructure().toString()));
            context.getUser().setEmail(utilisateur.getEmail());
            context.getUser().setFirstName(utilisateur.getPrenom());
            context.getUser().setLastName(utilisateur.getNom());
            context.success();
        } catch (FetchPEUtilisateurException | IOException e) {
            logger.error(e.getMessage());
            context.failure(AuthenticationFlowError.IDENTITY_PROVIDER_ERROR);
            throw new IdentityBrokerException(e.getMessage());
        } catch (FetchUtilisateurException e) {
            logger.error(e.getMessage());
            context.failure(AuthenticationFlowError.INTERNAL_ERROR);
        }
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
