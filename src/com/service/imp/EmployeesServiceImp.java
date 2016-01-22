package com.service.imp;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.EmployeesDao;
import com.dao.EmployeesLoginDao;
import com.service.EmployeesService;
import com.vos.EmpSearchVO;
import com.vos.Employee;
import com.vos.Employees;

@Service("employeesService")
public class EmployeesServiceImp implements EmployeesService{
	@Resource(name = "employeesLoginDao")
	private EmployeesLoginDao employeesLoginDao;
	@Resource(name = "employeesDao")
	private EmployeesDao employeesDao;
	
	
	public EmployeesDao getEmployeesDao() {
		return employeesDao;
	}

	public void setEmployeesDao(EmployeesDao employeesDao) {
		this.employeesDao = employeesDao;
	}

	public EmployeesLoginDao getEmployeesLoginDao() {
		return employeesLoginDao;
	}

	public void setEmployeesLoginDao(EmployeesLoginDao employeesLoginDao) {
		this.employeesLoginDao = employeesLoginDao;
	}

	public Employees queryById(Employees employees) throws SQLException{
		return employeesLoginDao.queryById(employees) ;
	}

	public void updateemployees(EmpSearchVO emp) throws SQLException {
		employeesDao.updateemployees(emp);
	}
}
