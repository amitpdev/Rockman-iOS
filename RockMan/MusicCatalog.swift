import Foundation

enum MegaManGame: String, CaseIterable, Identifiable {
    case megaMan1
    case megaMan2
    case megaMan3
    case megaMan4

    var id: String { rawValue }

    var title: String {
        switch self {
        case .megaMan1: "Mega Man"
        case .megaMan2: "Mega Man 2"
        case .megaMan3: "Mega Man 3"
        case .megaMan4: "Mega Man 4"
        }
    }

    var shortTitle: String {
        switch self {
        case .megaMan1: "MM1"
        case .megaMan2: "MM2"
        case .megaMan3: "MM3"
        case .megaMan4: "MM4"
        }
    }

    var audioResourceSubdirectory: String {
        "sound/\(shortTitle.lowercased())"
    }

}

struct MusicTrack: Identifiable, Equatable {
    let id: String
    let game: MegaManGame
    let bossName: String
    let stageName: String
    let audioFileName: String?
    let artworkName: String?
    let paletteIndex: Int

    var displayTitle: String { bossName }
    var isPlayable: Bool { audioFileName != nil }

    var resourceName: String? {
        audioFileName?.replacingOccurrences(of: ".flac", with: "")
    }

}

enum MusicCatalog {
    static let tracks: [MusicTrack] = [
        MusicTrack(id: "mm1-cut", game: .megaMan1, bossName: "Cut Man", stageName: "Cut Stage", audioFileName: "mm1-03. Cut Man.flac", artworkName: "mm1_cut_man", paletteIndex: 0),
        MusicTrack(id: "mm1-guts", game: .megaMan1, bossName: "Guts Man", stageName: "Guts Stage", audioFileName: "mm1-04. Guts Man.flac", artworkName: "mm1_gust_man", paletteIndex: 1),
        MusicTrack(id: "mm1-ice", game: .megaMan1, bossName: "Ice Man", stageName: "Ice Stage", audioFileName: "mm1-05. Ice Man.flac", artworkName: "mm1_ice_man", paletteIndex: 2),
        MusicTrack(id: "mm1-bomb", game: .megaMan1, bossName: "Bomb Man", stageName: "Bomb Stage", audioFileName: "mm1-06. Bomb Man.flac", artworkName: "mm1_bomb_man", paletteIndex: 3),
        MusicTrack(id: "mm1-fire", game: .megaMan1, bossName: "Fire Man", stageName: "Fire Stage", audioFileName: "mm1-07. Fire Man.flac", artworkName: "mm1_fire_man", paletteIndex: 4),
        MusicTrack(id: "mm1-elec", game: .megaMan1, bossName: "Elec Man", stageName: "Elec Stage", audioFileName: "mm1-08. Elec Man.flac", artworkName: "mm1_elec_man", paletteIndex: 5),
        MusicTrack(id: "mm1-wily-1-2", game: .megaMan1, bossName: "Dr. Wily 1-2", stageName: "Wily Castle", audioFileName: "mm1-11. Dr. Wily Stage 1~2.flac", artworkName: "mm2_dr_willy", paletteIndex: 30),
        MusicTrack(id: "mm1-wily-3-4", game: .megaMan1, bossName: "Dr. Wily 3-4", stageName: "Wily Castle", audioFileName: "mm1-12. Dr. Wily Stage 3~4.flac", artworkName: "mm2_dr_willy", paletteIndex: 31),

        MusicTrack(id: "mm2-metal", game: .megaMan2, bossName: "Metal Man", stageName: "Metal Stage", audioFileName: "mm2-06. Metal Man.flac", artworkName: "mm2_metal_man", paletteIndex: 6),
        MusicTrack(id: "mm2-air", game: .megaMan2, bossName: "Air Man", stageName: "Air Stage", audioFileName: "mm2-07. Air Man.flac", artworkName: "mm2_air_man", paletteIndex: 7),
        MusicTrack(id: "mm2-bubble", game: .megaMan2, bossName: "Bubble Man", stageName: "Bubble Stage", audioFileName: "mm2-08. Bubble Man.flac", artworkName: "mm2_bubble_man", paletteIndex: 8),
        MusicTrack(id: "mm2-quick", game: .megaMan2, bossName: "Quick Man", stageName: "Quick Stage", audioFileName: "mm2-09. Quick Man.flac", artworkName: "mm2_quick_man", paletteIndex: 9),
        MusicTrack(id: "mm2-crash", game: .megaMan2, bossName: "Crash Man", stageName: "Crash Stage", audioFileName: "mm2-10. Crash Man.flac", artworkName: "mm2_crash_man", paletteIndex: 10),
        MusicTrack(id: "mm2-flash", game: .megaMan2, bossName: "Flash Man", stageName: "Flash Stage", audioFileName: "mm2-11. Flash Man.flac", artworkName: "mm2_flash_man", paletteIndex: 11),
        MusicTrack(id: "mm2-heat", game: .megaMan2, bossName: "Heat Man", stageName: "Heat Stage", audioFileName: "mm2-12. Heat Man.flac", artworkName: "mm2_heat_man", paletteIndex: 12),
        MusicTrack(id: "mm2-wood", game: .megaMan2, bossName: "Wood Man", stageName: "Wood Stage", audioFileName: "mm2-13. Wood Man.flac", artworkName: "mm2_wood_man", paletteIndex: 13),
        MusicTrack(id: "mm2-wily-1-2", game: .megaMan2, bossName: "Dr. Wily 1-2", stageName: "Wily Castle", audioFileName: "mm2-18. Dr. Wily Stage 1~2.flac", artworkName: "mm2_dr_willy", paletteIndex: 32),
        MusicTrack(id: "mm2-wily-3-5", game: .megaMan2, bossName: "Dr. Wily 3-5", stageName: "Wily Castle", audioFileName: "mm2-19. Dr. Wily Stage 3~5.flac", artworkName: "mm2_dr_willy", paletteIndex: 33),

        MusicTrack(id: "mm3-needle", game: .megaMan3, bossName: "Needle Man", stageName: "Needle Stage", audioFileName: "mm3-05. Needle Man.flac", artworkName: "mm3_needle_man", paletteIndex: 14),
        MusicTrack(id: "mm3-magnet", game: .megaMan3, bossName: "Magnet Man", stageName: "Magnet Stage", audioFileName: "mm3-06. Magnet Man.flac", artworkName: "mm3_magnet_man", paletteIndex: 15),
        MusicTrack(id: "mm3-gemini", game: .megaMan3, bossName: "Gemini Man", stageName: "Gemini Stage", audioFileName: "mm3-07. Gemini Man.flac", artworkName: "mm3_gemini_man", paletteIndex: 16),
        MusicTrack(id: "mm3-hard", game: .megaMan3, bossName: "Hard Man", stageName: "Hard Stage", audioFileName: "mm3-08. Hard Man.flac", artworkName: "mm3_hard_man", paletteIndex: 17),
        MusicTrack(id: "mm3-top", game: .megaMan3, bossName: "Top Man", stageName: "Top Stage", audioFileName: "mm3-09. Top Man.flac", artworkName: "mm3_top_man", paletteIndex: 18),
        MusicTrack(id: "mm3-snake", game: .megaMan3, bossName: "Snake Man", stageName: "Snake Stage", audioFileName: "mm3-10. Snake Man.flac", artworkName: "mm3_snake_man", paletteIndex: 19),
        MusicTrack(id: "mm3-spark", game: .megaMan3, bossName: "Spark Man", stageName: "Spark Stage", audioFileName: "mm3-11. Spark Man.flac", artworkName: "mm3_spark_man", paletteIndex: 20),
        MusicTrack(id: "mm3-shadow", game: .megaMan3, bossName: "Shadow Man", stageName: "Shadow Stage", audioFileName: "mm3-12. Shadow Man.flac", artworkName: "mm3_shadow_man", paletteIndex: 21),
        MusicTrack(id: "mm3-wily-1-2", game: .megaMan3, bossName: "Dr. Wily 1-2", stageName: "Wily Castle", audioFileName: "mm3-18. Dr. Wily Stage 1~2.flac", artworkName: "mm2_dr_willy", paletteIndex: 34),
        MusicTrack(id: "mm3-wily-3-4", game: .megaMan3, bossName: "Dr. Wily 3-4", stageName: "Wily Castle", audioFileName: "mm3-19. Dr. Wily Stage 3~4.flac", artworkName: "mm2_dr_willy", paletteIndex: 35),
        MusicTrack(id: "mm3-wily-5-6", game: .megaMan3, bossName: "Dr. Wily 5-6", stageName: "Wily Castle", audioFileName: "mm3-20. Dr. Wily Stage 5~6.flac", artworkName: "mm2_dr_willy", paletteIndex: 36),

        MusicTrack(id: "mm4-bright", game: .megaMan4, bossName: "Bright Man", stageName: "Bright Stage", audioFileName: "mm4-07. Bright Man.flac", artworkName: "mm4_bright_man", paletteIndex: 22),
        MusicTrack(id: "mm4-toad", game: .megaMan4, bossName: "Toad Man", stageName: "Toad Stage", audioFileName: "mm4-08. Toad Man.flac", artworkName: "mm4_toad_man", paletteIndex: 23),
        MusicTrack(id: "mm4-drill", game: .megaMan4, bossName: "Drill Man", stageName: "Drill Stage", audioFileName: "mm4-09. Drill Man.flac", artworkName: "mm4_drill_man", paletteIndex: 24),
        MusicTrack(id: "mm4-pharaoh", game: .megaMan4, bossName: "Pharaoh Man", stageName: "Pharaoh Stage", audioFileName: "mm4-10. Pharaoh Man.flac", artworkName: "mm4_pharaoh_man", paletteIndex: 25),
        MusicTrack(id: "mm4-ring", game: .megaMan4, bossName: "Ring Man", stageName: "Ring Stage", audioFileName: "mm4-11. Ring Man.flac", artworkName: "mm4_ring_man", paletteIndex: 26),
        MusicTrack(id: "mm4-dust", game: .megaMan4, bossName: "Dust Man", stageName: "Dust Stage", audioFileName: "mm4-12. Dust Man.flac", artworkName: "mm4_dust_man", paletteIndex: 27),
        MusicTrack(id: "mm4-dive", game: .megaMan4, bossName: "Dive Man", stageName: "Dive Stage", audioFileName: "mm4-13. Dive Man.flac", artworkName: "mm4_dive_man", paletteIndex: 28),
        MusicTrack(id: "mm4-skull", game: .megaMan4, bossName: "Skull Man", stageName: "Skull Stage", audioFileName: "mm4-14. Skull Man.flac", artworkName: "mm4_skull_man", paletteIndex: 29),
        MusicTrack(id: "mm4-wily-castle", game: .megaMan4, bossName: "Dr. Wily Castle", stageName: "Wily Castle", audioFileName: "mm4-22. Dr. Wily Castle.flac", artworkName: "mm2_dr_willy", paletteIndex: 37),
        MusicTrack(id: "mm4-wily-1-2", game: .megaMan4, bossName: "Dr. Wily 1-2", stageName: "Wily Castle", audioFileName: "mm4-23. Dr. Wily Stage 1~2.flac", artworkName: "mm2_dr_willy", paletteIndex: 38),
        MusicTrack(id: "mm4-wily-3-4", game: .megaMan4, bossName: "Dr. Wily 3-4", stageName: "Wily Castle", audioFileName: "mm4-24. Dr. Wily Stage 3~4.flac", artworkName: "mm2_dr_willy", paletteIndex: 39)
    ]

    static func tracks(for game: MegaManGame) -> [MusicTrack] {
        tracks.filter { $0.game == game }
    }
}
