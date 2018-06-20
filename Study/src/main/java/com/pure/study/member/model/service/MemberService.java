package com.pure.study.member.model.service;

import java.util.List;
import java.util.Map;

import com.pure.study.member.model.vo.Member;

public interface MemberService {
	
	/****************************************/
	
	int memberEnrollEnd(Member member);

	int memberCristal(Member member);

	int checkIdDuplicate(String userId);

	int insertMailCertification(String tomail, String ranstr);

	int checkEmail(String tomail);

	int uploadMailCertification(String tomail, String encoded);

	Map<String, String> selectCheckJoinCode(String email);

	int deleteCertification(String email);

	List<Map<String, String>> selectCategory();
	/****************************************/

	Member selectOneMember(String userId);

	Member selectOneMember(Member fm);

	int updatePwd(Member changeM);

	int selectCntMember(Member equalM);

	int updateMember(Member member);
	
	int dropMember(String mid);

	int updateEmail(Member m);

	List<Map<String, String>> selectApplyList(int mno, int numPerPage, int cPage);

	int selectApplyListCnt(int mno);

	List<Map<String, String>> selectWishList(int mno, int numPerPage, int cPage);

	int selectWishListCnt(int mno);

	int selectMyStudyListCnt(int mno);

	List<Map<String, String>> selectMyStudyList(int mno, int numPerPage, int cPage);

	List<Map<String, String>> selectKind();
	
	List<Map<String, String>> serviceagree();

	List<Map<String, String>> informationagree();

}
