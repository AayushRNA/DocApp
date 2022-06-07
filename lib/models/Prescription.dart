/// prescriptions : [{"id":1,"doctor_id":4,"patient_id":2,"appointment_id":3,"date":"2022-05-06 12:16:51","medicine":"wwwww","dosage":"www","instruction":"wwwwwwwwww","created_at":"2022-05-06T12:16:51.000000Z","updated_at":"2022-05-06T12:16:51.000000Z"},{"id":2,"doctor_id":4,"patient_id":2,"appointment_id":3,"date":"2022-05-06 12:16:52","medicine":"wwwww","dosage":"www","instruction":"wwwwwwwwww","created_at":"2022-05-06T12:16:52.000000Z","updated_at":"2022-05-06T12:16:52.000000Z"},{"id":3,"doctor_id":4,"patient_id":2,"appointment_id":3,"date":"2022-05-06 12:16:57","medicine":"ssssss","dosage":"ssssssssssss","instruction":"sssssssssssssssss","created_at":"2022-05-06T12:16:57.000000Z","updated_at":"2022-05-06T12:16:57.000000Z"},{"id":4,"doctor_id":4,"patient_id":2,"appointment_id":3,"date":"2022-05-06 12:17:27","medicine":"ssssss","dosage":"ssssssssssss","instruction":"sssssssssssssssss","created_at":"2022-05-06T12:17:27.000000Z","updated_at":"2022-05-06T12:17:27.000000Z"},{"id":5,"doctor_id":4,"patient_id":2,"appointment_id":3,"date":"2022-05-06 12:17:37","medicine":"ssssss","dosage":"ssssssssssss","instruction":"sssssssssssssssss","created_at":"2022-05-06T12:17:37.000000Z","updated_at":"2022-05-06T12:17:37.000000Z"}]



/// id : 1
/// doctor_id : 4
/// patient_id : 2
/// appointment_id : 3
/// date : "2022-05-06 12:16:51"
/// medicine : "wwwww"
/// dosage : "www"
/// instruction : "wwwwwwwwww"
/// created_at : "2022-05-06T12:16:51.000000Z"
/// updated_at : "2022-05-06T12:16:51.000000Z"

class Prescriptions {
  late int id;
  late String doctorId;
  late String patientId;
  late String appointmentId;
  late String? date = null;
  late String medicine;
  late String dosage;
  late String instruction;
  late String createdAt;
  late String updatedAt;

  Prescriptions({
      required this.id,
      required this.doctorId,
      required this.patientId,
      required this.appointmentId,
      this.date,
      required this.medicine,
      required this.dosage,
      required this.instruction,
      required this.createdAt,
      required this.updatedAt,});

  Prescriptions.fromJson(dynamic json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    appointmentId = json['appointment_id'];
    date = json['date'];
    medicine = json['medicine'];
    dosage = json['dosage'];
    instruction = json['instruction'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }



}