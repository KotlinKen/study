package com.pure.study.member.model.dao;

import java.util.List;
import java.util.Map;

import com.pure.study.member.model.vo.Certification;
import com.pure.study.member.model.vo.Member;

public interface MemberDAO {

	int memberEnrollEnd(Member member);

	int memberCristal(Member member);

	int checkIdDuplicate(String userId);

	int insertMailCertification(String tomail, String ranstr);

	int checkEmail(String tomail);

	int uploadMailCertification(String tomail, String encoded);

	Map<String, String> selectCheckJoinCode(String email);

	int deleteCertification(String email);

	List<Map<String, String>> selectCategory();

}
