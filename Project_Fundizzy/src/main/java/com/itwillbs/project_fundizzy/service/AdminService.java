package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.AdminMapper;

@Service
public class AdminService {
	@Autowired
	private AdminMapper mapper;

	public Map<String, String> getAdminDBInfo(Map<String, String> admin) {
		return mapper.selectAdminDBInfo(admin);
	}
}
