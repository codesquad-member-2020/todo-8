package com.codesquad.todo8.api;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.http.HttpStatus;

public class ApiResult<T> {

  private final boolean success;

  private final T response;

  private final ApiError error;

  public ApiResult(boolean success, T response, ApiError error) {
    this.success = success;
    this.response = response;
    this.error = error;
  }

  public static <T> ApiResult<T> OK(T response) {
    return new ApiResult<>(true, response, null);
  }

  public static ApiResult ERROR(String errorMessage, HttpStatus status) {
    return new ApiResult<>(false, null, new ApiError(errorMessage, status));
  }

  public static ApiResult ERROR(Exception exception, HttpStatus status) {
    return new ApiResult<>(false, null, new ApiError(exception, status));
  }


  public boolean isSuccess() {
    return success;
  }

  public T getResponse() {
    return response;
  }

  public ApiError getError() {
    return error;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this)
        .append("success", success)
        .append("response", response)
        .append("error", error)
        .toString();
  }

}
