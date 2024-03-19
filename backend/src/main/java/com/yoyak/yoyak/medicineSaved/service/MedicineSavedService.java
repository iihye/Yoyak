package com.yoyak.yoyak.medicineSaved.service;

import com.yoyak.yoyak.medicine.domain.Medicine;
import com.yoyak.yoyak.medicine.domain.MedicineRepository;
import com.yoyak.yoyak.medicineEnvelop.domain.MedicineEnvelop;
import com.yoyak.yoyak.medicineEnvelop.domain.MedicineEnvelopRepository;
import com.yoyak.yoyak.medicineSaved.domain.MedicineSaved;
import com.yoyak.yoyak.medicineSaved.domain.MedicineSavedRepository;
import com.yoyak.yoyak.medicineSaved.dto.MedicineToEnvelopRegistrationDto;
import com.yoyak.yoyak.util.dto.StatusResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
@RequiredArgsConstructor
public class MedicineSavedService {

    private final MedicineSavedRepository medicineSavedRepository;
    private final MedicineEnvelopRepository medicineEnvelopRepository;
    private final MedicineRepository medicineRepository;

    @Transactional
    public StatusResponseDto addMedicineToEnvelop(
        MedicineToEnvelopRegistrationDto medicineToEnvelopRegistrationDto) {

        Medicine medicine = medicineRepository.findBySeq(
            medicineToEnvelopRegistrationDto.getMedicineSeq()).orElseThrow();

        for (Long envelopSeq : medicineToEnvelopRegistrationDto.getEnvelopeSeqList()) {
            MedicineEnvelop medicineEnvelop = medicineEnvelopRepository.findById(envelopSeq)
                .orElseThrow();

            MedicineSaved medicineSaved = MedicineSaved.builder()
                .accountSeq(medicineToEnvelopRegistrationDto.getAccountSeq())
                .medicineEnvelop(medicineEnvelop)
                .medicine(medicine).build();

            log.info("medicineSaved={}", medicineSaved);
            medicineSavedRepository.save(medicineSaved);
        }

        return StatusResponseDto.builder()
            .code(200)
            .message("sucess")
            .build();
    }
}
