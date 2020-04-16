package com.codesquad.todo8.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.time.LocalDateTime;
import java.util.ArrayList;
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
  private final Long id;

  @JsonIgnore
  private final Long userId;

  private final String title;

  private final String author;

  @Column(value = "create_at")
  private final LocalDateTime createdDate;

  @MappedCollection(idColumn = "category_id", keyColumn = "category_key")
  private List<Card> cards = new ArrayList<>();

  public Category(Long id, Long userId, String title, String author,
      LocalDateTime createdDate) {
    this.id = id;
    this.userId = userId;
    this.title = title;
    this.author = author;
    this.createdDate = createdDate;
  }

  Category withId(Long id) {
    return new Category(id, this.userId, this.title, this.author, this.createdDate);
  }


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

  public String getAuthor() {
    return author;
  }

  public void addFirstCard(Card card) {
    this.cards.add(0, card);
  }

  public void addCard(Card card, int index) {
    this.cards.add(index, card);
  }

  public void moveCard(int index, Card card) {
    this.cards.add(index, card);
  }

  public Card getFirstCard() {
    return this.cards.get(0);
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.SHORT_PREFIX_STYLE)
        .append("id", id)
        .append("userId", userId)
        .append("title", title)
        .append("author", author)
        .append("createdDate", createdDate)
        .append("cards", cards)
        .toString();
  }
}
