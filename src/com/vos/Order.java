package com.vos;

import java.util.Date;

public class Order {

	private float money;
	private int ordId;//订单id，主键
	private int proId;//项目id
	private String proName;	
	private String equName;//设备名称和ordId作为联合主键
	private String equDescription;
	private int equNumber;
	private float costUnitPrice;
	private float costPrice;
	private int supId;//供应商id
	private String supName;
	private float sellPrice;
	private String status;
	private String payRemarks;
	private String lastUpdateBy;
	private String lastUpdateDate;
	private String action;
	private String payWay;
	private String payDate;
	private float sellTotalPrice;
	private float diff;
	private String remarks;
	private String ifWholeSale;
	private String arrivalTime;
	public float getMoney() {
		return money;
	}
	public void setMoney(float money) {
		this.money = money;
	}
	public String getArrivalTime() {
		return arrivalTime;
	}
	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
	private float payables;
	public float getPayables() {
		return payables;
	}
	public void setPayables(float payables) {
		this.payables = payables;
	}
	public String getInvId() {
		return invId;
	}
	public void setInvId(String invId) {
		this.invId = invId;
	}
	private String invId;
	
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getLastUpdateBy() {
		return lastUpdateBy;
	}
	public void setLastUpdateBy(String lastUpdateBy) {
		this.lastUpdateBy = lastUpdateBy;
	}
	public String getLastUpdateDate() {
		return lastUpdateDate;
	}
	public void setLastUpdateDate(String lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}
	public String getPayRemarks() {
		return payRemarks;
	}
	public void setPayRemarks(String payRemarks) {
		this.payRemarks = payRemarks;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public float getSellPrice() {
		return sellPrice;
	}
	public void setSellPrice(float sellPrice) {
		this.sellPrice = sellPrice;
	}
	public String getSupName() {
		return supName;
	}
	public void setSupName(String supName) {
		this.supName = supName;
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
	public String getEquName() {
		return equName;
	}
	public void setEquName(String equName) {
		this.equName = equName;
	}
	public String getEquDescription() {
		return equDescription;
	}
	public void setEquDescription(String equDescription) {
		this.equDescription = equDescription;
	}
	public int getEquNumber() {
		return equNumber;
	}
	public void setEquNumber(int equNumber) {
		this.equNumber = equNumber;
	}
	public float getCostUnitPrice() {
		return costUnitPrice;
	}
	public void setCostUnitPrice(float costUnitPrice) {
		this.costUnitPrice = costUnitPrice;
	}
	public float getCostPrice() {
		return costPrice;
	}
	public void setCostPrice(float costPrice) {
		this.costPrice = costPrice;
	}
	public int getSupId() {
		return supId;
	}
	public void setSupId(int supId) {
		this.supId = supId;
	}
	public String getPayWay() {
		return payWay;
	}
	public void setPayWay(String payWay) {
		this.payWay = payWay;
	}
	public String getPayDate() {
		return payDate;
	}
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}
	public float getSellTotalPrice() {
		return sellTotalPrice;
	}
	public void setSellTotalPrice(float sellTotalPrice) {
		this.sellTotalPrice = sellTotalPrice;
	}
	public float getDiff() {
		return diff;
	}
	public void setDiff(float diff) {
		this.diff = diff;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getIfWholeSale() {
		return ifWholeSale;
	}
	public void setIfWholeSale(String ifWholeSale) {
		this.ifWholeSale = ifWholeSale;
	} 
	
	
	
}
