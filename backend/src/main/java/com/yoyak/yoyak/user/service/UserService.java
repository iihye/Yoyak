package com.yoyak.yoyak.user.service;

import com.yoyak.yoyak.user.domain.User;
import com.yoyak.yoyak.user.domain.UserRepository;
import com.yoyak.yoyak.util.exception.CustomException;
import com.yoyak.yoyak.util.exception.CustomExceptionStatus;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class UserService {

    private final UserRepository userRepository;

    public User findById(Long seq) {
        return userRepository.findById(seq)
            .orElseThrow(() -> new CustomException(CustomExceptionStatus.USER_INVALID));
    }
}
