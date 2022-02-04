package passemploi.authentication.user.authenticator;

import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.forms.login.LoginFormsProvider;

import javax.ws.rs.core.Response;

public class Helpers {
  public enum UTILISATEUR_INCONNU_MESSAGE {
    JEUNE_PE_INCONNU("passJeunePEInconnu"),
    UTILISATEUR_PASS_EMPLOI_INCONNU("passUtilisateurInconnu");

    public final String value;

    UTILISATEUR_INCONNU_MESSAGE(String value) {
      this.value = value;
    }
  }

  static public void utilisateurInconnuRedirect(AuthenticationFlowContext context, UTILISATEUR_INCONNU_MESSAGE utilisateurInconnuMessage) {
    LoginFormsProvider form = context.form();
    form.setAttribute("utilisateurInconnu", true);
    form.setAttribute("passMessage", utilisateurInconnuMessage.value);
    Response response = form.createForm("utilisateur-inconnu.ftl");
    context.failure(AuthenticationFlowError.INVALID_USER, response);
  }
}
