package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.HelpCenterMapper;

@Service
public class HelpCenterService {
	@Autowired
	private HelpCenterMapper mapper;

	public List<Map<String, String>> getBoardList() {
		return mapper.selectBoardList();
	}

	public Map<String, String> getUserLikeStatus(Map<String, String> map) {
	    return mapper.selectUserLikeStatus(map);
	}

	public int updateLikeStatus(Map<String, String> UserInfo) {
		return mapper.updateLikeStatus(UserInfo);
	}

	public int insertLikeStatus(Map<String, String> UserInfo) {
		return mapper.insertLikeStatus(UserInfo);
	}

	public int updateBoardLike(Map<String, String> userInfo) {
		return mapper.updateBoardLike(userInfo);
	}

	public int insertQna(Map<String, String> map) {
		return mapper.insertQna(map);
	}
}
