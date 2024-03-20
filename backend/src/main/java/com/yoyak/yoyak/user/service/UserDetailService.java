package com.yoyak.yoyak.user.service;

import com.yoyak.yoyak.user.domain.UserRepository;
import com.yoyak.yoyak.util.jwt.JwtUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class UserDetailService {

    private final UserRepository userRepository;
    private final JwtUtil jwtUtil;

    // 정보 가져오기
//    public UserDto loadUserDetail(LoginRequestDto loginRequestDto) {
//        User user = userRepository.findByUserIdAndPassword(loginRequestDto.getUserId())
//            .orElseThrow(() -> new CustomException(CustomExceptionStatus.LOGIN_WRONG));
//
//        return UserDto.builder()
//            .userSeq(user.getSeq())
//            .userId(user.getUserId())
//            .name(user.getName())
//            .nickname(user.getNickname())
//            .gender(user.getGender())
//            .birth(user.getBirth())
//            .platform(user.getPlatform())
//            .build();
//    }

}
