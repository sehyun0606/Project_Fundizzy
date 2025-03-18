package com.itwillbs.project_fundizzy.controller;


import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.handler.FileHandler;
import com.itwillbs.project_fundizzy.service.ChatService;


@Controller
public class ChatController {
	@Autowired
	private ChatService chatService;
	
	// 채팅 아이콘 클릭시 채팅메인 페이지로 이동
	@GetMapping("ChatMain")
	public String chatMain() {
		return "service/chat/chat_main";
	}
	
	// 채팅 리스트 페이지로 이동
	@GetMapping("ChatList")
	public String chatList() {
		return "service/chat/chat_list";
	}
	
	// 채팅방으로 이동
	@GetMapping("ChatRoom")
	public String chatRoom() {
		return "service/chat/chat_room";
	}
	
	// 채팅방에서 전송한 이미지파일 저장 및 디비에 저장
	
	@ResponseBody
	@PostMapping("ChatFileUpload")
	public String chatFileUpload(MultipartFile[] files, HttpSession session) {
		// JSON 형식의 응답 데이터 전송을 위해 Map 객체 생성
		List<Map<String, String>> uploadResultList = new ArrayList<Map<String,String>>();
		
		for(MultipartFile file : files) {
			// 각 파일별 결과 저장할 맵
			Map<String, String> uploadResult = new HashMap<String, String>();
			// 이미지 파일이 아닐경우 실패메시지 저장후 전송
			if(!file.getContentType().startsWith("image/")) {
				uploadResult.put("result", "fail");
				uploadResult.put("orginalName", file.getOriginalFilename());
				
			} else {
				uploadResult.put("orginalName", file.getOriginalFilename());
				// 실제 경로 리턴받기
				String realPath = FileHandler.getRealPath(session, "/resources/upload");
				
				// 멀티파일 처리
					
				String fileName = "";
				
				try {
					// 파일중복방지 이름생성 메서드 호출
					fileName = FileHandler.processDuplicateFileNames(file.getOriginalFilename());
					//실제 경로로 임시 파일 이동 처리
					file.transferTo(new File(realPath, "/" + fileName));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				// 파일 업로드 성공여부는 fileName이 "" 인지 아닌지 판별
				if(!fileName.equals("")) {
					// FileHandler - createThumbnailImage() 메서드 호출하여 썸네일 이미지 생성 처리
					// => 파라미터 : 실제 업로드 경로, 업로드 된 실제 파일명
					//    리턴타입 : String(썸네일 이미지 파일명)
					String thumbnailFileName = FileHandler.createThumbnailImage(realPath, fileName);
					
					// 원본 파일명과 썸네일 파일명을 Map 객체에 추가
					uploadResult.put("fileName", fileName);
					uploadResult.put("thumbnailFileName", thumbnailFileName);
				}
			}	
			uploadResultList.add(uploadResult);
		}
		
		return new Gson().toJson(uploadResultList);
	}
	
	// 읽지않은 수 카운트
	@ResponseBody
	@PostMapping("RequestUnreadCount")
	public int requestUnreadCount(HttpSession session) {
		return chatService.getTotalUnReadCount((String)session.getAttribute("sId"));
	}
	
}
