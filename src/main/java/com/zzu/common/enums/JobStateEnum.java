package com.zzu.common.enums;

/**
 * 职位状态
 */
public enum JobStateEnum {

    STOP_JOB(0, "未运行"),
    RUNNING_JOB(1, "运行中");

    private int value;
    private String title;

    public int getValue() {
        return value;
    }

    public String getTitle() {
        return title;
    }

    private JobStateEnum(int value, String title) {
        this.value = value;
        this.title = title;
    }
}
