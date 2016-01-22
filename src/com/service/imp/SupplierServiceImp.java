package com.service.imp;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import com.dao.supplierDao;
import com.service.SupplierService;
import com.vos.Order;
import com.vos.SupSearchVO;
import com.vos.Supplier;

public class SupplierServiceImp implements SupplierService {
	@Resource(name = "supplierDao")
	private supplierDao supplierDao;
	public supplierDao getSupplierDao() {
		return supplierDao;
	}
	public void setSupplierDao(supplierDao supplierDao) {
		this.supplierDao = supplierDao;
	}
	@Override
	public List<Supplier> getAllSupplier(int firstRow, Integer pageSize,
			SupSearchVO supSearchVO) throws SQLException {
		// TODO Auto-generated method stub
	
		return supplierDao.getAllSupplier(firstRow,pageSize,supSearchVO);
	}
	@Override
	public int getSupplierCount(SupSearchVO supSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return supplierDao.getSupplierCount(supSearchVO);
	}
	@Override
	public void addSupplier(Supplier supplier) throws SQLException {
		// TODO Auto-generated method stub
		supplierDao.addSupplier(supplier);
	}
	@Override
	public void editSupplier(Supplier supplier) throws SQLException {
		// TODO Auto-generated method stub
		supplierDao.editSupplier(supplier);
	}
	@Override
	public void deleteSupplier(int supId) throws SQLException {
		// TODO Auto-generated method stub
		supplierDao.delectSupplier(supId);
	}
	@Override
	public Supplier selectPaymentAmount(int supId) throws SQLException {
		return supplierDao.selectPaymentAmount(supId);
	}
	@Override
	public void updatePaymentAmount(int supId, float cpma) throws SQLException {
		supplierDao.updatePaymentAmount(supId, cpma);
	}

	@Override
	public List<Order> getPayInfoList(int supId) throws SQLException {
		return supplierDao.getPayInfoList(supId);
	}
}
