import '../../domain/entities/bank.dart';

class BankModel extends Bank {
  BankModel({
    required super.id,
    required super.name,
    super.accountNumber,
    super.accountName,
    super.iban,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'] as String,
      name: json['name'] as String,
      accountNumber: json['account_number'] as String?,
      accountName: json['account_name'] as String?,
      iban: json['iban'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'account_number': accountNumber,
      'account_name': accountName,
      'iban': iban,
    };
  }
}
