package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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

}
