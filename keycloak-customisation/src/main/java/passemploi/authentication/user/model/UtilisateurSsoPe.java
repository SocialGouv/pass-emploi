package passemploi.authentication.user.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UtilisateurSsoPe {
    private String sub;
    private String updated_at;
    private String name;
    private String given_name;
    private String family_name;
    private String email;
}
