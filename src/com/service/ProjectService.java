package com.service;

import java.sql.SQLException;
import java.util.List;

import com.vos.CusSearchVO;
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
	//添加货到时间
	public void updateOrderArrival(Order order, String action) throws SQLException;
	 //增加订单付款表
    public void addorderPay(Paymenthistory paymenthistory) throws SQLException;
    //获得发票
    public List<Invoice> getInvoiceList(int proId) throws SQLException;
    //添加发票信息
    public void updateorderofinv(Order order, String action)throws SQLException;
    //获取付款详情
    public List<Paymenthistory> getgetOrderHistory(int ordId)throws SQLException ;
    //获取项目
    public List<Project> getProject(int firstRow, Integer pageSize,ProSearchVO proSearchVO) throws SQLException;
    
    public int getProjectCount(ProSearchVO proSearchVO) throws SQLException;
    //修改项目状态
    public void updateProjectStatus(int id,String action)throws SQLException;
    //添加项目施工进度信息
    public void addSchedule(Schedule schedule)throws SQLException;
    //获取项目施工进度信息
    public List<Schedule> getProSchedule(int firstRow, Integer pageSize,int proId)throws SQLException;
    //获取项目进度数量
    public int getProScheduleCount(int proId) throws SQLException;
}
