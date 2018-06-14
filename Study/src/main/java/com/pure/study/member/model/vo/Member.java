package com.pure.study.member.model.vo;

import java.util.Date;

public class Member {
	private int mno;
	private String id;
	private String name;
	private String pwd;
	private String phone;
	private String addr;
	private String profile;
	private String email;
	private String birth;
	private String gender;
	private String favor;
	private int exp;
	private int point;
	private Date regDate;
	private Date qDate;
	public Member() {}
	public Member(int mno, String id, String name, String pwd, String phone, String addr, String profile, String email,
			String birth, String gender, String favor, int exp, int point, Date regDate, Date qDate) {
		this.mno = mno;
		this.id = id;
		this.name = name;
		this.pwd = pwd;
		this.phone = phone;
		this.addr = addr;
		this.profile = profile;
		this.email = email;
		this.birth = birth;
		this.gender = gender;
		this.favor = favor;
		this.exp = exp;
		this.point = point;
		this.regDate = regDate;
		this.qDate = qDate;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getFavor() {
		return favor;
	}
	public void setFavor(String favor) {
		this.favor = favor;
	}
	public int getExp() {
		return exp;
	}
	public void setExp(int exp) {
		this.exp = exp;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getqDate() {
		return qDate;
	}
	public void setqDate(Date qDate) {
		this.qDate = qDate;
	}
	@Override
	public String toString() {
		return "Member [mno=" + mno + ", id=" + id + ", name=" + name + ", pwd=" + pwd + ", phone=" + phone + ", addr="
				+ addr + ", profile=" + profile + ", email=" + email + ", birth=" + birth + ", gender=" + gender
				+ ", favor=" + favor + ", exp=" + exp + ", point=" + point + ", regDate=" + regDate + ", qDate=" + qDate
				+ "]";
	}
	
	
}
