extension StringX on String {
  bool get isArabic => this.startsWith(RegExp(r'[\u0600-\u06FF]'));
}