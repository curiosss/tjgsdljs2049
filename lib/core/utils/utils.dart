// final numberFormat = NumberFormat('# ###');

String seperateThousands(num input) {
  String num = input.toInt().toString();
  String output = '';
  while (num.length > 3) {
    output = '${num.substring(num.length - 3)} $output';
    num = num.substring(0, num.length - 3);
  }
  if (num.isNotEmpty) {
    output = '$num $output';
  }
  return output.trim();
}
