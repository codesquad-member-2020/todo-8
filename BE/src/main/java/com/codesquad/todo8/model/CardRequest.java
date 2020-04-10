package com.codesquad.todo8.model;

public class CardRequest {

  private Long categoryId;

  private String author;

  private String title;

  private String contents;

  public Long getCategoryId() {
    return categoryId;
  }

  public String getAuthor() {
    return author;
  }

  public String getTitle() {
    return title;
  }

  public String getContents() {
    return contents;
  }
}
