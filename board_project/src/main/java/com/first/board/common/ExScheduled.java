package com.first.board.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class ExScheduled {
	
	@Scheduled(cron = "*/10 * * * * *")
	public void exScheduled() throws Exception {
		String url = "jdbc:oracle:thin:@112.220.63.3:1521:xe";
        //project는 db명으로 mysql에 미리 생성해놓는다.
		// serverTimezone=UTC 서버의 시간을 설정 UTC(Coordinated Universal Time:세계 협정시)
		// localhost라고 적은 부분은 현재 자신의 컴퓨터가 데이터베이스가 설치된 서버라는 의미의 루프백 IP주소이다.
		// 루프백 IP 주소로는 127.0.0.1도 사용할 수 있다.
		// 3306은 MySQL의 포트 번호이다.
		String id = "PROJOB";
		String pw = "projob";  //보통은 이런 슈퍼유저아이디를 입력하진 않음
		//변수 안만들고 인수에 바로 집어넣어도되긴함
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			// 데이터베이스와 연결하는 드라이버 클래스를 찾아 로드한다.
			conn = DriverManager.getConnection(url, id, pw); 
			// 드라이버서버에 접속할수 있는 커넥션객체를 가져옴. 연결을 관리하는 Connection 객체를 생성한다.
			System.out.println("Connection 객체 생성 성공");
			
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			
			String sql = "select * from\r\n"
					+ "			(select u_date, count(*) u_no from (select us_date, to_char(us_date, 'mm') u_date from prouser where us_ok = 0 and us_date between (select add_months(sysdate, -3) from dual) and (select sysdate from dual)) group by u_date ) a\r\n"
					+ "			full join\r\n"
					+ "			(select u_date, count(*) u_ok from (select us_date, to_char(us_date, 'mm') u_date from prouser where us_ok = 1 and us_date between (select add_months(sysdate, -3) from dual) and (select sysdate from dual)) group by u_date) b\r\n"
					+ "			using(u_date) order by u_date";
			ArrayList<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			try {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("u_date", rs.getObject("u_date"));
					map.put("u_no", rs.getObject("u_no"));
					map.put("u_ok", rs.getObject("u_ok"));
					result.add(map);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				System.out.println(result);
				rs.close();
				pstmt.close();
			}
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로드 실패");
		} catch (SQLException e) {
			System.out.println("Connection 객체 생성 실패");
		} finally {
			try {
				if(conn != null)
					conn.close();
				// Connection 객체를 닫는다. 사용된 리소스같은것들을 colse메소드가 해제해줌
			} catch (SQLException e) {
				System.out.println("conn.close() 에러");
			}
		}
		
		
	}

}
