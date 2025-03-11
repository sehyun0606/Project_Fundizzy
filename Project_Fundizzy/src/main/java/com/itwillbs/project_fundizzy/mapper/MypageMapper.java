package com.itwillbs.project_fundizzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_fundizzy.vo.MemberVO;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;

@Mapper
public interface MypageMapper {

	List<ProjectListVO> selectMyProjectList(String id);

	MemberVO selectMemberInfo(String email);

	void updateProfile(MemberVO member);

}
