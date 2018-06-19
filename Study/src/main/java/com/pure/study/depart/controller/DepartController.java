package com.pure.study.depart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.pure.study.depart.model.service.DepartService;

@Controller
public class DepartController {
	@Autowired
	private DepartService departService;
	
}
