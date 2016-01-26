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
import com.vos.Paymenthistory;
import com.vos.ProSearchVO;
import com.vos.Project;
import com.vos.ProjectTypeVo;
import com.vos.Schedule;
import com.vos.Supplier;
import com.vos.Tender;
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
			System.out.println(pid);
			for (Order order  : list) {
				order.setProId(pid);
				System.out.println("是否批发"+order.getIfWholeSale());
				if(order.getIfWholeSale()==null){
					order.setIfWholeSale("0");
				}
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
	@Override
	public void updateOrderArrival(Order order, String action)
			throws SQLException {
		projectDao.updateOrderArrival(order,action);
		
	}
	@Override
	public void addorderPay(Paymenthistory paymenthistory) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.addorderPay(paymenthistory);
	}
	@Override
	public List<Invoice> getInvoiceList(int proId) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getInvoiceList(proId);
	}
	@Override
	public void updateorderofinv(Order order, String action)
			throws SQLException {
		projectDao.updateorderofinv(order, action);
		
	}
	@Override
	public List<Paymenthistory> getgetOrderHistory(int ordId)
			throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getgetOrderHistory(ordId);
	}
	@Override
	public List<Project> getProject(int firstRow, Integer pageSize,
			ProSearchVO proSearchVO) throws SQLException {
		return projectDao.getProject(firstRow,pageSize,proSearchVO);
	}
	@Override
	public int getProjectCount(ProSearchVO proSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectCount(proSearchVO);
	}
	@Override
	public void updateProjectStatus(int id, String action) throws SQLException {
		
		projectDao.updateProjectStatus(id,action);
	}
	@Override
	public void addSchedule(Schedule schedule) throws SQLException {
		projectDao.addSchedule(schedule);
		
	}
	@Override
	public List<Schedule> getProSchedule(int firstRow, Integer pageSize,int proId)
			throws SQLException {	
		return projectDao.getProSchedule(firstRow, pageSize,proId);
	}
	@Override
	public int getProScheduleCount(int proId) throws SQLException {
		return projectDao.getProScheduleCount(proId);
	}
	@Override
	public List<Tender> getTenderProject(int firstRow, int pageSize)
			throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getTenderProject(firstRow, pageSize);
	}
	@Override
	public int getTenderProjectCount() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getTenderProjectCount();
	}
	@Override
	public List<Project> getMaturityMoneyList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getMaturityMoneyList();
	}
	@Override
	public List<Project> getNowProject(int firstRow, int pageSize)
			throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getNowProject(firstRow, pageSize);
	}
	@Override
	public int getNowProjectCount() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getNowProjectCount();
	}
	@Override
	public List<Project> getProInfoList(int id) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProInfoList(id);
	}
	@Override
	public void addTender(Tender tender) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.addTender(tender);
	}
}
