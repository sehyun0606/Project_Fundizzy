package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.ProjectInfoVO;

@Mapper
public interface ProjectMakerMapper {

	void insertNewProject(Map<String, Object> map);

	//프로젝트 설정 여부
	Map<String, String> selectSettingInfo(String project_code);

	void updateServiceType(@Param("service_type") String service_type,
							@Param("project_code") String project_code);

	String selectServiceType(String projectCode);

	void insertProjcetInfo(ProjectInfoVO projectInfo);


}
