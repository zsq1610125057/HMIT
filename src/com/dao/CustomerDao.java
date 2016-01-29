package com.dao;

import java.sql.SQLException;
import java.util.List;


import com.vos.CusSearchVO;
import com.vos.Customer;

public interface CustomerDao {
	//public List<Customer> getAllCustomer() throws SQLException;

	public List<Customer> getCustomer(Customer customer) throws SQLException;

	public void deleteCustomer(int cusId) throws SQLException;

	public void editCustomer(Customer customer) throws SQLException;

	public void addCustomer(Customer customer) throws SQLException;

	//public List<Customer> getAllCustomer(int firstRow, Integer pageSize) throws SQLException;

	public List<Customer> getCustomer(int firstRow, Integer pageSize,
			Customer customer) throws SQLException;

	public List<Customer> getAllCustomer(int firstRow, Integer pageSize,
			CusSearchVO cusSearchVO) throws SQLException;

	public int getCustomerCount(CusSearchVO cusSearchVO) throws SQLException;

}
