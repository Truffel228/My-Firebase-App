class AuthServiceException implements Exception{
  AuthServiceException({required this.code});
  final String code;
}