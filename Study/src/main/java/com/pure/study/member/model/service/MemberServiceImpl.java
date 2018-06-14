package com.pure.study.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.spring.member.model.dao.MemberDAO;
import com.project.spring.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	@Override
	public int insertMember(Member member) {
		return memberDAO.insertMember(member);
	}

	@Override
	public Member selectOneMember(String userId) {
		return memberDAO.selectOneMember(userId);
	}

	@Override
	public Member selectOneMember(Member fm) {
		return memberDAO.selectOneMember(fm);
	}

	@Override
	public int updateEmail(Member changeM) {
		return memberDAO.updateEmail(changeM);
	}

	@Override
	public int selectCntMember(String mid) {
		return memberDAO.selectCntMember(mid);
	}
	
	
	
	

}
