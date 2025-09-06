class BalanceDetails {
  final int availableBalanceGems;
  final double usdEquivalent;
  final String conversionRate;
  final String withdrawMessage;
  final Activity activity;

  BalanceDetails({
    required this.availableBalanceGems,
    required this.usdEquivalent,
    required this.conversionRate,
    required this.withdrawMessage,
    required this.activity,
  });

  factory BalanceDetails.fromJson(Map<String, dynamic> json) {
    return BalanceDetails(
      availableBalanceGems: json['available_balance_gems'],
      usdEquivalent: json['usd_equivalent'],
      conversionRate: json['conversion_rate'],
      withdrawMessage: json['withdraw_message'],
      activity: Activity.fromJson(json['activity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available_balance_gems': availableBalanceGems,
      'usd_equivalent': usdEquivalent,
      'conversion_rate': conversionRate,
      'withdraw_message': withdrawMessage,
      'activity': activity.toJson(),
    };
  }
}

class Activity {
  final List<Transaction> received;
  final List<Transaction> requested;
  final List<RejectedTransaction> rejected;

  Activity({
    required this.received,
    required this.requested,
    required this.rejected,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      received: List<Transaction>.from(
          json['received'].map((x) => Transaction.fromJson(x))),
      requested: List<Transaction>.from(
          json['requested'].map((x) => Transaction.fromJson(x))),
      rejected: List<RejectedTransaction>.from(
          json['rejected'].map((x) => RejectedTransaction.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'received': List<dynamic>.from(received.map((x) => x.toJson())),
      'requested': List<dynamic>.from(requested.map((x) => x.toJson())),
      'rejected': List<dynamic>.from(rejected.map((x) => x.toJson())),
    };
  }
}

class Transaction {
  final String transactionId;
  final String address;
  final String date;
  final String amount;
  final String statusLabel;
  final String paymentMethod;

  Transaction({
    required this.transactionId,
    required this.address,
    required this.date,
    required this.amount,
    required this.statusLabel,
    required this.paymentMethod,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transaction_id'] ?? '',
      address: json['address'] ?? '',
      date: json['date'],
      amount: json['amount'],
      statusLabel: json['status_label'],
      paymentMethod: json['payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'address': address,
      'date': date,
      'amount': amount,
      'status_label': statusLabel,
      'payment_method': paymentMethod,
    };
  }
}

class RejectedTransaction {
  final String transactionId;
  final String address;
  final String date;
  final String amount;
  final String statusLabel;
  final String paymentMethod;

  RejectedTransaction({
    required this.transactionId,
    required this.address,
    required this.date,
    required this.amount,
    required this.statusLabel,
    required this.paymentMethod,
  });

  factory RejectedTransaction.fromJson(Map<String, dynamic> json) {
    return RejectedTransaction(
      transactionId: json['transaction_id'] ?? 'N/A',
      address: json['address'] ?? 'N/A',
      date: json['date'],
      amount: json['amount'],
      statusLabel: json['status_label'],
      paymentMethod: json['payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'address': address,
      'date': date,
      'amount': amount,
      'status_label': statusLabel,
      'payment_method': paymentMethod,
    };
  }
}
