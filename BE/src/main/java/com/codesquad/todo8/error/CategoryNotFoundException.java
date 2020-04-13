package com.codesquad.todo8.error;

public class CategoryNotFoundException extends RuntimeException {

  public CategoryNotFoundException(Long categoryId) {
    super("Category Not Found: " + categoryId);
  }
}
