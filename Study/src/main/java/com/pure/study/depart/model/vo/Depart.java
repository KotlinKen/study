package com.pure.study.depart.model.vo;

public class Depart {
	private int dno;
	private String dname;
	public Depart() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Depart(int dno, String dname) {
		super();
		this.dno = dno;
		this.dname = dname;
	}
	public int getDno() {
		return dno;
	}
	public void setDno(int dno) {
		this.dno = dno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	@Override
	public String toString() {
		return "Depart [dno=" + dno + ", dname=" + dname + "]";
	}
	
	
}
