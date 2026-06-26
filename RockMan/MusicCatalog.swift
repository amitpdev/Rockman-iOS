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

enum MusicTrackKind: Int {
    case boss
    case castle
    case intro
    case ending
}

struct MusicTrack: Identifiable, Equatable {
    let id: String
    let game: MegaManGame
    var kind: MusicTrackKind = .boss
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
        MusicTrack(id: "mm1-elec", game: .megaMan1, bossName: "Elec Man", stageName: "Elec Stage", audioFileName: "mm1-08. Elec Man.flac", artworkName: "mm1_elec_man", paletteIndex: 5),
        MusicTrack(id: "mm1-ice", game: .megaMan1, bossName: "Ice Man", stageName: "Ice Stage", audioFileName: "mm1-05. Ice Man.flac", artworkName: "mm1_ice_man", paletteIndex: 2),
        MusicTrack(id: "mm1-fire", game: .megaMan1, bossName: "Fire Man", stageName: "Fire Stage", audioFileName: "mm1-07. Fire Man.flac", artworkName: "mm1_fire_man", paletteIndex: 4),
        MusicTrack(id: "mm1-bomb", game: .megaMan1, bossName: "Bomb Man", stageName: "Bomb Stage", audioFileName: "mm1-06. Bomb Man.flac", artworkName: "mm1_bomb_man", paletteIndex: 3),
        MusicTrack(id: "mm1-wily-1-2", game: .megaMan1, kind: .castle, bossName: "Dr. Wily 1-2", stageName: "Wily Castle", audioFileName: "mm1-11. Dr. Wily Stage 1~2.flac", artworkName: "mm2_dr_willy", paletteIndex: 30),
        MusicTrack(id: "mm1-wily-3-4", game: .megaMan1, kind: .castle, bossName: "Dr. Wily 3-4", stageName: "Wily Castle", audioFileName: "mm1-12. Dr. Wily Stage 3~4.flac", artworkName: "mm2_dr_willy", paletteIndex: 31),
        MusicTrack(id: "mm1-stage-select", game: .megaMan1, kind: .intro, bossName: "Stage Select", stageName: "Menu", audioFileName: "mm1-01 Stage Select.flac", artworkName: "stage_select/megaman01_stage_select", paletteIndex: 40),
        MusicTrack(id: "mm1-stage-chosen", game: .megaMan1, kind: .intro, bossName: "Stage Chosen", stageName: "Menu", audioFileName: "mm1-02. Stage Chosen.flac", artworkName: "stage_select/megaman01_stage_select", paletteIndex: 41),
        MusicTrack(id: "mm1-ending", game: .megaMan1, kind: .ending, bossName: "Ending", stageName: "Finale", audioFileName: "mm1-15 Ending.flac", artworkName: "title/Rockman 1 Ending", paletteIndex: 42),
        MusicTrack(id: "mm1-game-over", game: .megaMan1, kind: .ending, bossName: "Game Over", stageName: "Finale", audioFileName: "mm1-16 Game Over.flac", artworkName: "title/Rockman 1 Ending", paletteIndex: 43),

