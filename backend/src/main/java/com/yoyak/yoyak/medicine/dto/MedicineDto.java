package com.yoyak.yoyak.medicine.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class MedicineDto {

    private Long medicineSeq;
    private String imgPath;
    private String itemName;
    private String entpName;
}
