import 'package:coffee_app/app/models/user.dart';
import 'package:coffee_app/app/services/user_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var isLoading = false.obs;
  var users = <User>[].obs;

  final UserService apiService = UserService();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      List<User> fetchedUsers = await apiService.fetchUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      print('Error while getting users data: $e');
    } finally {
      isLoading(false);
    }
  }
}
