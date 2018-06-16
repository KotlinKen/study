package com.pure.study.adversting.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pure.study.adversting.model.service.AdverstingService;
import com.pure.study.adversting.model.vo.Adversting;

@Controller
public class AdverstingController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@Autowired
	private AdverstingService adverstingService;
	
	
	@RequestMapping("/adv/formAdversting.do")
	public void formAdversting() {
		logger.info("test");
		
	}
	
	@RequestMapping("/adv/insertAdversting")
	public ModelAndView insert (Adversting adversting, @RequestParam(value="img", required=false) MultipartFile[] upFiles, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		logger.info("test 들어왔어"+ adversting);
		
		
		try {
			//1.파일업로드 처리
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/board");
					
			/************** MultipartFile을 이용한 파일 업로드 처리 로직 시작  ********************************************************/
			
			//
			int cnt = 0; 
			for(MultipartFile f : upFiles) {
				cnt++;
				logger.info("cnt"+saveDirectory);
				logger.debug("cnt"+cnt);
				if(!f.isEmpty()) {

					//파일명 재생성
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random() * 1000);
					String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "." + ext;
					logger.info("renamedFileName"+renamedFileName);
					try {
						f.transferTo(new File(saveDirectory + "/" + renamedFileName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					//VO객체 담기
					if(cnt == 1) {
						adversting.setImg1(renamedFileName); 
					}else {
						adversting.setImg2(renamedFileName); 
					}
				}
			}
			
			
			
			//2.비지니스로직
			
		/*	int result = adverstingService.insertAdversting(adversting);
			int boardNo = adversting.getAno();
			logger.debug("boardNo@controller = " + boardNo);
			
			
			//3. view단 분기
			String loc = "/";
			String msg = "";
			
			if(result>0) {
				msg = "게시물 등록 성공";
				loc = "/board/boardView.do?boardNo="+board.getBoardNo();
			}else {
				msg = "게시물 등록 실패";
			}
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");*/
		} catch(Exception e) {
/*			throw new BoardException("게시물 등록 오류");*/
		}
		
		
		
		
		
		
		return mav;
	}
	
	@RequestMapping("/adv/selectAdversting")
	public String  selectAdversting(Model model) {
		
		logger.debug("adversting list");
		model.addAttribute("auth", "555");
		return "selectAdversting";
		
	}
	
	@RequestMapping("/adv/selectPagingAdversting")
	public ModelAndView selectPagingAdversting(@RequestParam (value="cPage", required=false, defaultValue="1") int cPage) {
		
		ModelAndView mav = new ModelAndView();
		int numPerPage = 10; 
		List<Map<String, String>> map = adverstingService.selectPagingAdversting(cPage, numPerPage);
		
		logger.debug("adversting list");
		
		
		
		return mav;
		
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
