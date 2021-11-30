package passemploi.authentication.user;

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

import java.io.IOException;

public class UserAuthenticator implements Authenticator {
  protected static final Logger logger = Logger.getLogger(UserAuthenticator.class);

  public UserAuthenticator() {
  }

  @Override
  public void authenticate(AuthenticationFlowContext context) {
    logger.info("user-authenticator execution");
    FederatedIdentityModel federatedIdentityModel = context.getSession().users().getFederatedIdentity(context.getRealm(), context.getUser(), "similo-conseiller");
    AccessTokenResponse federatedToken = null;
    try {
      federatedToken = JsonSerialization.readValue(federatedIdentityModel.getToken(), AccessTokenResponse.class);
    } catch (IOException e) {
      throw new IdentityBrokerException("Could not decode access token response.", e);
    }
    logger.info("federated access token:" + federatedToken.getToken());

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
