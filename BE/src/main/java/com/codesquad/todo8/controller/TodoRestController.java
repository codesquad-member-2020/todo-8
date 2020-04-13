package com.codesquad.todo8.controller;

import static com.codesquad.todo8.api.ApiResult.OK;

import com.codesquad.todo8.api.ApiResult;
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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
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
  public ApiResult<BoardResponse> main(HttpServletRequest request) {
//    Long id = getUserId(request);
    List<Activity> activities = todoService.findAllActivity("nigayo");
    List<Category> categories = todoService.findAllContents(1L);
    return OK(BoardResponse.of(categories, activities));

  }

  @PostMapping("/cards")
  public ApiResult createCard(@RequestBody CardRequest cardRequest) {
    Card card = Card.of(
        cardRequest.getCategoryId(),
        cardRequest.getAuthor(),
        cardRequest.getTitle(),
        cardRequest.getContents()
    );
    return OK(todoService.createCard(card));
  }

  @PatchMapping("/cards/{cardId}")
  public Card updateCard(@PathVariable Long cardId, @RequestBody Card card) throws Exception {
    return todoService.updateCard(card, cardId);
  }

  @PatchMapping("/cards/{cardId}/position")
  public String moveCard(@PathVariable Long cardId, @RequestParam("category") Long categoryId,
      @RequestParam("index") int cardIndex)
      throws Exception {
    todoService.moveCard(cardId, categoryId, cardIndex);
    return "ok";
  }

  @DeleteMapping("/cards/{id}")
  public ApiResult deleteCard(@PathVariable(value = "id") Long cardId) {
    return OK(todoService.deleteCard(cardId));
  }

  private Long getUserId(HttpServletRequest request) {
    String userName = request.getAttribute("userName").toString();
    User user = null;
    user = userService.getUserByName(userName);
    return user.getId();
  }
}
