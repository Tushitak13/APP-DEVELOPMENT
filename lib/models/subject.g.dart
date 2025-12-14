part of 'subject.dart';

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 0;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{ for (int i=0; i<numOfFields; i++) reader.readByte(): reader.read() };
    return Subject(
      name: fields[0] as String,
      code: fields[1] as String,
      professor: fields[2] as String,
      attended: fields[3] as int,
      total: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)..write(obj.name)
      ..writeByte(1)..write(obj.code)
      ..writeByte(2)..write(obj.professor)
      ..writeByte(3)..write(obj.attended)
      ..writeByte(4)..write(obj.total);
  }
}