        MusicTrack(id: "mm2-bubble", game: .megaMan2, bossName: "Bubble Man", stageName: "Bubble Stage", audioFileName: "mm2-08. Bubble Man.flac", artworkName: "mm2_bubble_man", paletteIndex: 8),
        MusicTrack(id: "mm2-air", game: .megaMan2, bossName: "Air Man", stageName: "Air Stage", audioFileName: "mm2-07. Air Man.flac", artworkName: "mm2_air_man", paletteIndex: 7),
        MusicTrack(id: "mm2-quick", game: .megaMan2, bossName: "Quick Man", stageName: "Quick Stage", audioFileName: "mm2-09. Quick Man.flac", artworkName: "mm2_quick_man", paletteIndex: 9),
        MusicTrack(id: "mm2-heat", game: .megaMan2, bossName: "Heat Man", stageName: "Heat Stage", audioFileName: "mm2-12. Heat Man.flac", artworkName: "mm2_heat_man", paletteIndex: 12),
        MusicTrack(id: "mm2-wood", game: .megaMan2, bossName: "Wood Man", stageName: "Wood Stage", audioFileName: "mm2-13. Wood Man.flac", artworkName: "mm2_wood_man", paletteIndex: 13),
        MusicTrack(id: "mm2-metal", game: .megaMan2, bossName: "Metal Man", stageName: "Metal Stage", audioFileName: "mm2-06. Metal Man.flac", artworkName: "mm2_metal_man", paletteIndex: 6),
        MusicTrack(id: "mm2-flash", game: .megaMan2, bossName: "Flash Man", stageName: "Flash Stage", audioFileName: "mm2-11. Flash Man.flac", artworkName: "mm2_flash_man", paletteIndex: 11),
        MusicTrack(id: "mm2-crash", game: .megaMan2, bossName: "Crash Man", stageName: "Crash Stage", audioFileName: "mm2-10. Crash Man.flac", artworkName: "mm2_crash_man", paletteIndex: 10),
        MusicTrack(id: "mm2-wily-1-2", game: .megaMan2, kind: .castle, bossName: "Dr. Wily 1-2", stageName: "Wily Castle", audioFileName: "mm2-18. Dr. Wily Stage 1~2.flac", artworkName: "mm2_dr_willy", paletteIndex: 32),
        MusicTrack(id: "mm2-wily-3-5", game: .megaMan2, kind: .castle, bossName: "Dr. Wily 3-5", stageName: "Wily Castle", audioFileName: "mm2-19. Dr. Wily Stage 3~5.flac", artworkName: "mm2_dr_willy", paletteIndex: 33),
        MusicTrack(id: "mm2-opening", game: .megaMan2, kind: .intro, bossName: "Opening", stageName: "Intro", audioFileName: "mm2-01 Opening.flac", artworkName: "title/Rockman 2 Opening", paletteIndex: 44),
        MusicTrack(id: "mm2-title", game: .megaMan2, kind: .intro, bossName: "Title Screen", stageName: "Intro", audioFileName: "mm2-02. Title Screen.flac", artworkName: "title/Rockman 2 Title screen", paletteIndex: 45),
        MusicTrack(id: "mm2-password", game: .megaMan2, kind: .intro, bossName: "Password", stageName: "Menu", audioFileName: "mm2-03. Password.flac", artworkName: "stage_select/megaman02_stage_select", paletteIndex: 46),
        MusicTrack(id: "mm2-stage-select", game: .megaMan2, kind: .intro, bossName: "Stage Select", stageName: "Menu", audioFileName: "mm2-04 Stage Select.flac", artworkName: "stage_select/megaman02_stage_select", paletteIndex: 47),
        MusicTrack(id: "mm2-stage-chosen", game: .megaMan2, kind: .intro, bossName: "Stage Chosen", stageName: "Menu", audioFileName: "mm2-05. Stage Chosen.flac", artworkName: "stage_select/megaman02_stage_select", paletteIndex: 48),
        MusicTrack(id: "mm2-ending", game: .megaMan2, kind: .ending, bossName: "Ending", stageName: "Finale", audioFileName: "mm2 Ending.flac", artworkName: "title/Rockman 2 Ending", paletteIndex: 49),

