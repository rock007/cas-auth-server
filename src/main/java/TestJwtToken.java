/**
 * sam@here 2020/4/1
 **/
import org.apache.commons.codec.binary.Base64;
import org.jose4j.jwe.JsonWebEncryption;
import org.jose4j.jwk.JsonWebKey;
import org.jose4j.jws.JsonWebSignature;
import org.jose4j.keys.AesKey;

import java.nio.charset.StandardCharsets;
import java.security.Key;

public class TestJwtToken {

    public static void main(final String[] args) throws Exception{

        final String signingKey = "ZHfrJF9JKTF3ee6pXZvFVSbgArhKIEGHk8zaErUJTZPhhjGh9Xjz_CGhtFDw7UKOmagZSX6KTSW4sd12C-jJfQ";
        final String encryptionKey = "PMJEy6q6-1R029IYhnoI5Rm4ub66RQfxy8KDeXkG1_o";

        final String secureJwt="eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.ZXlKNmFYQWlPaUpFUlVZaUxDSmhiR2NpT2lKa2FYSWlMQ0psYm1NaU9pSkJNVEk0UTBKRExVaFRNalUySWl3aVkzUjVJam9pU2xkVUlpd2lkSGx3SWpvaVNsZFVJbjAuLnlDeTZsekV4d0pmYVNRNU5nLVZiNXcuVTE5SzlZV0E3OHA5ZVRMM2Q4MmJGYVk1Q3pITklkd2o5ZTkxSTR6NVJMTnI5dU5QMjNkcEtXem9hZ1YxbjJIeWRGRm1tTFdOZDU0M0F1YnpxUUxaUklMZXRpbkdDQk1uRDBQNldENDRGbTc2am9JOUp0U2FPQ29ScG9nUWlpVmYwQzI1TlZRX0RES1RmQWd2aURVUEtmVTUydlZ5WE1vZkNJWldKaGhzZThEWm1WbmJ3Y2VldHNVUkwwUDZjM05QbUY2cTBVXzlmZ0hUTG1EWlAxaDRMd05mU29MQTdtOG9vYTlrU2p1OEotRV9oOV80cExqX2w4SzBUTE0taHBvUG0zX3A3bUhfTkdIUDN4TDFjaGc3a0FTM29jc2otQkZWSkZKaUZGRTYtVlU5ZVRoSlNiWTJhZUYzdGV4Y3JsVmVPRXlvNm5GbWJhZHZlWVZzUE9zbzBnLjhLNTNkd01VTmN4ODMtMHRCYndOLVE.Xa5vTPm-WhD1XQj8Umzyn9K5edMxch1l6q5gTvDEtkdy4KcioGHZw4LZmcS4IxSgFX_prnMqsTgay5rHOQKDXw";

        final Key key = new AesKey(signingKey.getBytes(StandardCharsets.UTF_8));

        final JsonWebSignature jws = new JsonWebSignature();
        jws.setCompactSerialization(secureJwt);
        jws.setKey(key);
        if (!jws.verifySignature()) {
            throw new Exception("JWT verification failed");
        }

        final byte[] decodedBytes = Base64.decodeBase64(jws.getEncodedPayload().getBytes(StandardCharsets.UTF_8));
        final String decodedPayload = new String(decodedBytes, StandardCharsets.UTF_8);

        final JsonWebEncryption jwe = new JsonWebEncryption();
        final JsonWebKey jsonWebKey = JsonWebKey.Factory
                .newJwk("\n" + "{\"kty\":\"oct\",\n" + " \"k\":\"" + encryptionKey + "\"\n" + "}");

        jwe.setCompactSerialization(decodedPayload);
        jwe.setKey(new AesKey(jsonWebKey.getKey().getEncoded()));
        System.out.println(jwe.getPlaintextString());

    }
}


