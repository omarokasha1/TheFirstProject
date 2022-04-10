bool isPasswordCharacters = false;
bool hasPasswordNumber = false;
bool hasEmailValid = false;

onPasswordChanged(String password) {
  final numericRegex = RegExp(r'[0-9]');
  isPasswordCharacters = false;
  if (password.length >= 8) {
    isPasswordCharacters = true;
  }
  hasPasswordNumber = false;
  if (numericRegex.hasMatch(password)) {
    hasPasswordNumber = true;
  }
}

onEmailChanged(String email)
{
  final emailValid =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  hasEmailValid =false;
  if(emailValid.hasMatch(email)){
    hasEmailValid = true;
  }
}