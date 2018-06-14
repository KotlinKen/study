package com.pure.study.member.model.service;

import com.pure.study.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectOneMember(String userId);

	Member selectOneMember(Member fm);

	int updateEmail(Member changeM);

	int selectCntMember(Member equalM);

}
