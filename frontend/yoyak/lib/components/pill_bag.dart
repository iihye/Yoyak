import 'package:flutter/material.dart';

class PillBag extends StatefulWidget {
  final String envelopName;
  final int medicineSeq; // 필요한가? 해당 약이 들어있는지 check할 때 사용
  final int accountSeq;
  final String nickname;
  final bool isSavedMedicine; // 해당 약이 들어있는지 true/false로 check
  final VoidCallback onClick; // 선택 시 실행할 콜백 함수

  const PillBag({
    super.key,
    required this.envelopName,
    required this.medicineSeq,
    required this.accountSeq,
    required this.nickname,
    required this.isSavedMedicine,
    required this.onClick,
  });

  @override
  State<PillBag> createState() => _PillBagState();
}

class _PillBagState extends State<PillBag> {
  late bool isSavedMedicine; // 상태 관리

  @override
  void initState() {
    super.initState();
    isSavedMedicine = widget.isSavedMedicine; // 초기값을 위젯에서 받아옴
  }

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   leading: Checkbox(
    //       value: widget.isSavedMedicine,
    //       onChanged: (bool? value) {
    //         // 체크박스 클릭할때마다 상태 변경
    //         setState(() {
    //           isSavedMedicine = value!;
    //         });
    //         widget.onClick(); // 부모 위젯에 이벤트 알림
    //       }),
    //   title: Text(widget.envelopName),
    //   subtitle: Text(widget.nickname),
    // );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Checkbox(
          value: isSavedMedicine,
          onChanged: (bool? value) {
            // 체크박스 클릭할때마다 상태 변경
            setState(() {
              isSavedMedicine = value!;
            });
            widget.onClick(); // 부모 위젯에 이벤트 알림
          },
        ),
        title: Text(widget.envelopName),
        subtitle: Text(widget.nickname),
      ),
    );
  }
}
