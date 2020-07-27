String dateValidator(String date) {
  if (date == null || date.isEmpty) return 'Необходимо ввести дату рождения';
  if (date.length != 10) return 'Необходим формат дд.мм.гггг';
  return null;
}
