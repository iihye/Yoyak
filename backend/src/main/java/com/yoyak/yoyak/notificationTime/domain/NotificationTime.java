package com.yoyak.yoyak.notificationTime.domain;

import com.yoyak.yoyak.notification.domain.Notification;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.time.LocalTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

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
    private LocalDateTime time;

    @Column(nullable = true)
    private LocalTime takenTime;

    @ManyToOne
    @JoinColumn(name = "notification_seq", nullable = false)
    private Notification notification;

    public void modifyNotificationTime(LocalTime takenTime) {
        this.takenTime = takenTime;
    }

}
