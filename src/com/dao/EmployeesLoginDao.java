package com.dao;

import java.sql.SQLException;

import com.vos.Employees;

public interface EmployeesLoginDao {
	public Employees queryById(Employees employees) throws SQLException;
}
