package com.pure.study.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pure.study.member.model.dao.MemberDAO;
import com.pure.study.member.model.vo.Member;
@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO md;
	
	@Override
	public int memberEnrollEnd(Member member) {
		System.out.println("?");
		return md.memberEnrollEnd(member);
	}

	@Override
	public Member selectOne(String userId) {
		System.out.println("userId="+userId);
		return md.selectOne(userId);
	}

	@Override
	public int memberCristal(Member member) {
		return md.memberCristal(member);
	}

	@Override
	public int checkIdDuplicate(String userId) {
		return md.checkIdDuplicate(userId);
	}

}
