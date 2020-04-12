package com.codesquad.todo8.controller;


import com.codesquad.todo8.model.Activity;
import com.codesquad.todo8.model.BoardResponse;
import com.codesquad.todo8.model.Card;
import com.codesquad.todo8.model.CardRequest;
import com.codesquad.todo8.model.Category;
import com.codesquad.todo8.model.User;
import com.codesquad.todo8.service.TodoService;
import com.codesquad.todo8.service.UserService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class TodoRestController {

  private static Logger logger = LoggerFactory.getLogger(TodoRestController.class);
  private final TodoService todoService;
  private final UserService userService;

  public TodoRestController(TodoService todoService,
      UserService userService) {
    this.todoService = todoService;
    this.userService = userService;
  }

  @GetMapping("board")
  public BoardResponse main(HttpServletRequest request) {
//    Long id = getUserId(request);
    List<Activity> activities = todoService.findAllActivity("nigayo");
    List<Category> categories = todoService.findAllContents(1L);
    return BoardResponse.of(categories, activities);

  }

  @PostMapping("/cards")
  public Card createCard(@RequestBody CardRequest cardRequest) {
    return todoService.createCard(Card.of(
        cardRequest.getCategoryId(),
        cardRequest.getAuthor(),
        cardRequest.getTitle(),
        cardRequest.getContents()
    ));
  }

  @PatchMapping("/cards/{cardId}")
  public Card updateCard(@PathVariable Long cardId, @RequestBody Card card) throws Exception {
    return todoService.updateCard(card, cardId);
  }

  @PatchMapping("/cards/{cardId}/category/{categoryId}")
  public Card moveCard(@PathVariable Long cardId, @PathVariable Long categoryId) throws Exception {
    return todoService.moveCard(cardId, categoryId);
  }

  private Long getUserId(HttpServletRequest request) {
    String userName = request.getAttribute("userName").toString();
    User user = null;
    try {
      user = userService.getUserByName(userName).orElseThrow(NotFoundException::new);
    } catch (NotFoundException e) {
      logger.debug("UserName Not Found : {}", userName);
    }
    return user.getId();
  }
}
