package com.first.board.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.first.board.board.service.BoardService;

@Controller
public class PoiController {
	
	@Autowired
	private BoardService service;
	
	@PostMapping("/poiExcel")
	public void poiExcel (
			@RequestParam(value = "s_title", required = false) String s_title,
			@RequestParam(value = "s_content", required = false) String s_content,
			@RequestParam(value = "k_no", required = false) String k_no,
			Model model, 
			HttpServletResponse response,
			HttpServletRequest request
			) throws Exception{
		
		if(s_title=="") {
			s_title = null;
		}
		if(s_content=="") {
			s_content = null;
		}
		if(k_no=="") {
			k_no = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("s_title", s_title);
		map.put("s_content", s_content);
		map.put("k_no", k_no);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		if(k_no == null && s_title == null) {
			list = service.poiExcel();
		} else if (k_no != null && s_title == null) {
			list = service.poiExcelKind(map);
		} else if (k_no == null && s_title != null) {
			list = service.poiExcelSearch(map);
		} else {
			list = service.poiExcelKindSearch(map);
		}

		/*
		실제로는 DB 데이터를 추출하는 경우가 많기 때문에 날짜데이터를 예시로 든다면.
		웹에서 사용자가 day1 과 day2 를 넘겨주고. 컨트롤러에서 service로 데이터를 넘기고.
		dao에서 mapper를 통해  day1 과 day2 날짜 사이의 데이터들을 출력할 것이다.
		그 데이터들은 list 에 담아서 활용한다고 가정해보자 !
		 */

		Workbook wb = new HSSFWorkbook(); // 엑셀파일 객체 생성
		Sheet sheet = wb.createSheet("이안excel"); //시트 생성 ( 첫번째 시트이며, 시트명은 테스트 시트 )
		
		CellStyle style = wb.createCellStyle(); // 셀 스타일 생성
		Font font = wb.createFont(); // 폰트 스타일 생성
		
        font.setBoldweight(Font.BOLDWEIGHT_BOLD); // 글자 진하게
        font.setFontHeight((short)(16*18)); // 글자 크기
        font.setFontName("맑은 고딕"); // 글씨체
        
        // 자바의 배열처럼 첫번째 인덱스가 0 부터 시작한다.  첫번째는 0 , 두번째는 1 , 세번째는 2
        Row titleRow = sheet.createRow(0); // 타이틀행을 생성한다. 첫번째줄이기때문에 createRow(0)
        int titleColNum = 0; // 첫번째 열이기 때문에 0 
		Cell titleCell = titleRow.createCell(titleColNum); // 첫번째행의 첫번째열을 지정한다. 
		titleCell.setCellValue("이안소프트 게시판 프로젝트"); // setCellValue 셀에 값넣기.
		titleRow.setHeight((short)920); // Row에서 setHeight를 하면 행 높이가 조정된다. 
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,9)); // 셀 병합  첫번째줄~아홉번째 열까지 병합 
		// new CellRangeAddress(시작 row, 끝 row, 시작 col, 끝 col) 

		style.setWrapText(true); //문자열을 입력할때 \n 같은 개행을 인식해준다.
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); // 수직 가운데 정렬
		style.setAlignment(CellStyle.ALIGN_CENTER); // 수평 가운데 정렬
		style.setFont(font); // 스타일에 font 스타일 적용하기
		titleCell.setCellStyle(style); // 정리한 스타일들을 titleCell에 적용해주자 !
		
		//헤더 만들기
		Row headerRow = sheet.createRow(3); // 네번째줄 생성
		int headerCol = 0;
		Cell headerCell = headerRow.createCell(headerCol++);
		headerCell.setCellValue("글 번호");
		headerCell = headerRow.createCell(headerCol++);
		headerCell.setCellValue("글 종류");
		headerCell = headerRow.createCell(headerCol++);
		headerCell.setCellValue("글 제목");
		headerCell = headerRow.createCell(headerCol++);
		headerCell.setCellValue("첨부파일");
		headerCell = headerRow.createCell(headerCol++);
		headerCell.setCellValue("작성자");
		headerCell = headerRow.createCell(headerCol++);
		headerCell.setCellValue("작성일");
		headerCell = headerRow.createCell(headerCol++);
		headerCell.setCellValue("조회수");

		
		
		CellStyle dataStyle = wb.createCellStyle(); // 데이터스타일은 테두리를 만들어보자
		
		dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); //오른쪽 테두리
		dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); //왼쪽 테두리
		dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); // 상단 테두리
		dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 하단 테두리
		
		
		//데이터 삽입하기
		int rowNum = 4; // 세번째줄이 헤더니까 그 밑에서부터 데이터 삽입
		Row dataRow = null; // for문을 돌려주기위해.
		Cell dataCell = null;
		
		for(int i = 0; i<list.size(); i++) {
			int cellNum = 0;
			cellNum = 0;
			dataRow = sheet.createRow(rowNum++); // for문 돌면서 행 1줄씩 추가
			
			dataCell = dataRow.createCell(cellNum++); //열 한줄씩 추가
			dataCell.setCellValue(String.valueOf(list.get(i).get("B_NO"))); // 첫번째칸은 순번이기때문에 
			dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용
			
			dataCell = dataRow.createCell(cellNum++); // 두번째 열은 이름이니까
			dataCell.setCellValue((String)list.get(i).get("K_TITLE")); // list에 저장된 이름 출력
			dataCell.setCellStyle(dataStyle); // 테두리 스타일 적용
			
			dataCell = dataRow.createCell(cellNum++); // 
			dataCell.setCellValue((String)list.get(i).get("B_TITLE")); // list에 저장된 이름 출력
			dataCell.setCellStyle(dataStyle); // 테두리 스타일 적
			
			dataCell = dataRow.createCell(cellNum++); // 
			dataCell.setCellValue(String.valueOf(list.get(i).get("NVL(F_COUNT,0)"))); // list에 저장된 이름 출력
			dataCell.setCellStyle(dataStyle); // 테두리 스타일 적
			
			dataCell = dataRow.createCell(cellNum++); // 
			dataCell.setCellValue((String)list.get(i).get("M_NAME")); // list에 저장된 이름 출력
			dataCell.setCellStyle(dataStyle); // 테두리 스타일 적
			
			dataCell = dataRow.createCell(cellNum++); // 
			dataCell.setCellValue((String)list.get(i).get("B_DATE")); // list에 저장된 이름 출력
			dataCell.setCellStyle(dataStyle); // 테두리 스타일 적
			
			dataCell = dataRow.createCell(cellNum++); // 
			dataCell.setCellValue(String.valueOf(list.get(i).get("B_COUNT"))); // list에 저장된 이름 출력
			dataCell.setCellStyle(dataStyle); // 테두리 스타일 적
		}
		
		dataRow = sheet.createRow(rowNum++); // 총 인원을 작성해보자
		dataCell = dataRow.createCell(0); // 첫번쨰칸
		dataCell.setCellValue("총 : "+list.size());
		dataCell = dataRow.createCell(1); // 두번쨰칸
		
		
		 /* 엑셀 파일 생성 */
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=EanExcel.xls");
	    wb.write(response.getOutputStream());
	}

}
