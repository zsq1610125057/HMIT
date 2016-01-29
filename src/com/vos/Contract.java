package com.vos;

public class Contract {
private int contId;
private int id;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
private int cusId;
private String signDate;
private float  ContMoney;
private String fileDate;
public int getContId() {
	return contId;
}
public void setContId(int contId) {
	this.contId = contId;
}
public int getCusId() {
	return cusId;
}
public void setCusId(int cusId) {
	this.cusId = cusId;
}
public String getSignDate() {
	return signDate;
}
public void setSignDate(String signDate) {
	this.signDate = signDate;
}
public float getContMoney() {
	return ContMoney;
}
public void setContMoney(float contMoney) {
	ContMoney = contMoney;
}
public String getFileDate() {
	return fileDate;
}
public void setFileDate(String fileDate) {
	this.fileDate = fileDate;
}

}
