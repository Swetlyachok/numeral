import 'package:numeral/api/helper.dart';

/// Расчёт Вибрации Рождения
int birth(DateTime date) {
  final list = List<int>();
  list.add(date.year);
  list.add(date.month);
  list.add(date.day);
  return calc(list);
}

/// Расчёт Вибрации Имени
// int name()
