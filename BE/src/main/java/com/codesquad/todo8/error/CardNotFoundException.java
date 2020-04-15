package com.codesquad.todo8.error;

public class CardNotFoundException extends RuntimeException {

  public CardNotFoundException(Long id) {
    super("Card Not Found: " + id);
  }

}
