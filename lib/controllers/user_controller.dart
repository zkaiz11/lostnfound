import 'package:get/get.dart';
import 'package:lostnfound/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final user = UserModel().obs;

  setUser(UserModel userInfo) {
    user.value = userInfo;
    update();
  }

  setLocation(String location) {
    // Create a new UserModel instance with the updated location
    UserModel updatedUser = UserModel(
      googleUid: user.value.googleUid,
      name: user.value.name,
      email: user.value.email,
      pfp: user.value.pfp,
      location: location,
      isDeleted: user.value.isDeleted,
      createdAt: user.value.createdAt,
    );

    // Update the user with the new UserModel instance
    setUser(updatedUser);
    }
}
