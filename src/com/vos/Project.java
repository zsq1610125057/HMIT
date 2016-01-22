package com.vos;

import java.util.Date;

public class Project {
	
	private int id;
	private int proId;
	
	private String proName;
	private String proType;
	private float proMoney;
	private int cusId;//客户
	private String cusName;
	private String proBrokerage;//经手人
	private String recevablesDate;//应收时间
	private String deliveredDate;//收回时间
	private String delayDes;//延迟说明
	private String remarks;
	private String conId;//合同编号
	private String signDate;//项目签订时间
	private String beginDate;//项目开始时间
	private String ifInv;//是否开票
	private String ifContract;//是否合同
	private String ifAccessories;//是否配件
	private String ifMigAgent;//过单项目
	private String status;
	private String proProgress;
	private String lastUpdateBy;
	private String receivablesDate;
	private String completedDate;
	private String completedDescription;
	private String factRecevablesDate;
	private String pTName;
	
	public int getProId() {
		return proId;
	}
	public void setProId(int proId) {
		this.proId = proId;
	}
	public String getpTName() {
		return pTName;
	}
	public void setpTName(String pTName) {
		this.pTName = pTName;
	}
	public String getCusName() {
		return cusName;
	}
	public void setCusName(String cusName) {
		this.cusName = cusName;
	}
	public int getCusId() {
		return cusId;
	}
	public void setCusId(int cusId) {
		this.cusId = cusId;
	}
	
	
	public String getReceivablesDate() {
		return receivablesDate;
	}
	public void setReceivablesDate(String receivablesDate) {
		this.receivablesDate = receivablesDate;
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
	private String lastUpdateDate;
	public String getProProgress() {
		return proProgress;
	}
	public void setProProgress(String proProgress) {
		this.proProgress = proProgress;
	}
	public String getCompletedDate() {
		return completedDate;
	}
	public void setCompletedDate(String completedDate) {
		this.completedDate = completedDate;
	}
	public String getCompletedDescription() {
		return completedDescription;
	}
	public void setCompletedDescription(String completedDescription) {
		this.completedDescription = completedDescription;
	}
	public String getFactRecevablesDate() {
		return factRecevablesDate;
	}
	public void setFactRecevablesDate(String factRecevablesDate) {
		this.factRecevablesDate = factRecevablesDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getProType() {
		return proType;
	}
	public void setProType(String proType) {
		this.proType = proType;
	}
	public float getProMoney() {
		return proMoney;
	}
	public void setProMoney(float proMoney) {
		this.proMoney = proMoney;
	}
	public String getProBrokerage() {
		return proBrokerage;
	}
	public void setProBrokerage(String proBrokerage) {
		this.proBrokerage = proBrokerage;
	}
	public String getRecevablesDate() {
		return recevablesDate;
	}
	public void setRecevablesDate(String recevablesDate) {
		this.recevablesDate = recevablesDate;
	}
	public String getDeliveredDate() {
		return deliveredDate;
	}
	public void setDeliveredDate(String deliveredDate) {
		this.deliveredDate = deliveredDate;
	}
	public String getDelayDes() {
		return delayDes;
	}
	public void setDelayDes(String delayDes) {
		this.delayDes = delayDes;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getConId() {
		return conId;
	}
	public void setConId(String conId) {
		this.conId = conId;
	}
	public String getSignDate() {
		return signDate;
	}
	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getIfInv() {
		return ifInv;
	}
	public void setIfInv(String ifInv) {
		this.ifInv = ifInv;
	}
	public String getIfContract() {
		return ifContract;
	}
	public void setIfContract(String ifContract) {
		this.ifContract = ifContract;
	}
	public String getIfAccessories() {
		return ifAccessories;
	}
	public void setIfAccessories(String ifAccessories) {
		this.ifAccessories = ifAccessories;
	}
	public String getIfMigAgent() {
		return ifMigAgent;
	}
	public void setIfMigAgent(String ifMigAgent) {
		this.ifMigAgent = ifMigAgent;
	}
	
}
