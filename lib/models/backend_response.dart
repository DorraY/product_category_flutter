class BackendResponse {
  bool error;
  Object data;

  BackendResponse(this.error, this.data);

  factory BackendResponse.fromJson(Map<String, dynamic> json) {
    return BackendResponse(
      json['error'] as bool,
      json['data'] as Object,
    );
  }

}