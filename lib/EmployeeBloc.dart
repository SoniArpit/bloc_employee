// TODO: imports

// TODO: List of employees

// TODO: Stream controllers

// TODO: Stream Sink getter

// TODO: Constructor - add data; listen to changes

// TODO: Core functions

// TODO: dispose

import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  // sink to add in pipe
  // stream to get data from pipe
  // by pipe i mean data flow

  List<Employee> _employeeList = [
    Employee(1, "Ron", 10000.0),
    Employee(2, "Harry", 20000.0),
    Employee(3, "Harmoini", 30000.0),
    Employee(4, "Arpit", 40000.0)
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  // for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // getters sink
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrementSink =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrementSink =>
      _employeeSalaryDecrementStreamController.sink;

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }
}
