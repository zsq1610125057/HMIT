package com.vos;

public class ProSearchVO {
private String status;
private String beginDate;
private String signDate;
private String proBrokerage;
private int firstRow;
private int pageSize;
private String pTName;
private String cusId;

public String getCusId() {
	return cusId;
}
public void setCusId(String cusId) {
	this.cusId = cusId;
}
public String getpTName() {
	return pTName;
}
public void setpTName(String pTName) {
	this.pTName = pTName;
}
public int getFirstRow() {
	return firstRow;
}
public void setFirstRow(int firstRow) {
	this.firstRow = firstRow;
}
public int getPageSize() {
	return pageSize;
}
public void setPageSize(int pageSize) {
	this.pageSize = pageSize;
}
public String getStatus() {
	return status;
}
public void setStatus(String status) {
	this.status = status;
}
public String getBeginDate() {
	return beginDate;
}
public void setBeginDate(String beginDate) {
	this.beginDate = beginDate;
}
public String getSignDate() {
	return signDate;
}
public void setSignDate(String signDate) {
	this.signDate = signDate;
}
public String getProBrokerage() {
	return proBrokerage;
}
public void setProBrokerage(String proBrokerage) {
	this.proBrokerage = proBrokerage;
}
}
