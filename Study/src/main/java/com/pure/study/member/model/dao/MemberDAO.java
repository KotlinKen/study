package com.pure.study.member.model.dao;

import com.pure.study.member.model.vo.Member;

public interface MemberDAO {

	int memberEnrollEnd(Member member);

	Member selectOne(String userId);

	int memberCristal(Member member);

	int checkIdDuplicate(String userId);

}
