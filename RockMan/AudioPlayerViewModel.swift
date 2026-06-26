import AVFoundation
import Combine
import Foundation

@MainActor
final class AudioPlayerViewModel: ObservableObject {
    @Published private(set) var currentTrack: MusicTrack?
    @Published private(set) var isPlaying = false
    @Published var errorMessage: String?

    private var player: AVAudioPlayer?

    func toggle(_ track: MusicTrack) {
        guard track.isPlayable else {
            errorMessage = "\(track.bossName) audio is missing."
            return
        }

        if currentTrack == track {
            isPlaying ? pause() : play()
            return
        }

        start(track)
    }

    func play() {
        guard let player else {
            isPlaying = false
            return
        }

        do {
            try activateAudioSession()
            isPlaying = player.play()
            if !isPlaying {
                errorMessage = "Could not start audio playback."
            }
        } catch {
            errorMessage = "Could not activate audio playback."
            isPlaying = false
        }
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    func stop() {
        player?.stop()
        player?.currentTime = 0
        player = nil
        currentTrack = nil
        isPlaying = false
        deactivateAudioSession()
    }

    private func start(_ track: MusicTrack) {
        guard let url = audioURL(for: track) else {
            errorMessage = "Could not find \(track.bossName) in the app bundle."
            return
        }

        do {
            try activateAudioSession()
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
            currentTrack = track
            errorMessage = nil
            play()
        } catch {
            errorMessage = "Could not play \(track.bossName)."
            currentTrack = nil
            isPlaying = false
            deactivateAudioSession()
        }
    }

    private func audioURL(for track: MusicTrack) -> URL? {
        guard let audioFileName = track.audioFileName,
              let resourceURL = Bundle.main.resourceURL else {
            return nil
        }

        let fileManager = FileManager.default
        let expectedURL = resourceURL
            .appendingPathComponent(track.game.audioResourceSubdirectory, isDirectory: true)
            .appendingPathComponent(audioFileName)

        if fileManager.fileExists(atPath: expectedURL.path) {
            return expectedURL
        }

        let flattenedURL = resourceURL.appendingPathComponent(audioFileName)
        if fileManager.fileExists(atPath: flattenedURL.path) {
            return flattenedURL
        }

        guard let enumerator = fileManager.enumerator(
            at: resourceURL,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        ) else {
            return nil
        }

        for case let url as URL in enumerator where url.lastPathComponent == audioFileName {
            return url
        }

        return nil
    }

    private func activateAudioSession() throws {
        #if os(iOS)
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.playback, mode: .default)
        try session.setActive(true)
        #endif
    }

    private func deactivateAudioSession() {
        #if os(iOS)
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        #endif
    }
}
