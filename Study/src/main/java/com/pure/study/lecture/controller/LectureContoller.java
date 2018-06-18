package com.pure.study.lecture.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pure.study.lecture.model.service.LectureService;
import com.pure.study.lecture.model.vo.Lecture;

@Controller
public class LectureContoller {
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private LectureService ls;

	/* 강의 등록으로 이동하는 맵핑 */
	@RequestMapping("/lecture/insertLecture.do")
	public ModelAndView insertLecture() {
		ModelAndView mav = new ModelAndView();

		// 지역리스트
		List<Map<String, String>> locList = ls.selectLocList();
		// 큰 분류 리스트
		List<Map<String, String>> subjectList = ls.selectSubList();
		// 난이도 
		List<Map<String, String>> diffList = ls.selectDiff();

		mav.addObject("locList", locList);
		mav.addObject("subjectList", subjectList);
		mav.addObject("diffList", diffList);
		

		mav.setViewName("lecture/insertLecture");

		return mav;
	}

	@RequestMapping("/lecture/selectTown.do")
	@ResponseBody
	public List<Map<String, Object>> selectTown(@RequestParam(value = "localNo") int localNo) {
		List<Map<String, Object>> townList = ls.selectTownList(localNo);

		return townList;
	}

	@RequestMapping("/lecture/selectKind.do")
	@ResponseBody
	public List<Map<String, Object>> selectKind(@RequestParam(value = "subNo") int subNo) {
		List<Map<String, Object>> kindList = ls.selectKindList(subNo);

		return kindList;
	}

	@RequestMapping("/lecture/lectureFormEnd.do")
	public ModelAndView insetLecture(Lecture lecture, @RequestParam(value = "freqs", required = false) String[] freqs) {
		int result = 0;
		// 빈도 배열을 join해서 setter로 setting해줌
		String freq = String.join(",", freqs);
		lecture.setFreq(freq);

		result = ls.insertLecture(lecture);

		ModelAndView mav = new ModelAndView();

		mav.setViewName("lecture/lectureList");

		return mav;
	}

	@RequestMapping("/lecture/lectureList.do")
	public ModelAndView lectureList(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {
		ModelAndView mav = new ModelAndView();

		int numPerPage = 5;

		List<Map<String, String>> lectureList = ls.selectLectureList(cPage, numPerPage);
		List<Map<String, String>> locList = ls.selectLocList();
		List<Map<String, String>> subjectList = ls.selectSubList();
		List<Map<String, String>> diffList = ls.selectDiff();
		
		mav.addObject("lectureList", lectureList);
		mav.addObject("locList", locList);
		mav.addObject("subjectList", subjectList);
		mav.addObject("diffList", diffList);
		
		mav.setViewName("lecture/lectureListEnd");

		return mav;
	}

}
