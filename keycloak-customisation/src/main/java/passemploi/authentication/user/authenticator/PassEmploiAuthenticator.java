package passemploi.authentication.user.authenticator;

import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import passemploi.authentication.user.model.Structure;
import passemploi.authentication.user.model.Type;
import passemploi.authentication.user.model.Utilisateur;
import passemploi.authentication.user.model.UtilisateurSso;
import passemploi.authentication.user.repository.FetchUtilisateurException;
import passemploi.authentication.user.repository.UserRepository;

import java.util.List;

public class PassEmploiAuthenticator implements Authenticator {

  protected static final Logger logger = Logger.getLogger(PassEmploiAuthenticator.class);
  private final UserRepository userRepository;

  public PassEmploiAuthenticator() {
    userRepository = new UserRepository();
  }

  @Override
  public void authenticate(AuthenticationFlowContext context) {
    try {
      Type type = Type.valueOf(context.getUser().getAttributes().get("type").get(0));
      String idUser = context.getUser().getAttributes().get("id_user").get(0);
      UtilisateurSso utilisateurSso = new UtilisateurSso(Structure.PASS_EMPLOI, type);
      Utilisateur utilisateur = userRepository.createOrFetch(utilisateurSso, idUser);
      context.getUser().setAttribute("id_user", List.of(utilisateur.getId()));
      context.getUser().setAttribute("type", List.of(utilisateur.getType().toString()));
      context.getUser().setAttribute("structure", List.of(utilisateur.getStructure().toString()));
      context.getUser().setEmail(utilisateur.getEmail());
      context.getUser().setFirstName(utilisateur.getPrenom());
      context.getUser().setLastName(utilisateur.getNom());
      context.success();
    } catch (FetchUtilisateurException e) {
      logger.error(e.getMessage());
      Helpers.utilisateurInconnuRedirect(context, Helpers.UTILISATEUR_INCONNU_MESSAGE.UTILISATEUR_PASS_EMPLOI_INCONNU);
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
