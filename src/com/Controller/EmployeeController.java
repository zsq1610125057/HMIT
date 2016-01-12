package com.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.service.EmployeesService;
import com.service.WarehousemanagementService;
import com.util.HmitUtil;
import com.vos.CusSearchVO;
import com.vos.Customer;
import com.vos.EmpSearchVO;
import com.vos.Employee;
import com.vos.Employees;
import com.vos.JsonResult;
import com.vos.Payway;


@Controller
@SessionAttributes
public class EmployeeController {
	public static final String CREATE_NEW_SUCCESS_PROJECT_RESULT = "info";
	public static final String CREATE_NEW_ERROR_PROJECT_RESULT = "error";
	@Resource(name = "employeesService")
	private EmployeesService employeesService;

	public EmployeesService getEmployeesService() {
		return employeesService;
	}

	public void setEmployeesService(EmployeesService employeesService) {
		this.employeesService = employeesService;
	}

	@RequestMapping("/editpassword")
	@ResponseBody
	public void editpassword(@RequestParam("newpass" ) String newpass,HttpServletRequest request, HttpServletResponse response) throws IOException {
      EmpSearchVO empsearchvo=new EmpSearchVO();
      empsearchvo.setEmpName(HmitUtil.CURRENT_USER);
      empsearchvo.setNewpassword(newpass);
      empsearchvo.setPassword(HmitUtil.CURRENT_PASSWORD);
      PrintWriter pw = response.getWriter();
      try {
		employeesService.updateemployees(empsearchvo);
		JsonResult jr = new JsonResult();
		jr.setMsg(newpass);
		jr.setResult(newpass);
		HmitUtil.CURRENT_PASSWORD=newpass;
		JSONObject json = JSONObject.fromObject(jr);
		//System.out.println(json);
		pw.print( json);
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		JsonResult jr = new JsonResult();
		jr.setMsg(HmitUtil.CURRENT_PASSWORD);
		jr.setResult(HmitUtil.CURRENT_PASSWORD);
		JSONObject json = JSONObject.fromObject(jr);
		pw.print(json.toString());
	
	}
	}
	
	@RequestMapping("/getAllEmployee")
	@ResponseBody
	public Map<String, Object> getAllEmployee(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber,HttpServletResponse response,@ModelAttribute EmpSearchVO empSearchVO) {
		//System.out.println("customer______"+cusSearchVO.getEmpName());
		Map<String, Object> map = new HashMap<String, Object>();
		List<Employee> pageList = new ArrayList<Employee>();
		int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
		int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
		int firstRow = (pageNumber - 1) * pageSize;
		try {
			//list = customerService.getAllCustomer();
			pageList = employeesService.getAllEmployee(firstRow, pageSize, empSearchVO);
			int count = employeesService.getEmployeesCount();
			System.out.println(pageList.size());
		
			for(Employee emp:pageList){
				//System.out.println(emp.getRegDate());
				emp.setRegDate1(emp.getRegDate().toString());
				emp.setLastLoginDate1(emp.getLastLoginDate().toString());
			}
			
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
