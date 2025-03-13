package com.itwillbs.project_fundizzy.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.service.ProjectMakerService;
import com.itwillbs.project_fundizzy.vo.MakerInfoVO;
import com.itwillbs.project_fundizzy.vo.ProjectDateVO;
import com.itwillbs.project_fundizzy.vo.ProjectInfoVO;
import com.itwillbs.project_fundizzy.vo.ProjectStoryVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Controller
public class ProjectMakerController {
	
	@Autowired
	private ProjectMakerService projectMakerService;
	
	private String virtualPath = "/resources/upload/";
	
	@GetMapping("ProjectMaker")
	public String projectMaker(HttpSession session, Model model) {
		String project_code = (String) session.getAttribute("project_code");
		
		Map<String, String> projectSetting = projectMakerService.getSettingInfo(project_code);
		
		model.addAttribute("projectSetting", projectSetting);
		
		return "project/projectMaker/project_maker_home";
	}
	
	//세션에 프로젝트 코드 저장
	@PostMapping("ProjectMaker")
	public String goProjectMaker(String project_code,HttpSession session) {
		session.setAttribute("project_code", project_code);
		return "redirect:/ProjectMaker";
	}
	
	//프로젝트 생성
	//전달받은 파라미터: 아이디,공통코드
	@PostMapping("MakeProject")
	public String makeProject(@RequestParam Map<String,Object> map,Model model) {
		
		//프로젝트 번호 생성(난수)
		Random r = new Random();
		int rNum = r.nextInt(1000000);
		if(rNum < 100000) {
			rNum *= 10;
		}
		map.put("project_num", rNum);
		//공통코드 및 프로젝트 코드 작업
		String common_code = (String) map.get("common_code");
		String projcet_code = rNum + common_code;
		map.put("project_code", projcet_code);
		
		//insert
		projectMakerService.makeNewProject(map);
		
		System.out.println(map);
		
		return "redirect:/MakerPage";
	}
	
	@GetMapping("ProjectSubmit")
	public String projectSubmit(HttpSession session) {
		
		String projectCode = (String)session.getAttribute("project_code");
		
		projectMakerService.updateProjectList(projectCode);
		
		return "redirect:/MakerPage";
	}
	
	//서비스 요금 선택
	@GetMapping("ProjectPlan")
	public String projectPlan(HttpSession session, Model model) {
		
		String projectCode = (String) session.getAttribute("project_code");
		
		String serviceType = projectMakerService.getServiceType(projectCode);
		
		String requestInfo = projectMakerService.getRequestInfo(projectCode);
		
		
		model.addAttribute("serviceType", serviceType);
		
		if(requestInfo.equals("accept") || requestInfo.equals("request")) {
			return "project/projectMaker/project_plan_read";
		}
		
		return "project/projectMaker/project_plan";
	}
	
