package com.codesquad.todo8.model;

import java.time.LocalDateTime;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;

public class Activity {

  @Id
  private Long id;

  private String author;

  private String action;

  private String targetName;

  private Long departure;

  private Long arrival;

  @Column(value = "create_at")
  private LocalDateTime createdTime;

  public Activity() {
  }
  public Activity(String author, String action, String targetName, Long departure, Long arrival) {
    this.author = author;
    this.action = action;
    this.targetName = targetName;
    this.departure = departure;
    this.arrival = arrival;
  }

  public Activity(String author, String action, String targetName) {
    this.author = author;
    this.action = action;
    this.targetName = targetName;
  }

  public LocalDateTime getCreatedTime() {
    return createdTime;
  }

  public Long getId() {
    return id;
  }

  public String getAuthor() {
    return author;
  }

  public String getAction() {
    return action;
  }

  public String getTargetName() {
    return targetName;
  }

  public Long getDeparture() {
    return departure;
  }

  public Long getArrival() {
    return arrival;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this)
        .append("id", id)
        .append("author", author)
        .append("action", action)
        .append("targetName", targetName)
        .append("departure", departure)
        .append("arrival", arrival)
        .append("createdTime", createdTime)
        .toString();
  }
}
