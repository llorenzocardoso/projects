sealed class Results {

}

class ErrorResult extends Results{
  final String code;
  ErrorResult({required this.code});
}

class LoadingResult extends Results{

}

class SuccessResult extends Results {

}