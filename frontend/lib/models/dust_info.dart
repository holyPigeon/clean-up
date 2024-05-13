// ignore_for_file: public_member_api_docs, sort_constructors_first
class DustInfo {
  String nox;
  String sox;
  DustInfo({
    required this.nox,
    required this.sox,
  });
  factory DustInfo.fromJson(Map<String, dynamic> json) {
    return DustInfo(
      nox: json['data']['no2Value'],
      sox: json['data']['so2Value'],
    );
  }
}
