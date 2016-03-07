package com.Controller;

import java.awt.FileDialog;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import sun.jdbc.odbc.OdbcDef;

import com.service.CustomerService;
import com.service.EmployeesService;
import com.service.ProjectService;
import com.service.SupplierService;
import com.service.WarehousemanagementService;
import com.util.HmitUtil;
import com.vos.Contract;
import com.vos.ContractVO;
import com.vos.CusSearchVO;
import com.vos.Customer;
import com.vos.Invoice;
import com.vos.JsonResult;
import com.vos.Order;
import com.vos.Paymenthistory;
import com.vos.ProSearchVO;
import com.vos.Project;
import com.vos.Schedule;
import com.vos.SupSearchVO;
import com.vos.Supplier;
import com.vos.Tender;
import com.vos.Warehousemanagement;

@Controller
@SessionAttributes

public class ProjectController {
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
    
	public EmployeesService getEmployeesService() {
		return employeesService;
	}
	public void setEmployeesService(EmployeesService employeesService) {
		this.employeesService = employeesService;
	}
	public ProjectService getProjectService() {
		return projectService;
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	public CustomerService getCustomerService() {
		return customerService;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	public SupplierService getSupplierService() {
		return supplierService;
	}
	public void setSupplierService(SupplierService supplierService) {
		this.supplierService = supplierService;
	}
	public WarehousemanagementService getWarehousemanagementService() {
		return warehousemanagementService;
	}
	public void setWarehousemanagementService(
			WarehousemanagementService warehousemanagementService) {
		this.warehousemanagementService = warehousemanagementService;
	}

	//获取项目list
	@RequestMapping("/getProject")
	@ResponseBody
	public Map<String, Object> getProject(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber,HttpServletResponse response,@ModelAttribute ProSearchVO proSearchVO) {
		//System.out.println("customer______"+cusSearchVO.getEmpName());
		Map<String, Object> map = new HashMap<String, Object>();
		List<Project> pageList = new ArrayList<Project>();
		int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
		int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
		int firstRow = (pageNumber - 1) * pageSize;
		try {
			//list = customerService.getAllCustomer();
		
			pageList = projectService.getProject(firstRow, pageSize,proSearchVO);
			int count = projectService.getProjectCount(proSearchVO);
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
	//获取项目付款list
		@RequestMapping("/getProject1")
		@ResponseBody
		public Map<String, Object> getProject1(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber,HttpServletResponse response,@ModelAttribute ProSearchVO proSearchVO) {
			//System.out.println("customer______"+cusSearchVO.getEmpName());
			Map<String, Object> map = new HashMap<String, Object>();
			List<Project> pageList = new ArrayList<Project>();
			int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
			int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
			int firstRow = (pageNumber - 1) * pageSize;
			try {
				//list = customerService.getAllCustomer();
			
				pageList = projectService.getProject1(firstRow, pageSize,proSearchVO);
				int count = projectService.getProjectCount1(proSearchVO);
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
	//修改项目状态
	@RequestMapping("/updateProjectStatus")
	public void updateProjectStatus(@RequestParam("data") String row,
									HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			String[]arrData = row.split("=");
			String rowData = arrData[0];
			String action = arrData[1];
			pw = response.getWriter();
			rowData = URLDecoder.decode(rowData,"UTF-8");
			Project project = (Project) JSONObject.toBean(JSONObject.fromObject(rowData), Project.class);
			//System.out.println("项目id"+project.getProId());
			projectService.updateProjectStatus(project.getProId(), action);		
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
	//获取收款信息
	@RequestMapping("/getproPayHistory")
	@ResponseBody
    public Map<String, Object> getproHistory(HttpServletResponse response,@ModelAttribute Paymenthistory paymenthistory) {
				//System.out.println("customer______"+cusSearchVO.getEmpName());
				Map<String, Object> map = new HashMap<String, Object>();
				List<Paymenthistory> pageList = new ArrayList<Paymenthistory>();
				try {
					//System.out.println("huoqu"+paymenthistory.getProId());
					paymenthistory.setOrdId(0);
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
	//添加收款信息
	@RequestMapping("/saveprohistoye")
	public void saveprohistoye(@RequestParam("data") String row,
									HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			row = URLDecoder.decode(row,"UTF-8");
			Paymenthistory paymenthistory = (Paymenthistory) JSONObject.toBean(JSONObject.fromObject(row), Paymenthistory.class);
			Project pr=projectService.getpropaymoney(paymenthistory.getProId());
			projectService.addproPay(paymenthistory);
			float money=pr.getPaymoney()+paymenthistory.getPaidMoney();
			projectService.updatepropaymoney(paymenthistory.getProId(),money);
			//System.out.println(order.getCostPrice());
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
	//增加施工进度
		@RequestMapping("/addSchedule")
		@ResponseBody
		public void addSchedule(@RequestParam("data") String sch,HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
				sch = URLDecoder.decode(sch, "UTF-8");
				Schedule schedule = (Schedule) JSONObject.toBean(JSONObject.fromObject(sch), Schedule.class);
				projectService.addSchedule(schedule);
				JsonResult jr = new JsonResult();
				jr.setMsg("添加施工进度成功！");
				jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			} catch (Exception e) {
				e.printStackTrace();
				JsonResult jr = new JsonResult();
				jr.setMsg("添加施工进度失败！");
				jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			}

	}
    //获取施工进度
		@RequestMapping("/getProSchedule")
		@ResponseBody
		public Map<String, Object> getProSchedule(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber,HttpServletResponse response,@ModelAttribute Schedule schedule) {
			//System.out.println("customer______"+cusSearchVO.getEmpName());
			Map<String, Object> map = new HashMap<String, Object>();
			List<Schedule> pageList = new ArrayList<Schedule>();
			int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
			int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
			int firstRow = (pageNumber - 1) * pageSize;
			try {
				//list = customerService.getAllCustomer();
				pageList = projectService.getProSchedule(firstRow, pageSize,schedule.getProId());
				int count = projectService.getProScheduleCount(schedule.getProId());
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
		
		@RequestMapping("/addTender")
		@ResponseBody
		public void addTender(@RequestParam("data") String td,HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
				td = URLDecoder.decode(td, "UTF-8");
				Tender tender = (Tender) JSONObject.toBean(JSONObject.fromObject(td), Tender.class);
				projectService.addTender(tender);
				JsonResult jr = new JsonResult();
				jr.setMsg("添加招标成功！");
				jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			} catch (Exception e) {
				e.printStackTrace();
				JsonResult jr = new JsonResult();
				jr.setMsg("添加招标信息失败！");
				jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			}

	}

		//合同
		@RequestMapping("/getContract")
		@ResponseBody
		public Map<String, Object> getContract(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber,HttpServletResponse response,@ModelAttribute ContractVO contractVO) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<Contract> pageList = new ArrayList<Contract>();
			int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
			int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
			int firstRow = (pageNumber - 1) * pageSize;
			try {
				pageList = projectService.getContract(firstRow, pageSize,contractVO);
				System.out.println("1111"+pageList);
				int count = projectService.getContractCount(contractVO);
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

		//增加合同
		@RequestMapping("/addContract")
		@ResponseBody
		public void addContract(@RequestParam("data") String cont,HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
				cont = URLDecoder.decode(cont, "UTF-8");
				Contract contract = (Contract) JSONObject.toBean(JSONObject.fromObject(cont), Contract.class);
				projectService.addContract(contract);
				JsonResult jr = new JsonResult();
				jr.setMsg("添加合同信息成功！");
				jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			} catch (Exception e) {
				e.printStackTrace();
				JsonResult jr = new JsonResult();
				jr.setMsg("添加合同信息失败！");
				jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			}

	}
		//修改合同
		@RequestMapping("/editContract")
		@ResponseBody
		public void editContract(@RequestParam("data") String cont, @RequestParam("contId") int contId,HttpServletResponse response) throws Exception {
			PrintWriter pw = null;
			try {
				pw = response.getWriter();	
				cont = URLDecoder.decode(cont, "UTF-8");
				Contract contract = (Contract) JSONObject.toBean(JSONObject.fromObject(cont), Contract.class);
				//System.out.println("供应商id"+supId);
				contract.setContId(contId);			
				projectService.editContract(contract);
				JsonResult jr = new JsonResult();
				jr.setMsg("修改合同信息成功！");
				jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			} catch (Exception e) {
				e.printStackTrace();
				JsonResult jr = new JsonResult();
				jr.setMsg("修改合同信息失败！");
				jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			}
		}
		//删除合同
		@RequestMapping("/deleteContract")
		@ResponseBody
		public void deleteContract(@RequestParam("contId") int contId,
				HttpServletResponse response) throws Exception {
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
			projectService.deleteContract(contId);
				JsonResult jr = new JsonResult();
				jr.setMsg(CREATE_NEW_SUCCESS_CUSTOMER_MSG);
				jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			} catch (Exception e) {
				e.printStackTrace();
				JsonResult jr = new JsonResult();
				jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			}
		}
		//获取项目发票信息
		@RequestMapping("/getproinv")
		@ResponseBody
		public void getproinv(@RequestParam("proId") int proId,HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			List<Invoice> list = new ArrayList<Invoice>();
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
				//Invoice inv=new Invoice();
				list=projectService.getproinv(proId);
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			} catch (Exception e) {
				e.printStackTrace();
				JsonResult jr = new JsonResult();
				jr.setMsg("添加招标信息失败！");
				jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
				JSONObject json = JSONObject.fromObject(jr);
				pw.print(json.toString());
			}
	}
		//增加发票
		@RequestMapping("/addproInvoice")
		@ResponseBody
		public void addproInvoice(@RequestParam("data") String inv,HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			
			PrintWriter pw = null;
			try {
				pw = response.getWriter();
				inv = URLDecoder.decode(inv, "UTF-8");
				Invoice invoice = (Invoice) JSONObject.toBean(JSONObject.fromObject(inv), Invoice.class);
				invoice.setInvType("出项发票");
				invoice.setInvMoney(invoice.getProMoney());
				System.out.println("发票金额"+invoice.getProMoney());
				projectService.addInvoice(invoice);
				projectService.updateProInv(invoice.getProId());
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
    //导入excel
		 @RequestMapping("/readReport")  
		 @ResponseBody
		    public Map<String, Object> getReadReport(@RequestParam MultipartFile file,HttpServletResponse response)  
		            throws IOException {
			 Map<String, Object> map = new HashMap<String, Object>();
		      List<Order> list = projectService.readReport(file.getInputStream()); 
		      map.put("rows", list);     
		       return map;
		    }  
}