        MusicTrack(id: "mm3-spark", game: .megaMan3, bossName: "Spark Man", stageName: "Spark Stage", audioFileName: "mm3-11. Spark Man.flac", artworkName: "mm3_spark_man", paletteIndex: 20),
        MusicTrack(id: "mm3-snake", game: .megaMan3, bossName: "Snake Man", stageName: "Snake Stage", audioFileName: "mm3-10. Snake Man.flac", artworkName: "mm3_snake_man", paletteIndex: 19),
        MusicTrack(id: "mm3-needle", game: .megaMan3, bossName: "Needle Man", stageName: "Needle Stage", audioFileName: "mm3-05. Needle Man.flac", artworkName: "mm3_needle_man", paletteIndex: 14),
        MusicTrack(id: "mm3-hard", game: .megaMan3, bossName: "Hard Man", stageName: "Hard Stage", audioFileName: "mm3-08. Hard Man.flac", artworkName: "mm3_hard_man", paletteIndex: 17),
        MusicTrack(id: "mm3-top", game: .megaMan3, bossName: "Top Man", stageName: "Top Stage", audioFileName: "mm3-09. Top Man.flac", artworkName: "mm3_top_man", paletteIndex: 18),
        MusicTrack(id: "mm3-gemini", game: .megaMan3, bossName: "Gemini Man", stageName: "Gemini Stage", audioFileName: "mm3-07. Gemini Man.flac", artworkName: "mm3_gemini_man", paletteIndex: 16),
        MusicTrack(id: "mm3-magnet", game: .megaMan3, bossName: "Magnet Man", stageName: "Magnet Stage", audioFileName: "mm3-06. Magnet Man.flac", artworkName: "mm3_magnet_man", paletteIndex: 15),
        MusicTrack(id: "mm3-shadow", game: .megaMan3, bossName: "Shadow Man", stageName: "Shadow Stage", audioFileName: "mm3-12. Shadow Man.flac", artworkName: "mm3_shadow_man", paletteIndex: 21),
        MusicTrack(id: "mm3-wily-1-2", game: .megaMan3, kind: .castle, bossName: "Dr. Wily 1-2", stageName: "Wily Castle", audioFileName: "mm3-18. Dr. Wily Stage 1~2.flac", artworkName: "mm2_dr_willy", paletteIndex: 34),
        MusicTrack(id: "mm3-wily-3-4", game: .megaMan3, kind: .castle, bossName: "Dr. Wily 3-4", stageName: "Wily Castle", audioFileName: "mm3-19. Dr. Wily Stage 3~4.flac", artworkName: "mm2_dr_willy", paletteIndex: 35),
        MusicTrack(id: "mm3-wily-5-6", game: .megaMan3, kind: .castle, bossName: "Dr. Wily 5-6", stageName: "Wily Castle", audioFileName: "mm3-20. Dr. Wily Stage 5~6.flac", artworkName: "mm2_dr_willy", paletteIndex: 36),
        MusicTrack(id: "mm3-title", game: .megaMan3, kind: .intro, bossName: "Title Screen", stageName: "Intro", audioFileName: "mm3-01. Title Screen.flac", artworkName: "title/Rockman 3 Title screen", paletteIndex: 49),
        MusicTrack(id: "mm3-stage-select", game: .megaMan3, kind: .intro, bossName: "Stage Select", stageName: "Menu", audioFileName: "mm3 Stage Select.flac", artworkName: "stage_select/megaman03_stage_select", paletteIndex: 50),
        MusicTrack(id: "mm3-ending", game: .megaMan3, kind: .ending, bossName: "Ending", stageName: "Finale", audioFileName: "mm3-23 Ending.flac", artworkName: "title/Rockman 3 Ending", paletteIndex: 51),
        MusicTrack(id: "mm3-credits", game: .megaMan3, kind: .ending, bossName: "Credits", stageName: "Finale", audioFileName: "mm3-24. Credits.flac", artworkName: "title/Rockman 3 Ending", paletteIndex: 52),

