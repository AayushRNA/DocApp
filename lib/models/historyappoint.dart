/// historyappoint : [{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"natok","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"},{"subject":"dddddddd","created_at":"2022-05-10T00:00:00.000000Z","doctor_name":"prince"}]


/// subject : "dddddddd"
/// created_at : "2022-05-10T00:00:00.000000Z"
/// doctor_name : "prince"

class Historyappoint {

  late String subject;
  late String createdAt;
  late String doctorName;

  Historyappoint({
      required this.subject,
      required this.createdAt,
      required this.doctorName,});

  Historyappoint.fromJson(dynamic json) {
    subject = json['subject'];
    createdAt = json['created_at'];
    doctorName = json['doctor_name'];
  }

Historyappoint copyWith({  required String subject,
  required String createdAt,
  required String doctorName,
}) => Historyappoint(  subject: subject ,
  createdAt: createdAt,
  doctorName: doctorName ,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subject'] = subject;
    map['created_at'] = createdAt;
    map['doctor_name'] = doctorName;
    return map;
  }

}