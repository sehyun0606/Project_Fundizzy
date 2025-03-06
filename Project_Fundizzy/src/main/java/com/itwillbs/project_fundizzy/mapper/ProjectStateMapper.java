package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.NewsVO;

@Mapper
public interface ProjectStateMapper {

	int insertNewsBoard(Map<String, String> map);

	List<NewsVO> selectNewsList(@Param("project_code")String project_code, @Param("startRow")int startRow, @Param("listLimit")int listLimit);

	int selectNewsListCount(String project_code);

	NewsVO getNews(int news_code);

	int deleteNews(int news_code);

	int updateNewsBoard(Map<String, String> map);



}
