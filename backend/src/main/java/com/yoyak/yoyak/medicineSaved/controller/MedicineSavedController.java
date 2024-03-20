package com.yoyak.yoyak.medicineSaved.controller;

import com.yoyak.yoyak.medicineSaved.dto.MedicineFromEnvelopeRemovalDto;
import com.yoyak.yoyak.medicineSaved.dto.MedicineToEnvelopRegistrationDto;
import com.yoyak.yoyak.medicineSaved.service.MedicineSavedService;
import com.yoyak.yoyak.util.dto.StatusResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/medicineSaved")
@RequiredArgsConstructor
@Slf4j
public class MedicineSavedController {

    private final MedicineSavedService medicineSavedService;

    @PostMapping()
    public StatusResponseDto addMedicineToEnvelop(
        @RequestBody MedicineToEnvelopRegistrationDto medicineToEnvelopeRegistrationDto) {

        log.info("addMedicineToEnvelop={}", medicineToEnvelopeRegistrationDto);

        return medicineSavedService.addMedicineToEnvelop(medicineToEnvelopeRegistrationDto);
    }

    @DeleteMapping
    public ResponseEntity<StatusResponseDto> deleteMedicineToEnvelop(
        @RequestBody MedicineFromEnvelopeRemovalDto requestDto) {

        log.info("deleteMedicineToEnvelop={}", requestDto);

        return ResponseEntity.ok().body(
            medicineSavedService.deleteMedicineToEnvelop(requestDto));
    }
}
