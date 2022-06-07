/// doctors : [{"id":2,"name":"rumon","email":"rumon@mail.com","email_verified_at":null,"role":"doctor","created_at":null,"updated_at":null},{"id":4,"name":"prince","email":"prince@mail.com","email_verified_at":null,"role":"doctor","created_at":null,"updated_at":null},{"id":5,"name":"sakil","email":"sakil@mail.com","email_verified_at":null,"role":"doctor","created_at":null,"updated_at":null},{"id":6,"name":"zara","email":"zara@mail.com","email_verified_at":null,"role":"doctor","created_at":null,"updated_at":null}]

class Doctors {

  late int id;
  late String name;
  late String phone;
  late String speciality;
  late String qualification;
  late String experience;
  late String address;
  late String email;
  dynamic emailVerifiedAt;
  late String role;
  dynamic createdAt;
  dynamic updatedAt;

  Doctors({
    required int id,
    required String name,
    required String email,
     String? speciality,
     String? qualification,
     String? experience,
     String? address,
     String? phone,
    dynamic emailVerifiedAt,
    required String role,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    id = id;
    name = name;
    email = email;
    speciality = speciality;
    qualification = qualification;
    experience = experience;
    address = address;
    phone = phone;
    emailVerifiedAt = emailVerifiedAt;
    role = role;
    createdAt = createdAt;
    updatedAt = updatedAt;
  }

  Doctors.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    speciality = json['speciality'];
    qualification = json['qualification'];
    experience = json['experience'];
    address = json['address'];
    phone =   json['phone'] == null ? '01800000000' : json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}
