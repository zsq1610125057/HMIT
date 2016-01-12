package com.service;

import java.sql.SQLException;
import java.util.List;

import com.vos.Customer;
import com.vos.Employees;
import com.vos.Invoice;
import com.vos.Order;
import com.vos.OrderVO;
import com.vos.PayTypeVo;
import com.vos.Project;
import com.vos.ProjectTypeVo;
import com.vos.Supplier;

public interface ProjectService {

	public List<Customer> getAllCustomers() throws SQLException;
	
	public List<ProjectTypeVo> getProjectTypeList() throws SQLException;
	
	public List<Employees>getProBrokeragList() throws SQLException;
	
	public List<Supplier>getSupplierList() throws SQLException;
	
	public List<PayTypeVo>getPayWayList()throws SQLException;
	
	public void saveNewProject(Project project,List<Order> order) throws SQLException;
	
	public List<Order> getOrderListByPager(OrderVO orderVO,int firstRow,int pageSize) throws SQLException;
	
	public int getOrderCount() throws SQLException;
	
	public void updateOrderStatus(Order order, String action) throws SQLException;
	
	public void updateOrderWMId(int wMId, int ordId,float difference) throws SQLException;
	
	public void updateOrderStatus1(Order order, String action) throws SQLException;
	
	public List<Project> getProjectNameList() throws SQLException;
	//获取所有的项目名称
	public List<Project> getProjectAllNameList() throws SQLException;
	//增加发票
	public void addInvoice(Invoice invoice) throws SQLException;
}
