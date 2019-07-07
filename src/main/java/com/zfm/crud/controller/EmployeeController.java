package com.zfm.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zfm.crud.beans.Employee;
import com.zfm.crud.beans.Msg;
import com.zfm.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "deleteEmp/{id}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("id")String id){
        List<Integer> list = new ArrayList<>();
        if(id.contains("-")){
            String[] ids = id.split("-");
            for (String i : ids){
                list.add(Integer.parseInt(i));
            }
            employeeService.deleteEmpBatch(list);
        }else{
            Integer empId = Integer.parseInt(id);
            employeeService.deleteEmpById(empId);
        }
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "updatSave/{empId}", method = RequestMethod.PUT)
    public Msg updatSave(Employee employee){
//        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/getEmp/{id}",method = RequestMethod.GET)
    public Msg getMap(@PathVariable("id") Integer id){
            Employee employee = employeeService.getEmpById(id);
            return Msg.success().add("emp",employee);
    }

    @ResponseBody
    @RequestMapping(value = "/empSave", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        Map<String, Object> fieldErrors = new HashMap<String, Object>();
        if(result.hasErrors()){
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors){
                String field = fieldError.getField();
                String message = fieldError.getDefaultMessage();
                fieldErrors.put(field, message);
            }
            return Msg.fail().add("fieldErrors", fieldErrors);
        }else{
            employeeService.addEmp(employee);
            return Msg.success();
        }
    }

    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
//        String order = "empId" + " asc";
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn, 5);

        List<Employee> emps = employeeService.getAll();

        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }

    @ResponseBody
    @RequestMapping("/check_name")
    public Msg checkName(@RequestParam("name")String name){
        String re = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!name.matches(re)){
            return Msg.fail().add("va_msg", "用户名必须是6-16位的字幕和数字的组合或者和2-5位的中文");
        }
        boolean b = employeeService.checkName(name);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }
}
