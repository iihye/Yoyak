package com.yoyak.yoyak.util.jwt;

import com.yoyak.yoyak.util.dto.UserDto;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import java.security.Key;
import java.time.ZonedDateTime;
import java.util.Date;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class JwtUtil {

    private final Key key;
    private final long accessTokenExpTime;

    public JwtUtil(
        @Value("${jwt.secret}") String secretKey,
        @Value("${jwt.expiration_time}") long accessTokenExpTime
    ) {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        this.key = Keys.hmacShaKeyFor(keyBytes);
        this.accessTokenExpTime = accessTokenExpTime;
    }

    /**
     * Access Token 생성
     *
     * @param user
     * @return Access Token String
     */
    public String createAccessToken(UserDto user) {
        return createToken(user, accessTokenExpTime);
    }


    /**
     * JWT 생성
     *
     * @param user
     * @param expireTime
     * @return JWT String
     */
    private String createToken(UserDto user, long expireTime) {
        Claims claims = Jwts.claims();
        claims.put("userSeq", user.getUserSeq());
        claims.put("userId", user.getUserId());
        claims.put("name", user.getName());
        claims.put("nickname", user.getNickname());
        claims.put("gender", user.getGender());
//        claims.put("birth", user.getBirth());
        claims.put("platform", user.getPlatform());

        ZonedDateTime now = ZonedDateTime.now();
        ZonedDateTime tokenValidity = now.plusSeconds(expireTime);

        return Jwts.builder()
            .setClaims(claims)
            .setIssuedAt(Date.from(now.toInstant()))
            .setExpiration(Date.from(tokenValidity.toInstant()))
            .signWith(key, SignatureAlgorithm.HS256)
            .compact();
    }


    /**
     * Token에서 User ID 추출
     *
     * @param token
     * @return userSeq
     */
    public Long getUserSeq(String token) {
        return parseClaims(token).get("userSeq", Long.class);
    }


    /**
     * JWT 검증
     *
     * @param token
     * @return IsValidate
     */
    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
            return true;
        } catch (io.jsonwebtoken.security.SecurityException | MalformedJwtException e) {
            log.info("Invalid JWT Token", e);
        } catch (ExpiredJwtException e) {
            log.info("Expired JWT Token", e);
        } catch (UnsupportedJwtException e) {
            log.info("Unsupported JWT Token", e);
        } catch (IllegalArgumentException e) {
            log.info("JWT claims string is empty.", e);
        }
        return false;
    }


    /**
     * JWT Claims 추출
     *
     * @param accessToken
     * @return JWT Claims
     */
    public Claims parseClaims(String accessToken) {
        try {
            return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(accessToken)
                .getBody();
        } catch (ExpiredJwtException e) {
            return e.getClaims();
        }
    }


}