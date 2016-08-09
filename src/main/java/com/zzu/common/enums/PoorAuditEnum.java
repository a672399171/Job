package com.zzu.common.enums;

/**
 * 贫困生审核状态
 */
public enum PoorAuditEnum {

    NO_POOR(0, "未申请"),
    AUDITING_POOR(1, "审核中"),
    SUCCESS_POOR(2, "审核成功"),
    FAIL_POOR(3, "审核失败");

    private int value;
    private String title;

    private PoorAuditEnum(int value, String title) {
        this.value = value;
        this.title = title;
    }

    public int value() {
        return value;
    }
}
