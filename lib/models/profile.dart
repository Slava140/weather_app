class ProfileIn {
  final String login;
  final String password;

  const ProfileIn({
    required this.login,
    required this.password,
  });
}

class ProfileOut {
  final String login;
  final String passwordHash;

  const ProfileOut({
    required this.login,
    required this.passwordHash,
  });
}