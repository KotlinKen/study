package com.pure.study.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pure.study.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}

	@Override
	public Member selectOneMember(String userId) {
		return sqlSession.selectOne("member.selectOneMember", userId);
	}

	@Override
	public Member selectOneMember(Member fm) {
		return sqlSession.selectOne("member.selectOneMemberId",fm);
	}

	@Override
	public int updateEmail(Member changeM) {
		return sqlSession.update("member.updateEmail",changeM);
	}

	@Override
	public int selectCntMember(Member m) {
		return sqlSession.selectOne("member.selectCntMember", m);
	}
	
	


}
