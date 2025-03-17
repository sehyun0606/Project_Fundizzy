package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.AdminMapper;
import com.itwillbs.project_fundizzy.mapper.HomeMapper;

@Service
public class HomeService {
	@Autowired
	private HomeMapper mapper;

	public List<Map<String, String>> getCategory() {
		return mapper.selectCategory();
	}

	public List<Map<String, String>> getProjectList() {
		return mapper.selectProjectList();
	}

	public List<Map<String, String>> getProjectLikeList() {
		return mapper.selectProjectLikeList();
	}

	public List<Map<String, String>> getProjectRandomList() {
		return mapper.selectProjectRandomList();
	}

	public List<Map<String, String>> getProjectProgressList() {
		return mapper.selectProjectProgressList();
	}

}
