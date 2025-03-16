package com.itwillbs.project_fundizzy.service;

import java.util.List;
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

	public List<Map<String, String>> getUserInfo() {
		return mapper.selectUserInfo();
	}

	public List<Map<String, String>> getRegDate() {
		return mapper.selectGetRegDate();
	}

	public List<Map<String, String>> getWithdrawDate() {
		return mapper.selectWithdrawDate();
	}

	public int insertAdminInfo(Map<String, String> adminInfo) {
		return mapper.insertAdminInfo(adminInfo);
	}

	public List<Map<String, String>> getUnansweredQnaList() {
		return mapper.selectUnansweredQnaList();
	}

	public List<Map<String, String>> getAnsweredQnaList() {
		return mapper.selectAnsweredQnaList();
	}

	public List<Map<String, String>> getQnaList() {
		return mapper.selectQnaList();
	}
}
