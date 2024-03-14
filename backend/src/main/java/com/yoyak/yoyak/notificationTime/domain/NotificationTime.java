package com.yoyak.yoyak.notificationTime.domain;

import com.yoyak.yoyak.notification.domain.Notification;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Getter
@Table(name = "notification_time")
public class NotificationTime {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long seq;

    @Column(nullable = false)
    private LocalDate date;

    @Column(nullable = false)
    private LocalDate takenDate;

    @ManyToOne
    @JoinColumn(name = "notification_seq", nullable = false)
    private Notification notification;

}
