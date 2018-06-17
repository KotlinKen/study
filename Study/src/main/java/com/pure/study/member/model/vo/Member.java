package com.pure.study.member.model.vo;

import java.sql.Date;

public class Member {
	private int mno;
	private String mid;
	private String mname;
	private String pwd;
	private String phone;
	private String addr;
	private String mprofile;
	private String email;
	private Date birth;
	private String gender;
	private String[] favor;
	private int exp;
	private int point;
	private Date regdate;
	private Date qdate;
	private String cover;
	private String etc2;
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Member(int mno, String mid, String mname, String pwd, String phone, String addr, String mprofile,
			String email, Date birth, String gender, String[] favor, int exp, int point, Date regdate, Date qdate,
			String cover, String etc2) {
		super();
		this.mno = mno;
		this.mid = mid;
		this.mname = mname;
		this.pwd = pwd;
		this.phone = phone;
		this.addr = addr;
		this.mprofile = mprofile;
		this.email = email;
		this.birth = birth;
		this.gender = gender;
		this.favor = favor;
		this.exp = exp;
		this.point = point;
		this.regdate = regdate;
		this.qdate = qdate;
		this.cover = cover;
		this.etc2 = etc2;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
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
	public String getMprofile() {
		return mprofile;
	}
	public void setMprofile(String mprofile) {
		this.mprofile = mprofile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String[] getFavor() {
		return favor;
	}
	public void setFavor(String[] favor) {
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getQdate() {
		return qdate;
	}
	public void setQdate(Date qdate) {
		this.qdate = qdate;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getEtc2() {
		return etc2;
	}
	public void setEtc2(String etc2) {
		this.etc2 = etc2;
	}
	@Override
	public String toString() {
		return "Member [mno=" + mno + ", mid=" + mid + ", mname=" + mname + ", pwd=" + pwd + ", phone=" + phone
				+ ", addr=" + addr + ", mprofile=" + mprofile + ", email=" + email + ", birth=" + birth + ", gender="
				+ gender + ", favor=" + favor + ", exp=" + exp + ", point=" + point + ", regdate=" + regdate
				+ ", qdate=" + qdate + ", cover=" + cover + ", etc2=" + etc2 + "]";
	}
	
	
	
	
	
}
