package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OpenMapper {

	List<Map<String, Object>> selectOpenList();

	int selectKeepCount(String project_code);


}
