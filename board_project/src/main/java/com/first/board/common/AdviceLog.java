package com.first.board.common;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

@Component
@Aspect
public class AdviceLog {
	private static final Logger logger = LoggerFactory.getLogger(AdviceLog.class);
	
	@Pointcut("execution(public * com.first.board..*Dao.*(..))")
	public void commonDaoPointCut() {}
	@Pointcut("execution(public * com.first.board..*Service.*(..))")
	public void commonServicePointCut() {}
	@Pointcut("execution(public * com.first.board..*Controller.*(..))")
	public void commonControllerPointCut() {}
	
	@Around("commonDaoPointCut()")
	public Object aroundLogMethod(ProceedingJoinPoint pjp) throws Throwable {
		Object ro = null;  // 타겟메소드로부터 return 받은 값을 저장
		
//		System.out.println("\t\t["+pjp.getTarget()+":"+pjp.getSignature().getName()+"]");
		logger.debug("\t\t["+pjp.getTarget()+":"+pjp.getSignature().getName()+"]");
		// 타겟메소드로 전달되는 매개인자들
		Object[] args = pjp.getArgs();
		for(int i=0; i<args.length; i++) {
//			System.out.print("\t\t--args["+i+"] "+args[i] +"\n");
			logger.debug("\t\t--args["+i+"] "+args[i]);
		}	
		
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		// 타겟메소드 실행
		ro = pjp.proceed();
		
		stopWatch.stop();
		
		// 타겟메소드의 return 값
//		System.out.println("\t\t[DAO Ret:"+stopWatch.getTotalTimeMillis()+"ms] "+ ro);
		logger.debug("\t\t[DAO Ret:"+stopWatch.getTotalTimeMillis()+"ms] "+ ro);
		
		return ro;
	}
	@Around("commonControllerPointCut()")
	public Object aroundLogCtrlMethod(ProceedingJoinPoint pjp) throws Throwable {
		Object ro = null;  // 타겟메소드로부터 return 받은 값을 저장
		
//		System.out.println("\t\t["+pjp.getTarget()+":"+pjp.getSignature().getName()+"]");
		logger.debug("\t["+pjp.getTarget()+":"+pjp.getSignature().getName()+"]");
		// 타겟메소드로 전달되는 매개인자들
		Object[] args = pjp.getArgs();
		for(int i=0; i<args.length; i++) {
//			System.out.print("\t\t--args["+i+"] "+args[i] +"\n");
			logger.debug("\t--args["+i+"] "+args[i]);
		}	
		
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		// 타겟메소드 실행
		ro = pjp.proceed();
		
		stopWatch.stop();
		
		// 타겟메소드의 return 값
//		System.out.println("\t\t[DAO Ret:"+stopWatch.getTotalTimeMillis()+"ms] "+ ro);
		logger.debug("\t[CTRL Ret:"+stopWatch.getTotalTimeMillis()+"ms] "+ ro);
		
		return ro;
	}
}