        MusicTrack(id: "mm4-ring", game: .megaMan4, bossName: "Ring Man", stageName: "Ring Stage", audioFileName: "mm4-11. Ring Man.flac", artworkName: "mm4_ring_man", paletteIndex: 26),
        MusicTrack(id: "mm4-dive", game: .megaMan4, bossName: "Dive Man", stageName: "Dive Stage", audioFileName: "mm4-13. Dive Man.flac", artworkName: "mm4_dive_man", paletteIndex: 28),
        MusicTrack(id: "mm4-skull", game: .megaMan4, bossName: "Skull Man", stageName: "Skull Stage", audioFileName: "mm4-14. Skull Man.flac", artworkName: "mm4_skull_man", paletteIndex: 29),
        MusicTrack(id: "mm4-pharaoh", game: .megaMan4, bossName: "Pharaoh Man", stageName: "Pharaoh Stage", audioFileName: "mm4-10. Pharaoh Man.flac", artworkName: "mm4_pharaoh_man", paletteIndex: 25),
        MusicTrack(id: "mm4-bright", game: .megaMan4, bossName: "Bright Man", stageName: "Bright Stage", audioFileName: "mm4-07. Bright Man.flac", artworkName: "mm4_bright_man", paletteIndex: 22),
        MusicTrack(id: "mm4-toad", game: .megaMan4, bossName: "Toad Man", stageName: "Toad Stage", audioFileName: "mm4-08. Toad Man.flac", artworkName: "mm4_toad_man", paletteIndex: 23),
        MusicTrack(id: "mm4-drill", game: .megaMan4, bossName: "Drill Man", stageName: "Drill Stage", audioFileName: "mm4-09. Drill Man.flac", artworkName: "mm4_drill_man", paletteIndex: 24),
        MusicTrack(id: "mm4-dust", game: .megaMan4, bossName: "Dust Man", stageName: "Dust Stage", audioFileName: "mm4-12. Dust Man.flac", artworkName: "mm4_dust_man", paletteIndex: 27),
        MusicTrack(id: "mm4-wily-castle", game: .megaMan4, kind: .castle, bossName: "Dr. Wily Castle", stageName: "Wily Castle", audioFileName: "mm4-22. Dr. Wily Castle.flac", artworkName: "mm2_dr_willy", paletteIndex: 37),
        MusicTrack(id: "mm4-wily-1-2", game: .megaMan4, kind: .castle, bossName: "Dr. Wily 1-2", stageName: "Wily Castle", audioFileName: "mm4-23. Dr. Wily Stage 1~2.flac", artworkName: "mm2_dr_willy", paletteIndex: 38),
        MusicTrack(id: "mm4-wily-3-4", game: .megaMan4, kind: .castle, bossName: "Dr. Wily 3-4", stageName: "Wily Castle", audioFileName: "mm4-24. Dr. Wily Stage 3~4.flac", artworkName: "mm2_dr_willy", paletteIndex: 39),
        MusicTrack(id: "mm4-opening-city", game: .megaMan4, kind: .intro, bossName: "Opening City", stageName: "Intro", audioFileName: "mm4-01. Opening (City).flac", artworkName: "title/Rockman 4 Opening", paletteIndex: 53),
        MusicTrack(id: "mm4-opening-train", game: .megaMan4, kind: .intro, bossName: "Opening Train", stageName: "Intro", audioFileName: "mm4-02. Opening (Train).flac", artworkName: "title/Rockman 4 Train", paletteIndex: 54),
        MusicTrack(id: "mm4-title", game: .megaMan4, kind: .intro, bossName: "Title Screen", stageName: "Intro", audioFileName: "mm4-03. Title Screen.flac", artworkName: "title/Rockman 4 Title screen", paletteIndex: 55),
        MusicTrack(id: "mm4-stage-select", game: .megaMan4, kind: .intro, bossName: "Stage Select", stageName: "Menu", audioFileName: "mm4-05 Stage Select.flac", artworkName: "stage_select/megaman04_stage_select", paletteIndex: 56),
        MusicTrack(id: "mm4-stage-chosen", game: .megaMan4, kind: .intro, bossName: "Stage Chosen", stageName: "Menu", audioFileName: "mm4-06. Stage Chosen.flac", artworkName: "title/Rockman 4 Stage selected", paletteIndex: 57),
        MusicTrack(id: "mm4-ending", game: .megaMan4, kind: .ending, bossName: "Ending", stageName: "Finale", audioFileName: "mm4-27 Ending.flac", artworkName: "title/Rockman 4 Ending", paletteIndex: 58),
        MusicTrack(id: "mm4-credits", game: .megaMan4, kind: .ending, bossName: "Credits", stageName: "Finale", audioFileName: "mm4-28. Credits.flac", artworkName: "title/Rockman 4 Ending", paletteIndex: 59)
    ]

    static func tracks(for game: MegaManGame) -> [MusicTrack] {
        tracks
            .enumerated()
            .filter { $0.element.game == game }
            .sorted {
                if $0.element.kind != $1.element.kind {
                    return $0.element.kind.rawValue < $1.element.kind.rawValue
                }
                return $0.offset < $1.offset
            }
            .map { $0.element }
    }
}
