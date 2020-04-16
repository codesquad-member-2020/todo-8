package com.codesquad.todo8.controller;

import static com.codesquad.todo8.model.api.ApiResult.OK;

import com.codesquad.todo8.model.Activity;
import com.codesquad.todo8.model.Card;
import com.codesquad.todo8.model.Category;
import com.codesquad.todo8.model.User;
import com.codesquad.todo8.model.api.ApiResult;
import com.codesquad.todo8.model.api.request.CardRequest;
import com.codesquad.todo8.model.api.response.BoardResponse;
import com.codesquad.todo8.service.TodoService;
import com.codesquad.todo8.service.user.UserService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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

  @GetMapping("activities")
  public ApiResult<List<Activity>> logs(HttpServletRequest request) {
//    String author = getAuthor(request);
    List<Activity> activities = todoService.findAllActivity("nigayo");
    return OK(activities);

  }

  @PostMapping("cards")
  public ApiResult<Card> createCard(@RequestBody CardRequest cardRequest) {
    Card card = Card.of(
        cardRequest.getCategoryId(),
        cardRequest.getAuthor(),
        cardRequest.getTitle(),
        cardRequest.getContents()
    );
    return OK(todoService.createCard(card));
  }

  @PutMapping("cards/{cardId}")
  public ApiResult<Card> updateCard(@PathVariable Long cardId,
      @RequestBody CardRequest cardRequest) {
    Card card = Card.of(
        cardRequest.getCategoryId(),
        cardRequest.getAuthor(),
        cardRequest.getTitle(),
        cardRequest.getContents()
    );
    return OK(todoService.updateCard(card, cardId));
  }

  @PutMapping("cards/{cardId}/position")
  public ApiResult<Card> moveCard(@PathVariable Long cardId,
      @RequestParam("category") Long categoryId,
      @RequestParam("index") int index) {
    return OK(todoService.moveCard(cardId, categoryId, index));
  }

  @DeleteMapping("cards/{id}")
  public ApiResult<Card> deleteCard(@PathVariable(value = "id") Long cardId) {
    return OK(todoService.deleteCard(cardId));
  }

  private Long getUserId(HttpServletRequest request) {
    String userName = request.getAttribute("userName").toString();
    User user = null;
    user = userService.getUserByName(userName);
    return user.getId();
  }

  private String getAuthor(HttpServletRequest request) {
    return request.getAttribute("userName").toString();
  }

}
