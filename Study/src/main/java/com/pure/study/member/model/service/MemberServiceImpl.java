package com.pure.study.member.model.service;

import java.util.List;
import java.util.Map;

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

	@Override
	public List<Map<String, String>> selectApplyList(int mno, int numPerPage, int cPage) {
		return memberDAO.selectApplyList(mno, numPerPage, cPage);
	}

	@Override
	public int selectApplyListCnt(int mno) {
		return memberDAO.selectApplyListCnt(mno);
	}

	@Override
	public List<Map<String, String>> selectWishList(int mno, int numPerPage, int cPage) {
		return memberDAO.selectWishList(mno, numPerPage, cPage);
	}

	@Override
	public int selectWishListCnt(int mno) {
		return memberDAO.selectWishListCnt(mno);
	}

	@Override
	public int selectMyStudyListCnt(int mno) {
		return memberDAO.selectMyStudyListCnt(mno);
	}

	@Override
	public List<Map<String, String>> selectMyStudyList(int mno, int numPerPage, int cPage) {
		return memberDAO.selectMyStudyList(mno, numPerPage, cPage);
	}
	
	
	
	

}
