package com.pure.study.study.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pure.study.study.model.dao.StudyDAO;
import com.pure.study.study.model.vo.Study;



@Service
public class StudyServiceImpl implements StudyService {
	
	@Autowired
	private StudyDAO studyDAO;

	@Override
	public List<Map<String, String>> selectStudyList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return studyDAO.selectStudyList(cPage,numPerPage);
	}

	@Override
	public int studyTotalCount() {
		// TODO Auto-generated method stub
		return studyDAO.studyTotalCount();
	}

	@Override
	public List<Map<String, Object>> selectSubject() {
		// TODO Auto-generated method stub
		return studyDAO.selectSubject();
	}

	@Override
	public List<Map<String, Object>> selectKind(int subno) {
		// TODO Auto-generated method stub
		return studyDAO.selectKind(subno);
	}

	@Override
	public List<Map<String, Object>> selectLocal() {
		// TODO Auto-generated method stub
		return studyDAO.selectLocal();
	}

	@Override
	public List<Map<String, Object>> selectTown(int lno) {
		// TODO Auto-generated method stub
		return studyDAO.selectTown(lno);
	}

	@Override
	public List<Map<String, Object>> selectLv() {
		// TODO Auto-generated method stub
		return studyDAO.selectLv();
	}

	@Override
	public int insertStudy(Study study) {
		// TODO Auto-generated method stub
		return studyDAO.insertStudy(study);
	}

	@Override
	public int updateStudyImg(Study study) {
		// TODO Auto-generated method stub
		return studyDAO.updateStudyImg(study);
	}

	@Override
	public List<Map<String, Object>> selectStudyForSearch(Map<String, Object> terms) {
		// TODO Auto-generated method stub
		return studyDAO.selectStudyForSearch(terms);
	}

	@Override
	public List<Map<String, Object>> selectStudyAdd(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return studyDAO.selectStudyAdd(cPage,numPerPage);
	}

	@Override
	public Map<String, Object> selectStudyOne(int sno) {
		// TODO Auto-generated method stub
		return studyDAO.selectStudyOne(sno);
	}

	@Override
	public int insertApplyStudy(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return studyDAO.insertApplyStudy(map);
	}

	@Override
	public int insertWishStudy(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return studyDAO.insertWishStudy(map);
	}

}
