package com.codesquad.todo8.repository.user;

import com.codesquad.todo8.model.User;
import java.util.Optional;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

  @Query("SELECT u.id, u.user_name FROM user u WHERE u.user_name = :name")
  Optional<User> findByName(@Param(value = "name") String userName);

}
