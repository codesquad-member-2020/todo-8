package com.codesquad.todo8;

import static org.assertj.core.api.Assertions.assertThat;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class JWTTest {

  private Logger logger = LoggerFactory.getLogger(JWTTest.class);
  private static final String jwt = "eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiY2xpZW50In0.HEaCFpogl46sWOwmY2B53Sd09v89adcKW7_9gI-990c";

  @Value("${jwt.token.clientSecret}")
  private String key;

  @Test
  public void 기본() {

//    Key key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
//    String secretString = Encoders.BASE64URL.encode(key.getEncoded());
//    logger.info("secretString : {}", secretString);

    SecretKey sk = Keys.hmacShaKeyFor(Decoders.BASE64URL.decode(key));

    String client = "client";
    String jws = Jwts.builder()
        .claim("name", "client")
        .signWith(sk)
        .compact();
    assertThat(jws).isEqualTo(jwt);
  }

}
