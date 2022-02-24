package passemploi.authentication.user.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class Utilisateur {
    private String id;
    private String prenom;
    private String nom;
    private String email;
    private Structure structure;
    private Type type;
    private List<String> roles;
}
