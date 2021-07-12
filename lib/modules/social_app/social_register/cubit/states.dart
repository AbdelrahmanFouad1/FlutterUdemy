
abstract class SocialRegisterStates {}

class SocialRegisterInitialStates extends SocialRegisterStates {}

class SocialRegisterLoadingStates extends SocialRegisterStates {}

class SocialRegisterSuccessStates extends SocialRegisterStates {}

class SocialRegisterErrorStates extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorStates(this.error);
}

class SocialChangeRegisterPasswordVisibilityState extends SocialRegisterStates {}