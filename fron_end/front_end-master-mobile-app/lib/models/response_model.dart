class ResponseModel{
  final bool _isSuccessfull;
  final String _message;
  ResponseModel( this._isSuccessfull,  this._message);

  String get message =>_message;
  bool get isSuccesfull => _isSuccessfull;

}