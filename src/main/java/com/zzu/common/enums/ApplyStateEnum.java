package com.zzu.common.enums;

/**
 * 职位申请状态枚举
 */
public enum ApplyStateEnum {

    APPLYING_APPLY(0, "申请中"),
    SUCCESS_APPLY(1, "申请失败"),
    FAIL_APPLY(2, "申请成功");

    private int value;
    private String title;

    private ApplyStateEnum(int value, String title) {
        this.value = value;
        this.title = title;
    }
}
