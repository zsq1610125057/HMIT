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
import com.vos.Employees;
import com.vos.EmployeesVO;

public class EmployeesDaoImp implements EmployeesDao {
	private SqlMapClient sqlMapClient;

	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<EmployeesVO> getRoleTypeList() throws SQLException {
		// TODO Auto-generated method stub
				try {
					return sqlMapClient.queryForList("getRoleTypeList");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return null;
			}
	@SuppressWarnings("unchecked")
	@Override
	public List<Employees> gettitleList() throws SQLException {
		// TODO Auto-generated method stub
		try {
			return sqlMapClient.queryForList("gettitleList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Employees> getAllEmployee(int firstRow, Integer pageSize,
			EmpSearchVO empSearchVO) throws SQLException {
		try{
			Map<String,Object> map = new HashMap<String, Object>();
			List<Employees> list = new ArrayList<Employees>();
			map.put("title", empSearchVO.getTitle());
			map.put("RoleType", empSearchVO.getRoleType());
			map.put("firstRow",firstRow);
			map.put("pageSize",pageSize);
		
			list = sqlMapClient.queryForList("getAllEmployee",map);
			return list;

		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
		// TODO Auto-generated method stub
	}
	@Override
	public int getEmployeeCount(EmpSearchVO empSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) sqlMapClient.queryForObject("getEmployeeCount",empSearchVO);
	}

	@Override
	public void addEmployee(Employees employee) throws SQLException {
		// TODO Auto-generated method stub
		employee.setPassword("1234");
		sqlMapClient.insert("addEmployee",employee);
	}

	@Override
	public void editEmployee(Employees employee) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.insert("editEmployee",employee);
	}

	@Override
	public void deleteEmployee(int empId) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.delete("deleteEmployee",empId);
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
	
}
