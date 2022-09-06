package com.first.board.common;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class ExScheduled {
	
	@Scheduled(cron = "1 * * * * ?")
	public void exScheduled() throws Exception {
		System.out.println("????");
	}

}
