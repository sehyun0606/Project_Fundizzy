package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.OpenMapper;

@Service
public class OpenService {
	@Autowired
	private OpenMapper openMapper;

	public List<Map<String, Object>> getOpenList() {
		return openMapper.selectOpenList();
	}

	public int getKeepCount(String project_code) {
		return openMapper.selectKeepCount(project_code);
	}

}
