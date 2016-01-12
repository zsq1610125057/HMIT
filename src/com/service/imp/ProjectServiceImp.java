package com.service.imp;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ProjectDao;
import com.service.ProjectService;
import com.vos.Customer;
import com.vos.Employees;
import com.vos.Invoice;
import com.vos.Order;
import com.vos.OrderVO;
import com.vos.PayTypeVo;
import com.vos.Project;
import com.vos.ProjectTypeVo;
import com.vos.Supplier;
@Service
public class ProjectServiceImp implements ProjectService {

	private ProjectDao projectDao;
	public ProjectDao getProjectDao() {
		return projectDao;
	}
	public void setProjectDao(ProjectDao projectDao) {
		this.projectDao = projectDao;
	}
	@Override
	public List<Customer> getAllCustomers() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getAllCustomers();
	}
	@Override
	public List<ProjectTypeVo> getProjectTypeList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectTypeList();
	}
	@Override
	public List<Employees> getProBrokeragList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProBrokeragList();
	}
	@Override
	public List<Supplier> getSupplierList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getSupplierList();
	}
	
	@Override
	public List<PayTypeVo> getPayWayList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getPayWayList();
	}
	
	@Override
	public void saveNewProject(Project project, List<Order>list) throws SQLException{
		try{
			
			int pid = projectDao.saveNewProject(project);
			for (Order order  : list) {
				order.setProId(pid);
				//order.setSupId(Integer.parseInt(order.getSupName().split("-")[0]));
				projectDao.saveOrder(order);
			}
						
		} catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
	
	}
	@Override
	public List<Order> getOrderListByPager(OrderVO orderVO,int firstRow, int pageSize)
			throws SQLException {
		return projectDao.getOrderListByPager(orderVO,firstRow, pageSize);
	}
	@Override
	public int getOrderCount() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getOrderCount();
	}
	@Override
	public void updateOrderStatus(Order order, String action)
			throws SQLException {
		// TODO Auto-generated method stub
		projectDao.updateOrderStatus(order, action);
	}
	@Override
	public void updateOrderWMId(int wMId, int ordId,float difference) throws SQLException {
		projectDao.updateOrderWMId(wMId, ordId, difference);
		
	}
	@Override
	public void updateOrderStatus1(Order order, String action)
			throws SQLException {
		// TODO Auto-generated method stub
		projectDao.updateOrderStatus1(order, action);
	}
	@Override
	public List<Project> getProjectNameList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectNameList();
	}
	@Override
	public void addInvoice(Invoice invoice) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.addInvoice(invoice);
	}
	@Override
	public List<Project> getProjectAllNameList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectAllNameList();
	}
}
