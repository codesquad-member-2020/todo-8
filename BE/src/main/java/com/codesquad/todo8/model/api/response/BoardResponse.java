package com.codesquad.todo8.model.api.response;

import com.codesquad.todo8.model.Activity;
import com.codesquad.todo8.model.Category;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;

public class BoardResponse {

  List<Category> category;

  List<Activity> activity;

  public static BoardResponse of(List<Category> category, List<Activity> activity) {
    return new BoardResponse(category, activity);
  }

  private BoardResponse(List<Category> category, List<Activity> activity) {
    this.category = category;
    this.activity = activity;
  }

  public List<Category> getCategory() {
    return category;
  }

  public List<Activity> getActivity() {
    return activity;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this)
        .append("category", category)
        .append("activity", activity)
        .toString();
  }
}
