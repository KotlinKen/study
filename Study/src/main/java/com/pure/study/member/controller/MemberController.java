package com.pure.study.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.pure.study.board.model.vo.Attachment;
import com.pure.study.board.model.vo.Board;
import com.pure.study.member.model.service.MemberService;
import com.pure.study.member.model.vo.Certification;
import com.pure.study.member.model.vo.Member;

@SessionAttributes({"memberLoggedIn"})
@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	@Autowired
	private JavaMailSender mailSender;
	 
	
	/*정보 입력동의페이지 이동 시작*/
	@RequestMapping("/member/memberAgreement.do")
	public String memberAgreement() {
		if(logger.isDebugEnabled()) {
			logger.debug("회원동의홈페이지");
		}
		
		return "member/memberAgreement";
	}
	/*정보 입력페이지 이동 시작*/
	@RequestMapping("/member/memberEnroll.do")
	public ModelAndView memberEnroll() {
		if(logger.isDebugEnabled()) {
			logger.debug("회원등록홈페이지");
		}
		ModelAndView mav = new ModelAndView();
		List<Map<String,String>> list = memberService.selectCategory();
		System.out.println(list);
		
		mav.addObject("list",list);
		return mav;
	}
	
	/*mailSending 코드 전송*/
	@RequestMapping(value = "/member/certification.do")
	@ResponseBody
	public Map<String,Object> mailCertification(HttpServletRequest request ,@RequestParam(value="em") String em) {
		Map<String,Object> map = new HashMap<>();
		String setfrom = "jjsk109@gmail.com";         
		String tomail  = em;     // 받는 사람 이메일
		String title   =   "( 스터디 그룹트 ) 회원가입 인증번호 내역";   // 제목
		
		String content =   "회원님 \n인증번호는  ";  // 내용
		String ranstr = ""; 
		for(int i =0; i<4 ; i++) {
			int ran = (int)(Math.random()*10);
			ranstr +=ran;
		}
		String encoded = bcryptPasswordEncoder.encode(ranstr);
		content += ranstr;
		
		int checkemail = memberService.checkEmail(tomail);
		int result =0;
		if(checkemail ==0 ) {
			result = memberService.insertMailCertification(tomail,encoded);			
		}else {
			result = memberService.uploadMailCertification(tomail,encoded);
		}
		try {
			MimeMessage message = mailSender.createMimeMessage(); 
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(tomail);     // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content);  // 메일 내용
		     
			mailSender.send(message);
		} catch(Exception e){
		}
		return map;
	}
	
	/*mailSending 코드 검증*/
	@RequestMapping(value = "/member/checkJoinCode.do")
	@ResponseBody
	public Map<String,Object> checkJoinCode(HttpServletRequest request ,@RequestParam(value="em") String em ,@RequestParam(value="inputCode") String inputCode) {
		Map<String,Object> map = new HashMap<>();
		String email = em;
		Map<String,String> cer = new HashMap<>();
		cer = memberService.selectCheckJoinCode(email);
		if(bcryptPasswordEncoder.matches(inputCode, cer.get("CERTI"))) {
			map.put("result", true);
		}else {
			map.put("result", false);			
		}
		return map;
	}
	
		


	
	/*주소입력*/
	@RequestMapping("/member/jusoPopup.do")
	public String jusoPopup() {
		return "member/jusoPopup";
	}
	
	/*파일 업로드 시작*/
	@RequestMapping("/member/memberImgUpload.do")
	public ModelAndView insertBoard(Model model,@RequestParam(value="upFile",required=false) MultipartFile[] upFiles,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		logger.debug("게시판 페이지저장");
		logger.debug("upFiles.length="+upFiles.length);
		logger.debug("upFile1="+upFiles[0].getOriginalFilename());
		
		Map<String , String> map = new HashMap<>();
	
		//1.파일업로드처리
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/member");
		String renamedFileName ="";
		/****** MultipartFile을 이용한 파일 업로드 처리로직 시작 ******/
		for(MultipartFile f: upFiles) {
			if(!f.isEmpty()) {
				//파일명 재생성
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+
										"_"+rndNum+"."+ext;
				try {
					f.transferTo(new File(saveDirectory+"/"+renamedFileName));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		/****** MultipartFile을 이용한 파일 업로드 처리로직 끝 ******/

		//3.view단 분기
		logger.debug(renamedFileName);
		map.put("renamedFileName", renamedFileName);
		
		mav.addAllObjects(map);
		mav.setViewName("jsonView");
	
		return mav;
	}
	
	
	
	/*회원가입 시작 */
	@RequestMapping(value="/member/memberEnrollEnd.do", method=RequestMethod.POST)
	public String memberEnrollEnd(Model model , Member member  ) {
		if(logger.isDebugEnabled()) {
			logger.debug("회원가입완료");
		}
		logger.debug(""+member);
		
		/*이메일 가져오기*/
		String email = member.getEmail();
		String[] emailArr = email.split(",");
		email = emailArr[0]+"@"+emailArr[1];
		logger.debug(email);
		member.setEmail(email);
		
		/*생년월일 가져오기*/
		String birth= member.getBirth();
		String[] birthArr = birth.split(",");
		birth = birthArr[0]+"/"+birthArr[1]+"/"+birthArr[2];
		member.setBirth(birth);
		
		/*주소값 정리 (임시 addr1/addr2필요)*/
		String addr= member.getAddr();
		String[] addrArr = addr.split(",");
		addr = addrArr[0]+" "+addrArr[2]+" "+addrArr[3];
		member.setAddr(addr);
		
		
		logger.debug(""+member);
		String rawPassword = member.getPwd();
		/******* password 암호화 시작 *******/
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPwd(encodedPassword);
		/******* password 암호화 끝 *******/
		
		/* favor null일 경우 처리 */
		if(member.getFavor()==null) {
			member.setFavor("no");
		}
		
		int result = memberService.memberEnrollEnd(member);
		String email2 = member.getEmail();
		memberService.deleteCertification(email2);

		//2.처리결과에 따라 view단 분기처리
		String loc = "/"; 
		String msg = "";
		if(result>0) msg="회원가입성공!";
		else msg="회원가입성공!";
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	/*ID 중복 검사 시작 */
	@RequestMapping("/member/checkIdDuplicate.do")
	@ResponseBody
	public Map<String,Object> checkIdDuplicate(@RequestParam("userId") String userId) throws IOException {
		logger.debug("@ResponseBody-javaobj ajax : "+userId);
		Map<String,Object> map = new HashMap<>();
	
		//업무로직
		int count = memberService.checkIdDuplicate(userId);
		logger.debug("count : "+count);
		boolean isUsable = count==0?true:false;
		logger.debug(""+isUsable);
		
		map.put("isUsable", isUsable);
		
		return map;
	}

	
}
