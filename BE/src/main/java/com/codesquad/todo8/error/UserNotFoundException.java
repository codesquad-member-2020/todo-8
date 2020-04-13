package com.codesquad.todo8.error;

public class UserNotFoundException extends RuntimeException {

  public UserNotFoundException(String userName) {
    super("User Not Found: " + userName);
  }

}
