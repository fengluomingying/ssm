package com.zfm.crud.test;

import com.github.pagehelper.PageInfo;
import com.zfm.crud.beans.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:sringmvc-config.xml"})
public class MvcTest {

    //SpringMvc的ioc
    @Autowired
    WebApplicationContext context;
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "6")).andReturn();

        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码: "+pageInfo.getPageNum());
        System.out.println("总页码: "+pageInfo.getPages());
        System.out.println("总记录数: "+pageInfo.getTotal());
        System.out.println("连续页码: ");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums){
            System.out.println(" "+i);
        }

        List<Employee> list = pageInfo.getList();
        for(Employee emp: list){
            System.out.println(emp.getEmpId());
            System.out.println(emp.getEmpName());
        }
    }
}
