package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

@Mapper
public interface HomeMapper {

	List<Map<String, String>> selectCategory();

	List<Map<String, String>> selectProjectList();

	List<Map<String, String>> selectProjectLikeList();

	List<Map<String, String>> selectProjectRandomList();

	List<Map<String, String>> selectProjectProgressList();

	List<Map<String, String>> select();


}
