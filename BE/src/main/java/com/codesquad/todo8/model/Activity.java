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
  private final Long id;

  private final String author;

  private final String action;

  private final String targetName;

  private final Long departure;

  private final Long arrival;

  @Column(value = "create_at")
  private final LocalDateTime createdTime;

  public Activity(Long id, String author, String action, String targetName, Long departure,
      Long arrival, LocalDateTime createdTime) {
    this.id = id;
    this.author = author;
    this.action = action;
    this.targetName = targetName;
    this.departure = departure;
    this.arrival = arrival;
    this.createdTime = createdTime;
  }

  Activity withId(Long id) {
    return new Activity(id, this.author, this.action, this.targetName, this.departure, this.arrival,
        this.createdTime);
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

  public static class Builder {

    private Long id;
    private String author;
    private String action;
    private String targetName;
    private Long departure;
    private Long arrival;
    private LocalDateTime createdTime;
    ;

    public Builder() {
    }

    public Builder(Activity activity) {
      this.id = activity.id;
      this.author = activity.author;
      this.action = activity.action;
      this.targetName = activity.targetName;
      this.departure = activity.departure;
      this.arrival = activity.arrival;
      this.createdTime = activity.createdTime;
    }

    public Builder id(Long id) {
      this.id = id;
      return this;
    }

    public Builder author(String author) {
      this.author = author;
      return this;
    }

    public Builder action(String action) {
      this.action = action;
      return this;
    }

    public Builder targetName(String targetName) {
      this.targetName = targetName;
      return this;
    }

    public Builder departure(Long departure) {
      this.departure = departure;
      return this;
    }

    public Builder arrival(Long arrival) {
      this.arrival = arrival;
      return this;
    }

    public Builder createdTime(LocalDateTime createdTime) {
      this.createdTime = createdTime;
      return this;
    }

    public Activity build() {
      return new Activity(id, author, action, targetName, departure, arrival, createdTime);
    }
  }


}
