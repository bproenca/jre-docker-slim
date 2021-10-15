package br.com.bcp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class App {

  private static final Logger log = LoggerFactory.getLogger(App.class);

  public static void main(String[] args) {
    SpringApplication.run(App.class, args);
  }

  @RequestMapping("/")
  public String index() {
    log.debug("Index path");
    return "Index " + System.currentTimeMillis();
  }

  @RequestMapping("/hello")
  public String home() {
    log.info("Hello path");
    return "Hello Docker World " + System.currentTimeMillis();
  }

}