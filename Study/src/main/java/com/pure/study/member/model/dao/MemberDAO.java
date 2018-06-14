package com.pure.study.member.model.dao;

import com.pure.study.member.model.vo.Member;

public interface MemberDAO {

	int insertMember(Member member);

	Member selectOneMember(String userId);

	Member selectOneMember(Member fm);

	int updateEmail(Member changeM);

	int selectCntMember(Member m);


}
