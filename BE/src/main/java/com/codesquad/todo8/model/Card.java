package com.codesquad.todo8.model;

import com.google.common.base.Objects;
import java.time.LocalDateTime;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table
public class Card {

  @Id
  private Long id;

  private Long categoryId;

  private String author;

  private String title;

  private String contents;

  @Column(value = "create_at")
  private LocalDateTime createdDate;

  @Column(value = "modify_at")
  private LocalDateTime modifiedDate;

  private Card(Long id, Long categoryId, String author, String title, String contents,
      LocalDateTime createdDate, LocalDateTime modifiedDate) {
    this.id = id;
    this.categoryId = categoryId;
    this.author = author;
    this.title = title;
    this.contents = contents;
    this.createdDate = createdDate;
    this.modifiedDate = modifiedDate;
  }

  public static Card of(Long categoryId, String author, String title, String contents) {
    LocalDateTime now = getNow();
    return new Card(null, categoryId, author, title, contents, now,
        now);
  }

  private static LocalDateTime getNow() {
    return LocalDateTime.now();
  }

  public Long getId() {
    return id;
  }

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

  public LocalDateTime getCreatedDate() {
    return createdDate;
  }

  public LocalDateTime getModifiedDate() {
    return modifiedDate;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    Card card = (Card) o;
    return Objects.equal(id, card.id);
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(id);
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.SHORT_PREFIX_STYLE)
        .append("id", id)
        .append("categoryId", categoryId)
        .append("author", author)
        .append("title", title)
        .append("contents", contents)
        .append("createdDate", createdDate)
        .append("modifiedDate", modifiedDate)
        .toString();
  }
}

