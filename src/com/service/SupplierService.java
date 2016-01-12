package com.service;

import java.sql.SQLException;
import java.util.List;
import com.vos.SupSearchVO;
import com.vos.Supplier;

public interface SupplierService {
	public List<Supplier> getAllSupplier(int firstRow, Integer pageSize,
			SupSearchVO supSearchVO) throws SQLException;
	public int getSupplierCount(SupSearchVO supSearchVO) throws SQLException;
	public void addSupplier(Supplier supplier) throws SQLException;
	public void editSupplier(Supplier supplier) throws SQLException;
	public void deleteSupplier(int supId) throws SQLException;
	public Supplier selectPaymentAmount(int supId) throws SQLException;
	public void updatePaymentAmount(int supId,float cpma) throws SQLException;
}
