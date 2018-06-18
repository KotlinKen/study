package com.pure.study.depart.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pure.study.depart.model.dao.DepartDAO;

@Service

public class DepartServiceImpl implements DepartService {
	@Autowired
	DepartDAO departDAO;

	@Override
	public List<Map<String, String>> selectDepart() {
		return departDAO.selectDepart();
	}
}
