package com.yoyak.yoyak.medicineDetail.domain;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MedicineDetailRepository extends JpaRepository<MedicineDetail, Integer> {

    Optional<MedicineDetail> findBySeq(Long Seq);
}
