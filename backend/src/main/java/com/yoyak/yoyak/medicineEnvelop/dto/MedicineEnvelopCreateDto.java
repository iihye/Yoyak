package com.yoyak.yoyak.medicineEnvelop.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Builder
@Setter
@Getter
public class MedicineEnvelopCreateDto {

    private String name;
    private String color;
}
