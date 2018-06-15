package com.pure.study.member.model.dao;



import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pure.study.member.model.vo.Certification;
import com.pure.study.member.model.vo.Member;
@Repository
public class MemberDAOImpl implements MemberDAO {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private SqlSessionTemplate sqlSession;
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
		logger.debug(userId);
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

}
