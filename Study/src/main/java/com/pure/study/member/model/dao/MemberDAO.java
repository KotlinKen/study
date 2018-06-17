package com.pure.study.member.model.dao;

import com.pure.study.member.model.vo.Member;

public interface MemberDAO {

	int insertMember(Member member);

	Member selectOneMember(String userId);

	Member selectOneMember(Member fm);

	int selectCntMember(Member m);

	int updatePwd(Member changeM);

	int updateMember(Member member);

	int dropMember(String mid);

	int updateEmail(Member m);


}
