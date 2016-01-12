package com.service;

import java.sql.SQLException;
import java.util.List;

import com.vos.EmpSearchVO;
import com.vos.Employee;
import com.vos.Employees;

public interface EmployeesService {
	public Employees queryById(Employees employees) throws SQLException;
	public void updateemployees(EmpSearchVO emp) throws SQLException;
	public List<Employee> getAllEmployee(int firstRow, Integer pageSize,EmpSearchVO emp) throws SQLException;
	public int getEmployeesCount() throws SQLException;
}
