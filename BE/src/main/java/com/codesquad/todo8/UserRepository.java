package com.codesquad.todo8;

import java.util.Optional;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

  @Query("SELECT * FROM user u WHERE u.id = :userId")
  Optional<User> findById(@Param(value = "userId") String userId);

}
