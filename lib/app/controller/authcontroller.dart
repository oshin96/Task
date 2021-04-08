import 'package:get/get.dart';
import 'package:task/app/model/employeeModel.dart';
import 'package:task/app/services/apiService.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    getEmpList();
    super.onInit();
  }

  var empList = List<Employee>().obs;
  getEmpList() async {
    var data;
    // await ApiService().loadLocalJsonData();
    if (data != null) {
      empList.addAll(data);
      print('+++++++++++>>>>>>EMPLOYE LIST');
      print(empList);
    } else {
      print("error");
    }
  }
}
