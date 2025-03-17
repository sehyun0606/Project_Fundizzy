package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

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

	public void updateProfile(MemberVO member) {
		mypageMapper.updateProfile(member);
	}

	public List<Map<String, Object>> getMyLike(String email, int startRow, int listLimit) {
		return mypageMapper.selectMyLike(email,startRow,listLimit);
	}

	public int getLikeListCount(String email) {
		return mypageMapper.selectLikeListCount(email);
	}


	public int getMySupportListCount(String email) {
		return mypageMapper.selectSupportListCount(email);
	}

	public List<Map<String, Object>> getMySupport(String email, int startRow, int listLimit) {
		return mypageMapper.selectMysupport(email,startRow,listLimit);
	}

	public void memberWithdraw(String email) {
		mypageMapper.memberWithdraw(email);
	}
}
