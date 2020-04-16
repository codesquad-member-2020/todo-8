package com.codesquad.todo8.error;

public class UnauthorizedException extends RuntimeException {

  public UnauthorizedException(String message) {
    super("Unauthorized: " + message);
  }
}
