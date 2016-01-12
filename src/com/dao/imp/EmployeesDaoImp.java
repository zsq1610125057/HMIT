package com.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dao.EmployeesDao;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.vos.Customer;
import com.vos.EmpSearchVO;
import com.vos.Employee;

public class EmployeesDaoImp implements EmployeesDao {
	private SqlMapClient sqlMapClient;

	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void updateemployees(EmpSearchVO empSearchVO) throws SQLException {
		try{
			Map<String,Object> map = new HashMap<String, Object>();
			
			map.put("loginName", empSearchVO.getEmpName());
			map.put("password", empSearchVO.getPassword());
			map.put("newpassword", empSearchVO.getNewpassword());
			
			
			 sqlMapClient.update("editEmployees",map);
			

		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> getAllEmployee(int firstRow, Integer pageSize,EmpSearchVO emp) throws SQLException {
		try{
			Map<String,Object> map = new HashMap<String, Object>();
			List<Employee> list = new ArrayList<Employee>();
			map.put("roleId", emp.getRoleId());
			map.put("title", emp.getTitle());
			map.put("firstRow",firstRow);
			map.put("pageSize",pageSize);
			
			list = sqlMapClient.queryForList("getAllEmployee",map);
			return list;

		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int getEmployeesCount() throws SQLException {
		int in=(Integer) sqlMapClient.queryForObject("getEmployeesCount");
		return in;
	}

}
