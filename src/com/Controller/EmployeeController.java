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
import com.vos.EmployeesVO;
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

	
	
	@RequestMapping("/editEmployee")
	@ResponseBody
	public void editEmployee(@RequestParam("data") String emp, @RequestParam("empId") int empId,HttpServletResponse response) throws Exception {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();	
			emp = URLDecoder.decode(emp, "UTF-8");
			Employees employee = (Employees) JSONObject.toBean(JSONObject.fromObject(emp), Employees.class);
			employee.setEmpId(empId);
			employeesService.editEmployee(employee);
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
	@RequestMapping("/addEmployee")
	@ResponseBody
	public void addEmployee(@RequestParam("data") String emp,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			emp = URLDecoder.decode(emp, "UTF-8");
			Employees employee = (Employees) JSONObject.toBean(JSONObject.fromObject(emp), Employees.class);
			employeesService.addEmployee(employee);
			JsonResult jr = new JsonResult();
			jr.setMsg("添加客户信息成功！");
			jr.setResult(CREATE_NEW_SUCCESS_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
			JsonResult jr = new JsonResult();
			jr.setMsg("添加员工信息失败！");
			jr.setResult(CREATE_NEW_ERROR_PROJECT_RESULT);
			JSONObject json = JSONObject.fromObject(jr);
			pw.print(json.toString());
		}

}
	@RequestMapping("/deleteEmployee")
	@ResponseBody
	public void deleteEmployee(@RequestParam("empId") int empId,
			HttpServletResponse response) throws Exception {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			employeesService.deleteEmployee(empId);
			JsonResult jr = new JsonResult();
			jr.setMsg(CREATE_NEW_SUCCESS_PROJECT_RESULT);
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
	
	//获取角色类型
	@RequestMapping("/getRoleTypeList")
	public void getRoleTypeList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<EmployeesVO> list = new ArrayList<EmployeesVO>();
		try {
			list =employeesService.getRoleTypeList();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("/gettitleList")
	public void gettitleList(HttpServletResponse response) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		List<Employees> list = new ArrayList<Employees>();
		try {
			list =employeesService.gettitleList();
			if (list != null && list.size() > 0) {
				JSONArray json = JSONArray.fromObject(list);
				pw.write(json.toString());	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/getAllEmployee")
	@ResponseBody
	public Map<String, Object> getAllEmployee(@RequestParam("rows") Integer pageSize,@RequestParam("page") Integer pageNumber,HttpServletResponse response,@ModelAttribute EmpSearchVO empSearchVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Employees> pageList = new ArrayList<Employees>();
		int intPageNum=pageNumber==null||pageNumber<=0?1:pageNumber;
		int intPageSize=pageSize==null||pageSize<=0?10:pageSize;
		int firstRow = (pageNumber - 1) * pageSize;
		try {	
			pageList = employeesService.getAllEmployee(firstRow, pageSize,empSearchVO);
			int count = employeesService.getEmployeeCount(empSearchVO);
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
}
