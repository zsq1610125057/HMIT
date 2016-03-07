package com.service.imp;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ProjectDao;
import com.service.ProjectService;
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
@Service
public class ProjectServiceImp implements ProjectService {
	private static Logger logger = Logger.getLogger("service");
	private ProjectDao projectDao;
	private Object computer;
	public ProjectDao getProjectDao() {
		return projectDao;
	}
	public void setProjectDao(ProjectDao projectDao) {
		this.projectDao = projectDao;
	}
	@Override
	public List<Customer> getAllCustomers() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getAllCustomers();
	}
	@Override
	public List<ProjectTypeVo> getProjectTypeList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectTypeList();
	}
	@Override
	public List<Employees> getProBrokeragList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProBrokeragList();
	}
	@Override
	public List<Supplier> getSupplierList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getSupplierList();
	}
	
	@Override
	public List<PayTypeVo> getPayWayList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getPayWayList();
	}
	
	@Override
	public void saveNewProject(Project project, List<Order>list) throws SQLException{
		try{
			
			int pid = projectDao.saveNewProject(project);
			System.out.println(pid);
			for (Order order  : list) {
				order.setProId(pid);
				System.out.println("是否批发"+order.getIfWholeSale());
				if(order.getIfWholeSale()==null){
					order.setIfWholeSale("0");
				}
				//order.setSupId(Integer.parseInt(order.getSupName().split("-")[0]));
				projectDao.saveOrder(order);
			}
						
		} catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
	
	}
	@Override
	public List<Order> getOrderListByPager(OrderVO orderVO,int firstRow, int pageSize)
			throws SQLException {
		return projectDao.getOrderListByPager(orderVO,firstRow, pageSize);
	}
	@Override
	public int getOrderCount() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getOrderCount();
	}
	@Override
	public void updateOrderStatus(Order order, String action)
			throws SQLException {
		// TODO Auto-generated method stub
		projectDao.updateOrderStatus(order, action);
	}
	@Override
	public void updateOrderWMId(int wMId, int ordId,float difference) throws SQLException {
		projectDao.updateOrderWMId(wMId, ordId, difference);
		
	}
	@Override
	public void updateOrderStatus1(Order order, String action)
			throws SQLException {
		// TODO Auto-generated method stub
		projectDao.updateOrderStatus1(order, action);
	}
	@Override
	public List<Project> getProjectNameList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectNameList();
	}
	@Override
	public void addInvoice(Invoice invoice) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.addInvoice(invoice);
	}
	@Override
	public List<Project> getProjectAllNameList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectAllNameList();
	}
	@Override
	public void updateOrderArrival(Order order, String action)
			throws SQLException {
		projectDao.updateOrderArrival(order,action);
		
	}
	@Override
	public void addorderPay(Paymenthistory paymenthistory) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.addorderPay(paymenthistory);
	}
	@Override
	public List<Invoice> getInvoiceList(int proId) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getInvoiceList(proId);
	}
	@Override
	public void updateorderofinv(Order order, String action)
			throws SQLException {
		projectDao.updateorderofinv(order, action);
		
	}
	@Override
	public List<Paymenthistory> getgetOrderHistory(Paymenthistory paymenthistory)
			throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getgetOrderHistory(paymenthistory);
	}
	@Override
	public List<Project> getProject(int firstRow, Integer pageSize,
			ProSearchVO proSearchVO) throws SQLException {
		return projectDao.getProject(firstRow,pageSize,proSearchVO);
	}
	@Override
	public int getProjectCount(ProSearchVO proSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectCount(proSearchVO);
	}
	@Override
	public List<Invoice> getAllInvoice(int firstRow, Integer pageSize,
			InvSearchVO invSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getAllInvoice(firstRow,pageSize,invSearchVO);
	}
	@Override
	public int getInvoiceCount(InvSearchVO invSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getInvoiceCount(invSearchVO);
	}
	@Override
	public void updateProjectStatus(int id, String action) throws SQLException {
		
		projectDao.updateProjectStatus(id,action);
	}
	@Override
	public void addSchedule(Schedule schedule) throws SQLException {
		projectDao.addSchedule(schedule);
		
	}
	@Override
	public List<Schedule> getProSchedule(int firstRow, Integer pageSize,int proId)
			throws SQLException {	
		return projectDao.getProSchedule(firstRow, pageSize,proId);
	}
	@Override
	public int getProScheduleCount(int proId) throws SQLException {
		return projectDao.getProScheduleCount(proId);
	}
	@Override
	public List<Tender> getTenderProject(int firstRow, int pageSize)
			throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getTenderProject(firstRow, pageSize);
	}
	@Override
	public int getTenderProjectCount() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getTenderProjectCount();
	}
	@Override
	public List<Project> getMaturityMoneyList() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getMaturityMoneyList();
	}
	@Override
	public List<Project> getNowProject(int firstRow, int pageSize)
			throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getNowProject(firstRow, pageSize);
	}
	@Override
	public int getNowProjectCount() throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getNowProjectCount();
	}
	@Override
	public List<Project> getProInfoList(int id) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProInfoList(id);
	}
	@Override
	public void addTender(Tender tender) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.addTender(tender);
	}
	@Override
	public List<Contract> getContract(int firstRow, Integer pageSize,
			ContractVO contractVO) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getContract(firstRow, pageSize,contractVO);
	}
	@Override
	public int getContractCount(ContractVO contractVO) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getContractCount(contractVO);
	}
	@Override
	public void addContract(Contract contract) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.addContract(contract);
	}
	@Override
	public void editContract(Contract contract) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.editContract(contract);
	}
	@Override
	public void deleteContract(int contId) throws SQLException {
		// TODO Auto-generated method stub
		projectDao.deleteContract(contId);
	}
	public List<Project> getProject1(int firstRow, Integer pageSize,
			ProSearchVO proSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProject1(firstRow,pageSize,proSearchVO);
	}
	@Override
	public int getProjectCount1(ProSearchVO proSearchVO) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getProjectCount1(proSearchVO);
	}
	@Override
	public void updateProInv(int proId) {
		projectDao.updateProInv(proId);
		
	}
	@Override
	public List<Invoice> getproinv(int proId) {
		return projectDao.getproinv(proId);
		
	}
	@Override
	public void addproPay(Paymenthistory paymenthistory) throws SQLException {
		projectDao.addproPay(paymenthistory);
		
	}
	@Override
	public Project getpropaymoney(int proId) throws SQLException {
		// TODO Auto-generated method stub
		return projectDao.getpropaymoney(proId);
	}
	@Override
	public void updatepropaymoney(int proId, float money) {
		// TODO Auto-generated method stub
		projectDao.updatepropaymoney( proId, money);
	}
	@Override
	public List<Order> readReport(InputStream inp) {
		List<Order> orderList = new ArrayList<Order>();  
		  
        try {  
            String cellStr = null;  
  
            Workbook wb = WorkbookFactory.create(inp);  
  
            Sheet sheet = wb.getSheetAt(0);// 取得第一个sheets  
  
            //从第3行开始读取数据  
            for (int i = 2; i <= sheet.getLastRowNum(); i++) {  
  
            	Order order = new Order();  
            	Order addOrder = new Order();  
  
                Row row = sheet.getRow(i); // 获取行(row)对象  
  
                if (row == null) {  
                    // row为空的话,不处理  
                    continue;  
                }  
  
                for (int j = 0; j < row.getLastCellNum(); j++) {  
  
                    Cell cell = row.getCell(j); // 获得单元格(cell)对象  
  
                    // 转换接收的单元格  
                    cellStr = ConvertCellStr(cell, cellStr);  
  
                    // 将单元格的数据添加至一个对象  
                    addOrder = addingOrder(j, order, cellStr);  
  
                }  
                // 将添加数据后的对象填充至list中  
                orderList.add(addOrder);  
            }  
  
        } catch (InvalidFormatException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (inp != null) {  
                try {  
                    inp.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            } else {  
                logger.info("没有数据流!");  
            }  
        }  
        return orderList;  
  
    }  
	private Order addingOrder(int j, Order order, String cellStr) {  
        switch (j) {
        case 0:
        	order.setOrdId(0);
        	break;
        case 1:  
            order.setEquName(cellStr);  
            break;  
        case 2: 
        	cellStr=cellStr.substring(0,cellStr.indexOf("."));
        	order.setEquNumber(Integer.parseInt(cellStr));  
            break;  
        case 3:  
        	order.setEquDescription(cellStr);  
            break;  
        case 4:     	
        	order.setSellPrice(Float.parseFloat(cellStr));  
            break;  
        case 5: 
        	order.setSellTotalPrice(Float.parseFloat(cellStr)); 
            break;  
        case 6: 
        	order.setRemarks(cellStr);  
            break;  
        }  
  
        return order;  
    }  
	  /** 
     * 把单元格内的类型转换至String类型 
     */  
    private String ConvertCellStr(Cell cell, String cellStr) {  
  
        switch (cell.getCellType()) {  
  
        case Cell.CELL_TYPE_STRING:  
            // 读取String  
            cellStr = cell.getStringCellValue().toString();  
            break;  
  
        case Cell.CELL_TYPE_BOOLEAN:  
            // 得到Boolean对象的方法  
            cellStr = String.valueOf(cell.getBooleanCellValue());  
            break;  
  
        case Cell.CELL_TYPE_NUMERIC:  
            // 先看是否是日期格式  
            if (DateUtil.isCellDateFormatted(cell)) {  
  
                // 读取日期格式  
                cellStr = cell.getDateCellValue().toString();  
  
            } else {  
            	
                // 读取数字  
                cellStr = String.valueOf(cell.getNumericCellValue()); 
            }  
            break;  
  
        case Cell.CELL_TYPE_FORMULA:  
            // 读取公式  
        	
            cellStr = cell.getCellFormula().toString();  
            break;  
        }  
        return cellStr;  
    }  
}
