package com.zfm.crud.beans;

public class Department {
    private Integer depatId;

    private String deptName;

    public Department(Integer depatId, String deptName) {
        this.depatId = depatId;
        this.deptName = deptName;
    }

    public Department() {
    }

    public Integer getDepatId() {
        return depatId;
    }

    public void setDepatId(Integer depatId) {
        this.depatId = depatId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}