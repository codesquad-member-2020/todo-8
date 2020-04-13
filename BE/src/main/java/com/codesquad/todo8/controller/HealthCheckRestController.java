package com.codesquad.todo8.controller;

import static com.codesquad.todo8.api.ApiResult.OK;

import com.codesquad.todo8.api.ApiResult;
import java.text.SimpleDateFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("hcheck")
public class HealthCheckRestController {

  private final static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

  @GetMapping
  public ApiResult<String> healthCheck() {
    return OK(dateFormat.format(System.currentTimeMillis()));
  }
}
