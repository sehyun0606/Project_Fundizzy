package com.itwillbs.project_fundizzy.mapper;

import org.apache.ibatis.annotations.Param;

public interface FundMapper {
	//지지서명 글 등록
	int insertSupportSignature(@Param("project_code") int project_code, @Param("email")String email, @Param("supportContent") String supportContent, @Param("supportKeyword") String supportKeyword);
	
}
