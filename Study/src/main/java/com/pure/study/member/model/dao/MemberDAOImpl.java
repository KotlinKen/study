package com.pure.study.member.model.dao;



import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public Member selectOne(String userId) {
		System.out.println("userId="+userId);
		return sqlSession.selectOne("member.selectOne",userId);
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

}
