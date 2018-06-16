package com.pure.study.board.model.vo;

	import java.sql.Date;

	public class BoardComment {
		private int board_comment_no;
		private int board_comment_level;
		private String board_comment_writer;
		private String board_comment_content;
		private int board_ref;
		private int board_comment_ref;
		private Date board_comment_date;
		public BoardComment(int board_comment_no, int board_comment_level, String board_comment_writer,
				String board_comment_content, int board_ref, int board_comment_ref, Date board_comment_date) {
			super();
			this.board_comment_no = board_comment_no;
			this.board_comment_level = board_comment_level;
			this.board_comment_writer = board_comment_writer;
			this.board_comment_content = board_comment_content;
			this.board_ref = board_ref;
			this.board_comment_ref = board_comment_ref;
			this.board_comment_date = board_comment_date;
		}
		public BoardComment() {
			super();
			// TODO Auto-generated constructor stub
		}
		public int getBoard_comment_no() {
			return board_comment_no;
		}
		public void setBoard_comment_no(int board_comment_no) {
			this.board_comment_no = board_comment_no;
		}
		public int getBoard_comment_level() {
			return board_comment_level;
		}
		public void setBoard_comment_level(int board_comment_level) {
			this.board_comment_level = board_comment_level;
		}
		public String getBoard_comment_writer() {
			return board_comment_writer;
		}
		public void setBoard_comment_writer(String board_comment_writer) {
			this.board_comment_writer = board_comment_writer;
		}
		public String getBoard_comment_content() {
			return board_comment_content;
		}
		public void setBoard_comment_content(String board_comment_content) {
			this.board_comment_content = board_comment_content;
		}
		public int getBoard_ref() {
			return board_ref;
		}
		public void setBoard_ref(int board_ref) {
			this.board_ref = board_ref;
		}
		public int getBoard_comment_ref() {
			return board_comment_ref;
		}
		public void setBoard_comment_ref(int board_comment_ref) {
			this.board_comment_ref = board_comment_ref;
		}
		public Date getBoard_comment_date() {
			return board_comment_date;
		}
		public void setBoard_comment_date(Date board_comment_date) {
			this.board_comment_date = board_comment_date;
		}
		@Override
		public String toString() {
			return "BoardComment [board_comment_no=" + board_comment_no + ", board_comment_level=" + board_comment_level
					+ ", board_comment_writer=" + board_comment_writer + ", board_comment_content=" + board_comment_content
					+ ", board_ref=" + board_ref + ", board_comment_ref=" + board_comment_ref + ", board_comment_date="
					+ board_comment_date + "]";
		}
		
	}


