package com.cd.autoTest.util;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class ExcelUtil {
	Logger log = LoggerFactory.getLogger(super.getClass());
	private static ExcelUtil excelUtil;
	private String localFilePath;
	private String serverFolderPath;
	private String serverFilePath;
	private SXSSFWorkbook wb;
	private Sheet sheet;
	private File file;
	private int rownum;
	public static ExcelUtil getInstance() {
		if (excelUtil == null) {
			excelUtil = new ExcelUtil();
		}
		return excelUtil;
	}

	
	public SXSSFWorkbook init(){
		wb = new SXSSFWorkbook();
		return wb;
	}
	

	public void createSheet(String sheetName) {
		try {
			boolean flag = false;
			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				if (sheetName.equals(wb.getSheetName(i))) {
					sheet = wb.getSheetAt(i);
					flag = true;
				}
			}
			if (!flag) {
				sheet = wb.createSheet(sheetName);
				this.setRownum(0);
			}
			for (int i = 0; i < 5; i++) {
				sheet.setColumnWidth(i, 8000);
			}
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Row addRow() {
		try {
			Row row = sheet.createRow(rownum);
			row.setHeight((short) 450);
			rownum++;
			return row;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}
	public Row addRow(int height) {
		try {
			Row row = sheet.createRow(rownum);
			row.setHeight((short) height);
			rownum++;
			return row;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}
	public Cell addCell(Row row, int column, String value) {
		try {
			Cell cell = row.createCell(column);
			cell.setCellValue(value);
			return cell;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}
	public Cell addCell(Row row, int column, Object value) {
		try {
			
			Cell cell = row.createCell(column);
			if(value instanceof String){
				String s=(String)value;
				cell.setCellValue(s);
			}
			if(value instanceof HSSFRichTextString){
				HSSFRichTextString s=(HSSFRichTextString)value;
				cell.setCellValue(s);
			}
			return cell;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	public void addMergeRegion(String value) {
		CellRangeAddress cra = new CellRangeAddress(rownum, rownum, 0, 2);
		RegionUtil.setBorderBottom(CellStyle.BORDER_THIN, cra, sheet, wb);
		RegionUtil.setBorderLeft(CellStyle.BORDER_THIN, cra, sheet, wb);
		RegionUtil.setBorderRight(CellStyle.BORDER_THIN, cra, sheet, wb);
		RegionUtil.setBorderTop(CellStyle.BORDER_THIN, cra, sheet, wb);
		sheet.addMergedRegion(cra);
		Row row = sheet.getRow(rownum);
		row.setHeight((short) 450);
		Cell cell = this.addCell(row, 0, value);
		CellStyle cellStyle = this.createStyle(0);
		cell.setCellStyle(cellStyle);
		rownum++;
	}

	public void writeExcel() {
		try {
			FileOutputStream os = new FileOutputStream(file);
			wb.write(os);
			os.flush();
			os.close();
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void copyFile() {
		File file = new File(localFilePath);
		File serverFolder = new File(serverFolderPath);
		if (!serverFolder.exists()) {
			serverFolder.mkdirs();
		}
		File serverFile = new File(serverFilePath);
		try {
			FileUtils.copyFile(file, serverFile);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	/**
	 * i为0则为title，否则为内容
	 * 
	 * @param i
	 * @return
	 */
	public CellStyle createStyle(int i) {
		try {
			CellStyle style = wb.createCellStyle();
			if (i == 0) {
				style.setFillForegroundColor(IndexedColors.DARK_RED.getIndex());// 设置背景色
				style.setFillPattern(CellStyle.SOLID_FOREGROUND);
			}
			Font title = this.createFont(i);
			style.setFont(title);
			style.setBorderBottom(CellStyle.BORDER_THIN); // 下边框
			style.setBorderLeft(CellStyle.BORDER_THIN);// 左边框
			style.setBorderTop(CellStyle.BORDER_THIN);// 上边框
			style.setBorderRight(CellStyle.BORDER_THIN);// 右边框
			style.setAlignment(CellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);// 垂直居中
			return style;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	/**
	 * i为0则为title，否则为内容
	 * 
	 * @param i
	 * @return
	 */
	public Font createFont(int i) {
		try {
			Font font = wb.createFont();
			if (i == 0) {
				font.setColor(HSSFColor.WHITE.index);// HSSFColor.VIOLET.index
														// //字体颜色
				font.setFontHeightInPoints((short) 11);
				font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			} else {
				font.setColor(HSSFColor.BLACK.index);// HSSFColor.VIOLET.index
														// //字体颜色
				font.setFontHeightInPoints((short) 10);
			}

			return font;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	public void init(String fileName) {
		this.setRownum(0);
	}

	public void createRow(int i, String[] valueList) {
		try {
			Row row = this.addRow();
			Cell cell = null;
			CellStyle style = null;
			for (int j = 0; j < valueList.length; j++) {
				cell = this.addCell(row, j, valueList[j]);
				style = this.createStyle(i);
				style.setWrapText(true);     
				cell.setCellStyle(style);
			}
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void createRow(int i, int height,Object[] valueList) {
		try {
			Row row = this.addRow(height);
			Cell cell = null;
			CellStyle style = null;
			for (int j = 0; j < valueList.length; j++) {
				cell = this.addCell(row, j, valueList[j]);
				style = this.createStyle(i);
				style.setWrapText(true);     
				cell.setCellStyle(style);
			}
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void createRow(int i, String checkName, String pageValue, String expectValue) {
		try {
			String[] valueList = new String[4];
			valueList[0] = checkName;
			valueList[1] = pageValue;
			valueList[2] = expectValue;
			valueList[3] = pageValue.equals(expectValue) ? "一致" : "不一致";
			this.createRow(i, valueList);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}




	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	public String getServerFilePath() {
		return serverFilePath;
	}

	public void setServerFilePath(String serverFilePath) {
		this.serverFilePath = serverFilePath;
	}

}
