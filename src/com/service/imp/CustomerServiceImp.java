package com.service.imp;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.dao.CustomerDao;
import com.service.CustomerService;
import com.vos.CusSearchVO;
import com.vos.Customer;

public class CustomerServiceImp implements CustomerService{
	@Resource(name = "customerDao")
	private CustomerDao customerDao;
	
	public CustomerDao getCustomerDao() {
		return customerDao;
	}
	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}
//	@Override
//	public List<Customer> getAllCustomer() throws SQLException {
//		// TODO Auto-generated method stub
//		return customerDao.getAllCustomer();
//	}

	@Override
	public List<Customer> getCustomer(Customer customer) throws SQLException {
		// TODO Auto-generated method stub
		return customerDao.getCustomer(customer);
	}
	@Override
	public void deleteCustomer(int cusId) throws SQLException {
		// TODO Auto-generated method stub
		customerDao.deleteCustomer(cusId);
	}
	@Override
	public void editCustomer(Customer customer) throws SQLException {
		// TODO Auto-generated method stub
		customerDao.editCustomer(customer);
	}
	@Override
	public void addCustomer(Customer customer) throws SQLException {
		// TODO Auto-generated method stub
		customerDao.addCustomer(customer);
	}
//	@Override
//	public List<Customer> getAllCustomer(int firstRow, Integer pageSize)
//			throws SQLException {
//		// TODO Auto-generated method stub
//		return customerDao.getAllCustomer(firstRow,pageSize);
//	}
	@Override
	public List<Customer> getCustomer(int firstRow, Integer pageSize,
			Customer customer) throws SQLException {
		// TODO Auto-generated method stub
		return customerDao.getCustomer(firstRow,pageSize,customer);
	}
	@Override
	public List<Customer> getAllCustomer(int firstRow, Integer pageSize,
			CusSearchVO cusSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return customerDao.getAllCustomer(firstRow,pageSize,cusSearchVO);
	}
	@Override
	public int getCustomerCount(CusSearchVO cusSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return customerDao.getCustomerCount(cusSearchVO);
	}


}
