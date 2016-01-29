package com.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dao.CustomerDao;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapException;
import com.vos.CusSearchVO;
import com.vos.Customer;

public class CustomerDaoImp implements CustomerDao {
	private SqlMapClient sqlMapClient;

	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

//	@SuppressWarnings("unchecked")
//	@Override
//	public List<Customer> getAllCustomer() throws SQLException {
//		// TODO Auto-generated method stub
//		
//		return sqlMapClient.queryForList("getAllCustomer");
//		
//	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Customer> getCustomer(Customer customer) throws SQLException {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("getCustomer");
	}

	@Override
	public void deleteCustomer(int cusId) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.delete("deleteCustomer",cusId);
	}

	@Override
	public void editCustomer(Customer customer)throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.update("editCustomer",customer);
	}

	@Override
	public void addCustomer(Customer customer) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.insert("addCustomer",customer);
	}

//	@SuppressWarnings("unchecked")
//	@Override
//	public List<Customer> getAllCustomer(int firstRow, Integer pageSize)
//			throws SQLException {
//		// TODO Auto-generated method stub
//		return sqlMapClient.queryForList("getAllCustomer",firstRow,pageSize);
//	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Customer> getCustomer(int firstRow, Integer pageSize,Customer customer) throws SQLException {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("getCustomer",firstRow,pageSize);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Customer> getAllCustomer(int firstRow, Integer pageSize,
			CusSearchVO cusSearchVO) throws SQLException {
		try{
			Map<String,Object> map = new HashMap<String, Object>();
			List<Customer> list = new ArrayList<Customer>();
			map.put("comName", cusSearchVO.getCompName());
			map.put("cusName", cusSearchVO.getCusName());
			map.put("contact", cusSearchVO.getContact());
			map.put("address", cusSearchVO.getAddress());
			map.put("beginMoney", cusSearchVO.getBeginMoney());
			map.put("endMoney", cusSearchVO.getEndMoney());
			map.put("empId", cusSearchVO.getEmpName());
			map.put("firstRow",firstRow);
			map.put("pageSize",pageSize);
			
			list = sqlMapClient.queryForList("getAllCustomer",map);
			return list;

		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
		// TODO Auto-generated method stub
	}

	@Override
	public int getCustomerCount(CusSearchVO cusSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		int in=(Integer) sqlMapClient.queryForObject("getCustomerCount",cusSearchVO);
		return in;
	}


	


}
