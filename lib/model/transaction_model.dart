class TransactionModel {
  final String transactionId;
  String transactionNarration;
  String transactionAmount;
  String transactionType;

  TransactionModel({
      required this.transactionId,
      required this.transactionNarration,
      required this.transactionAmount,
      required this.transactionType
  });
}