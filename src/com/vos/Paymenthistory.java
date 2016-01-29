package com.vos;

public class Paymenthistory {
private int pHId;
private int ordId;
private int proId;
private float paidMoney;
private String paidDate;
private String payRemarks;
private float remainingSum;
private String payWay;
private String pWName;
private String proName;

public String getProName() {
	return proName;
}
public void setProName(String proName) {
	this.proName = proName;
}
public String getpWName() {
	return pWName;
}
public void setpWName(String pWName) {
	this.pWName = pWName;
}
public String getPayWay() {
	return payWay;
}
public void setPayWay(String payWay) {
	this.payWay = payWay;
}
public int getpHId() {
	return pHId;
}
public void setpHId(int pHId) {
	this.pHId = pHId;
}
public int getOrdId() {
	return ordId;
}
public void setOrdId(int ordId) {
	this.ordId = ordId;
}
public int getProId() {
	return proId;
}
public void setProId(int proId) {
	this.proId = proId;
}
public float getPaidMoney() {
	return paidMoney;
}
public void setPaidMoney(float paidMoney) {
	this.paidMoney = paidMoney;
}
public String getPaidDate() {
	return paidDate;
}
public void setPaidDate(String paidDate) {
	this.paidDate = paidDate;
}
public String getPayRemarks() {
	return payRemarks;
}
public void setPayRemarks(String payRemarks) {
	this.payRemarks = payRemarks;
}
public float getRemainingSum() {
	return remainingSum;
}
public void setRemainingSum(float remainingSum) {
	this.remainingSum = remainingSum;
}

}
