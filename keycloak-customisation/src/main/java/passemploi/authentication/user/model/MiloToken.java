package passemploi.authentication.user.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class MiloToken {
    Integer exp;
    Integer iat;
    Integer auth_time;
    String jti;
    String iss;
    String aud;
    String sub;
    String typ;
    String azp;
    String nonce;
    String session_state;
    String acr;
    String name;
    String preferred_username;
    String given_name;
    String family_name;
    String email;
    String scope;
    Boolean email_verified;

    @JsonProperty("allowed-origins")
    List<String> allowedOrigins;

    RealAccess realm_access;
    ResourceAccess resource_access;
}

@Data
@AllArgsConstructor
class RealAccess {
    List<String> roles;
}

@Data
@AllArgsConstructor
class ResourceAccess {
    Account account;
}


@Data
@AllArgsConstructor
class Account {
    List<String> roles;
}
