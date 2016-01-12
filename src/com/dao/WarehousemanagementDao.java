package com.dao;

import java.sql.SQLException;
import java.util.List;

import com.vos.Customer;
import com.vos.Payway;
import com.vos.Warehousemanagement;

public interface WarehousemanagementDao {
   public int addWarehousemanagement(Warehousemanagement ware)throws SQLException;
   public List<Payway> getAllPayway() throws SQLException;
}
