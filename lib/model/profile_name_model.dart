class ProfileNameModel {
  final String firstname;
  final String lastname;

  ProfileNameModel({
    required this.firstname,
    required this.lastname,
  });

  factory ProfileNameModel.fromJson(Map<String, dynamic> json) =>
      ProfileNameModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
      };
}
