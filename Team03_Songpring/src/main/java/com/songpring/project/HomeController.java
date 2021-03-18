package com.songpring.project;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/home")
	public String home() {
		return "home";
	}
	@RequestMapping("/test")
	public String test() {
		return "test";
	}
	@RequestMapping("/manager_error")
	public String managerError() {
		return "manager_error";
	}

	@RequestMapping("/manager/managerPage")
	public String managerPage() {
		return "manager/managerPage";
	}
}
