package com.codesquad.todo8.service;

import static org.assertj.core.api.Assertions.assertThat;

import com.codesquad.todo8.model.Card;
import com.codesquad.todo8.model.Category;
import com.codesquad.todo8.repository.CategoryRepository;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class TodoServiceTest {

  private static Logger logger = LoggerFactory.getLogger(TodoServiceTest.class);

  @Autowired
  TodoService todoService;

  @Autowired
  CategoryRepository categoryRepository;

  @Test
  void 유저아이디를_통해_카테고리와_카드를_반환한다() {
    Long userId = 1L;
    List<Category> list = todoService.findAllContents(userId);
    assertThat(list.size()).isEqualTo(3);
    logger.debug("list : {}", list.toString());

  }

  @Test
  void 새로운_카드를_카테고리중간에_넣을수_있다() {
    Long categoryId = 1L;
    Card card = Card.of(
        categoryId,
        "nigayo",
        "새로운 카드입니다",
        "원하는 2번째 위치에 들어갔나요?"
    );
    Category category = categoryRepository.findById(categoryId).get();
    logger.debug("before category : {}", category);
    category.getCards().add(1, card);
    Category after = categoryRepository.save(category);
    logger.debug("after category : {}", after);
    assertThat(after.getCards().get(1).getTitle()).isEqualTo(card.getTitle());
  }
}
