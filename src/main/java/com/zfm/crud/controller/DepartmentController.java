package com.zfm.crud.controller;

import com.zfm.crud.beans.Department;
import com.zfm.crud.beans.Msg;
import com.zfm.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;
    @ResponseBody
    @RequestMapping("/deps")
    public Msg getDeps(){
        List<Department> list = departmentService.getAll();
        return Msg.success().add("deps", list);
    }
}
