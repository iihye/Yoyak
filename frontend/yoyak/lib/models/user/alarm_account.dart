class AlarmAccountModel {
  int? seq;
  String? nickname;
  String? gender;
  String? birth;
  int? profileImg;

  AlarmAccountModel({
    this.seq,
    this.nickname,
    this.gender,
    this.birth,
    this.profileImg,
  });

  AlarmAccountModel.fromJson(Map<String, dynamic> json) {
    seq = json['seq'];
    nickname = json['nickname'];
    gender = json['gender'];
    birth = json['birth'];
    profileImg = json['profileImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seq'] = seq;
    data['nickname'] = nickname;
    data['gender'] = gender;
    data['birth'] = birth;
    data['profileImg'] = profileImg;
    return data;
  }
}
