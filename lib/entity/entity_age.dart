class Age {
  final int years;
  final int months;
  final int days;

  Age({required this.years, required this.months, required this.days});

  @override
  String toString() {
    return '$years years, $months months, and $days days';
  }
}