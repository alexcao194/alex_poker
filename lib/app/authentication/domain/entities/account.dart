class Account {
  const Account({this.name, required this.email, required this.password, this.rePassword});
  
  final String? name;
  final String email;
  final String password;
  final String? rePassword;
}