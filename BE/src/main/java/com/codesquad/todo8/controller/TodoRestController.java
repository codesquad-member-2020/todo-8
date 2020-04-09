package com.codesquad.todo8.controller;

import com.codesquad.todo8.model.Card;
import com.codesquad.todo8.model.Column;
import com.codesquad.todo8.model.User;
import com.codesquad.todo8.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/")
public class TodoRestController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/columns")
    public List<Column> getColumn() throws Exception {
        User user = userRepository.findById(1).orElseThrow(Exception::new);
        return user.getColumns();
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

    @PostMapping("/columns")
    public String addColumn() throws Exception {
        System.out.println("--------------------");
        User user = userRepository.findById(1).orElseThrow(Exception::new);
        Column column = new Column("testColumn");
        Column newColumn = new Column(column.getTitle());
        user.addColumn(newColumn);
        userRepository.save(user);
        return "ok";
    }

    @PostMapping("/columns/{columnId}/cards")
    public void addCard(@PathVariable int columnId, @RequestBody Card card) throws Exception {
        User user = userRepository.findById(1).orElseThrow(Exception::new);
        user.getColumns().get(columnId).addCard(card);
        userRepository.save(user);
    }
}
