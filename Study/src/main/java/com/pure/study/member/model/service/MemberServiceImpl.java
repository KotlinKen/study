package com.pure.study.member.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pure.study.member.model.dao.MemberDAO;
import com.pure.study.member.model.vo.Certification;
import com.pure.study.member.model.vo.Member;
@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int memberEnrollEnd(Member member) {
		System.out.println("?");
		return memberDAO.memberEnrollEnd(member);
	}

	@Override
	public int memberCristal(Member member) {
		return memberDAO.memberCristal(member);
	}

	@Override
	public int checkIdDuplicate(String userId) {
		return memberDAO.checkIdDuplicate(userId);
	}

	@Override
	public int insertMailCertification(String tomail, String ranstr) {
		return memberDAO.insertMailCertification(tomail,ranstr);
	}

	@Override
	public int checkEmail(String tomail) {
		return memberDAO.checkEmail(tomail);
	}

	@Override
	public int uploadMailCertification(String tomail, String encoded) {
		return memberDAO.uploadMailCertification(tomail,encoded);
	}

	@Override
	public Map<String, String> selectCheckJoinCode(String email) {
		return memberDAO.selectCheckJoinCode(email);
	}

	@Override
	public int deleteCertification(String email) {
		return memberDAO.deleteCertification(email);
	}

}
