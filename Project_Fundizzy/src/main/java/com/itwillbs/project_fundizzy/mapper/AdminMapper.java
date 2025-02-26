package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {

	Map<String, String> selectAdminDBInfo(Map<String, String> admin);

}
