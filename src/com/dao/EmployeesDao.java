package com.dao;

import java.sql.SQLException;
import java.util.List;

import com.vos.CusSearchVO;
import com.vos.EmpSearchVO;
import com.vos.Employee;
import com.vos.Employees;
import com.vos.EmployeesVO;

public interface EmployeesDao {
public void updateemployees(EmpSearchVO emp)throws SQLException;

public List<Employees> getAllEmployee(int firstRow, Integer pageSize,
		EmpSearchVO empSearchVO) throws SQLException;
public int getEmployeeCount(EmpSearchVO empSearchVO) throws SQLException;

public List<EmployeesVO> getRoleTypeList() throws SQLException;
public List<Employees> gettitleList() throws SQLException;



public void addEmployee(Employees employee) throws SQLException;
public void editEmployee(Employees employee) throws SQLException;
public void deleteEmployee(int empId) throws SQLException;

}
