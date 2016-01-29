package com.service;

import java.sql.SQLException;
import java.util.List;

import com.vos.Payway;
import com.vos.Warehousemanagement;

public interface WarehousemanagementService {
public int addWarehousemanagementService(Warehousemanagement ware)throws SQLException;
public List<Payway> getAllPayway() throws SQLException;
}
