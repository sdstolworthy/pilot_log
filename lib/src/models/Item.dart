import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

class LogbookEntry {
  String id;
  String title;
  String description;
  String photoUrl;

  LogbookEntry({this.title, this.description, this.photoUrl, String id})
      : this.id = id ?? Uuid().v4();
  LogbookEntry.fromMap(Map<String, dynamic> parsedJson) {
    title = parsedJson['title'];
    description = parsedJson['description'];
    photoUrl = parsedJson['photoUrl'];
  }

  LogbookEntry.random()
      : title = faker.lorem.word(),
        description = faker.lorem.sentence(),
        photoUrl = 'https://via.placeholder.com/70';

  toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'photoUrl': photoUrl
    };
  }
}
