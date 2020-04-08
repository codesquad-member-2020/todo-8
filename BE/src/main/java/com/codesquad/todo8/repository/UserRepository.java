package com.codesquad.todo8.repository;

import com.codesquad.todo8.model.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

    @Query("SELECT * FROM user u WHERE u.id = :id")
    Optional<User> findById(@Param(value = "id") int id);
}
