package com.itwillbs.project_fundizzy.handler;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

public class FileHandler {
	// 파일 업로드에 사용될 실제 업로드 디렉토리 경로를 리턴하는 메서드
	public static String getRealPath(HttpSession session, String virtualPath) {
		return session.getServletContext().getRealPath(virtualPath);
	}
	
	// 전송된 원본 파일명에 대한 파일명 중복 방지 처리
	public static String processDuplicateFileNames(String originalFilename) {
		// 중복방지를 위해 UUID 8자리 결합
		String uuid = UUID.randomUUID().toString().substring(0, 8);
		// 확장자 추출
		String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
		
		return System.currentTimeMillis() + "_" + uuid + fileExtension;
	}
	
	// --------------------------------------------------------------------------------
	// 썸네일 이미지 생성하는 메서드
	public static String createThumbnailImage(String realPath, String uploadFileName) {
		String thumbnailFileName = "";
		
		// 업로드 된 파일명 앞에 "thumb_" 문자열 추가
		StringBuffer sb = new StringBuffer(uploadFileName);
		sb.insert(sb.lastIndexOf("/") + 1, "thumb_");
		
		// 입출력 스트림을 활용하여 썸네일 이미지 파일 생성하기
		// 1) File 객체를 생성하여 원본 파일 객체 생성
		File file = new File(realPath, uploadFileName);
		
		// 2) File 객체를 생성하여 출력 파일 객체 생성
		File thumbnailFile = new File(realPath, sb.toString());
		
		// 3) FileInputStream, FileOutputStream 객체를 생성
		//    => try ~ recoures 블록 형태로 스트림 객체 반환까지 자동으로 처리
		try(FileInputStream fis = new FileInputStream(file);
				FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
			// 4) 썸네일 생성 전 File 객체를 java.awt.BufferedImage 객체로 변환하여 이미지 사이즈 알아내기
			// => 주의! 최근 이클립스 버전들은 java.awt 패키지가 정상적으로 접근되지 않으므로 추가 설정 필요
			// => Window 메뉴 - Preferences - Java - Appearance - Type Filters 항목에서 java.awt 항목 체크 해제
			BufferedImage bufferedImage = ImageIO.read(fis);
			int width = bufferedImage.getWidth();
			int height = bufferedImage.getHeight();
			
			// 5) 이미지 사이즈인 가로, 세로 중 한 쪽이라고 150px 보다 클 경우
			//    썸네일 이미지 크기를 150, 150 으로 설정하고, 아니면 기본 사이즈 그대로 사용
			if(width > 100 || height > 100) {
				width = 100;
				height = 100;
			}
			
			// 6) Thumbnailator 클래스의 static 메서드 createThumbnail() 메서드 호출하여
			//    1번과 2번에서 생성한 파일을 대상으로 썸네일 이미지 생성
			//    => 이 과정에서 FileOutputStream 객체로 관리되는 파일이 실제 파일로 출력됨
			Thumbnailator.createThumbnail(file, thumbnailFile, width, height);
			// => width, height 로 전달한 값에 맞게 무조건 크기가 조절되는 것이 아니라
			//    이미지 비율에 맞게 자동으로 크기 조절됨
			//    ex) 450 * 300 일 때 150 * 150 이 아닌 150 * 100 으로 변환됨
			
			// 7) 생성된 썸네일 파일명을 변수에 저장
			thumbnailFileName = sb.toString();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return thumbnailFileName;
	}
}