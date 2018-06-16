package com.pure.study.adversting.model.service;

import java.util.List;
import java.util.Map;

public interface AdverstingService {

	List<Map<String, String>> selectPagingAdversting(int cPage, int numPerPage);

}