	//서비스타입 고를때 실행되는 AJAX
	@ResponseBody
	@GetMapping("GetServiceType")
	public String getServiceType(String service_type, HttpSession session) {
		String project_code = (String) session.getAttribute("project_code");
		String result = "TRUE";
		projectMakerService.updateServceType(service_type, project_code);
		
		return result;
	}
	
	
	//프로젝트 정보 입력 폼
	@GetMapping("ProjectInfo")
	public String projectInfo(HttpSession session, Model model) {
		
		String projectCode = (String)session.getAttribute("project_code");
		
		String requestInfo = projectMakerService.getRequestInfo(projectCode);
		
		
		Map<String, String> projectConfig = projectMakerService.getSettingInfo(projectCode);
		
		String projectInfoConfig = projectConfig.get("project_info_config");
		
		
		
		if(requestInfo.equals("accept") || requestInfo.equals("request")) {
			return "redirect:/ProjectInfoRead";
		}else if(requestInfo.equals("before") && projectInfoConfig.equals("Y")) {
			return "redirect:/ProjectInfoEdit";
		}
		
		
		return "project/projectMaker/project_info";
	}
	
	
	//프로젝트 정보 업로드
	@PostMapping("ProjectInfo")
	public String registProjcetInfo(ProjectInfoVO projectInfo, HttpSession session, Model model) {
		
		String projectCode = projectInfo.getProject_code();
		String realPath = getRealPath(session, virtualPath);
		//파일 업로드되는 서브 경로
		String subDir = projectCode + "/registrationCard" ;
		
		realPath += subDir;
		
		//실제 파일 업로드 경로 생성
		try {
			Path path = Paths.get(realPath);
			Files.createDirectory(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile registrationCardImg = projectInfo.getRegistrationCard();
		
		projectInfo.setRegistration_card("");
		
		String registrationCardName = "";
		
		if(!registrationCardImg.getOriginalFilename().equals("")) {
			registrationCardName = UUID.randomUUID().toString() + "_" + registrationCardImg.getOriginalFilename();
			projectInfo.setRegistration_card(subDir + "/" + registrationCardName);
		}
		projectMakerService.registProjectInfo(projectInfo);
		
		try {
			if(!registrationCardImg.getOriginalFilename().equals("")) {
				registrationCardImg.transferTo(new File(realPath,registrationCardName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/ProjectMaker";
	}
	
	//프로젝트 수정 폼
	@GetMapping("ProjectInfoEdit")
	public String projcetInfoEdit(HttpSession session, Model model) {
		
		String project_code = (String)session.getAttribute("project_code");
		
		ProjectInfoVO projectInfo = projectMakerService.getProjectinfo(project_code);
		
		model.addAttribute("projectInfo", projectInfo);
		
		return "project/projectMaker/project_info_edit";
	}
	
	@PostMapping("ProjectInfoEdit")	
	public String projectInfoEdit(ProjectInfoVO projectInfo, HttpSession session) {
		
		String projectCode = projectInfo.getProject_code();
		String realPath = getRealPath(session, virtualPath);
		//파일 업로드되는 서브 경로
		String subDir = projectCode + "/registrationCard" ;
		
		realPath += subDir;
		
		//실제 파일 업로드 경로 생성
		try {
			Path path = Paths.get(realPath);
			Files.createDirectory(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile registrationCardImg = projectInfo.getRegistrationCard();
		
		projectInfo.setRegistration_card("");
		
		String registrationCardName = "";
		
		if(!registrationCardImg.getOriginalFilename().equals("")) {
			registrationCardName = UUID.randomUUID().toString() + "_" + registrationCardImg.getOriginalFilename();
			projectInfo.setRegistration_card(subDir + "/" + registrationCardName);
		}
		projectMakerService.updateProjectInfo(projectInfo);
		
		try {
			if(!registrationCardImg.getOriginalFilename().equals("")) {
				registrationCardImg.transferTo(new File(realPath,registrationCardName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/ProjectMaker";
	}
	
	
	@GetMapping("ProjectStory")
	public String projectStory(HttpSession session){
		
		String projectCode = (String)session.getAttribute("project_code");
		
		String requestInfo = projectMakerService.getRequestInfo(projectCode);
		
		
		Map<String, String> projectConfig = projectMakerService.getSettingInfo(projectCode);
		
		String storyConfig = projectConfig.get("story_config");
		
		
		
		if(requestInfo.equals("accept") || requestInfo.equals("request")) {
			return "redirect:/ProjectStoryRead";
		}else if(requestInfo.equals("before") && storyConfig.equals("Y")) {
			return "redirect:/ProjectStoryEdit";
		}
		
		return "project/projectMaker/project_story";
	}
	
	@PostMapping("ProjectStory")
	public String submitProjectStory(ProjectStoryVO projectStory, HttpSession session) {

	    String projectCode = projectStory.getProject_code();
	    String realPath = getRealPath(session, virtualPath) + projectCode + "/ProjectStory";

	    //실제 파일 업로드 경로 생성
	    try {
	        Path path = Paths.get(realPath);
	        if (!Files.exists(path)) { 
	            Files.createDirectories(path);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    //대표 이미지 업로드
	    MultipartFile representativePicture = projectStory.getRepresentativePicture();
	    projectStory.setRepresentative_picture(""); // 기본값 설정

	    if (representativePicture != null && !representativePicture.getOriginalFilename().isEmpty()) {
	        String repFileName = UUID.randomUUID().toString() + "_" + representativePicture.getOriginalFilename();
	        projectStory.setRepresentative_picture( projectCode +"/ProjectStory/" + repFileName);
	        try {
	            representativePicture.transferTo(new File(realPath, repFileName));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    //소개 이미지 (다중 파일 업로드)
	    MultipartFile[] productPictures = projectStory.getProductPicture();
	    List<String> productPicturePaths = new ArrayList<>();

	    if (productPictures != null) {
	        for (MultipartFile file : productPictures) {
	            if (file != null && !file.getOriginalFilename().isEmpty()) {
	                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	                productPicturePaths.add( projectCode + "/ProjectStory/" + fileName);

	                try {
	                    file.transferTo(new File(realPath, fileName));
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }

	    //경로를 하나의 문자열로 저장
	    projectStory.setProduct_picture(String.join(",", productPicturePaths));

	    //DB 저장
	    projectMakerService.registProjectStory(projectStory);

	    return "redirect:/ProjectMaker";
	}
	@GetMapping("ProjectStoryEdit")
	public String projectStoryEdit(HttpSession session, Model model) {
		
		String project_code = (String) session.getAttribute("project_code");
		
		ProjectStoryVO projectStory = projectMakerService.getProjectStory(project_code);
		
		model.addAttribute("projectStory", projectStory);
		
		//다중파일 목록을 배열처리하기
		String[] projectStoryArray = projectStory.getProduct_picture().split(",");
		model.addAttribute("imgList", projectStoryArray);
		
		
		return "project/projectMaker/project_story_edit";
	}
	
	@PostMapping("ProjectStoryUpdate")
	public String updateProjectStory(ProjectStoryVO projectStory, HttpSession session) {
		 String projectCode = projectStory.getProject_code();
		    String realPath = getRealPath(session, virtualPath) + projectCode + "/ProjectStory";

		    //실제 파일 업로드 경로 생성
		    try {
		        Path path = Paths.get(realPath);
		        if (!Files.exists(path)) { 
		            Files.createDirectories(path);
		        }
		    } catch (IOException e) {
		        e.printStackTrace();
		    }

		    //대표 이미지 업로드
		    MultipartFile representativePicture = projectStory.getRepresentativePicture();
		    projectStory.setRepresentative_picture(""); // 기본값 설정

		    if (representativePicture != null && !representativePicture.getOriginalFilename().isEmpty()) {
		        String repFileName = UUID.randomUUID().toString() + "_" + representativePicture.getOriginalFilename();
		        projectStory.setRepresentative_picture( projectCode +"/ProjectStory/" + repFileName);
		        try {
		            representativePicture.transferTo(new File(realPath, repFileName));
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
		    }

		    //소개 이미지 (다중 파일 업로드)
		    MultipartFile[] productPictures = projectStory.getProductPicture();
		    List<String> productPicturePaths = new ArrayList<>();

		    if (productPictures != null) {
		        for (MultipartFile file : productPictures) {
		            if (file != null && !file.getOriginalFilename().isEmpty()) {
		                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		                productPicturePaths.add( projectCode + "/ProjectStory/" + fileName);

		                try {
		                    file.transferTo(new File(realPath, fileName));
		                } catch (IOException e) {
		                    e.printStackTrace();
		                }
		            }
		        }
		    }

		    //경로를 하나의 문자열로 저장
		    projectStory.setProduct_picture(String.join(",", productPicturePaths));

		    //DB 저장
		    projectMakerService.updateProjectStory(projectStory);

		    return "redirect:/ProjectMaker";
	}
	//리워드 설정 페이지
	@GetMapping("ProjectReward")
	public String projectReward(HttpSession session, Model model) {
		
		String projectCode =  (String)session.getAttribute("project_code");
		
		List<RewardVO> rewardList = projectMakerService.getReward(projectCode);
		
		model.addAttribute("rewardList", rewardList);
		
		
		String requestInfo = projectMakerService.getRequestInfo(projectCode);
		
		if(requestInfo.equals("accept") || requestInfo.equals("request")) {
			return "redirect:/ProjectRewardRead";
		}
		
		
		return "project/projectMaker/project_reward";
	}
	
	//리워드 저장하기
	@PostMapping("ProjectReward")
	public String registReward(RewardVO reward, HttpSession session) {
		
		String projectCode =  (String)session.getAttribute("project_code");
		
		reward.setProject_code(projectCode);
		
		
		projectMakerService.registReward(reward);
		
		
		return "redirect:/ProjectReward";
	}
	
	//ajax를 활용하여 리워드 수정하기
	@GetMapping("GetRewardInfo")
	@ResponseBody
	public String getRewardInfo(int reward_code) {
		RewardVO reward = projectMakerService.getRewardInfo(reward_code);
		Gson gson = new Gson();
		
		return gson.toJson(reward);
	}
	
	//리워드 업데이트
	@PostMapping("ProjectRewardUpdate")
	public String projectRewardUpdate(RewardVO reward){
		
		projectMakerService.updateReward(reward);
		
		
		return "redirect:/ProjectReward";
	}
	
	//리워드 삭제 ajax
	@GetMapping("DeleteReward")
	@ResponseBody
	public String deleteReward(String reward_code) {
		projectMakerService.deleteReward(reward_code);
		return "success";
	}
	
	@GetMapping("MakerInfo")
	public String makerInfo(HttpSession session) {
		String projectCode = (String)session.getAttribute("project_code");
		
		String requestInfo = projectMakerService.getRequestInfo(projectCode);
		
		
		Map<String, String> projectConfig = projectMakerService.getSettingInfo(projectCode);
		
		String makerConfig = projectConfig.get("maker_config");
		
		
		
		if(requestInfo.equals("accept") || requestInfo.equals("request")) {
			return "redirect:/MakerInfoRead";
		}else if(requestInfo.equals("before") && makerConfig.equals("Y")) {
			return "redirect:/MakerInfoEdit";
		}
		return "project/projectMaker/maker_info";
	}
	
	//메이커 정보 저장
	@PostMapping("MakerInfo")
	public String submitMakerInfo(MakerInfoVO makerInfo, HttpSession session) {
		String projectCode = makerInfo.getProject_code();
		String realPath = getRealPath(session, virtualPath);
		//파일 업로드되는 서브 경로
		String subDir = projectCode + "/MakerProfile" ;
		
		realPath += subDir;
		
		//실제 파일 업로드 경로 생성
		try {
			Path path = Paths.get(realPath);
			Files.createDirectory(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile registrationCardImg = makerInfo.getProfileImg();
		
		makerInfo.setProfile_img("");
		
		String registrationCardName = "";
		
		if(!registrationCardImg.getOriginalFilename().equals("")) {
			registrationCardName = UUID.randomUUID().toString() + "_" + registrationCardImg.getOriginalFilename();
			makerInfo.setProfile_img(subDir + "/" + registrationCardName);
		}
		projectMakerService.registMakerInfo(makerInfo);
		
		try {
			if(!registrationCardImg.getOriginalFilename().equals("")) {
				registrationCardImg.transferTo(new File(realPath,registrationCardName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/ProjectMaker";
	}
	
	//메이커 정보 수정 폼
	@GetMapping("MakerInfoEdit")
	public String makerInfoEditForm(HttpSession session,Model model) {
		
		String projectCode = (String)session.getAttribute("project_code");
		
		MakerInfoVO makerInfo = projectMakerService.getMakerInfo(projectCode);
		
		model.addAttribute("makerInfo", makerInfo);
		
		return "project/projectMaker/maker_info_edit";
	}
	
	//메이커 정보 업데이트
	@PostMapping("MakerInfoEdit")
	public String makerInfoEdit(MakerInfoVO makerInfo, HttpSession session) {
		
		String projectCode = makerInfo.getProject_code();
		String realPath = getRealPath(session, virtualPath);
		
		//파일 업로드되는 서브 경로
		String subDir = projectCode + "/MakerProfile" ;
		
		realPath += subDir;
		
		MultipartFile profileImg = makerInfo.getProfileImg();
		
		makerInfo.setProfile_img("");
		
		String imgName = "";
		
		if(!profileImg.getOriginalFilename().equals("")) {
			imgName = UUID.randomUUID().toString() + "_" + profileImg.getOriginalFilename();
			makerInfo.setProfile_img(subDir + "/" + imgName);
		}
		
		projectMakerService.updateMakerInfo(makerInfo);
		
		updateFile(profileImg, realPath, imgName);
		
		
		return "redirect:/ProjectMaker";
	}
	
	//읽기전용 리워드 확인
	@GetMapping("ProjectRewardRead")
	public String projectRewardRead(HttpSession session, Model model) {
		
		String projectCode = (String) session.getAttribute("project_code");
		
		List<RewardVO> rewardList = projectMakerService.getReward(projectCode);
		
		model.addAttribute("rewardList", rewardList);
		
		return "project/projectMaker/project_reward_read";
	}
	
	//읽기전용 메이커 정보 확인
	@GetMapping("MakerInfoRead")
	public String makerInfoRead(HttpSession session, Model model) {
		
		String projectCode = (String) session.getAttribute("project_code");
		
		MakerInfoVO makerInfo = projectMakerService.getMakerInfo(projectCode);
		
		model.addAttribute("makerInfo", makerInfo);
		
		return "project/projectMaker/maker_info_read";
	}
	
	@GetMapping("ProjectStoryRead")
	public String projectStoryRead(HttpSession session, Model model) {
		String project_code = (String) session.getAttribute("project_code");
		
		ProjectStoryVO projectStory = projectMakerService.getProjectStory(project_code);
		
		model.addAttribute("projectStory", projectStory);
		
		//다중파일 목록을 배열처리하기
		String[] projectStoryArray = projectStory.getProduct_picture().split(",");
		model.addAttribute("imgList", projectStoryArray);
		
		
		return "project/projectMaker/project_story_read";
	}
	
	@GetMapping("ProjectInfoRead")
	public String projectInfoRead(Model model, HttpSession session) {
		
		String projectCode = (String) session.getAttribute("project_code");
		
		ProjectInfoVO projectInfo = projectMakerService.getProjectinfo(projectCode);
		
		model.addAttribute("projectInfo",projectInfo);
		
		return "project/projectMaker/project_info_read";
	}
	
	@GetMapping("ProjectPlanRead")
	public String projectPlanRead(Model model, HttpSession session) {
		
		String projectCode = (String) session.getAttribute("project_code");
		
		String serviceType = projectMakerService.getServiceType(projectCode);
		
		model.addAttribute("serviceType", serviceType);
		
		return "project/projectMaker/project_plan_read";
	}
	
	@GetMapping("ProjectDate")
	public String projectDate(HttpSession session, Model model) {
		
		String projectCode = (String)session.getAttribute("project_code");
		
		Map<String, Object> dateMap = projectMakerService.getDate(projectCode);
		
		String requestInfo = projectMakerService.getRequestInfo(projectCode);
		
		if (requestInfo.equals("accept")) {
		    if (dateMap == null || dateMap.isEmpty()) {
		        return "project/projectMaker/project_date";
		    } else {
		        model.addAttribute("date", dateMap);
		        return "project/projectMaker/project_date_read";
		    }
		} else {
		    model.addAttribute("msg", "프로젝트 승인 후 설정해주세요");
		    return "result/result";
		}
		
	}
	
	@PostMapping("ProjectDate")
	public String projectDateRegist(HttpSession session, Model model, ProjectDateVO date) {
		
		String projectCode = (String) session.getAttribute("project_code");
		
		date.setProject_code(projectCode);
		
		projectMakerService.setProjectDate(date);
		
		return "redirect:/ProjectDate";
	}
	
	//파일 업로드 및 다운로드를 위한 유틸리티 메서드
	//파일 업로드에 사용될 실제 업로드 디렉토리 경로를 리턴하는 메서드
	private String getRealPath(HttpSession session, String virturalPath) {
		return session.getServletContext().getRealPath(virturalPath);
	}
	
	//업로드된 파일을 업데이트하는 메서드
	private void updateFile(MultipartFile img, String realPath, String imgName) {
		try {
			MultipartFile mFile = img;
			
			
			if(!mFile.getOriginalFilename().equals("")) {
				mFile.transferTo(new File(realPath,imgName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//프로젝트 스토리에서 파일 업로드를 담당하는 메서드
	@PostMapping("StoryImg")
	@ResponseBody
	public String uploadStoryImg(@RequestParam("image") MultipartFile file, HttpSession session) {
	    String projectCode = (String)session.getAttribute("project_code");
	    String realPath = getRealPath(session, virtualPath);
	    

	    // 파일 경로 설정
	    String subDir = projectCode + "/ProjectStoryImg";
	    realPath = realPath.endsWith("/") ? realPath + subDir : realPath + "/" + subDir;

	    try {
	        // 디렉토리 생성
	        Path dirPath = Paths.get(realPath);
	        if (!Files.exists(dirPath)) {
	            Files.createDirectories(dirPath); // 디렉토리 생성
	        }

	        // 파일명 생성
	        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        Path filePath = Paths.get(realPath + "/" + fileName);
	        
	        // 파일 저장
	        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
	        
	        System.out.println(fileName);
	        
	        
	        // URL 반환
	        return "resources/upload/" + projectCode + "/ProjectStoryImg/" + fileName;
	    } catch (IOException e) {
	        e.printStackTrace();
	        return "Image upload failed: " + e.getMessage();
	    }
	}
}
