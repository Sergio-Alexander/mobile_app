// // lib/floor_model/floor_recorder_repository.dart
// import 'emotion_recorder_dao.dart';
// import 'workout_recorder/workout_recorder_dao.dart';
// import 'diet_recorder_dao.dart';
// import 'emotion_recorder_entity.dart';
// import 'workout_recorder_entity.dart';
// import 'diet_recorder_entity.dart';
// import 'app_status/app_status_entity.dart';
// import 'app_status/app_status_dao.dart';
//
// class RecorderRepository {
//   final EmotionRecorderDao emotionRecorderDao;
//   final WorkoutRecorderDao workoutRecorderDao;
//   final DietRecorderDao dietRecorderDao;
//   final AppStatusDao appStatusDao;
//
//   RecorderRepository(this.emotionRecorderDao, this.workoutRecorderDao,
//       this.dietRecorderDao, this.appStatusDao);
//
//   // EmotionRecorder methods
//   Future<List<EmotionRecorderEntity>> getAllEmotionRecordings() async {
//     return await emotionRecorderDao.findAllEmotionRecorders();
//   }
//
//   Stream<EmotionRecorderEntity?> getEmotionRecordingById(int id) {
//     return emotionRecorderDao.findEmotionRecorderById(id);
//   }
//
//   Future<int> insertEmotionRecording(EmotionRecorderEntity recorder) async {
//     return await emotionRecorderDao.insertEmotionRecorder(recorder);
//   }
//
//   Future<void> updateEmotionRecording(EmotionRecorderEntity recorder) async {
//     await emotionRecorderDao.updateEmotionRecorder(recorder);
//   }
//
//   Future<void> deleteEmotionRecording(EmotionRecorderEntity recorder) async {
//     await emotionRecorderDao.deleteEmotionRecorder(recorder);
//   }
//
//   // WorkoutRecorder methods
//   Future<List<WorkoutRecorderEntity>> getAllWorkoutRecordings() async {
//     return await workoutRecorderDao.findAllWorkoutRecorders();
//   }
//
//   Stream<WorkoutRecorderEntity?> getWorkoutRecordingById(int id) {
//     return workoutRecorderDao.findWorkoutRecorderById(id);
//   }
//
//   Future<int> insertWorkoutRecording(WorkoutRecorderEntity recorder) async {
//     return await workoutRecorderDao.insertWorkoutRecorder(recorder);
//   }
//
//   Future<void> updateWorkoutRecording(WorkoutRecorderEntity recorder) async {
//     await workoutRecorderDao.updateWorkoutRecorder(recorder);
//   }
//
//   Future<void> deleteWorkoutRecording(WorkoutRecorderEntity recorder) async {
//     await workoutRecorderDao.deleteWorkoutRecorder(recorder);
//   }
//
//   // DietRecorder methods
//   Future<List<DietRecorderEntity>> getAllDietRecordings() async {
//     return await dietRecorderDao.findAllDietRecorders();
//   }
//
//   Stream<DietRecorderEntity?> getDietRecordingById(int id) {
//     return dietRecorderDao.findDietRecorderById(id);
//   }
//
//   Future<int> insertDietRecording(DietRecorderEntity recorder) async {
//     return await dietRecorderDao.insertDietRecorder(recorder);
//   }
//
//   Future<void> updateDietRecording(DietRecorderEntity recorder) async {
//     await dietRecorderDao.updateDietRecorder(recorder);
//   }
//
//   Future<void> deleteDietRecording(DietRecorderEntity recorder) async {
//     await dietRecorderDao.deleteDietRecorder(recorder);
//   }
//
//   // AppStatus methods
//   Future<List<AppStatusEntity>> getAllAppStatuses() async {
//     return await appStatusDao.findAllAppStatuses();
//   }
//
//   Stream<AppStatusEntity?> getAppStatusById(int id) {
//     return appStatusDao.findAppStatusById(id);
//   }
//
//   Future<int> insertAppStatus(AppStatusEntity status) async {
//     return await appStatusDao.insertAppStatus(status);
//   }
//
//   Future<void> updateAppStatus(AppStatusEntity status) async {
//     await appStatusDao.updateAppStatus(status);
//   }
//
//   Future<void> deleteAppStatus(AppStatusEntity status) async {
//     await appStatusDao.deleteAppStatus(status);
//   }
//
// }
//
