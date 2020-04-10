package com.codesquad.todo8.service;

import com.codesquad.todo8.model.User;
import com.codesquad.todo8.repository.UserRepository;
import java.util.Optional;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

  private final UserRepository userRepository;

  public UserService(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  @Transactional(readOnly = true)
  public Optional<User> getUserByName(String name) {
    return userRepository.findByName(name);
  }
}
