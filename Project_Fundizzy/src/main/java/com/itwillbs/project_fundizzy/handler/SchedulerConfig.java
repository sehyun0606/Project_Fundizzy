package com.itwillbs.project_fundizzy.handler;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

@Configuration
public class SchedulerConfig {
	
	//스케줄링을 사용하기 위해 빈등록
	@Bean
    public ThreadPoolTaskScheduler taskScheduler() {
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        scheduler.setPoolSize(20); // 동시 실행 가능한 작업 수
        scheduler.initialize();
        return scheduler;
    }
}
