package com.pure.study.board.model.vo;

import java.sql.Date;

public class BoardComment {
		private int ReplyNo;
		private int MemberNo;
		private int BoardNo;
		private int ParentNo;
		private String ReplyContent;
		private Date ReplyRegdate;
		@Override
		public String toString() {
			return "BoardComment [ReplyNo=" + ReplyNo + ", MemberNo=" + MemberNo + ", BoardNo=" + BoardNo
					+ ", ParentNo=" + ParentNo + ", ReplyContent=" + ReplyContent
					+ ", ReplyRegdate=" + ReplyRegdate + "]";
		}
		public int getReplyNo() {
			return ReplyNo;
		}
		public void setReplyNo(int replyNo) {
			ReplyNo = replyNo;
		}
		public int getMemberNo() {
			return MemberNo;
		}
		public void setMemberNo(int memberNo) {
			MemberNo = memberNo;
		}
		public int getBoardNo() {
			return BoardNo;
		}
		public void setBoardNo(int boardNo) {
			BoardNo = boardNo;
		}
		public int getParentNo() {
			return ParentNo;
		}
		public void setParentNo(int parentNo) {
			ParentNo = parentNo;
		}
		
		public String getReplyContent() {
			return ReplyContent;
		}
		public void setReplyContent(String replyContent) {
			ReplyContent = replyContent;
		}
		public Date getReplyRegdate() {
			return ReplyRegdate;
		}
		public void setReplyRegdate(Date replyRegdate) {
			ReplyRegdate = replyRegdate;
		}
		public BoardComment() {
			super();
			// TODO Auto-generated constructor stub
		}
		public BoardComment(int replyNo, int memberNo, int boardNo, int parentNo, 
				String replyContent, Date replyRegdate) {
			super();
			ReplyNo = replyNo;
			MemberNo = memberNo;
			BoardNo = boardNo;
			ParentNo = parentNo;
			ReplyContent = replyContent;
			ReplyRegdate = replyRegdate;
		}
}