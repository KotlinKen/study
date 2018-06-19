package com.pure.study.lecture.model.dao;

import java.util.List;
import java.util.Map;

import com.pure.study.lecture.model.vo.Lecture;

public interface LectureDAO {

	List<Map<String, String>> selectLocList();

	List<Map<String, Object>> selectTownList(int localNo);

	List<Map<String, String>> selectSubList();

	List<Map<String, Object>> selectKindList(int subNo);

	int insertLecture(Lecture lecture);

	List<Map<String, String>> selectLectureList(int cPage, int numPerPage);

	List<Map<String, String>> selectDiffList();

	Map<String, String> selectLectureOne(int sno);

	int deleteLecture(int sno);

}
