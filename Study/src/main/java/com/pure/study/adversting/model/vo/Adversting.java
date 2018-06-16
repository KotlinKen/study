package com.pure.study.adversting.model.vo;

import java.sql.Date;

public class Adversting {
	private int ano;
	private String title;
	private String content;
	private String img1;
	private String img2;
	private String url;
	private String position;
	private Date startAd;
	private Date endAd;
	private Date regDate;
	public Adversting() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Adversting(int ano, String title, String content, String img1, String img2, String url, String position,
			Date startAd, Date endAd, Date regDate) {
		super();
		this.ano = ano;
		this.title = title;
		this.content = content;
		this.img1 = img1;
		this.img2 = img2;
		this.url = url;
		this.position = position;
		this.startAd = startAd;
		this.endAd = endAd;
		this.regDate = regDate;
	}
	public int getAno() {
		return ano;
	}
	public void setAno(int ano) {
		this.ano = ano;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Date getStartAd() {
		return startAd;
	}
	public void setStartAd(Date startAd) {
		this.startAd = startAd;
	}
	public Date getEndAd() {
		return endAd;
	}
	public void setEndAd(Date endAd) {
		this.endAd = endAd;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "Adversting [ano=" + ano + ", title=" + title + ", content=" + content + ", img1=" + img1 + ", img2="
				+ img2 + ", url=" + url + ", position=" + position + ", startAd=" + startAd + ", endAd=" + endAd
				+ ", regDate=" + regDate + "]";
	}

}
