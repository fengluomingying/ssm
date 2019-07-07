package com.zfm.crud.service;

import com.zfm.crud.beans.Employee;
import com.zfm.crud.beans.EmployeeExample;
import com.zfm.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void addEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public boolean checkName(String name) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(name);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    public Employee getEmpById(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteEmpBatch(List<Integer> list) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(list);
        employeeMapper.deleteByExample(employeeExample);
    }
}
