package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.ProjectStateMapper;
import com.itwillbs.project_fundizzy.vo.NewsVO;

@Service
public class ProjectStateService {
	@Autowired
	ProjectStateMapper stateMapper;

	public int registNewsBoard(NewsVO news) {
		return stateMapper.insertNewsBoard(news);
	}

	public List<NewsVO> getNewsList() {
		return stateMapper.selectNewsList();
	}

}
