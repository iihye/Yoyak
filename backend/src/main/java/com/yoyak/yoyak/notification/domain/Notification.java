package com.yoyak.yoyak.notification.domain;

import com.yoyak.yoyak.account.domain.Account;
import jakarta.persistence.*;
import lombok.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Getter
@Table(name = "notification")
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long seq;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private LocalDate startDate;

    @Column(nullable = false)
    private LocalDate endDate;

    @Column(nullable = false)
    private List<DayOfWeek> period;

    @Column(nullable = false)
    private LocalDate createDate;

    @Column(nullable = true)
    private LocalDate modifyDate;

    @ManyToOne
    @JoinColumn(name = "account_seq", nullable = false)
    private Account account;

}
