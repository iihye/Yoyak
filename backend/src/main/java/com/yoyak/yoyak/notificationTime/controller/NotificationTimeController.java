package com.yoyak.yoyak.notificationTime.controller;

import com.yoyak.yoyak.notification.dto.NotificationListDto;
import com.yoyak.yoyak.notificationTime.dto.MedicationDto;
import com.yoyak.yoyak.notificationTime.dto.NotificationTimeAccountSeqDto;
import com.yoyak.yoyak.notificationTime.service.NotificationTimeService;
import com.yoyak.yoyak.util.dto.BasicResponseDto;
import com.yoyak.yoyak.util.dto.StatusResponseDto;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/noti/check")
public class NotificationTimeController {

    private final NotificationTimeService notificationTimeService;

    // 알림 목록
    @GetMapping()
    public BasicResponseDto notificationList(
        @RequestBody NotificationTimeAccountSeqDto notificationTimeAccountSeqDto) {
        List<NotificationListDto> notificationListDtos = notificationTimeService.findNotification(
            notificationTimeAccountSeqDto);

        BasicResponseDto basicResponseDto = BasicResponseDto.builder()
            .count(notificationListDtos.size())
            .result(notificationListDtos)
            .build();

        return basicResponseDto;
    }

    // 알림 삭제
    @DeleteMapping("/{notiSeq}")
    public StatusResponseDto notificationRemove(@PathVariable Long notiSeq) {
        notificationTimeService.removeNotification(notiSeq);

        StatusResponseDto statusResponseDto = StatusResponseDto.builder()
            .code(200)
            .message("알림 삭제 성공")
            .build();

        return statusResponseDto;
    }

    // 복용 등록
    @PutMapping()
    public StatusResponseDto addMedication(
        @RequestBody MedicationDto medicationDto) {
        notificationTimeService.addMedication(medicationDto);

        StatusResponseDto statusResponseDto = StatusResponseDto.builder()
            .code(200)
            .message("복용 등록 성공")
            .build();

        return statusResponseDto;
    }

}
