package com.pure.study.board.model.dao;

import java.util.List;
import java.util.Map;

import com.pure.study.board.model.vo.Attachment;
import com.pure.study.board.model.vo.Board;
import com.pure.study.board.model.vo.BoardComment;

public interface BoardDAO {

	List<Map<String, String>> selectBoardList(int cPage, int numPerPage);

	int selectCount();

	int insertBoard(Board board);

	int inserAttachment(Attachment a);

	List<Map<String, String>> selectOne(int boardNo);

	int selectOneAttachCount(int boardNo);

	List<Map<String, String>> selectOneAttach(int boardNo);

	Board selectOneBoard(int boardNo);

	List<Attachment> selectAttachmentList(int boardNo);

	Board selectOneBoardFix(int boardNo);

	int updateAttachment(Attachment a);

	int updateBoard(Board board);

	int deleteBoard(int boardNo);

	int insertBoardComment(BoardComment boardComment);

	


}
