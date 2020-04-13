package com.codesquad.todo8.api;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.http.HttpStatus;

public class ApiError {

  private final String message;

  private final int httpStatus;

  public ApiError(Exception exception, HttpStatus status) {
    this.message = exception.getMessage();
    this.httpStatus = status.value();
  }


  public ApiError(String message, HttpStatus httpStatus) {
    this.message = message;
    this.httpStatus = httpStatus.value();
  }

  public String getMessage() {
    return message;
  }

  public int getHttpStatus() {
    return httpStatus;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this)
        .append("message", message)
        .append("httpStatus", httpStatus)
        .toString();
  }
}
