package com.zzu.common.enums;

/**
 * 公司认证状态枚举
 */
public enum CompanyAuditStateEnum {
    UNAUTH_COMPANY(0, "未认证"),
    AUDITING_COMPANY(1, "认证中"),
    AUDITED_COMPANY(2, "已认证");

    private int value;
    private String title;

    private CompanyAuditStateEnum(int value, String title) {
        this.value = value;
        this.title = title;
    }
}
