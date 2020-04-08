package com.codesquad.todo8.model;

import com.google.common.base.Objects;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.data.annotation.Id;

public class User {

  @Id
  private Long seq;

  private final String id;

  public User(String id) {
    this.id = id;
  }

  public Long getSeq() {
    return seq;
  }

  public String getId() {
    return id;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    User user = (User) o;
    return Objects.equal(seq, user.seq);
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(seq);
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this)
        .append("seq", seq)
        .append("id", id)
        .toString();
  }
}
