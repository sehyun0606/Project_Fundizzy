package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_fundizzy.vo.NewsVO;

@Mapper
public interface ProjectStateMapper {

	int insertNewsBoard(NewsVO news);

	List<NewsVO> selectNewsList(String project_code);

}
