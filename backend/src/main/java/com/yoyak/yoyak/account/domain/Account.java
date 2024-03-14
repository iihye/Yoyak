package com.yoyak.yoyak.account.domain;

import com.yoyak.yoyak.user.domain.User;
import com.yoyak.yoyak.user.domain.UserGender;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Getter
@Table(name = "account")
public class Account {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long seq;

    @Column(nullable = false, length = 32)
    private String name;

    @Column(nullable = false, length = 32)
    private String nickname;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private UserGender gender;

    @Column(nullable = false)
    private LocalDate birth;

    @Column(nullable = true)
    private String disease;

    @Column(nullable = false)
    private int profileImg;

    @Column(nullable = false)
    private AccountRole role;

    @ManyToOne
    @JoinColumn(name = "user_seq", nullable = false)
    private User user;

}
