package com.pure.study.member.controller;

import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.project.spring.depart.model.service.DepartService;
import com.pure.study.member.model.service.MemberService;
import com.pure.study.member.model.vo.Member;

@SessionAttributes({"memberLoggedIn"})
@Controller
public class MemberController {

	//private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private DepartService departService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	@RequestMapping("/member/memberEnroll.do")
	public ModelAndView memberEnroll() {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String,String>> d = departService.selectDepart();
		
		mav.addObject("departList",d);
		mav.setViewName("member/memberEnroll");
		
		return mav;
	}
	
	@RequestMapping("/member/memberEnrollEnd.do")
	public String memberEnrollerEnd(Member member, Model model) {
		
		System.out.println(member);
		String rawPassword = member.getPwd();
		System.out.println("암호화전 : "+rawPassword);
		
		/****** password 암호화 시작 ******/
		
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPwd(encodedPassword);
		
		/****** password 암호화 끝 ******/
		System.out.println("암호화후 : "+member.getPwd());
		

		//1.비지니스로직 실행
		int result = memberService.insertMember(member);
		
		//2.처리결과에 따라 view단 분기처리
		String loc = "/"; 
		String msg = "";
		if(result>0) msg="회원가입성공!";
		else msg="회원가입실패!";
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	@RequestMapping("/member/memberLogin.do")
	public ModelAndView memberLogin(@RequestParam("userId") String userId, @RequestParam String pwd, HttpSession session  ) {
		ModelAndView mav = new ModelAndView();
		
		Member m = memberService.selectOneMember(userId);
		
		String msg = "";
		String loc = "/";
		
		if(m==null) {
			msg = "존재하지 않는 아이디입니다.";
		}
		else {
			if(bcryptPasswordEncoder.matches(pwd, m.getPwd())) {
				msg = "로그인성공!";
				mav.addObject("memberLoggedIn", m);
				
			}
			else {
				msg = "비밀번호가 틀렸습니다.";
			}
			
		}
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/member/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		
		return "redirect:/";
	}
	
	@RequestMapping("/member/memberFindPage.do")
	public ModelAndView memberFindPage(@RequestParam("findType") String findType ) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("findType", findType);
		mav.setViewName("member/memberFind");
		
		return mav;
	}
	
	@RequestMapping("/member/memberFindIdPwd.do")
	public ModelAndView memberFindId(@RequestParam String mname, @RequestParam String email, @RequestParam("findType") String findType, @RequestParam String mid ) {
		
		ModelAndView mav = new ModelAndView();
		
		Member fm = new Member();
		fm.setMname(mname); 
		fm.setEmail(email);
		
		Member m = memberService.selectOneMember(fm);
		
		String msg = "";
		String loc = "/";
		
		System.out.println(findType);
		
		//id 찾기
		if(m != null && findType.equals("아이디")) {
			
			mid = m.getMid();
			mid = mid.substring(0, mid.length()-2);
			
			mav.addObject("findType", findType);
			mav.addObject("mid", mid);
			mav.setViewName("member/memberFind");
		}else if(m == null && findType.equals("아이디")) {
			msg = "존재 하지 않는 회원 입니다. ";
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		} else if(findType.equals("비밀번호")) {
			
			//다시 써야함.
			String pwd = "11";
			
			mav.addObject("pwd", pwd);
			mav.addObject("findType", findType);
			mav.setViewName("member/memberFind");
		}
		
		
		
		return mav;
	}
	
	 // 임시 비밀번호 메일로 보내기
	  @RequestMapping(value = "/member/mailSending.do")
	  public ModelAndView mailSending(HttpServletRequest request, @RequestParam String mid, @RequestParam String email) {
		  
		  ModelAndView mav = new ModelAndView();
		  String msg="";
		  String loc="/";
		  
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	      
	      String tempPwd = "";
	      int tempSize = 3;
	      char[] temp = new char[tempSize];
	      
	      //48~57- 숫자, 65~90- 대문자, 97~122- 소문자
	      for(int i=0; i<tempSize; i++) {
	    	  int rnd = (int)(Math.random()*122)+48;
	    	  if(rnd>48&&rnd<57||rnd>65&&rnd<90||rnd>97&&rnd<122) {
	    		  temp[i] = (char)rnd;
	    		  tempPwd += temp[i];
	    		  System.out.println(tempPwd);
	    	  } else {
	    		  i--;
	    	  }		  
	      }
	      
	      int resultEqual = memberService.selectCntMember(mid);
	      
	      //디비를 통해 회원 아이디와 이메일을 비교해서 일치하는 디비 값이 없으면 일치 하지 않다고 알려주기
	      if(resultEqual>0) {
	    	  
	    	  msg="일치하는 아이디나 이메일이 없습니다.";
	    	  
	      } else {
	    	  //이메일을 보내면서 디비의 값을 update 한다.
	    	  Member changeM = new Member();
	    	  String encodedPassword = bcryptPasswordEncoder.encode(tempPwd);
	    	  changeM.setPwd(encodedPassword);
	    	  changeM.setMid(mid);
	    	  
	    	  int result = memberService.updateEmail(changeM);
	    	  
	    	  if(result>0) {
	    		  msg="회원 가입시 입력한 이메일로 임시 비밀번호를 발송했습니다.";
	    		  
	    	  }else {
	    		  msg="오류 발생!!!";
	    		  
	    		  
	    	  }
	      }
	      
	      mav.addObject("loc", loc);
	      mav.addObject("msg", msg);
	      mav.setViewName("common/msg");
	      
	      
	      messageHelper.setFrom("kimemail2018@gmail.com");  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(email);     // 받는사람 이메일
	      messageHelper.setSubject("스터디 그룹 임시 비밀번호 발송"); // 메일제목은 생략이 가능하다
	      messageHelper.setText("당신의 임시 비밀번호는 "+tempPwd+"입니다.");  // 메일 내용
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      e.getStackTrace();
	    }
	    
	    
	    return mav;
	  }
	
}















