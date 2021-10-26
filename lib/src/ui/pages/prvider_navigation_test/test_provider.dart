import '../../../core/models/base_provider.dart';

class TestProvider extends BaseProvider {
  late List<int> dateList;
  TestProvider() {
    dateList = List.generate(100, (index) => index);
  }
  Future<int> getData(int index) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return dateList[index];
  }

  Future update(int index, int value) async {
    await Future.delayed(const Duration(milliseconds: 200));
    dateList[index] = value;
    notifyListeners();
  }
}
