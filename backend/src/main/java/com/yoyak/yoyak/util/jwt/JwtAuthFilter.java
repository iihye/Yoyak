package com.yoyak.yoyak.util.jwt;

import com.yoyak.yoyak.user.domain.User;
import com.yoyak.yoyak.user.service.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

@RequiredArgsConstructor
public class JwtAuthFilter extends OncePerRequestFilter { // OncePerRequestFilter -> 한 번 실행 보장

    private final UserService userService;
    private final JwtUtil jwtUtil;

    @Override
    /**
     * JWT 토큰 검증 필터 수행
     */
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
        FilterChain filterChain) throws ServletException, IOException {
        String authorizationHeader = request.getHeader("Authorization");

        //JWT가 헤더에 있는 경우
        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer")) {
            String token = authorizationHeader.substring(7);
            //JWT 유효성 검증
            if (jwtUtil.validateToken(token)) {
                Long userSeq = jwtUtil.getUserSeq(token);

                //유저와 토큰 일치 시 userDetails 생성
                User user = userService.findById(userSeq);
//                UserDto userDto = customUserDetailsService.loadUserByUsername(
//                    userSeq.toString());

                if (user != null) {
                    //UserDetsils, Password, Role -> 접근권한 인증 Token 생성
                    UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
                        new UsernamePasswordAuthenticationToken(user, null);

                    //현재 Request의 Security Context에 접근권한 설정
                    SecurityContextHolder.getContext()
                        .setAuthentication(usernamePasswordAuthenticationToken);
                }
            }
        }

        filterChain.doFilter(request, response); // 다음 필터로 넘기기
    }
}