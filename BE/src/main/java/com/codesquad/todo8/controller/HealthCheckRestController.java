package com.codesquad.todo8.controller;

import java.text.SimpleDateFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("hcheck")
public class HealthCheckRestController {

  private final static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

  @GetMapping
  public String healthCheck() {
    return dateFormat.format(System.currentTimeMillis());
  }
}
