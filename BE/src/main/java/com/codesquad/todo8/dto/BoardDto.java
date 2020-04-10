package com.codesquad.todo8.dto;

import com.codesquad.todo8.model.Activity;
import com.codesquad.todo8.model.Category;
import org.apache.commons.lang3.builder.ToStringBuilder;

import java.util.List;

public class BoardDto {
    List<Category> category;

    List<Activity> activity;

    public BoardDto(List<Category> category, List<Activity> activity) {
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
