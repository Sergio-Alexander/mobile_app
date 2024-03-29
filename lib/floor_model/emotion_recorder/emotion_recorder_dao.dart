import 'package:floor/floor.dart';
import 'emotion_recorder_entity.dart';

@dao
abstract class EmotionRecorderDao {
  @Query('SELECT * FROM EmotionRecorder')
  Future<List<EmotionRecorderEntity>> findAllEmotionRecorders();

  // @Query('SELECT * FROM emotion_recorder WHERE id = :id')
  // Stream<EmotionRecorderEntity> findEmotionRecorderById(int id);

  @Query('SELECT * FROM EmotionRecorder WHERE id = :id')
  Stream<EmotionRecorderEntity?> findEmotionRecorderById(int id);

  @insert
  Future<int> insertEmotionRecorder(EmotionRecorderEntity recorder);

  @update
  Future<void> updateEmotionRecorder(EmotionRecorderEntity recorder);

  @delete
  Future<void> deleteEmotionRecorder(EmotionRecorderEntity recorder);



  @Query('SELECT * FROM EmotionRecorder ORDER BY id DESC LIMIT 1')
  Future<EmotionRecorderEntity?> getLastEmotion();



  @Query('SELECT COUNT(*) FROM EmotionRecorder')
  Future<int?> countEmotions();
}
