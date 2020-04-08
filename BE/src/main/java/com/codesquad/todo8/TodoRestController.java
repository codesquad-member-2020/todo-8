package com.codesquad.todo8;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api")
public class TodoRestController {

  @GetMapping
  public String hello() {
    return "hello";
  }


}
