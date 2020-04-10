package com.codesquad.todo8.repository;

import com.codesquad.todo8.model.Activity;
import java.util.List;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

public interface ActivityRepository extends CrudRepository<Activity, Long> {

  @Query("SELECT * FROM activity a WHERE a.author = :author")
  List<Activity> findAllByUserId(String author);
}
