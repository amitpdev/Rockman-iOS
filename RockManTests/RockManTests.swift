//
//  RockManTests.swift
//  RockManTests
//
//  Created by Amit Palomo on 14/06/2026.
//

import Testing
@testable import RockMan

struct RockManTests {

    @Test func catalogContainsRobotMasterTracksByGame() {
        #expect(MusicCatalog.tracks(for: .megaMan1).count == 8)
        #expect(MusicCatalog.tracks(for: .megaMan2).count == 10)
        #expect(MusicCatalog.tracks(for: .megaMan3).count == 11)
        #expect(MusicCatalog.tracks(for: .megaMan4).count == 11)
    }

    @Test func catalogMarksOnlySkullManAsMissingAudio() {
        let missingTracks = MusicCatalog.tracks.filter { !$0.isPlayable }

        #expect(missingTracks.count == 1)
        #expect(missingTracks.first?.id == "mm4-skull")
    }

    @Test func playableTracksHaveBundleResourceReferences() {
        let playableTracks = MusicCatalog.tracks.filter(\.isPlayable)

        #expect(playableTracks.count == 39)

        for track in playableTracks {
            #expect(track.resourceName?.isEmpty == false)
            #expect(track.game.audioResourceSubdirectory == "sound/\(track.game.shortTitle.lowercased())")
            #expect(track.audioFileName?.hasPrefix(track.game.shortTitle.lowercased()) == true)
        }
    }

    @Test func catalogIncludesDrWilyStages() {
        let wilyTracks = MusicCatalog.tracks.filter { $0.id.contains("wily") }

        #expect(wilyTracks.count == 10)
        #expect(wilyTracks.filter(\.isPlayable).count == 10)
    }

}
