import 'package:keep_notes_lite/model_class/user_model.dart';
import 'package:keep_notes_lite/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<UserModel> _userBox;

  ObjectBox._init(this.store) {
    _userBox = Box<UserModel>(store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }

  UserModel? getData(
    int id,
  ) =>
      _userBox.get(id);

  Stream<List<UserModel>> getDats() {
    return _userBox
        .query()
        .watch(triggerImmediately: true)
        .map((event) => event.find());
  }

  insertUser(
    UserModel usermodel,
  ) {
    return _userBox.putAsync(usermodel);
  }

  bool deleteUser(
    int id,
  ) =>
      _userBox.remove(id);
}
