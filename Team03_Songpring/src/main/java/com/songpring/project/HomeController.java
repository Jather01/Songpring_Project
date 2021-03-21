package com.songpring.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.shop.service.ShopService;

@Controller
public class HomeController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("/home")
	public ModelAndView home(ModelAndView mView) {
		service.getDataRandom(mView);
		mView.setViewName("home");
		return mView;
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
