package com.yoyak.yoyak.notification.service;

import com.yoyak.yoyak.account.domain.Account;
import com.yoyak.yoyak.account.domain.AccountRepository;
import com.yoyak.yoyak.notification.domain.Notification;
import com.yoyak.yoyak.notification.domain.NotificationRepository;
import com.yoyak.yoyak.notification.dto.NotificationFindDto;
import com.yoyak.yoyak.notification.dto.NotificationModifyDto;
import com.yoyak.yoyak.notification.dto.NotificationRegistDto;
import com.yoyak.yoyak.util.exception.CustomException;
import com.yoyak.yoyak.util.exception.CustomExceptionStatus;
import jakarta.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class NotificationService {

    private final AccountRepository accountRepository;
    private final NotificationRepository notificationRepository;

    // 알람 등록
    public Notification addNotification(NotificationRegistDto notificationRegistDto) {
        Account account = accountRepository.findById(notificationRegistDto.getAccountSeq())
            .orElseThrow(() -> new CustomException(CustomExceptionStatus.ACCOUNT_INVALID));

        Notification notification = Notification.builder()
            .name(notificationRegistDto.getName())
            .startDate(notificationRegistDto.getStartDate())
            .endDate(notificationRegistDto.getEndDate())
            .period(notificationRegistDto.getPeriod())
            .time(notificationRegistDto.getTime())
            .createDate(LocalDateTime.now())
            .account(account)
            .build();

        return notificationRepository.save(notification);
    }

    // 알림 상세 보기
    public List<NotificationFindDto> findNotification(Long notiSeq) {
        List<NotificationFindDto> notificationFindDtos = new ArrayList<>();

        Notification notification = notificationRepository.findById(notiSeq)
            .orElseThrow(() -> new CustomException(CustomExceptionStatus.NOTI_INVALID));

        NotificationFindDto notificationFindDto = NotificationFindDto.builder()
            .notiSeq(notification.getSeq())
            .name(notification.getName())
            .startDate(notification.getStartDate())
            .endDate(notification.getEndDate())
            .period(notification.getPeriod())
            .time(notification.getTime())
            .build();

        notificationFindDtos.add(notificationFindDto);

        return notificationFindDtos;
    }

    // 알람 수정
    public Notification modifyNotification(NotificationModifyDto notificationModifyDto) {
        Notification notification = notificationRepository.findById(
                notificationModifyDto.getNotiSeq())
            .orElseThrow(() -> new CustomException(CustomExceptionStatus.NOTI_INVALID));

        notification.modifyNotification(notificationModifyDto);

        return notification;
    }

    // 알람 삭제
    public void removeNotification(Long notiSeq) {
        Notification notification = notificationRepository.findById(notiSeq)
            .orElseThrow(() -> new CustomException(CustomExceptionStatus.NOTI_INVALID));

        notificationRepository.delete(notification);
    }
}
