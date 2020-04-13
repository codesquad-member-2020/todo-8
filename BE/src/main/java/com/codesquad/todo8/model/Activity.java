package com.codesquad.todo8.model;

import com.google.common.base.Objects;
import java.time.LocalDateTime;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table
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

  private static LocalDateTime getNow() {
    return LocalDateTime.now();
  }

  private Activity(Long id, String author, String action, String targetName, Long departure,
      Long arrival) {
    this.id = id;
    this.author = author;
    this.action = action;
    this.targetName = targetName;
    this.departure = departure;
    this.arrival = arrival;
    this.createdTime = getNow();
  }

  private Activity(Long id, String author, String action, String targetName) {
    this.id = id;
    this.author = author;
    this.action = action;
    this.targetName = targetName;
    this.createdTime = getNow();
  }

  public static Activity add(String author, String action, String targetName) {
    return new Activity(null, author, action, targetName);
  }

  public static Activity remove(String author, String action, String targetName) {
    return new Activity(null, author, action, targetName);
  }

  public static Activity update(String author, String action, String targetName, Long departure,
      Long arrival) {
    return new Activity(null, author, action, targetName, departure, arrival);
  }

  public static Activity move(String author, String action, String targetName, Long departure,
      Long arrival) {
    return new Activity(null, author, action, targetName, departure, arrival);
  }

  public Activity() {
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
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    Activity activity = (Activity) o;
    return Objects.equal(id, activity.id);
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(id);
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
