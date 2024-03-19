package com.yoyak.yoyak.notification.controller;

import com.yoyak.yoyak.notification.domain.Notification;
import com.yoyak.yoyak.notification.dto.NotificationFindDto;
import com.yoyak.yoyak.notification.dto.NotificationModifyDto;
import com.yoyak.yoyak.notification.dto.NotificationRegistDto;
import com.yoyak.yoyak.notification.service.NotificationService;
import com.yoyak.yoyak.notificationTime.service.NotificationTimeService;
import com.yoyak.yoyak.util.dto.BasicResponseDto;
import com.yoyak.yoyak.util.dto.StatusResponseDto;
import java.time.LocalDate;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/noti")
public class NotificationController {

    private final NotificationService notificationService;
    private final NotificationTimeService notificationTimeService;

    // 알림 등록
    @PostMapping()
    public StatusResponseDto notificationAdd(
        @RequestBody NotificationRegistDto notificationRegistDto) {
        Notification notification = notificationService.addNotification(notificationRegistDto);
        notificationTimeService.addNotification(notificationRegistDto, notification);

        StatusResponseDto statusResponseDto = StatusResponseDto.builder()
            .code(200)
            .message("알림 등록 성공")
            .build();

        return statusResponseDto;
    }

    // 알림 상세 보기
    @GetMapping("/{notiSeq}")
    public BasicResponseDto notificationDetail(@PathVariable Long notiSeq) {
        List<NotificationFindDto> notificationFindDto = notificationService.findNotification(
            notiSeq);

        BasicResponseDto basicResponseDto = BasicResponseDto.builder()
            .count(1)
            .result(notificationFindDto)
            .build();

        return basicResponseDto;
    }

    // 알림 수정
    @PutMapping()
    public StatusResponseDto notificationModify(
        @RequestBody NotificationModifyDto notificationModifyDto) {
        Notification notification = notificationService.modifyNotification(notificationModifyDto);

        NotificationRegistDto notificationRegistDto = new NotificationRegistDto();
        notificationRegistDto.setName(notificationModifyDto.getName());
        notificationRegistDto.setStartDate(LocalDate.now());
        notificationRegistDto.setEndDate(notificationModifyDto.getEndDate());
        notificationRegistDto.setPeriod(notificationModifyDto.getPeriod());
        notificationRegistDto.setTime(notificationModifyDto.getTime());

        notificationTimeService.removeNotification(notificationModifyDto.getNotiSeq());
        notificationTimeService.addNotification(notificationRegistDto, notification);

        StatusResponseDto statusResponseDto = StatusResponseDto.builder()
            .code(200)
            .message("알림 수정 성공")
            .build();

        return statusResponseDto;
    }


}
