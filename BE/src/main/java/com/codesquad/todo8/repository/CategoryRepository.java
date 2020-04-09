package com.codesquad.todo8.repository;

import com.codesquad.todo8.model.Category;
import java.util.List;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends CrudRepository<Category, Long> {

  @Query("SELECT c.id, c.user_id, c.title, c.create_at FROM category c WHERE c.user_id = :id")
  List<Category> findAllByUserId(@Param(value = "id") Long id);
}
