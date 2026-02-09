class ProfileOut {
  final String login;
  final String passwordHash;

  const ProfileOut({
    required this.login,
    required this.passwordHash,
  });
}