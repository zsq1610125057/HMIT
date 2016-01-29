package com.dao.imp;

import java.sql.SQLException;

import com.dao.EmployeesLoginDao;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.vos.Employees;

public class EmployeesLoginDaoImp implements EmployeesLoginDao {
	private SqlMapClient sqlMapClient;

	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	public Employees queryById(Employees employees) throws SQLException {
		return (Employees) sqlMapClient.queryForObject("queryById", employees);
	}

}
