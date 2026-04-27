class User {
  final int? id;
  final String passwordHash;
  final String securityQ1Answer; // Place of birth
  final String securityQ2Answer; // Shop opening date

  User({
    this.id,
    required this.passwordHash,
    required this.securityQ1Answer,
    required this.securityQ2Answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password_hash': passwordHash,
      'security_q1_answer': securityQ1Answer,
      'security_q2_answer': securityQ2Answer,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      passwordHash: map['password_hash'],
      securityQ1Answer: map['security_q1_answer'],
      securityQ2Answer: map['security_q2_answer'],
    );
  }
}
