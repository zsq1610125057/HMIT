package com.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sun.jdbc.odbc.OdbcDef;

import com.dao.ProjectDao;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.util.HmitUtil;
import com.vos.Contract;
import com.vos.ContractVO;
import com.vos.Customer;
import com.vos.Employees;
import com.vos.InvSearchVO;
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

public class ProjectDaoImp implements ProjectDao {

	private SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Customer> getAllCustomers() throws SQLException {
		// TODO Auto-generated method stub
		try {
			List<Customer> list = new ArrayList<Customer>();
			list = sqlMapClient.queryForList("getAllCustomers");
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ProjectTypeVo> getProjectTypeList() throws SQLException {
		// TODO Auto-generated method stub
		try {
			return sqlMapClient.queryForList("getProjectTypeList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Employees> getProBrokeragList() throws SQLException {
		// TODO Auto-generated method stub
		try {
			return sqlMapClient.queryForList("getProBrokeragList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Supplier> getSupplierList() throws SQLException {
		// TODO Auto-generated method stub
		try {
			return sqlMapClient.queryForList("getSupplierList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<PayTypeVo> getPayWayList() throws SQLException {
		// TODO Auto-generated method stub
		try {
			return sqlMapClient.queryForList("getPayTypeList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@Override
	public int saveNewProject(Project project) throws SQLException{
		// TODO Auto-generated method stub
		int id=0;
		try {
			System.out.println(project.getIfInv());
			id = (Integer) sqlMapClient.insert("saveNewProject",project);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
		return id;
	}
	@Override
	public void saveOrder(Order order) throws SQLException {
		// TODO Auto-generated method stub
		try{
			
			sqlMapClient.insert("saveOrder",order);
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Order> getOrderListByPager(OrderVO orderVO,int firstRow, int pageSize)
			throws SQLException {
		List<Order> list = null;
		Map<String,Object> map = new HashMap<String,Object>();
		//int endRow = pageSize+firstRow;
		map.put("beginRow", firstRow);
		map.put("pageSize", pageSize);
		map.put("equName", orderVO.getEquName());
		map.put("proId", orderVO.getProId());
		map.put("status", orderVO.getStatus());
		map.put("supId", orderVO.getSupId());
		list = sqlMapClient.queryForList("getOrderListByPager",map);
		return list;
	}
	@Override
	public int getOrderCount() throws SQLException {
		// TODO Auto-generated method stub
		int count = 0;
		count = (Integer) sqlMapClient.queryForObject("getOrderCount");
		return count;
	}
	@Override
	public void updateOrderStatus(Order order, String action)
			throws SQLException {
		try{
			order.setAction(action);
			order.setLastUpdateBy(HmitUtil.CURRENT_USER);
			sqlMapClient.update("updateOrderSupInfo", order);
		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public void updateOrderWMId(int wMId, int ordId,float difference) throws SQLException {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("wMId",wMId);
		map.put("ordId", ordId);
		map.put("difference", difference);
		sqlMapClient.update("updateOrderWMId", map);
	}
	@Override
	public void updateOrderStatus1(Order order, String action)
			throws SQLException {
		try{
			if(order.getPayables()==0 && order.getInvId()!=null){
				order.setAction("已完成");
			}else if(order.getPayables()==0 && order.getInvId()==null){
				order.setAction("已付款未开票");
			}else if(order.getPayables()!=0 && order.getInvId()==null){
				order.setAction("未付清未开票");
			}else{
				order.setAction("未付清已开票");
			}
			
			order.setLastUpdateBy(HmitUtil.CURRENT_USER);
			sqlMapClient.update("updateOrderSupInfo1", order);
		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Project> getProjectNameList() throws SQLException {
		// TODO Auto-generated method stub
		List<Project> list = null;
		list=sqlMapClient.queryForList("getProjectNameList");
		return list;
	}
	@Override
	public void addInvoice(Invoice invoice) throws SQLException {
		sqlMapClient.insert("addInv", invoice);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Project> getProjectAllNameList() throws SQLException {
		List<Project> list = null;
		list=sqlMapClient.queryForList("getProjectAllNameList");
		return list;
	}
	@Override
	public void updateOrderArrival(Order order, String action)
			throws SQLException {
		try{
			
				order.setAction(action);
		
			order.setLastUpdateBy(HmitUtil.CURRENT_USER);
			//System.out.println(order);
			sqlMapClient.update("updateOrderArrival", order);
		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public void addorderPay(Paymenthistory paymenthistory) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.insert("addorderPay", paymenthistory);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Invoice> getInvoiceList(int proId) throws SQLException {
		List<Invoice> list = null;
		Map<String,Object> map = new HashMap<String,Object>();
		//int endRow = pageSize+firstRow;
		map.put("proId", proId);
		list = sqlMapClient.queryForList("getInvoiceList",map);
		return list;
	}
	@Override
	public void updateorderofinv(Order order, String action)throws SQLException {
		try{
			if(order.getPayables()==0 && order.getInvId()!=null){
				order.setAction("已完成");
			}else if(order.getPayables()==0 && order.getInvId()==null){
				order.setAction("已付款未开票");
			}else if(order.getPayables()!=0 && order.getInvId()==null){
				order.setAction("未付清未开票");
			}else{
				order.setAction("未付清已开票");
			}
			order.setLastUpdateBy(HmitUtil.CURRENT_USER);
			sqlMapClient.update("updateorderofinv", order);
		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Paymenthistory> getgetOrderHistory(int ordId)
			throws SQLException {
		List<Paymenthistory> list = null;
		Map<String,Object> map = new HashMap<String,Object>();
		//int endRow = pageSize+firstRow;
		map.put("ordId", ordId);
		list = sqlMapClient.queryForList("getOrderHistory",map);
		return list;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Project> getProject(int firstRow, Integer pageSize,
			ProSearchVO proSearchVO) throws SQLException {
		try{
			proSearchVO.setFirstRow(firstRow);
			proSearchVO.setPageSize(pageSize);
			List<Project> list = new ArrayList<Project>();		
			list = sqlMapClient.queryForList("getProject",proSearchVO);
			return list;
		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public int getProjectCount(ProSearchVO proSearchVO) throws SQLException {
		int in=(Integer) sqlMapClient.queryForObject("getProjectCount",proSearchVO);
		return in;
	}
	@Override
	public void updateProjectStatus(int id, String action) throws SQLException {
		// TODO Auto-generated method stub
		
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("id", id);
		map.put("action",action);
		map.put("lastUpdateBy", HmitUtil.CURRENT_USER);
		sqlMapClient.update("updateProjectStatus", map);
	}
	@Override
	public void addSchedule(Schedule schedule) throws SQLException {
		schedule.setAddPeople(HmitUtil.CURRENT_USER);
		sqlMapClient.insert("addschedule", schedule);
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Schedule> getProSchedule(int firstRow, Integer pageSize,int proId)
			throws SQLException {
		List<Schedule> list = null;
		Map<String,Object> map = new HashMap<String,Object>();
		//int endRow = pageSize+firstRow;
		map.put("firstRow", firstRow);
		map.put("pageSize", pageSize);
		map.put("proId", proId);
		list = sqlMapClient.queryForList("getProSchedule",map);
		return list;
	}
	@Override
	public int getProScheduleCount(int proId) throws SQLException {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("proId", proId);
		int in=(Integer) sqlMapClient.queryForObject("getProScheduleCount",map);
		return in;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Tender> getTenderProject(int firstRow, int pageSize)
			throws SQLException {
		List<Tender> list=new ArrayList<Tender>();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("beginRow", firstRow);
		map.put("pageSize", pageSize);
		list = sqlMapClient.queryForList("getTenderProject",map);
		return list;
	}
	@Override
	public int getTenderProjectCount() throws SQLException {
		int count = 0;
		count = (Integer) sqlMapClient.queryForObject("getTenderProjectCount");
		return count;
	}

@SuppressWarnings("unchecked")
@Override
public List<Project> getMaturityMoneyList() throws SQLException {
	try {
		List<Project> list = new ArrayList<Project>();
		list = sqlMapClient.queryForList("getMaturityMoneyList");
		return list;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return null;
}
@SuppressWarnings("unchecked")
@Override
public List<Project> getNowProject(int firstRow, int pageSize)
		throws SQLException {
	List<Project> list=new ArrayList<Project>();
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("beginRow", firstRow);
	map.put("pageSize", pageSize);
	list = sqlMapClient.queryForList("getNowProject",map);
	return list;
}
@Override
public int getNowProjectCount() throws SQLException {
	// TODO Auto-generated method stub
	int count = 0;
	count = (Integer) sqlMapClient.queryForObject("getNowProjectCount");
	return count;
}
@SuppressWarnings("unchecked")
@Override
public List<Project> getProInfoList(int id) throws SQLException {
	try {
		return sqlMapClient.queryForList("getProInfoList",id);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return null;
}

@Override
public void addTender(Tender tender) throws SQLException {
	// TODO Auto-generated method stub
	sqlMapClient.insert("addTender",tender);
}
@SuppressWarnings("unchecked")
@Override
public List<Invoice> getAllInvoice(int firstRow, Integer pageSize,
		InvSearchVO invSearchVO) throws SQLException {
	try{
		Map<String,Object> map = new HashMap<String, Object>();
		List<Invoice> list = new ArrayList<Invoice>();
		map.put("invType", invSearchVO.getInvType());
		map.put("invDate", invSearchVO.getInvDate());
		map.put("beginMoney", invSearchVO.getBeginMoney());
		map.put("endMoney", invSearchVO.getEndMoney());
		map.put("proId", invSearchVO.getProName());
		map.put("firstRow",firstRow);
		map.put("pageSize",pageSize);
		
		list = sqlMapClient.queryForList("getAllInvoice",map);
		return list;

	}catch(SQLException e) {
		e.printStackTrace();
		throw e;
	}
	// TODO Auto-generated method stub
}
@Override
public int getInvoiceCount(InvSearchVO invSearchVO) throws SQLException {
	// TODO Auto-generated method stub
	int in=(Integer) sqlMapClient.queryForObject("getInvoiceCount",invSearchVO);
	return in;
}
@SuppressWarnings("unchecked")
@Override
public List<Contract> getContract(int firstRow, Integer pageSize,
		ContractVO contractVO) throws SQLException {
	try{
		Map<String,Object> map = new HashMap<String, Object>();
		List<Contract> list = new ArrayList<Contract>();
	    map.put("contId",contractVO.getContId());
		map.put("beginDate",contractVO.getBeginDate());
		map.put("endDate",contractVO.getEndDate());
		map.put("firstRow",firstRow);
		map.put("pageSize",pageSize);
		list = sqlMapClient.queryForList("getContract",map);
		System.out.println("我擦"+list);
		return list;

	}catch(SQLException e) {
		e.printStackTrace();
		throw e;
	}
	// TODO Auto-generated method stub
}
@Override
public int getContractCount(ContractVO contractVO) throws SQLException {
	// TODO Auto-generated method stub
	return (Integer) sqlMapClient.queryForObject("getContractCount",contractVO);
}
@Override
public void addContract(Contract contract) throws SQLException {
	// TODO Auto-generated method stub
	sqlMapClient.insert("addContract",contract);
}
@Override
public void editContract(Contract contract) throws SQLException {
	// TODO Auto-generated method stub
	sqlMapClient.insert("editContract",contract);
}
@Override
public void deleteContract(int contId) throws SQLException {
	// TODO Auto-generated method stub
	sqlMapClient.delete("deleteContract",contId);
}
}
