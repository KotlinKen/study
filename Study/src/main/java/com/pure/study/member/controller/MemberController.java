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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.pure.study.depart.model.service.DepartService;
import com.pure.study.member.model.service.MemberService;
import com.pure.study.member.model.vo.Member;

@SessionAttributes({ "memberLoggedIn" })
@Controller
public class MemberController {

	// private Logger logger = LoggerFactory.getLogger(getClass());

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

		List<Map<String, String>> d = departService.selectDepart();

		mav.addObject("departList", d);
		mav.setViewName("member/memberEnroll");

		return mav;
	}

	@RequestMapping("/member/memberEnrollEnd.do")
	public String memberEnrollerEnd(Member member, Model model) {

		System.out.println(member);
		String rawPassword = member.getPwd();
		System.out.println("암호화전 : " + rawPassword);

		/****** password 암호화 시작 ******/

		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPwd(encodedPassword);

		/****** password 암호화 끝 ******/
		System.out.println("암호화후 : " + member.getPwd());

		// 1.비지니스로직 실행
		int result = memberService.insertMember(member);

		// 2.처리결과에 따라 view단 분기처리
		String loc = "/";
		String msg = "";
		if (result > 0)
			msg = "회원가입성공!";
		else
			msg = "회원가입실패!";

		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);

		return "common/msg";
	}

	@RequestMapping("/member/memberLogin.do")
	public ModelAndView memberLogin(@RequestParam("userId") String userId, @RequestParam String pwd,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();

		Member m = memberService.selectOneMember(userId);

		String msg = "";
		String loc = "/";

		if (m == null) {
			msg = "존재하지 않는 아이디입니다.";
		} else {
			if (bcryptPasswordEncoder.matches(pwd, m.getPwd())) {
				msg = "로그인성공!";
				mav.addObject("memberLoggedIn", m);

			} else {
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

		if (!sessionStatus.isComplete())
			sessionStatus.setComplete();

		return "redirect:/";
	}

	/**************** id, pwd찾기 */
	// 아이디,비밀번호 찾기 페이지로 이동
	@RequestMapping("/member/memberFindPage.do")
	public ModelAndView memberFindPage(@RequestParam("findType") String findType) {

		ModelAndView mav = new ModelAndView();

		mav.addObject("findType", findType);// findType - 아이디/비밀번호
		mav.setViewName("member/memberFind");

		return mav;
	}

	// 아이디 찾기 페이지이면, 바로 아이디를 맨 뒤의 2자리를 제외하고 알려준다.
	// 비밀번호 찾기 페이지면, 비밀번호 찾는 페이지로 이동
	@RequestMapping(value = "/member/memberFindIdPwd.do")
	public ModelAndView memberFindId(@RequestParam("mname") String mname, @RequestParam("email") String email,
			@RequestParam("findType") String findType) {
		ModelAndView mav = new ModelAndView();

		Member fm = new Member();
		fm.setMname(mname);
		fm.setEmail(email);

		Member m = memberService.selectOneMember(fm);

		String msg = "";
		String loc = "/";

		System.out.println(findType);

		// id 찾기
		if (m != null && findType.equals("아이디")) {

			String mid = m.getMid();
			mid = mid.substring(0, mid.length() - 2);

			mav.addObject("findType", findType);
			mav.addObject("mid", mid);
			mav.setViewName("member/memberFind");
		} else if (m == null && findType.equals("아이디")) {
			msg = "존재 하지 않는 회원 입니다. ";
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		} else if (findType.equals("비밀번호")) {

			mav.addObject("findType", findType);
			mav.setViewName("member/memberFind");
		}

		return mav;
	}

	// ****************(방법1)비밀번호 변경 페이지 보내주기*********************

	// 이메일로 비밀번호 변경 페이지를 보내준다.
	@RequestMapping(value = "/member/mailSending.do", method = RequestMethod.POST)
	public ModelAndView mailSending(HttpServletRequest request, @RequestParam String mid, @RequestParam String email) {
		ModelAndView mav = new ModelAndView();
		String msg = "";
		String loc = "/";

		// 1. 페이지의 인증키를 생성한다.
		String tempPwd = "";
		int tempSize = 8;
		char[] temp = new char[tempSize];

		// 48~57- 숫자, 65~90- 대문자, 97~122- 소문자
		for (int i = 0; i < tempSize; i++) {
			int rnd = (int) (Math.random() * 122) + 48;
			if (rnd > 48 && rnd < 57 || rnd > 65 && rnd < 90 || rnd > 97 && rnd < 122) {
				temp[i] = (char) rnd;
				tempPwd += temp[i];
			} else {
				i--;
			}
		}

		// 2. 입력한 아이디와 이메일이 일치하는지 확인
		Member equalM = new Member();
		equalM.setMid(mid);
		equalM.setEmail(email);
		int resultEqual = memberService.selectCntMember(equalM);

		// 3. 입력한 아이디와 이메일이 일치하면 이메일로 비밀번호 변경 페이지를 전송함.
		if (resultEqual > 0) {

			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				msg = "비밀번호 변경을 메일로 발송하였습니다.";

				messageHelper.setFrom("kimemail2018@gmail.com"); // 보내는사람 생략하거나 하면 정상작동을 안함
				messageHelper.setTo(email); // 받는사람 이메일
				messageHelper.setSubject("스터디 그룹 임시 비밀번호 발송"); // 메일제목은 생략이 가능하다
				// 3.1 메일 내용에 form을 이용하여 비밀번호를 변경하고자 하는 아이디와 인증키(페이지의 유효성?을 위해)를 보내준다.
				messageHelper.setText(new StringBuffer().append("<form action='http://localhost:9090/study/member/memberPwd.do' target=\"_blank\" method='post'>")
						.append("<input type='hidden' name='mid' value='" + mid + "'/>")
						.append("<input type='hidden' name='key' value='" + tempPwd + "'/>")
						.append("<button type='submit'>비밀번호 변경하러 가기</button>").append("</form>").toString(), true); // 메일
																													// 내용

				mailSender.send(message);
			} catch (Exception e) {
				e.getStackTrace();
			}

		} else {
			msg = "일치하는 회원 정보가 없습니다.";
		}

		mav.addObject("loc", loc);
		mav.addObject("msg", msg);

		mav.setViewName("common/msg");

		return mav;
	}

	// 4. 인증키 암호화(페이지 유효성을 위해)
	@RequestMapping(value = "/member/memberPwd.do", method = RequestMethod.POST)
	public ModelAndView pwd(String mid, String key, String email) {
		ModelAndView mav = new ModelAndView();

		// 4.1 인증키를 암호화 한다.
		Member changeM = new Member();
		String encodedPassword = bcryptPasswordEncoder.encode(key);
		changeM.setPwd(encodedPassword);
		changeM.setMid(mid);

		// 4.2 암호화 한 인증키를 디비에 넣어준다.(임시 비밀번호처럼 )
		int result = memberService.updateEmail(changeM);

		if (result > 0) {
			// System.out.println("임시 비밀번호로 변경!");
		} else {
			mav.addObject("msg", "페이지 오류");
			mav.addObject("loc", "/");
			mav.setViewName("common/msg");
		}

		mav.addObject("key", encodedPassword);
		mav.addObject("mid", mid);
		mav.setViewName("member/memberUpdatePwd");

		return mav;
	}

	// 5. 디비의 임시 비밀번호와 페이지 이동을 통한 인증키 비교(페이지 유효성 검사)
	@RequestMapping(value = "/member/memberUpdatePwd.do", method = RequestMethod.POST)
	public String updatePwd(String pwd, String key, String mid, Model model) {
		String loc = "/";
		String msg = "";

		// 인코딩 된 키 값과 디비에 있는 값(임시 비밀번호)을 비교하고 맞으면 비밀번호를 바꿔준다.
		Member m = memberService.selectOneMember(mid);

		if (m == null) {
			msg = "잘못된 접근입니다.";
			System.out.println("mid 잘못 가져옴");
		} else {
			// 인증키와 디비값 비교
			if (key.equals(m.getPwd())) {
				msg = "비밀번호 변경!";
				Member changeM = new Member();
				String encodedPassword = bcryptPasswordEncoder.encode(pwd);
				changeM.setPwd(encodedPassword);
				changeM.setMid(mid);

				// 사용자가 입력한 비밀번호로 디비값 변경
				int result = memberService.updateEmail(changeM);

			} else {
				System.out.println("값은 있지만 비번이 서로 매치가 안됨");// 유효성
				msg = "잘못된 접근입니다.";
			}

		}

		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);

		return "common/msg";
	}

	/*
	 * // *********************(방법2)임시 비밀번호 메일로 보내기*********************
	 * 
	 * @RequestMapping(value = "/member/mailSending.do", method=RequestMethod.POST)
	 * public ModelAndView mailSending(HttpServletRequest request, @RequestParam
	 * String mid, @RequestParam String email) { ModelAndView mav = new
	 * ModelAndView(); String msg=""; String loc="/";
	 * 
	 * //디비에서 회원 아이디와 이메일 가져오기 Member equalM = new Member(); equalM.setMid(mid);
	 * equalM.setEmail(email); int resultEqual =
	 * memberService.selectCntMember(equalM);
	 * 
	 * //디비를 통해 회원 아이디와 이메일을 비교해서 일치하는 디비 값 확인 if(resultEqual>0) { //임시 비밀번호 생성
	 * String tempPwd = ""; int tempSize = 8; char[] temp = new char[tempSize];
	 * 
	 * //48~57- 숫자, 65~90- 대문자, 97~122- 소문자 for(int i=0; i<tempSize; i++) { int rnd
	 * = (int)(Math.random()*122)+48;
	 * if(rnd>48&&rnd<57||rnd>65&&rnd<90||rnd>97&&rnd<122) { temp[i] = (char)rnd;
	 * tempPwd += temp[i]; } else { i--; } }
	 * 
	 * 
	 * //이메일을 보내면서 디비의 비밀번호를 임시비밀번호로 update 한다. Member changeM = new Member();
	 * String encodedPassword = bcryptPasswordEncoder.encode(tempPwd);
	 * changeM.setPwd(encodedPassword); changeM.setMid(mid);
	 * 
	 * int result = memberService.updateEmail(changeM);
	 * 
	 * if(result>0) { msg="회원 가입시 입력한 이메일로 임시 비밀번호를 발송했습니다."; try { //이메일 발송 코드
	 * MimeMessage message = mailSender.createMimeMessage(); MimeMessageHelper
	 * messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	 * 
	 * messageHelper.setFrom("kimemail2018@gmail.com"); // 보내는사람 생략하거나 하면 정상작동을 안함
	 * messageHelper.setTo(email); // 받는사람 이메일
	 * messageHelper.setSubject("스터디 그룹 임시 비밀번호 발송"); // 메일제목은 생략이 가능하다
	 * messageHelper.setText("당신의 임시 비밀번호는 "+tempPwd+"입니다."); // 메일 내용
	 * 
	 * mailSender.send(message); } catch(Exception e){ e.getStackTrace(); }
	 * 
	 * }else { msg="오류 발생!!!";
	 * 
	 * }
	 * 
	 * } else { msg="일치하는 아이디나 이메일이 없습니다.";
	 * loc="/member/memberFindPage.do?findType=비밀번호"; }
	 * 
	 * mav.addObject("loc", loc); mav.addObject("msg", msg);
	 * 
	 * mav.setViewName("common/msg");
	 * 
	 * return mav; }
	 */
	/* id,pwd 찾기 ******************************/
}
