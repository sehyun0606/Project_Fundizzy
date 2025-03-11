package com.itwillbs.project_fundizzy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.ProjectStoryMapper;

@Service
public class ProjectStoryService {
    @Autowired
    private ProjectStoryMapper projectStoryMapper;

    public String getProject_title(String project_code) {
        return projectStoryMapper.selectProjectTitle(project_code);
    }

	public String getRepresentativePicture(String project_code) {
		// TODO Auto-generated method stub
		return projectStoryMapper.selectRepresentativePicture(project_code);
	}
	
	
}
