package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HelpCenterMapper {

	List<Map<String, String>> selectBoardList();

	Map<String, String> selectUserLikeStatus(Map<String, String> map);

	int updateLikeStatus(Map<String, String> UserInfo);

	int insertLikeStatus(Map<String, String> map);

	int updateBoardLike(Map<String, String> userInfo);

	int insertQna(Map<String, String> map);

}
