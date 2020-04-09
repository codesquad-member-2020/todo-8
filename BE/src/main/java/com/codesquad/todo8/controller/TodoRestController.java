package com.codesquad.todo8.controller;

import com.codesquad.todo8.model.Category;
import com.codesquad.todo8.service.TodoService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/category")
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

//    @PostMapping("/columns")
//    public String addColumn(@RequestBody Column column) {
//    Todo Column이 안 받아짐
//        System.out.println("--------------------");
//        User user = userRepository.findById(1).get();
//        Column newColumn = new Column(column.getTitle());
//        user.addColumn(newColumn);
//        userRepository.save(user);
//        return "ok";
//    }
//
//    @PostMapping("/columns")
//    public String addColumn() throws Exception {
//        System.out.println("--------------------");
//        User user = userRepository.findById(1).orElseThrow(Exception::new);
//        Column column = new Column("testColumn");
//        Column newColumn = new Column(column.getTitle());
//        user.addColumn(newColumn);
//        userRepository.save(user);
//        return "ok";
//    }
//
//    @PostMapping("/columns/{columnId}/cards")
//    public void addCard(@PathVariable int columnId, @RequestBody Card card) throws Exception {
//        User user = userRepository.findById(1).orElseThrow(Exception::new);
//        user.getColumns().get(columnId).addCard(card);
//        userRepository.save(user);
//    }
}
