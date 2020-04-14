package com.codesquad.todo8.service;

import static org.assertj.core.api.Assertions.assertThat;

import com.codesquad.todo8.model.User;
import com.codesquad.todo8.service.user.UserService;
import java.util.Optional;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class UserServiceTest {

  private static Logger logger = LoggerFactory.getLogger(UserServiceTest.class);

  @Autowired
  UserService userService;

  @Test
  void 유저아이디를_기반으로_유저를_반환한다() {
    Optional<User> user = userService.getUserByName("nigayo");
    assertThat(user.isPresent()).isEqualTo(true);
    logger.debug("user : {}", user.get());
  }
}
