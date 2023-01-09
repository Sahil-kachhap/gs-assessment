class Rider{
  final String? name;
  final String? phoneNumber;
  final List<String>? localities;
  final String? address;
  final String? pinCode;
  bool? isApproved = false;
  final String? bankAccountNumber;
  final String? ifscNumber;
  final List<String>? documents;

  Rider(
      {this.name,
      this.phoneNumber,
      this.localities,
      this.address,
      this.pinCode,
      this.bankAccountNumber,
      this.ifscNumber,
      this.documents});
}
