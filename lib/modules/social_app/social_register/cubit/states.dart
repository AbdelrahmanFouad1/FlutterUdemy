
abstract class SocialRegisterStates {}

class SocialRegisterInitialStates extends SocialRegisterStates {}

class SocialRegisterLoadingStates extends SocialRegisterStates {}

class SocialRegisterSuccessStates extends SocialRegisterStates {}

class SocialRegisterErrorStates extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorStates(this.error);
}

class SocialCreateSuccessStates extends SocialRegisterStates {}

class SocialCreateErrorStates extends SocialRegisterStates {
  final String error;

  SocialCreateErrorStates(this.error);
}

class SocialChangeRegisterPasswordVisibilityState extends SocialRegisterStates {}