package com.pure.study.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pure.study.member.model.dao.MemberDAO;
import com.pure.study.member.model.vo.Member;

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
	public int updatePwd(Member changeM) {
		return memberDAO.updatePwd(changeM);
	}

	@Override
	public int selectCntMember(Member m) {
		return memberDAO.selectCntMember(m);
	}

	@Override
	public int updateMember(Member member) {
		return memberDAO.updateMember(member);
	}

	@Override
	public int dropMember(String mid) {
		return memberDAO.dropMember(mid);
	}

	@Override
	public int updateEmail(Member m) {
		return memberDAO.updateEmail(m);
	}
	
	
	
	

}
