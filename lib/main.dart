import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:numeral/screen2.dart';
import 'package:numeral/ui/utils/date_validator.dart';
import 'package:numeral/ui/utils/upper_formatter.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  bool _hasError = false;
  String _lastName;
  String _name;
  String _middleName;
  String _date;
  String _letters;
  final dataMaskFormatter = MaskTextInputFormatter(mask: '##.##.####');

  final _lastNameFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _middleNameFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  final _lettersFocusNode = FocusNode();
  final _buttonFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

//поле фамилии
  Widget _buildLastName() {
    return TextFormField(
      autofocus:
          true, //при открытии экрана курсор автоматически ставится в это поле
      focusNode: _lastNameFocusNode,
      decoration: _buildInputDec('Фамилия'),
      keyboardType: TextInputType.text, //клавиатура
      validator: _buildValidator('Необходимо ввести фамилию'), //проверка ввода
      onSaved: (String value) {
        _lastName = value;
      },
      onEditingComplete: () {
        FocusScope.of(context)
            .requestFocus(_nameFocusNode); //шаг курсора к полю "Имя"
      },
      textInputAction: TextInputAction.next,
      inputFormatters: [
        UpperInputFormatter()
      ], //верхний регистр ввода //рисут кнопку ввода на клавиатуре в виде стрелки
    );
  }

//поле имени
  Widget _buildName() {
    return TextFormField(
      focusNode: _nameFocusNode, //
      decoration: _buildInputDec('Имя'),
      keyboardType: TextInputType.text, //клавиатура
      validator: _buildValidator('Необходимо ввести имя'), //проверка ввода
      onSaved: (String value) {
        _name = value;
      },
      onEditingComplete: () {
        FocusScope.of(context)
            .requestFocus(_middleNameFocusNode); //шаг курсора к полю "Отчество"
      },
      textInputAction: TextInputAction.next,
      inputFormatters: [
        UpperInputFormatter()
      ], //верхний регистр ввода //рисут кнопку ввода на клавиатуре в виде стрелки
    );
  }

//поле отчества
  Widget _buildMiddleName() {
    return TextFormField(
      focusNode: _middleNameFocusNode,
      decoration: _buildInputDec('Отчество'),
      keyboardType: TextInputType.text, //клавиатура
      validator: _buildValidator('Необходимо ввести отчество'), //проверка ввода
      onSaved: (String value) {
        _middleName = value;
      },
      onEditingComplete: () {
        FocusScope.of(context)
            .requestFocus(_dateFocusNode); //шаг курсора к полю "Дата рождения"
      },
      textInputAction: TextInputAction.next,
      inputFormatters: [
        UpperInputFormatter()
      ], //верхний регистр ввода //рисут кнопку ввода на клавиатуре в виде стрелки
    );
  }

//поле даты рождения
  Widget _buildDate() {
    return TextFormField(
      focusNode: _dateFocusNode,
      decoration: _buildInputDec('Дата рождения (дд.мм.гггг)'),
      keyboardType: TextInputType.number, //клавиатура
      validator: dateValidator, //проверка ввода
      onSaved: (String value) {
        _date = value;
      },
      inputFormatters: [dataMaskFormatter],
      onEditingComplete: () {
        FocusScope.of(context)
            .requestFocus(_lettersFocusNode); //шаг курсора к полю "Подпись"
      },
      textInputAction: TextInputAction
          .next, //рисут кнопку ввода на клавиатуре в виде стрелки
    );
  }

//поле подписи
  Widget _buildLetters() {
    return TextFormField(
      focusNode: _lettersFocusNode,
      decoration: _buildInputDec('Буквы, присутствующие в подписи'),
      keyboardType: TextInputType.text, //клавиатура
      validator:
          _buildValidator('Необходимо ввести буквы подписи'), //проверка ввода
      onSaved: (String value) {
        _letters = value;
      },

      onEditingComplete: _onCommit, //расчёта портрета с клавиатуры
      textInputAction: TextInputAction.done,
      inputFormatters: [UpperInputFormatter()], //верхний регистр ввода
    );
  }

//Метод кнопки (расчёта портрета с кнопки)
  void _onCommit() {
    FocusScope.of(context).requestFocus(_buttonFocusNode);
    final error = !_formKey.currentState.validate();
    setState(() {
      _hasError = error;
    });
    if (error) {
      return;
    }

    _formKey.currentState.save();

    print(_lastName);
    print(_name);
    print(_middleName);
    print(_date);
    print(_letters);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondScreen()));
  }

  //объединение свойств полей
  InputDecoration _buildInputDec(String hint) {
    return InputDecoration(
      labelText: !_hasError ? hint : null,
      errorStyle: TextStyle(color: Colors.blue),
    );
  }

  //объединение проверки ввода в поля всех, кроме даты рождения
  String Function(String) _buildValidator(String error) {
    return (String value) {
      if (value.isEmpty) {
        return error;
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Ввод данных"))),
      body: Container(
        padding: const EdgeInsets.all(24.0), //отступ данных слева
        //margin: EdgeInsets.all(24),  // можно и так сделать отступ...
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Spacer(flex: 1),
              Expanded(
                //прокрутка списка
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLastName(),
                      _buildName(),
                      _buildMiddleName(),
                      _buildDate(),
                      _buildLetters(),
                    ],
                  ),
                ),
              ),
              // Spacer(flex: 2),
              //Минимальное расстрояние между последним полем и кнопкой
              SizedBox(height: 16),
              //кнопка
              RaisedButton(
                focusNode: _buttonFocusNode,
                child: Text(
                  'Портрет'.toUpperCase(),
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: _onCommit,
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(body: new FormScreen())));
}
