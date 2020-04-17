package com.codesquad.todo8.controller.authentication;

import com.codesquad.todo8.error.UnauthorizedException;
import com.codesquad.todo8.service.user.UserService;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class JwtInterceptor implements HandlerInterceptor {

  // JWT 요청 : eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InR0b3p6aSJ9.6INtCczPguAqOIYYR6fsL2XOZ3ZqnVveKDwhQxqsIVE
  private static final Logger logger = LoggerFactory.getLogger(JwtInterceptor.class);
  private final UserService userService;

  @Value("${jwt.token.secret}")
  private String key;

  public JwtInterceptor(UserService userService) {
    this.userService = userService;
  }

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
      Object handler) {
    String jwt = request.getHeader("Authorization").split(" ")[1];
    logger.debug("JWT : {}", jwt);
    if (validationToken(jwt)) {
      request.setAttribute("userName", getUserName(jwt));
      return true;
    }
    return false;
  }

  private Boolean validationToken(String jwt) {
    String userName = "";
    if (!StringUtils.isEmpty(jwt)) {
      userName = getUserName(jwt);
      logger.debug("userName : {}", userName);
    }
    return userService.getUserByName(userName).getUserId().equals(userName);
  }

  private String getUserName(String jwt) {
    try {
      return Jwts.parserBuilder()
          .setSigningKey(key)
          .build()
          .parseClaimsJws(jwt)
          .getBody()
          .get("userName", String.class);
    } catch (JwtException e) {
      throw new UnauthorizedException(e.getMessage());
    }
  }
}
