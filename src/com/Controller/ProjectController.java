package com.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.service.CustomerService;
import com.service.EmployeesService;
import com.service.ProjectService;
import com.service.SupplierService;
import com.service.WarehousemanagementService;
import com.util.HmitUtil;
import com.vos.CusSearchVO;
import com.vos.Customer;
import com.vos.Invoice;
import com.vos.JsonResult;
import com.vos.Order;
import com.vos.ProSearchVO;
import com.vos.Project;
import com.vos.Schedule;
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
			System.out.println("项目id"+project.getProId());
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
}
