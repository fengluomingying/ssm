package com.zfm.crud.service;

import com.zfm.crud.beans.Department;
import com.zfm.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getAll() {
        return departmentMapper.selectByExample(null);
    }
}
