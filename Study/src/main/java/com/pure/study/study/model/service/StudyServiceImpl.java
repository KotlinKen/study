package com.pure.study.study.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pure.study.study.model.dao.StudyDAO;

@Service
public class StudyServiceImpl implements StudyService {
	@Autowired
	private StudyDAO studyDAO;
}
