package com.example.onlineshop.enumirations;

public enum ExceptionMessageCode {
    USER_NOT_FOUND_USERNAME("user.not.found.username"),
    USER_NOT_FOUND_ID("user.not.found.id"),
    USER_NOT_FOUND_EMAIL("user.not.found.email"),

    ROLE_NOT_FOUND_NAME("role.not.found.name"),
    ROLE_NOT_FOUND_BY_ID("role.not.found.id"),

    PRODUCT_NOT_FOUND_NAME("product.not.found.name"),
    PRODUCT_NOT_FOUND_ID("product.not.found.id"),

    CATEGORY_NOT_FOUND_NAME("category.not.found.name"),
    CATEGORY_NOT_FOUND_ID("category.not.found.id"),

    ORDER_NOT_FOUND_ID("order.not.found.id"),

    ORDER_ITEM_NOT_FOUND_ID("order.item.not.found.id");

    private final String messageCode;

    ExceptionMessageCode(String messageCode) {
        this.messageCode = messageCode;
    }

    public String getMessageCode() {
        return messageCode;
    }
}
