package com.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONString;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.tags.EscapeBodyTag;

import sun.jdbc.odbc.OdbcDef;

import com.service.CustomerService;
import com.service.EmployeesService;
import com.service.ProjectService;
import com.service.SupplierService;
import com.service.WarehousemanagementService;
import com.sun.xml.internal.fastinfoset.tools.PrintTable;
import com.util.HmitUtil;
import com.vos.CusSearchVO;
import com.vos.Customer;
import com.vos.Employees;
import com.vos.Invoice;
import com.vos.JsonResult;
import com.vos.Order;
import com.vos.OrderVO;
import com.vos.PayTypeVo;
import com.vos.Paymenthistory;
import com.vos.Payway;
import com.vos.Project;
import com.vos.ProjectTypeVo;
import com.vos.SupSearchVO;
import com.vos.Supplier;
import com.vos.Tender;
import com.vos.Warehousemanagement;

@Controller
@SessionAttributes
public class LoginController {
	public  static final String LOGIN_SUCCESS_MSG = "登录成功";
	public  static final String LOGIN_FAILED_MSG = "用户名或密码错误";
	public  static final String LOGIN_ERROR_MSG = "服务器出错,请重试";
	public  static final String SAVE_SUCCESS_MSG = "操作成功";	
	public  static final String SAVE_ERROR_MSG = "操作失败，请重试";	
	public  static final String UPDATE_ERROR_MSG = "更新失败，请重试";
	public  static final String UPDATE_SUCCESS_MSG = "更新成功";
	public  static final String LOAD_FILE_ERROR_MSG = "下载文件失败";	
	public  static final String CONNECT_PORT_FAILED = "端口已被占用，请重新选择";	
	public  static final String CONNECT_PORT_SUCCESS = "端口链接成功";
	public  static final String CONNECT_PORT_ERROR = "服务器出错，请重试";
	public static final String CREATE_NEW_SUCCESS_PROJECT_RESULT = "info";
	public static final String CREATE_NEW_ERROR_PROJECT_RESULT = "error";
	public static final String CREATE_NEW_SUCCESS_PROJECT_MSG = "项目创建成功";
	public static final String CREATE_NEW_SUCCESS_CUSTOMER_MSG = "删除成功";
	public static final String CREATE_NEW_ERROR_CUSTOMER_MSG = "删除失败，请重试";
	@Resource(name = "employeesService")
	private EmployeesService employeesService;
	@Resource(name = "projectService")
	private ProjectService projectService;
	@Resource(name = "customerService")
	private CustomerService customerService;
	@Resource(name = "supplierService")
	private SupplierService supplierService;
    @Resource(name = "warehousemanagementService")
    private WarehousemanagementService warehousemanagementService;
	public WarehousemanagementService getWarehousemanagementService() {
		return warehousemanagementService;
	}

	public void setWarehousemanagementService(
			WarehousemanagementService warehousemanagementService) {
		this.warehousemanagementService = warehousemanagementService;
	}

