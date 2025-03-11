package com.itwillbs.project_fundizzy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.MypageMapper;
import com.itwillbs.project_fundizzy.vo.MemberVO;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;

@Service
public class MypageService {
	@Autowired
	private MypageMapper mypageMapper;

	public List<ProjectListVO> getMyProjectList(String id) {
		return mypageMapper.selectMyProjectList(id);
	}

	public MemberVO getMemberInfo(String email) {
		return mypageMapper.selectMemberInfo(email);
	}
}
