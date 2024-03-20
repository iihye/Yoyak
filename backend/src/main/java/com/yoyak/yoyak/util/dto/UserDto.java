package com.yoyak.yoyak.util.dto;

import com.yoyak.yoyak.user.domain.UserGender;
import com.yoyak.yoyak.user.domain.UserPlatform;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {

    private Long userSeq;
    private String userId;
    private String name;
    private String nickname;
    private UserGender gender;
    private LocalDate birth;
    private UserPlatform platform;

}
