package com.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dao.WarehousemanagementDao;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.vos.Payway;
import com.vos.Warehousemanagement;

public class WarehousemanagementDaoImp implements WarehousemanagementDao {

	private SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	@Override
	public int addWarehousemanagement(Warehousemanagement ware)
			throws SQLException {
		int id=0;
		try {
       id=(Integer)sqlMapClient.insert("savenewWarehousemanagement",ware);
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
        return id;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Payway> getAllPayway() throws SQLException {
		// TODO Auto-generated method stub
		List<Payway> list=new ArrayList<Payway>();
		list=sqlMapClient.queryForList("queryAllPayway");
		return list;
	}

}
