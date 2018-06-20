package com.pure.study.board.model.service;

import java.util.List;
import java.util.Map;

import com.pure.study.board.model.vo.Attachment;
import com.pure.study.board.model.vo.Board;
import com.pure.study.board.model.vo.BoardComment;


public interface BoardService {

	List<Map<String, String>> selectBoardList(int cPage, int numPerPage);
	int selectCount();
	int insertBoard(Board board, List<Attachment> attachList);
	List<Map<String, String>> selectOne(int boardNo);
	Board selectOneBoard(int boardNo);
	List<Attachment> selectAttachmentList(int boardNo);
	Board selectOneBoardFix(int boardNo);
	int updateBoard(Board board, List<Attachment> attachList);
	int deleteBoard(int boardNo);
	int insertBoardComment(BoardComment boardComment);
	
	
}
