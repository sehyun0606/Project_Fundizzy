package com.itwillbs.project_fundizzy.service;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.ProjectInfoMapper;

@Service
public class ProjectInfoService {
	@Mapper
	private ProjectInfoMapper mapper;

	public String getBusinessName(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectBusinessName(project_code);
	}
	
}
