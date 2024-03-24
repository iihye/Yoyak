package com.yoyak.yoyak.medicineEnvelop.controller;

import com.yoyak.yoyak.medicineEnvelop.dto.MedicineEnvelopCreateDto;
import com.yoyak.yoyak.medicineEnvelop.service.MedicineEnvelopService;
import com.yoyak.yoyak.util.dto.BasicResponseDto;
import com.yoyak.yoyak.util.dto.StatusResponseDto;
import com.yoyak.yoyak.util.security.SecurityUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/medicineEnvelop")
@RequiredArgsConstructor
@Slf4j
public class MedicineEnvelopController {

    private final MedicineEnvelopService medicineEnvelopService;

    /**
     * 약 봉투 정보를 받아 등록하고, 등록 결과를 반환하는 메소드
     *
     * @param requestDto
     * @return ResponseEntity<StatusResponseDto>
     */
    @PostMapping
    public ResponseEntity<StatusResponseDto> medicineEnvelopAdd(
        @RequestBody MedicineEnvelopCreateDto requestDto) {

        log.info("약 봉투 등록 - {}", requestDto);

        return ResponseEntity
            .ok()
            .body(medicineEnvelopService.addMedicineEnvelop(requestDto));
    }

    /**
     * 지정한 약 봉투의 약 목록을 조회하는 메소드. 선택적으로 특정 약에 대한 포함여부를 조회.
     *
     * @param itemSeq
     * @return ResponseEntity<BasicResponseDto>
     */
    @GetMapping
    public ResponseEntity<BasicResponseDto> medicineEnvelopList(
        @RequestParam(name = "medicineSeq", required = false) Long itemSeq
    ) {
        Long userSeq = SecurityUtil.getUserSeq();
        log.info("userSeq({})의 약 봉투 조회 {} -", userSeq, itemSeq);

        return ResponseEntity
            .ok()
            .body(medicineEnvelopService.findMedicineEnvelopList(userSeq, itemSeq));
    }


    /**
     * 특정 약 봉투의 약의 간략정보를 조회하는 메소드
     *
     * @param medicineEnvelopSeq
     * @return ResponseEntity<BasicResponseDto>
     */
    @GetMapping("/{medicineEnvelopSeq}")
    public ResponseEntity<BasicResponseDto> medicineEnvelopDetails(
        @PathVariable Long medicineEnvelopSeq) {
        log.info("findMedicineSummaryList - medicineEnvelopSeq={}", medicineEnvelopSeq);

        return ResponseEntity
            .ok()
            .body(medicineEnvelopService.findMedicineSummaryList(medicineEnvelopSeq));
    }
}
