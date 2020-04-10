package com.codesquad.todo8.repository;

import com.codesquad.todo8.model.Activity;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ActivityRepository extends CrudRepository<Activity, Long> {

    @Query("SELECT * FROM activity a WHERE a.author = :author")
    List<Activity> findAllByUserId(String author);
}
