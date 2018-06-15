package com.pure.study.adversting.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Adversting {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/adv/insertAdversting")
	public ModelAndView insertAdversting() {
		ModelAndView mav = new ModelAndView();
		
		logger.debug("adversting");
		
		mav.addObject("test", "test");
		
		return mav;
	}
	
	@RequestMapping("/adv/selectAdversting")
	public String  selectAdversting(Model model) {
		
		logger.debug("adversting list");
		model.addAttribute("auth", "555");
		return "selectAdversting";
		
	}
	
	@RequestMapping("/adv/updateAdversting")
	public ModelAndView updateAdversting() {
		ModelAndView mav = new ModelAndView();
		
		logger.debug("adversting");
		
		mav.addObject("test", "test");
		
		return mav;
	}
	
	@RequestMapping("/adv/deleteAdversting")
	public ModelAndView deleteAdversting() {
		ModelAndView mav = new ModelAndView();
		
		logger.debug("adversting");
		
		mav.addObject("test", "test");
		
		return mav;
	}
	
	@RequestMapping(value="/adv/test")
    public String login(Model model,String auth)throws Exception{
        model.addAttribute("auth", "asdfasdffd");
        return "test";
    }


}
