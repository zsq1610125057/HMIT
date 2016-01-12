package com.vos;

import java.sql.Timestamp;




public class Employee {
	private int empId;
	private String empName;
	private String password;
	private Timestamp regDate;
	private Timestamp lastLoginDate;
	private String email;
	private String contact;
	private String loginName;
	private int roleId;
	private String title;
	private String regDate1;
	private String lastLoginDate1;
	
	
	public String getRegDate1() {
		return regDate1;
	}

	public void setRegDate1(String regDate1) {
		this.regDate1 = regDate1;
	}

	public String getLastLoginDate1() {
		return lastLoginDate1;
	}

	public void setLastLoginDate1(String lastLoginDate1) {
		this.lastLoginDate1 = lastLoginDate1;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public Timestamp getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Timestamp lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

//	@Override
//	public String toString() {
//		return "Employees [empId=" + empId + ", empName=" + empName + ", password=" + password + ", regDate=" + regDate
//				+ ", lastLoginDate=" + lastLoginDate + ", email=" + email + ", contact=" + contact + ", loginName="
//				+ loginName + ", roleId=" + roleId + "]";
//	}
//	
	
}
