package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminMapper {

	Map<String, String> selectAdminDBInfo(Map<String, String> admin);

	List<Map<String, String>> selectUserInfo();

	List<Map<String, String>> selectGetRegDate();

	List<Map<String, String>> selectWithdrawDate();

	int insertAdminInfo(Map<String, String> adminInfo);

	List<Map<String, String>> selectUnansweredQnaList();

	List<Map<String, String>> selectAnsweredQnaList();
	
	List<Map<String, String>> selectQnaList();

	int updateQnaReply(Map<String, String> map);

	int selectBoardListCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	List<Map<String, Object>> selectQnaBoardList(
			@Param("searchType") String searchType, 
			@Param("searchKeyword") String searchKeyword,
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);

//	List<Map<String, Object>> selectQnaList(
//			@Param("searchType") String searchType, 
//			@Param("searchKeyword") String searchKeyword,
//			@Param("startRow") int startRow, 
//			@Param("listLimit") int listLimit);
//
//	int selectBoardListCount(
//			@Param("searchType") String searchType, 
//			@Param("searchKeyword") String searchKeyword);

}
