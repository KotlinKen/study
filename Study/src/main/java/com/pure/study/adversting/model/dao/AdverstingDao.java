package com.pure.study.adversting.model.dao;

import java.util.List;
import java.util.Map;

public interface AdverstingDao {

	List<Map<String, String>> selectPagingAdversting(int cPage, int numPerPage);

}
