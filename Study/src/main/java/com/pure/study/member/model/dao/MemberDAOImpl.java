package com.pure.study.member.model.dao;

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
	public List<Map<String, String>> selectApplyList(int mno, int numPerPage, int cPage) {
		return sqlSession.selectList("member.selectApplyList", mno, new RowBounds(numPerPage*(cPage-1),numPerPage));
	}

	@Override
	public int selectApplyListCnt(int mno) {
		return sqlSession.selectOne("member.selectApplyListCnt", mno);
	}

	@Override
	public List<Map<String, String>> selectWishList(int mno, int numPerPage, int cPage) {
		return sqlSession.selectOne("member.selectWishList", mno);
		//mapper 안 만들었음.
	}

	@Override
	public int selectWishListCnt(int mno) {
		return sqlSession.selectOne("member.selectWishListCnt", mno);
		//mapper 안 만들었음.
	}

	@Override
	public int selectMyStudyListCnt(int mno) {
		return sqlSession.selectOne("member.selectMyStudyListCnt", mno);
		//mapper 안 만들었음.
	}

	@Override
	public List<Map<String, String>> selectMyStudyList(int mno, int numPerPage, int cPage) {
		return sqlSession.selectOne("member.selectMyStudyList", mno);
		//mapper 안 만들었음.
	}
	
	


}
