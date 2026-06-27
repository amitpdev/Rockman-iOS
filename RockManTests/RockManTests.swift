//
//  RockManTests.swift
//  RockManTests
//
//  Created by Amit Palomo on 14/06/2026.
//

import Testing
@testable import RockMan

struct RockManTests {

    @Test func catalogContainsTracksByGame() {
        #expect(MusicCatalog.tracks(for: .megaMan1).count == 12)
        #expect(MusicCatalog.tracks(for: .megaMan2).count == 16)
        #expect(MusicCatalog.tracks(for: .megaMan3).count == 15)
        #expect(MusicCatalog.tracks(for: .megaMan4).count == 18)
        #expect(MusicCatalog.tracks(for: .megaMan5).count == 15)
        #expect(MusicCatalog.tracks(for: .megaMan6).count == 14)
    }

    @Test func catalogTracksArePlayable() {
        let missingTracks = MusicCatalog.tracks.filter { !$0.isPlayable }

        #expect(missingTracks.isEmpty)
    }

    @Test func playableTracksHaveBundleResourceReferences() {
        let playableTracks = MusicCatalog.tracks.filter(\.isPlayable)

        #expect(playableTracks.count == 90)

        for track in playableTracks {
            #expect(track.resourceName?.isEmpty == false)
            #expect(track.game.audioResourceSubdirectory == "sound/\(track.game.shortTitle.lowercased())")
        }
    }

    @Test func catalogIncludesDrWilyStages() {
        let wilyTracks = MusicCatalog.tracks.filter { $0.id.contains("wily") }

        #expect(wilyTracks.count == 12)
        #expect(wilyTracks.filter(\.isPlayable).count == 12)
    }

    @Test func bossTracksComeFirstForEachGame() {
        for game in MegaManGame.allCases {
            let tracks = MusicCatalog.tracks(for: game)
            let kindOrder = tracks.map { $0.kind.rawValue }

            if let firstNonBossTrack = tracks.firstIndex(where: { $0.kind != .boss }) {
                #expect(firstNonBossTrack > 0)
                #expect(tracks.prefix(upTo: firstNonBossTrack).allSatisfy { $0.kind == .boss })
            }
            #expect(kindOrder == kindOrder.sorted())
        }
    }

    @Test func bossTracksFollowStageSelectScreenOrder() {
        let expectedBossOrder: [MegaManGame: [String]] = [
            .megaMan1: ["mm1-cut", "mm1-guts", "mm1-elec", "mm1-ice", "mm1-fire", "mm1-bomb"],
            .megaMan2: ["mm2-bubble", "mm2-air", "mm2-quick", "mm2-heat", "mm2-wood", "mm2-metal", "mm2-flash", "mm2-crash"],
            .megaMan3: ["mm3-spark", "mm3-snake", "mm3-needle", "mm3-hard", "mm3-top", "mm3-gemini", "mm3-magnet", "mm3-shadow"],
            .megaMan4: ["mm4-ring", "mm4-dive", "mm4-skull", "mm4-pharaoh", "mm4-bright", "mm4-toad", "mm4-drill", "mm4-dust"],
            .megaMan5: ["mm5-stone", "mm5-gravity", "mm5-crystal", "mm5-charge", "mm5-napalm", "mm5-wave", "mm5-star", "mm5-gyro"],
            .megaMan6: ["mm6-blizzard", "mm6-wind", "mm6-flame", "mm6-plant", "mm6-tomahawk", "mm6-yamato", "mm6-knight", "mm6-centaur"]
        ]

        for game in MegaManGame.allCases {
            let bossTrackIDs = MusicCatalog.tracks(for: game)
                .filter { $0.kind == .boss }
                .map(\.id)

            #expect(bossTrackIDs == expectedBossOrder[game])
        }
    }

}
