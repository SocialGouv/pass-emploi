package passemploi.authentication.user.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Utilisateur {
    private String id;
    private String prenom;
    private String nom;
    private String email;
    private Structure structure;
    private Type type;
}
