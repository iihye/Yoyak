package com.yoyak.yoyak.medicineEnvelop.controller;

import com.yoyak.yoyak.medicineEnvelop.dto.MedicineEnvelopCreateDto;
import com.yoyak.yoyak.medicineEnvelop.service.MedicineEnvelopService;
import com.yoyak.yoyak.util.dto.BasicResponseDto;
import com.yoyak.yoyak.util.dto.StatusResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/medicineEnvelop")
@RequiredArgsConstructor
@Slf4j
public class MedicineEnvelopController {

    private final MedicineEnvelopService medicineEnvelopService;

    @PostMapping
    public StatusResponseDto medicineEnvelopAdd(
        @ModelAttribute MedicineEnvelopCreateDto medicineEnvelopCreateDto) {

        log.info("약 봉투 등록 - Name: {}, Color: {}", medicineEnvelopCreateDto.getName(),
            medicineEnvelopCreateDto.getColor());

        return medicineEnvelopService.addMedicineEnvelop(medicineEnvelopCreateDto);
    }

    @GetMapping
    public BasicResponseDto medicineEnvelopList(
        @RequestParam(name = "userSeq", required = true) Long userSeq,
        @RequestParam(name = "itemSeq", required = false) Long itemSeq
    ) {

        log.info("userSeq({})의 약 봉투 조회 {} -", userSeq, itemSeq);

        return medicineEnvelopService.findMedicineEnvelopList(userSeq, itemSeq);
    }


    @GetMapping("/{medicineEnvelopSeq}")
    public BasicResponseDto medicineEnvelopDetails(@PathVariable Long medicineEnvelopSeq) {
        log.info("findMedicineSummaryList - medicineEnvelopSeq={}", medicineEnvelopSeq);
        return medicineEnvelopService.findMedicineSummaryList(medicineEnvelopSeq);
    }
}
