class LoginCredentialsDTO {
  final String email;
  final String password;

  LoginCredentialsDTO(this.email, this.password);

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class RegisterCredentialsDTO {
  final String email;
  final String password;
  final String name;

  RegisterCredentialsDTO(this.email, this.password, this.name);

  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'name': name};
}
