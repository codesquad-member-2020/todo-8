package com.codesquad.todo8.model;

import static java.time.LocalDateTime.now;

import com.fasterxml.jackson.annotation.JsonFormat;
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
  private final Long id;

  private final Long categoryId;

  private final String author;

  @Column(value = "create_at")
  @JsonFormat(pattern = "yyyy-MM-dd kk:mm:ss")
  private final LocalDateTime createdDate;

  private String title;

  private String contents;

  @Column(value = "modify_at")
  @JsonFormat(pattern = "yyyy-MM-dd kk:mm:ss")
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
    LocalDateTime time = now();
    return new Card(null, categoryId, author, title, contents, time, time);
  }

  Card withId(Long id) {
    return new Card(id, this.categoryId, this.author, this.title, this.contents,
        this.createdDate, this.modifiedDate);
  }

  public void update(Card card) {
    this.title = card.title;
    this.contents = card.contents;
    this.modifiedDate = now();
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

