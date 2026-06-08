class Bank {
  final String id;
  final String name;
  final String? accountNumber;
  final String? accountName;
  final String? iban;

  Bank({
    required this.id,
    required this.name,
    this.accountNumber,
    this.accountName,
    this.iban,
  });
}
