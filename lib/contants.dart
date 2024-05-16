const BaseUrl = "http://10.0.2.2:3000";

// const imageUrl = "http://172.16.43.234:3000/";
// const imageUrl = "http://192.168.202.1:3000/";
const imageUrl = "http://192.168.202.1:3000/";

String formatCurrency(num amount) {
  final roundedAmount = amount.toStringAsFixed(2);
  final parts = roundedAmount.split('.');
  final currency = parts[0].replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );
  final decimals = parts[1] == '00' ? '' : '.${parts[1]}';
  return '$currency$decimals';
}

