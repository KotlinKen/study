package com.pure.study.study.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pure.study.study.model.service.StudyService;
import com.pure.study.study.model.vo.Study;




@Controller
public class StudyController {
	
	@Autowired
	private StudyService studyService;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@RequestMapping("/study/studyList.do")
	public ModelAndView selectStudyList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage) {
		ModelAndView mav = new ModelAndView();
		
		//지역 리스트
		List<Map<String,Object>> localList=studyService.selectLocal();
		mav.addObject("localList",localList);
		
		//카테고리 리스트
		List<Map<String,Object>> subjectList=studyService.selectSubject();
		mav.addObject("subjectList",subjectList);
		
		//난이도 리스트
		List<Map<String,Object>> diffList=studyService.selectLv();
		mav.addObject("diffList",diffList);
		
		
		int numPerPage = 6; // => limit
		
		//1. 현재 페이지 컨텐츠 구하기 
		List<Map<String,String>> list = studyService.selectStudyList(cPage,numPerPage);
		logger.debug("list="+list);
		//2. 페이지바 처리를 위한 전체 컨텐츠 수 구하기 
		int total = studyService.studyTotalCount();
		logger.debug("total="+total);
		
		mav.addObject("total",total);
		mav.addObject("list",list);
		mav.addObject("numPerPage",numPerPage);
		mav.setViewName("study/study");
		
		return mav;
	}
	
	@RequestMapping("/study/studyForm.do")
	public void boardForm() {
		
	}
	@RequestMapping("/study/studyFormEnd.do") 
	public ModelAndView insertStudy(Study study, @RequestParam(value="freq") String[] freq, @RequestParam(value="upFile", required=false) MultipartFile[] upFiles,
			HttpServletRequest request) {
		
		ModelAndView mav= new ModelAndView();
		String dayname="";
		int i=0;
		for(String day:freq) {
			if(i!=0) dayname+=",";
			dayname+=day+"";
			i++;
		}
		study.setFreq(dayname);
		String imgs="";
		
		
		logger.debug("upFiles.length="+upFiles.length);

		if(study.getPrice()==null) study.setPrice(0+"원");
		System.out.println("study="+study);
		study.setMno(2); //임시로
		//스터디 생성하기 
		int result = studyService.insertStudy(study);
		
		//스터디 생성 성공하면, 첨부 사진들 폴더에 저장, db에 저장
		if(result>0) {
			try { //최초 메소드 부른 곳은 controller이기때문에 여기서 에러 처리함. 
				
				//1. 파일 업로드 처리 
				String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/studyImg");
				//List<Attachment> attachList = new ArrayList<>();
				
				/********* MultipartFile을 이용한 파일 업로드 처리 로직 시작 ********/
				for(MultipartFile f : upFiles) {
					
					if(!f.isEmpty()) {
						//파일명 재생성
						String originalFileName = f.getOriginalFilename();
						String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
						int rndNum = (int)(Math.random()*1000); //0~9999
						String renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
						
						try {
							
							//저장하는 걸, study insert 성공하고 해야 하는 것이 아닌가.? 
							f.transferTo(new File(saveDirectory+"/"+renamedFileName)); //실제 저장하는 코드. 
						} catch (IllegalStateException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						if(i!=0) {
							imgs+=",";
						}
						imgs+=renamedFileName;
						i++;
					}
				}
		
				System.out.println("imgs="+imgs);
			}catch(Exception e) {
				throw new RuntimeException("스터디 등록 오류");
			}
			
		}
		/********* MultipartFile을 이용한 파일 업로드 처리 로직 끝 ********/
		study.setUpfile(imgs);
		
		result = studyService.updateStudyImg(study);
		
		//3. view단 분기
		String loc="/";
		String msg="";
		if(result>0) {
			msg="스터디 등록 성공";
			//loc="/board/boardView.do?no="+boardNo;
		}else
			msg="스터디 등록 실패";
		
		mav.addObject("msg",msg);
		mav.addObject("loc",loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	@RequestMapping("/study/searchStudy.do")
	public ModelAndView selectStudyForSearch(@RequestParam(value="lno") int lno,@RequestParam(value="tno", defaultValue="null") int tno, @RequestParam(value="subno") int subno,
			@RequestParam(value="kno") int kno,@RequestParam(value="dno") int dno,@RequestParam(value="leadername") String leadername
			,@RequestParam(value="cPage", required=false, defaultValue="1") int cPage) {
		
	
		int numPerPage = 6; 
		int total = studyService.studyTotalCount();
		
		if(leadername.trim().length()<1) leadername=null;
		ModelAndView mav= new ModelAndView();
		Map<String,Object> terms=new HashMap<>();
		terms.put("lno", lno);
		terms.put("tno", tno);
		terms.put("subno", subno);
		terms.put("kno", kno);
		terms.put("dno", dno);
		terms.put("leadername", leadername);
		terms.put("cPage", cPage);
		terms.put("numPerPage", numPerPage);
		System.out.println("map="+terms);
		
		List<Map<String,Object>> studyList = studyService.selectStudyForSearch(terms);
		
		System.out.println("studyList="+studyList);
		
		
		return mav;
	}
	
	
	@RequestMapping("/study/studyListAdd")
	@ResponseBody
	public List<Map<String,Object>> selectStudyAdd(@RequestParam(value="cPage",defaultValue="1") int cPage,@RequestParam(value="total") int total, @RequestParam(value="numPerPage") int numPerPage){
		
		List<Map<String,Object>> studyList= studyService.selectStudyAdd(cPage,numPerPage);
		
		System.out.println("studyList="+studyList);
		return studyList;
		
	}
	
	//스터디 상세보기
	@RequestMapping("/study/studyView")
	public ModelAndView selectStudyOne(@RequestParam(value="sno", required=true) int sno) {
		ModelAndView mav = new ModelAndView();
		
		//스터디 정보 가져오기 +보고 있는 유저의 점수들 가져와야함..
		Map<String,Object> study = studyService.selectStudyOne(sno);
		System.out.println("study="+study);
		
		//
		
		
		mav.setViewName("study/studyView");
		return mav;
	}
	
	
	
	
	
	/* ---------------------------------------study form에 필요한 select ------------------------------------------------*/
	@RequestMapping("/study/selectSubject.do")
	@ResponseBody
	public List<Map<String,Object>> selectSubject(){
		
		List<Map<String,Object>> list = studyService.selectSubject();
		return list;
		
	}
	
	@RequestMapping("/study/selectKind.do")
	@ResponseBody
	public List<Map<String,Object>> selectKind(@RequestParam(value="subno", required=true) int subno){
		
		List<Map<String,Object>> list = studyService.selectKind(subno);
		
		return list;
		
	}
	@RequestMapping("/study/selectLocal.do")
	@ResponseBody
	public List<Map<String,Object>> selectLocal(){
		
		List<Map<String,Object>> list = studyService.selectLocal();
		
		return list;
	}
	
		
	@RequestMapping("/study/selectTown.do")
	@ResponseBody
	public List<Map<String,Object>> selectTown(@RequestParam(value="lno", required=true) int lno){
		
		List<Map<String,Object>> list = studyService.selectTown(lno);
		
		return list;
	}	

	@RequestMapping("/study/selectLv.do")
	@ResponseBody
	public List<Map<String,Object>> selectLv(){
		
		List<Map<String,Object>> list = studyService.selectLv();
		
		return list;
	}	


}
