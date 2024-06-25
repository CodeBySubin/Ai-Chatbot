import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class ChatModel {

  @HiveField(0)
  final String time;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final bool isImage;

  @HiveField(3)
  final bool isSender;

  const ChatModel(this.time, this.message, this.isImage, this.isSender);
}