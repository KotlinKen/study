package com.pure.study.adversting.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pure.study.adversting.model.dao.AdverstingDao;

@Service
public class AdverstingServiceImpl implements AdverstingService {

	@Autowired
	private AdverstingDao adverstingDao;

	@Override
	public List<Map<String, String>> selectPagingAdversting(int cPage, int numPerPage) {
		return adverstingDao.selectPagingAdversting(cPage, numPerPage);
	}
	

}
