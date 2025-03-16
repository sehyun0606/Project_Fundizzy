package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.MemberVO;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;

@Mapper
public interface MypageMapper {

	List<ProjectListVO> selectMyProjectList(String id);

	MemberVO selectMemberInfo(String email);

	void updateProfile(MemberVO member);

	List<Map<String, Object>> selectMyLike(@Param("email")String email, 
											@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit);

	int selectLikeListCount(String email);

}
