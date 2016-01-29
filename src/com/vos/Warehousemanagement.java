package com.vos;

public class Warehousemanagement {
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private int stock;
	private String equName;
	private String outWarehouseDate;
	private String brokerage;
	private int outWarehouseNumber;
	private int wMId;

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getEquName() {
		return equName;
	}

	public void setEquName(String equName) {
		this.equName = equName;
	}

	public String getOutWarehouseDate() {
		return outWarehouseDate;
	}

	public void setOutWarehouseDate(String outWarehouseDate) {
		this.outWarehouseDate = outWarehouseDate;
	}

	public String getBrokerage() {
		return brokerage;
	}

	public void setBrokerage(String brokerage) {
		this.brokerage = brokerage;
	}

	public int getOutWarehouseNumber() {
		return outWarehouseNumber;
	}

	public void setOutWarehouseNumber(int outWarehouseNumber) {
		this.outWarehouseNumber = outWarehouseNumber;
	}

	public int getwMId() {
		return wMId;
	}

	public void setwMId(int wMId) {
		this.wMId = wMId;
	}
}
