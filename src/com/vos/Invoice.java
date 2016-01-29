package com.vos;

public class Invoice {
private String invId;
private float invMoney;
private String invContent;
private String invType;
private String invDate;
private String invRemarks;
private int proId;
private float proMoney;
private String proName;
private float remainingSum;

public float getRemainingSum() {
	return remainingSum;
}
public void setRemainingSum(float remainingSum) {
	this.remainingSum = remainingSum;
}
public String getProName() {
	return proName;
}
public void setProName(String proName) {
	this.proName = proName;
}
public float getProMoney() {
	return proMoney;
}
public void setProMoney(float proMoney) {
	this.proMoney = proMoney;
}
public String getInvId() {
	return invId;
}
public void setInvId(String invId) {
	this.invId = invId;
}
public float getInvMoney() {
	return invMoney;
}
public void setInvMoney(float invMoney) {
	this.invMoney = invMoney;
}
public String getInvContent() {
	return invContent;
}
public void setInvContent(String invContent) {
	this.invContent = invContent;
}
public String getInvType() {
	return invType;
}
public void setInvType(String invType) {
	this.invType = invType;
}
public String getInvDate() {
	return invDate;
}
public void setInvDate(String invDate) {
	this.invDate = invDate;
}
public String getInvRemarks() {
	return invRemarks;
}
public void setInvRemarks(String invRemarks) {
	this.invRemarks = invRemarks;
}
public int getProId() {
	return proId;
}
public void setProId(int proId) {
	this.proId = proId;
}


}
