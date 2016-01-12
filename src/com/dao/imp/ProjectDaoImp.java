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
import com.vos.Customer;
import com.vos.Employees;
import com.vos.Invoice;
import com.vos.Order;
import com.vos.OrderVO;
import com.vos.PayTypeVo;
import com.vos.Project;
import com.vos.ProjectTypeVo;
import com.vos.Supplier;

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
			order.setAction(action);
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
	@Override
	public List<Project> getProjectAllNameList() throws SQLException {
		List<Project> list = null;
		list=sqlMapClient.queryForList("getProjectAllNameList");
		return list;
	}
}
