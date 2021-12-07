package passemploi.authentication.user.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UtilisateurSso {
    private String prenom;
    private String nom;
    private String email;
    private Structure structure;
    private Type type;
    
    public UtilisateurSso(Structure structure, Type type) {
        this.structure = structure;
        this.type = type;
    }
}
