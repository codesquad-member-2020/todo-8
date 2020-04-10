package com.codesquad.todo8.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table
public class User {

  @Id
  private Long id;

  private String userName;

  public Long getId() {
    return id;
  }

  public String getUserId() {
    return userName;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.SHORT_PREFIX_STYLE)
        .append("id", id)
        .append("userName", userName)
        .toString();
  }
}
