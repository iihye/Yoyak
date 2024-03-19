package com.yoyak.yoyak.medicineEnvelop.domain;

import com.yoyak.yoyak.medicineEnvelop.dto.MedicineSummaryDto;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface MedicineEnvelopRepository extends JpaRepository<MedicineEnvelop, Long> {

    @Query(
        "SELECT new com.yoyak.yoyak.medicineEnvelop.dto.MedicineSummaryDto(m.medicine.seq, m.medicine.itemName, m.medicine.imgPath) "
            + "FROM MedicineSaved m WHERE m.medicineEnvelop.seq = :medicineEnvelopSeq")
    List<MedicineSummaryDto> findMedicineSummaryByEnvelopSeq(Long medicineEnvelopSeq);
}
