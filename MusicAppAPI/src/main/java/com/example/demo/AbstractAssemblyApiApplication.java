package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.support.SpringBootServletInitializer;

@SpringBootApplication
public class AbstractAssemblyApiApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(AbstractAssemblyApiApplication.class, args);
	}
}
