package com.codesquad.todo8.model;

import java.time.LocalDateTime;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

@Table
public class Category {

  @Id
  private Long id;

  private Long userId;

  private String title;

  @Column(value = "create_at")
  private LocalDateTime createdDate;

  @MappedCollection(idColumn = "category_id", keyColumn = "category_key")
  private List<Card> cards;

  public Long getId() {
    return id;
  }

  public Long getUserId() {
    return userId;
  }

  public String getTitle() {
    return title;
  }

  public LocalDateTime getCreatedDate() {
    return createdDate;
  }

  public List<Card> getCards() {
    return cards;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("id", id)
        .append("userId", userId)
        .append("title", title)
        .append("createdDate", createdDate)
        .append("cards", cards)
        .toString();
  }
}
