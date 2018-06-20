package com.pure.study.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pure.study.board.model.vo.Attachment;
import com.pure.study.board.model.vo.Board;
import com.pure.study.board.model.vo.BoardComment;
@Repository
public class BoardDAOImpl implements BoardDAO {

	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Map<String, String>> selectBoardList(int cPage, int numPerPage) {
		
		return sqlSession.selectList("board.boardList", null, new RowBounds((cPage-1)*numPerPage, numPerPage));
	}

	@Override
	public int selectCount() {
		return sqlSession.selectOne("board.boardCount"); 
	}

	@Override
	public int insertBoard(Board board) {
		return sqlSession.insert("board.insertBoard", board);
	}

	@Override
	public int inserAttachment(Attachment a) {

		return sqlSession.insert("board.insertAttachment", a);
	}

	@Override
	public List<Map<String, String>> selectOne(int boardNo) {
		return sqlSession.selectList("board.selectOne", boardNo);
	}

	@Override
	public int selectOneAttachCount(int boardNo) {
		return sqlSession.selectOne("board.selectOneAttachCount", boardNo);
	}

	@Override
	public List<Map<String, String>> selectOneAttach(int boardNo) {
		return sqlSession.selectList("board.selectOneAttach", boardNo); 
	}

	@Override
	public Board selectOneBoard(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.selectOneBoard", boardNo);
	}

	@Override
	public List<Attachment> selectAttachmentList(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectAttachmentList", boardNo);
	}

	@Override
	public Board selectOneBoardFix(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.selectOneBoardFix", boardNo);
	}

	@Override
	public int updateAttachment(Attachment a) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.updateAttachment", a);
	}

	@Override
	public int updateBoard(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.updateBoard", board);
	}

	@Override
	public int deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.deleteBoard", boardNo);
	}

	@Override
	public int insertBoardComment(BoardComment boardComment) {
		return sqlSession.insert("boardComment.insertBoardComment", boardComment);
	}




}
