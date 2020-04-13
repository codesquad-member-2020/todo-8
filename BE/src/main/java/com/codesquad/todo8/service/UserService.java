package com.codesquad.todo8.service;

import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.base.Preconditions.checkNotNull;

import com.codesquad.todo8.error.UserNotFoundException;
import com.codesquad.todo8.model.User;
import com.codesquad.todo8.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

  private final UserRepository userRepository;

  public UserService(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  @Transactional(readOnly = true)
  public User getUserByName(String name) {
    return userRepository.findByName(name).orElseThrow(() -> new UserNotFoundException(name));
  }
}
