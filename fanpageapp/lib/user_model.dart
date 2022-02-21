class User {
  final String firstName;
  final String lastName;

  User({
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap(){
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
