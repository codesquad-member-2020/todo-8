package com.codesquad.todo8.controller;

import com.codesquad.todo8.model.Category;
import com.codesquad.todo8.service.TodoService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/board")
public class TodoRestController {

  private final TodoService todoService;

  public TodoRestController(TodoService todoService) {
    this.todoService = todoService;
  }

  @GetMapping
  public List<Category> main(HttpServletRequest request) {
//    Long userId = Long.parseLong(request.getAttribute("userId").toString());
    return todoService.findAllContents(1L);
  }
}