	public CustomerService getCustomerService() {
		return customerService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public ProjectService getProjectService() {
		return projectService;
	}

	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	public EmployeesService getEmployeesService() {
		return employeesService;
	}

	public void setEmployeesService(EmployeesService employeesService) {
		this.employeesService = employeesService;
	}

	@RequestMapping("/queryById")
	@ResponseBody
	public void queryById(@RequestParam("loginName") String LoginName,@RequestParam("password") String password,HttpServletRequest request, HttpServletResponse response) throws IOException {
		Employees employees = new Employees();
		employees.setLoginName(LoginName);
		employees.setPassword(password);
		PrintWriter pw = response.getWriter();
		
		String incode = (String)request.getParameter("code");   
	    String rightcode = (String)request.getSession().getAttribute("rCode");  
	    
		try {
			Employees employees1 = employeesService.queryById(employees);
			if(employees1!=null&&(incode.equals(rightcode))){
				request.getSession().setAttribute("current_user", employees.getLoginName());
				HmitUtil.CURRENT_USER = LoginName;
				HmitUtil.CURRENT_PASSWORD=password;
				pw.print("{\"result\":" + true + ",\"msg\":\"" + LOGIN_SUCCESS_MSG + "\"}");
			} else {
				pw.print("{\"result\":" + false + ",\"msg\":\"" + LOGIN_FAILED_MSG + "\"}");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pw.flush();
			pw.close();
		}
	}
	@RequestMapping("/getCustomerList")
	public void getCustomerList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<Customer> list = new ArrayList<Customer>();
		try {
			list = projectService.getAllCustomers();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/getProjectTypeList")
	public void getProjectTypeList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<ProjectTypeVo> list = new ArrayList<ProjectTypeVo>();
		try {
			list = projectService.getProjectTypeList();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/getPayInfo")
	public void getPayInfo(HttpServletResponse response,@ModelAttribute Supplier supplier){
		PrintWriter pw = null;
System.out.println("11"+supplier.getSupId());
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<Order> list = new ArrayList<Order>();
		try {
			list = supplierService.getPayInfoList(supplier.getSupId());
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/getProjectNameList")
	public void getProjectNameList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<Project> list = new ArrayList<Project>();
		try {
			list = projectService.getProjectNameList();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	//获取所有的项目
	@RequestMapping("/getProjectAllNameList")
	public void getProjectAllNameList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<Project> list = new ArrayList<Project>();
		try {
			list = projectService.getProjectAllNameList();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/getProBrokeragList")
	public void getProBrokeragList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<Employees> list = new ArrayList<Employees>();
		try {
			list = projectService.getProBrokeragList();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("/getSupplierList")
	public void getSupplierList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<Supplier> list = new ArrayList<Supplier>();
		try {
			list = projectService.getSupplierList();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/getPayWayList")
	public void getPayWayList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<PayTypeVo> list = new ArrayList<PayTypeVo>();
		try {
			list = projectService.getPayWayList();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("/getAllCustomer")
	@ResponseBody
	public Map<String, Object> getAllCustomer(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber,HttpServletResponse response,@ModelAttribute CusSearchVO cusSearchVO) {
		//System.out.println("customer______"+cusSearchVO.getEmpName());
		Map<String, Object> map = new HashMap<String, Object>();
		List<Customer> pageList = new ArrayList<Customer>();
		int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
		int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
		int firstRow = (pageNumber - 1) * pageSize;
		try {
			//list = customerService.getAllCustomer();
			pageList = customerService.getAllCustomer(firstRow, pageSize,cusSearchVO);
			int count = customerService.getCustomerCount(cusSearchVO);
			map.put("rows", pageList);
			map.put("total", count);
			return map;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("error", false);
		}
		return null;
		
	}
	
	@RequestMapping("/getCustomer")
	@ResponseBody
	public Map<String, Object> getCustomer(@RequestParam("data") String cus,HttpServletResponse response) throws UnsupportedEncodingException {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Customer> list = new ArrayList<Customer>();
		try {
			cus = URLDecoder.decode(cus, "UTF-8");
			Customer customer = (Customer)JSONObject.toBean(JSONObject.fromObject(cus), Customer.class);
			list = customerService.getCustomer(customer);
			map.put("rows", list);
			map.put("total", list.size());
			return map;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@RequestMapping("/createNewProject")
	public void createNewProject(@RequestParam("data") String data,
									HttpServletResponse response,HttpServletRequest request,@RequestParam("cusId") int cusId) {
		
		PrintWriter pw = null;
		//String status = "已立项";
		try {

			pw  = response.getWriter();
			String str = URLDecoder.decode(data,"UTF-8");
			//前台2组数据用=号链接
			String[]arrData = str.split("=");
			String proData = arrData[0];
			String ordData = arrData[1];
			JSONObject object = JSONObject.fromObject(proData);
			//json对象转换成javabean
			Project project = (Project) object.toBean(JSONObject.fromObject(proData), Project.class);
			
			//System.out.println(project.getBeginDate());
			//System.out.println(project.getRecevablesDate());
			//System.out.println(project.getBeginDate());
			project.setCusId(cusId);
			project.setStatus(HmitUtil.ORDER_STATUS_NEW);
			project.setLastUpdateBy(HmitUtil.CURRENT_USER);
//			Date da=new Date();
//			DateFormat format=new SimpleDateFormat("yyyy-MM-dd ");
//			project.setLastUpdateDate(format.format(da));
			//json数组转换成list
			List <Order>list = (List)JSONArray.toList(JSONArray.fromObject(ordData), Order.class);
			if (list != null && list.size() > 0) {
				project.setIfAccessories("1");
			} else {
				project.setIfAccessories("0");
			}
			if (project.getIfMigAgent() == null) {
				project.setIfMigAgent("0");
			}
			for (Order order : list) {
				order.setStatus(HmitUtil.ORDER_STATUS_NEW);
				order.setLastUpdateBy(HmitUtil.CURRENT_USER);
				
			}
			
			//保存项目信息
				
			projectService.saveNewProject(project, list);			
			JsonResult jr = new JsonResult();
			jr.setMsg(CREATE_NEW_SUCCESS_PROJECT_MSG);
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);			
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("项目创建失败，请重试");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);			
			pw.print(json.toString());
			
		}
	}
	
	@RequestMapping("/deleteCustomer")
	@ResponseBody
	public void deleteCustomer(@RequestParam("cusId") int cusId,
			HttpServletResponse response) throws Exception {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			customerService.deleteCustomer(cusId);
			JsonResult jr = new JsonResult();
			jr.setMsg(CREATE_NEW_SUCCESS_CUSTOMER_MSG);
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("请先删除联系人");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		}
	}
	
	
	@RequestMapping("/editCustomer")
	@ResponseBody
	public void editCustomer(@RequestParam("data") String cus, @RequestParam("cusId") int cusId,HttpServletResponse response) throws Exception {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();	
			cus = URLDecoder.decode(cus, "UTF-8");
			Customer customer = (Customer) JSONObject.toBean(JSONObject.fromObject(cus), Customer.class);
			customer.setCusId(cusId);
			customerService.editCustomer(customer);
			JsonResult jr = new JsonResult();
			jr.setMsg("修改客户信息成功！");
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("修改客户信息失败！");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		}
	}

	@RequestMapping("/addCustomer")
	@ResponseBody
	public void addCustomer(@RequestParam("data") String cus,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			cus = URLDecoder.decode(cus, "UTF-8");
			Customer customer = (Customer) JSONObject.toBean(JSONObject.fromObject(cus), Customer.class);
			customerService.addCustomer(customer);
			JsonResult jr = new JsonResult();
			jr.setMsg("添加客户信息成功！");
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("添加客户信息失败！");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		}

}

	@RequestMapping("/getOrderListByPager")
	@ResponseBody
	public Map<String,Object> getOrderListByPager(@ModelAttribute OrderVO order ,@RequestParam("rows") Integer pageSize,
			@RequestParam("page") Integer pageNumber) throws IOException {
		System.out.println("sjdfk"+order.getProId());
		int count = 0;
		Map<String,Object> map = new HashMap<String,Object>();
		List<Order> pageList = new ArrayList<Order>();
		List<Order> totalList = new ArrayList<Order>();
		int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
		int intPageSize=pageSize==null||pageSize<=0?2:pageSize;
		int firstRow = (pageNumber - 1) * pageSize;
		try{
			pageList = projectService.getOrderListByPager(order,firstRow, pageSize);
			//System.out.println("采购表"+pageList);
			count = projectService.getOrderCount();
			map.put("rows", pageList);
			map.put("total", count);
			return map;
		}catch(Exception e) {
			e.printStackTrace();
			map.put("error", false);
			return map;
		}
	}
	@RequestMapping("/updateOrderStatus")
	public void updateOrderStatus(@RequestParam("data") String row,
									HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			String[]arrData = row.split("=");
			String rowData = arrData[0];
			String action = arrData[1];
			pw = response.getWriter();
			rowData = URLDecoder.decode(rowData,"UTF-8");
			Order order = (Order) JSONObject.toBean(JSONObject.fromObject(rowData), Order.class);
			projectService.updateOrderStatus(order, action);
			if(action.equals(HmitUtil.ORDER_STATUS_ARRIVED)){
					Warehousemanagement ware=new Warehousemanagement();
					ware.setStock(order.getEquNumber());
					ware.setEquName(order.getEquName());
					int id=warehousemanagementService.addWarehousemanagementService(ware);
					float difference=order.getSellTotalPrice()-order.getCostPrice();
					projectService.updateOrderWMId(id, order.getOrdId(),difference);
				}
			
		    pw.print(messageSuc());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			pw.print(messageErr());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/updateOrderStatus1")
	public void updateOrderStatus1(@RequestParam("data") String row,
									HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			String[]arrData = row.split("=");
			String rowData = arrData[0];
			String action = arrData[1];
			pw = response.getWriter();
			rowData = URLDecoder.decode(rowData,"UTF-8");
			Order order = (Order) JSONObject.toBean(JSONObject.fromObject(rowData), Order.class);
			Paymenthistory paymenthistory=new Paymenthistory();
			paymenthistory.setOrdId(order.getOrdId());
			paymenthistory.setPaidDate(order.getPayDate());
			paymenthistory.setPaidMoney(order.getMoney());
			paymenthistory.setPayRemarks(order.getPayRemarks());
			paymenthistory.setPayWay(order.getPayWay());
			order.setPayables(order.getPayables()-order.getMoney());
			projectService.addorderPay(paymenthistory);
			projectService.updateOrderStatus1(order, action);
			//System.out.println(order.getCostPrice());
			Supplier su=supplierService.selectPaymentAmount(order.getSupId());
			float cpma=su.getTotalPaymentAmount()-order.getMoney();
		    supplierService.updatePaymentAmount(su.getSupId(), cpma);
		    pw.print(messageSuc());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			pw.print(messageErr());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/updateOrderStatus2")
	public void updateOrderStatus2(@RequestParam("data") String row,
									HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			String[]arrData = row.split("=");
			String rowData = arrData[0];
			String action = arrData[1];
			pw = response.getWriter();
			rowData = URLDecoder.decode(rowData,"UTF-8");
			Order order = (Order) JSONObject.toBean(JSONObject.fromObject(rowData), Order.class);
			order.setPayables(order.getCostPrice());
			projectService.updateOrderArrival(order,action);
			Supplier su=supplierService.selectPaymentAmount(order.getSupId());
			float cpma=su.getTotalPaymentAmount()+order.getCostPrice();
		    supplierService.updatePaymentAmount(su.getSupId(), cpma);
		    pw.print(messageSuc());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			pw.print(messageErr());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/updateorderofinv")
	public void updateorderofinv(@RequestParam("data") String row,
									HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			String[]arrData = row.split("=");
			String rowData = arrData[0];
			String action = arrData[1];
			pw = response.getWriter();
			rowData = URLDecoder.decode(rowData,"UTF-8");
			Order order = (Order) JSONObject.toBean(JSONObject.fromObject(rowData), Order.class);			
			System.out.println("应付款"+order.getPayables());
			projectService.updateorderofinv(order,action);
		    pw.print(messageSuc());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			pw.print(messageErr());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public String messageSuc() {
		JsonResult jr = new JsonResult();
		jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
		jr.setMsg(SAVE_SUCCESS_MSG);
		JSONObject json = JSONObject.fromObject(jr);
		return json.toString();
	}
	public String messageErr() {
		JsonResult jr = new JsonResult();
		jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
		jr.setMsg(UPDATE_ERROR_MSG);
		JSONObject json = JSONObject.fromObject(jr);
		return json.toString();
	}
	
	//获取全部供应商
	@RequestMapping("/getAllSupplier")
	@ResponseBody
	public Map<String, Object> getAllSupplier(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber,HttpServletResponse response,@ModelAttribute SupSearchVO supSearchVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Supplier> pageList = new ArrayList<Supplier>();
		int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
		int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
		int firstRow = (pageNumber - 1) * pageSize;
		try {
			//list = customerService.getAllCustomer();
			pageList = supplierService.getAllSupplier(firstRow, pageSize,supSearchVO);
			//System.out.println(pageList);
			int count = supplierService.getSupplierCount(supSearchVO);
			map.put("rows", pageList);
			map.put("total", count);
			return map;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("error", false);
		}
		return null;
		
	}

	//增加供应商
	@RequestMapping("/addSupplier")
	@ResponseBody
	public void addSupplier(@RequestParam("data") String sup,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			sup = URLDecoder.decode(sup, "UTF-8");
			Supplier supplier = (Supplier) JSONObject.toBean(JSONObject.fromObject(sup), Supplier.class);
			supplierService.addSupplier(supplier);
			JsonResult jr = new JsonResult();
			jr.setMsg("添加客户信息成功！");
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("添加客户信息失败！");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		}

}
	//修改供应商
	@RequestMapping("/editSupplier")
	@ResponseBody
	public void editSupplier(@RequestParam("data") String sup, @RequestParam("supId") int supId,HttpServletResponse response) throws Exception {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();	
			sup = URLDecoder.decode(sup, "UTF-8");
			Supplier supplier = (Supplier) JSONObject.toBean(JSONObject.fromObject(sup), Supplier.class);
			//System.out.println("供应商id"+supId);
			supplier.setSupId(supId);			
			supplierService.editSupplier(supplier);
			JsonResult jr = new JsonResult();
			jr.setMsg("修改客户信息成功！");
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("修改客户信息失败！");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		}
	}
	//删除供应商
	@RequestMapping("/deleteSupplier")
	@ResponseBody
	public void deleteSupplier(@RequestParam("supId") int supId,
			HttpServletResponse response) throws Exception {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			//System.out.println("-----------id:"+supId);
			supplierService.deleteSupplier(supId);
			JsonResult jr = new JsonResult();
			jr.setMsg(CREATE_NEW_SUCCESS_CUSTOMER_MSG);
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("请先删除联系人");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		}
	}
	@RequestMapping("/getPaywayList")
	public void getPaywayList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<Payway> list = new ArrayList<Payway>();
		try {
			list=warehousemanagementService.getAllPayway();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public SupplierService getSupplierService() {
		return supplierService;
	}

	public void setSupplierService(SupplierService supplierService) {
		this.supplierService = supplierService;
	}
	//增加发票
	@RequestMapping("/addInvoice")
	@ResponseBody
	public void addInvoice(@RequestParam("data") String inv,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			inv = URLDecoder.decode(inv, "UTF-8");
			Invoice invoice = (Invoice) JSONObject.toBean(JSONObject.fromObject(inv), Invoice.class);
			invoice.setInvType("进项发票");
			projectService.addInvoice(invoice);
			JsonResult jr = new JsonResult();
			jr.setMsg("添加发票信息成功！");
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("添加发票信息失败！");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		}

}
//获取发票	
		@RequestMapping("/getInvoiceList")
		@ResponseBody
		public void getInvoiceList(@RequestParam("proId") int proId,HttpServletResponse response) {
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			List<Invoice> list = new ArrayList<Invoice>();
			try {
				list =projectService.getInvoiceList(proId);
				if (list != null && list.size() > 0) {
					JSONArray json = JSONArray.fromObject(list);
					pw.write(json.toString());	
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
//获取付款详情
		@RequestMapping("/getOrderPayHistory")
		@ResponseBody
		public Map<String, Object> getOrderHistory(HttpServletResponse response,@ModelAttribute Paymenthistory paymenthistory) {
			//System.out.println("customer______"+cusSearchVO.getEmpName());
			Map<String, Object> map = new HashMap<String, Object>();
			List<Paymenthistory> pageList = new ArrayList<Paymenthistory>();
			try {
				paymenthistory.setProId(0);
				pageList = projectService.getgetOrderHistory(paymenthistory);			
				map.put("rows", pageList);
				return map;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				map.put("error", false);
			}
			return null;
			
		}
		
		@RequestMapping("/getMaturityMoneyList")
		public void getMaturityMoneyList(HttpServletResponse response) {
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			List<Project> list = new ArrayList<Project>();
			try {
				list =projectService.getMaturityMoneyList();
				if (list != null && list.size() > 0) {
					JSONArray json = JSONArray.fromObject(list);
					pw.write(json.toString());	
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		@RequestMapping("/getProInfo")
		public void getProInfo(HttpServletResponse response,@ModelAttribute Project project){
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			List<Project> list = new ArrayList<Project>();
			try {
				list = projectService.getProInfoList(project.getId());
				if (list != null && list.size() > 0) {
					JSONArray json = JSONArray.fromObject(list);
					pw.write(json.toString());	
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		//首页的近期项目列表
		@RequestMapping("/getNowProject")
		@ResponseBody
		public Map<String, Object> getNowProject(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<Project> pageList = new ArrayList<Project>();
			int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
			int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
			int firstRow = (pageNumber - 1) * pageSize;
			try {
				pageList = projectService.getNowProject(firstRow, pageSize);
				int count = projectService.getNowProjectCount();
				map.put("rows", pageList);
				map.put("total", count);
				return map;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				map.put("error", false);
			}
			return null;
			
		}
		//首页招标项目
		@RequestMapping("/getTenderProject")
		@ResponseBody
		public Map<String, Object> getTenderProject(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<Tender> pageList = new ArrayList<Tender>();
			int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
			int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
			int firstRow = (pageNumber - 1) * pageSize;
			try {
				pageList = projectService.getTenderProject(firstRow, pageSize);
				int count = projectService.getTenderProjectCount();
				map.put("rows", pageList);
				map.put("total", count);
				return map;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				map.put("error", false);
			}
			return null;
			
		}
}
