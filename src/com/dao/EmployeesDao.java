package com.dao;

import java.sql.SQLException;
import java.util.List;

import com.vos.CusSearchVO;
import com.vos.EmpSearchVO;
import com.vos.Employee;
import com.vos.Employees;

public interface EmployeesDao {
public void updateemployees(EmpSearchVO emp)throws SQLException;
}
