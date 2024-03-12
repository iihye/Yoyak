package com.yoyak.yoyak.util.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum CustomExceptionStatus {
    // user 관련
    WRONG_ID(1001, "잘못된 아이디입니다"),
    WRONG_PW(1002, "잘못된 비밀번호입니다");

    private final Integer code;
    private final String message;
}