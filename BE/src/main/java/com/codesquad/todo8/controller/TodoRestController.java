package com.codesquad.todo8.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class TodoRestController {

  @GetMapping("hello")
  public String hello() {
    return "hello";
  }


}
