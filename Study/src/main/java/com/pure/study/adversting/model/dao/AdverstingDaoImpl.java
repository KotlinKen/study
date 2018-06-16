package com.pure.study.adversting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class AdverstingDaoImpl implements AdverstingDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, String>> selectPagingAdversting(int cPage, int numPerPage) {
		return sqlSession.selectList("adversting.selectPagingAdversting", null, new RowBounds((cPage-1)*numPerPage, numPerPage));
	}

}
