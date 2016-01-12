package com.service.imp;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.WarehousemanagementDao;
import com.service.WarehousemanagementService;
import com.vos.Payway;
import com.vos.Warehousemanagement;
@Service("warehousemanagementService")
public class WarehousemanagementServiceImp implements
		WarehousemanagementService {
	@Resource(name="warehousemanagementDao")
	private WarehousemanagementDao warehousemanagementDao;
	public WarehousemanagementDao getWarehousemanagementDao() {
		return warehousemanagementDao;
	}
	public void setWarehousemanagementDao(
			WarehousemanagementDao warehousemanagementDao) {
		this.warehousemanagementDao = warehousemanagementDao;
	}
	@Override
	public int addWarehousemanagementService(Warehousemanagement ware)
			throws SQLException {
		return warehousemanagementDao.addWarehousemanagement(ware);
	}
	@Override
	public List<Payway> getAllPayway() throws SQLException {
		// TODO Auto-generated method stub
		return warehousemanagementDao.getAllPayway();
	}

}
