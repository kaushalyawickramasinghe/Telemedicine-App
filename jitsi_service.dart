import 'package:jitsi_meet/jitsi_meet.dart';
import '../config.dart';

// Simple helper to open a Jitsi meeting; in production, use server-side tokens if needed
class JitsiService {
  static Future<void> joinMeeting({required String roomName, required String displayName}) async {
    try {
      var options = JitsiMeetingOptions(room: roomName)
        ..serverURL = JITSI_SERVER_URL
        ..userDisplayName = displayName
        ..audioOnly = false
        ..audioMuted = false
        ..videoMuted = false;
      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      rethrow;
    }
  }

  // TODO: add functions to create server-side tokens and pass into Jitsi as needed
}