package com.pure.study.member.model.service;

import com.pure.study.member.model.vo.Member;

public interface MemberService {

	int memberEnrollEnd(Member member);

	Member selectOne(String userId);

	int memberCristal(Member member);

	int checkIdDuplicate(String userId);
	
	

}
