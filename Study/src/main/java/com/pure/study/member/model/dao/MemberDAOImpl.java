package com.pure.study.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pure.study.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	/**************************************/
	@Override
	public int memberEnrollEnd(Member member) {
		System.out.println(member);
		return sqlSession.insert("member.memberEnrollEnd",member);
	}
	
	@Override
	public int memberCristal(Member member) {
		return sqlSession.update("member.memberCristal",member);
	}
	@Override
	public int checkIdDuplicate(String userId) {
		return sqlSession.selectOne("member.checkIdDuplicate",userId);
	}
	@Override
	public int insertMailCertification(String tomail, String ranstr) {
		Map <String,String> map = new HashMap<>();
		map.put("tomail", tomail);
		map.put("ranstr", ranstr);
		return sqlSession.insert("member.insertMailCertification",map);
	}
	@Override
	public int checkEmail(String tomail) {
		return sqlSession.selectOne("member.checkEmail",tomail);
	}
	@Override
	public int uploadMailCertification(String tomail, String encoded) {
		Map <String,String> map = new HashMap<>();
		map.put("tomail", tomail);
		map.put("encoded", encoded);
		return sqlSession.update("member.uploadMailCertification",map);
	}
	@Override
	public Map<String, String> selectCheckJoinCode(String email) {
		return sqlSession.selectOne("member.selectCheckJoinCode",email);
	}

	@Override
	public int deleteCertification(String email) {
		return sqlSession.delete("member.deleteCertification",email);
	}

	@Override
	public List<Map<String, String>> selectCategory() {
		return sqlSession.selectList("member.selectCategory");
	}
	
	/**************************************/
	
	@Override
	public Member selectOneMember(String userId) {
		return sqlSession.selectOne("member.selectOneMember", userId);
	}

	@Override
	public Member selectOneMember(Member fm) {
		return sqlSession.selectOne("member.selectOneMemberId",fm);
	}

	@Override
	public int updatePwd(Member changeM) {
		return sqlSession.update("member.updatePwd",changeM);
	}

	@Override
	public int selectCntMember(Member m) {
		return sqlSession.selectOne("member.selectCntMember", m);
	}

	@Override
	public int updateMember(Member member) {
		return sqlSession.update("member.updateMember", member);
	}

	@Override
	public int dropMember(String mid) {
		return sqlSession.update("member.dropMember", mid);
	}

	@Override
	public int updateEmail(Member m) {
		return sqlSession.update("member.updateEmail", m);

	}

	@Override
	public List<Map<String, String>> selectApplyList(Map<String, String> map, int numPerPage, int cPage) {
		return sqlSession.selectList("member.selectApplyList", map, new RowBounds(numPerPage*(cPage-1),numPerPage));
	}

	@Override
	public int selectApplyListCnt(Map<String, String> map) {
		return sqlSession.selectOne("member.selectApplyListCnt", map);
	}
	@Override
	public List<Map<String, String>> selectWishList(Map<String, String> map, int numPerPage, int cPage) {
		return sqlSession.selectList("member.selectWishList", map, new RowBounds(numPerPage*(cPage-1),numPerPage));
	}

	@Override
	public int selectWishListCnt(Map<String, String> map) {
		return sqlSession.selectOne("member.selectWishListCnt", map);
	}

	@Override
	public List<Map<String, String>> selectMyStudyList(Map<String, String> map, int numPerPage, int cPage) {
		return sqlSession.selectList("member.selectMyStudyList", map, new RowBounds(numPerPage*(cPage-1),numPerPage));
	}

	@Override
	public int selectMyStudyListCnt(Map<String, String> map) {
		return sqlSession.selectOne("member.selectMyStudyListCnt", map);
	}

	@Override
	public List<Map<String, String>> selectKind() {
		return sqlSession.selectList("member.selectKind");
	}
	
	@Override
	public List<Map<String, String>> serviceagree() {
		return sqlSession.selectList("member.serviceagree");
	}
	
	@Override
	public List<Map<String, String>> informationagree() {
		return sqlSession.selectList("member.informationagree");
	}

	@Override
	public List<Map<String, String>> selectLeaderList(Map<String, String> map, int numPerPage, int cPage) {
		return sqlSession.selectList("member.selectLeaderList", map, new RowBounds(numPerPage*(cPage-1),numPerPage));
	}

	@Override
	public int selectLeaderListCnt(Map<String, String> map) {
		return sqlSession.selectOne("member.selectLeaderListCnt",map);
	}


	

}