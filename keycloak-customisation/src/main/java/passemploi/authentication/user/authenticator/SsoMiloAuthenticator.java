package passemploi.authentication.user.authenticator;

import org.jboss.logging.Logger;
import org.keycloak.TokenVerifier;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.broker.provider.IdentityBrokerException;
import org.keycloak.common.VerificationException;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.representations.AccessTokenResponse;
import org.keycloak.representations.IDToken;
import passemploi.authentication.user.model.Structure;
import passemploi.authentication.user.model.Type;
import passemploi.authentication.user.model.Utilisateur;
import passemploi.authentication.user.model.UtilisateurSso;
import passemploi.authentication.user.repository.FetchUtilisateurException;
import passemploi.authentication.user.repository.UserRepository;

public class SsoMiloAuthenticator implements Authenticator {
  protected static final Logger logger = Logger.getLogger(SsoMiloAuthenticator.class);
  private final UserRepository userRepository;
  private final Type type;

  public SsoMiloAuthenticator(Type type) {
    this.type = type;
    userRepository = new UserRepository();
  }

  @Override
  public void authenticate(AuthenticationFlowContext context) {
    try {
      String tokenFirstName = context.getUser().getFirstName();
      String tokenLastName = context.getUser().getLastName();
      String tokenEmail = context.getUser().getEmail();
      UtilisateurSso utilisateurSso = new UtilisateurSso(tokenFirstName, tokenLastName, tokenEmail, Structure.MILO, this.type);
      Utilisateur utilisateur = userRepository.createOrFetch(utilisateurSso, context.getUser().getFirstAttribute("idMilo"));
      Helpers.setContextPostLogin(context, utilisateur);
      updateUsernameFromIdToken(context);
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

  private void updateUsernameFromIdToken(AuthenticationFlowContext context) {
    String username = context.getUser().getFirstAttribute("preferred_username");
    logger.info("Preferred username from context.getUser() : " + username);
    AccessTokenResponse tokenResponse = Helpers.getFederatedAccessTokenResponse(context);
    try {
      IDToken idToken = TokenVerifier.create(tokenResponse.getIdToken(), IDToken.class).getToken();
      String preferredUsername = idToken.getPreferredUsername();
      logger.info("Preferred username from ID token: " + preferredUsername);
      context.getUser().setUsername(preferredUsername);
    } catch (VerificationException e) {
      logger.error(e.getMessage());
    }
  }
}
