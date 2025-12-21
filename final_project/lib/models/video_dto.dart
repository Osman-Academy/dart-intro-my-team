import 'package:final_project/entities/video.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_dto.freezed.dart';
part 'video_dto.g.dart';
@freezed
class VideoDto with _$VideoDto{
  factory VideoDto(
  {required String title,
  required String author,}
      ) = _VideoDto;

  factory VideoDto.fromJson(Map<String, dynamic> json) => _$VideoDtoFromJson(json);
}
extension VideoMapper on VideoDto {
  Video toEntity() => Video(title: title, author: author);
}