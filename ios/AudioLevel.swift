@objc(AudioLevel)
class AudioLevel: NSObject {

  var recorder: AVAudioRecorder!
  var levelTimer = Timer()

  let LEVEL_THRESHOLD: Float = -10.0

  @objc(multiply:withB:withResolver:withRejecter:)
  func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve(a*b)
  }

  @objc(startFetchAudioLevel)
  /* refernce links:
  https://stackoverflow.com/questions/31230854/ios-detect-blow-into-mic-and-convert-the-results-swift?noredirect=1&lq=1
  https://stackoverflow.com/questions/35929989/how-to-monitor-audio-input-on-ios-using-swift-example
  https://holyswift.app/sounds-streams-analysis-using-ai-in-swift/

  */
  func startFetchAudioLevel() {
    let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
    let url = documents.appendingPathComponent("record.caf")

    let recordSettings: [String: Any] = [
        AVFormatIDKey:              kAudioFormatAppleIMA4,
        AVSampleRateKey:            44100.0,
        AVNumberOfChannelsKey:      2,
        AVEncoderBitRateKey:        12800,
        AVLinearPCMBitDepthKey:     16,
        AVEncoderAudioQualityKey:   AVAudioQuality.max.rawValue
    ]

    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try audioSession.setActive(true)
        try recorder = AVAudioRecorder(url:url, settings: recordSettings)

    } catch {
        return
    }

    recorder.prepareToRecord()
    recorder.isMeteringEnabled = true
    recorder.record()

    levelTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(levelTimerCallback), userInfo: nil, repeats: true)
  }

  func levelTimerCallback() {
    recorder.updateMeters()

    let level = recorder.averagePower(forChannel: 0)
    let isLoud = level > LEVEL_THRESHOLD

    // do whatever you want with isLoud
    }
}
