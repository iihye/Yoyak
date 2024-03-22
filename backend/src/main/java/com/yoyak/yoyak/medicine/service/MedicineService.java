package com.yoyak.yoyak.medicine.service;

import com.yoyak.yoyak.medicine.domain.MedicineRepository;
import com.yoyak.yoyak.medicine.dto.MedicineDto;
import com.yoyak.yoyak.medicine.dto.MedicineSearchParametersDto;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class MedicineService {

    private final MedicineRepository medicineRepository;

    public List<MedicineDto> findMedicine(MedicineSearchParametersDto parameters) {
        log.info("param={}", parameters.getFormCodeName());
        return medicineRepository.findByParameters(
            parameters.getSearchName(),
            parameters.getDrugShape(),
            parameters.getColorClass(),
            parameters.getFormCodeName(),
            parameters.getLine());
    }
}
