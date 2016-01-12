package com.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dao.supplierDao;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.vos.SupSearchVO;
import com.vos.Supplier;

public class supplierDaoImp implements supplierDao {
	private SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Supplier> getAllSupplier(int firstRow, Integer pageSize,
			SupSearchVO supSearchVO) throws SQLException {
		try{
			Map<String,Object> map = new HashMap<String, Object>();
			List<Supplier> list = new ArrayList<Supplier>();
			map.put("supName", supSearchVO.getSupName());
			map.put("contactPersonName", supSearchVO.getContactPersonName());
			map.put("contact", supSearchVO.getContact());
			map.put("address", supSearchVO.getAddress());
			map.put("empId", supSearchVO.getEmpName());
			map.put("firstRow",firstRow);
			map.put("pageSize",pageSize);
			
			list = sqlMapClient.queryForList("getAllSupplier",map);
			return list;

		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
		// TODO Auto-generated method stub
	}

	@Override
	public int getSupplierCount(SupSearchVO supSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) sqlMapClient.queryForObject("getSupplierCount",supSearchVO);
	}

	@Override
	public void addSupplier(Supplier supplier) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.insert("addSupplier", supplier);
	}

	@Override
	public void editSupplier(Supplier supplier) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.update("editSupplier", supplier);
	}

	@Override
	public void delectSupplier(int supId) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.delete("deleteSupplier", supId);
	}

	@Override
	public Supplier selectPaymentAmount(int supId) throws SQLException {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("supId", supId);
		return (Supplier)sqlMapClient.queryForObject("getPaymentAmount", map);
	}

	@Override
	public void updatePaymentAmount(int supId, float cpma) throws SQLException {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("supId", supId);
		map.put("totalPaymentAmount", cpma);
		sqlMapClient.update("updatePaymentAmount", map);
		
	}

}
