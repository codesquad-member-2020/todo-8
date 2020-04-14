package com.codesquad.todo8.repository;

import com.codesquad.todo8.model.Activity;
import java.util.List;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ActivityRepository extends CrudRepository<Activity, Long> {

  @Query("SELECT a.id, a.author, a.action, a.target_name, a.departure, a.arrival, a.create_at "
      + "FROM activity a "
      + "WHERE a.author = :author")
  List<Activity> findAllByAuthor(@Param(value = "author") String author);
}
