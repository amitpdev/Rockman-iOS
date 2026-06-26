//
//  ContentView.swift
//  RockMan
//
//  Created by Amit Palomo on 14/06/2026.
//

import SwiftUI
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct ContentView: View {
    @State private var selectedGame: MegaManGame = .megaMan1
    @StateObject private var audioPlayer = AudioPlayerViewModel()

    private let columns = [
        GridItem(.adaptive(minimum: 148, maximum: 220), spacing: 14)
    ]

    var body: some View {
        ZStack {
            CartridgeBackground(game: selectedGame)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.28), value: selectedGame)

            VStack(spacing: 0) {
                header

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(MusicCatalog.tracks(for: selectedGame)) { track in
                            StageTile(
                                track: track,
                                accentColor: selectedGame.cartridgePalette.accent,
                                isCurrent: audioPlayer.currentTrack == track,
                                isPlaying: audioPlayer.currentTrack == track && audioPlayer.isPlaying
                            ) {
                                audioPlayer.toggle(track)
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 18)
                    .padding(.bottom, audioPlayer.currentTrack == nil ? 24 : 112)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            if let currentTrack = audioPlayer.currentTrack {
                NowPlayingBar(
                    track: currentTrack,
                    isPlaying: audioPlayer.isPlaying,
                    onPlayPause: { audioPlayer.toggle(currentTrack) },
                    onStop: { audioPlayer.stop() }
                )
            }
        }
        .alert("Playback", isPresented: errorAlertBinding) {
            Button("OK", role: .cancel) {
                audioPlayer.errorMessage = nil
            }
        } message: {
            Text(audioPlayer.errorMessage ?? "")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("ROCKMAN MUSIC")
                    .font(.system(size: 34, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .textCase(.uppercase)

                Text("Robot master stage themes")
                    .font(.system(size: 15, weight: .semibold, design: .monospaced))
                    .foregroundStyle(selectedGame.cartridgePalette.accent)
            }

            Picker("Game", selection: $selectedGame) {
                ForEach(MegaManGame.allCases) { game in
                    Text(game.shortTitle).tag(game)
                }
            }
            .pickerStyle(.segmented)
            .tint(selectedGame.cartridgePalette.accent)
        }
        .padding(.horizontal, 18)
        .padding(.top, 24)
        .padding(.bottom, 18)
        .background(.black.opacity(0.42))
    }

    private var errorAlertBinding: Binding<Bool> {
        Binding(
            get: { audioPlayer.errorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    audioPlayer.errorMessage = nil
                }
            }
        )
    }
}

private struct StageTile: View {
    let track: MusicTrack
    let accentColor: Color
    let isCurrent: Bool
    let isPlaying: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                BossArtwork(track: track, initials: initials)
                .overlay(alignment: .topTrailing) {
                    statusBadge
                }

                VStack(spacing: 3) {
                    Text(track.displayTitle)
                        .font(.system(size: 18, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.72)

                    Text(track.isPlayable ? track.stageName : "Audio missing")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(track.isPlayable ? .cyan : .orange)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(tileBackground)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isCurrent ? accentColor : Color.white.opacity(0.22), lineWidth: isCurrent ? 3 : 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(track.isPlayable ? 1 : 0.55)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(accessibilityLabel)
        .disabled(!track.isPlayable)
    }

    private var initials: String {
        track.bossName
            .split(separator: " ")
            .compactMap(\.first)
            .map(String.init)
            .joined()
    }

    private var statusBadge: some View {
        Image(systemName: badgeSystemName)
            .font(.system(size: 13, weight: .black))
            .foregroundStyle(.black)
            .frame(width: 28, height: 28)
            .background(track.isPlayable ? accentColor : Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding(8)
    }

    private var badgeSystemName: String {
        if !track.isPlayable { return "exclamationmark.triangle.fill" }
        if isPlaying { return "speaker.wave.2.fill" }
        return "play.fill"
    }

    private var tileBackground: some ShapeStyle {
        LinearGradient(
            colors: [Color.white.opacity(0.13), Color.white.opacity(0.04)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var accessibilityLabel: String {
        track.isPlayable ? "Play \(track.bossName), \(track.game.title)" : "\(track.bossName), audio missing"
    }
}

private struct CartridgePalette: Equatable {
    let shell: Color
    let shellShadow: Color
    let label: Color
    let accent: Color
}

private extension MegaManGame {
    var cartridgePalette: CartridgePalette {
        switch self {
        case .megaMan1:
            CartridgePalette(
                shell: Color(red: 0.02, green: 0.58, blue: 0.86),
                shellShadow: Color(red: 0.00, green: 0.20, blue: 0.45),
                label: Color(red: 0.34, green: 0.88, blue: 0.95),
                accent: Color(red: 0.41, green: 0.94, blue: 1.00)
            )
        case .megaMan2:
            CartridgePalette(
                shell: Color(red: 0.86, green: 0.05, blue: 0.12),
                shellShadow: Color(red: 0.34, green: 0.00, blue: 0.04),
                label: Color(red: 0.97, green: 0.94, blue: 0.88),
                accent: Color(red: 1.00, green: 0.50, blue: 0.24)
            )
        case .megaMan3:
            CartridgePalette(
                shell: Color(red: 0.02, green: 0.61, blue: 0.25),
                shellShadow: Color(red: 0.00, green: 0.19, blue: 0.10),
                label: Color(red: 0.93, green: 0.96, blue: 0.88),
                accent: Color(red: 0.52, green: 1.00, blue: 0.61)
            )
        case .megaMan4:
            CartridgePalette(
                shell: Color(red: 0.97, green: 0.20, blue: 0.55),
                shellShadow: Color(red: 0.46, green: 0.03, blue: 0.24),
                label: Color(red: 0.16, green: 0.22, blue: 0.70),
                accent: Color(red: 1.00, green: 0.77, blue: 0.23)
            )
        }
    }
}

private struct CartridgeBackground: View {
    let game: MegaManGame

    var body: some View {
        let palette = game.cartridgePalette

        ZStack {
            LinearGradient(
                colors: [
                    palette.shell.opacity(0.92),
                    palette.shellShadow.opacity(0.96),
                    Color(red: 0.02, green: 0.02, blue: 0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height

                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(palette.label.opacity(0.16))
                        .frame(width: width * 0.78, height: max(120, height * 0.18))
                        .rotationEffect(.degrees(-8))
                        .offset(x: width * -0.06, y: height * -0.28)

                    ForEach(0..<7, id: \.self) { index in
                        Rectangle()
                            .fill(index.isMultiple(of: 2) ? Color.white.opacity(0.08) : Color.black.opacity(0.10))
                            .frame(width: width * 1.35, height: 24)
                            .rotationEffect(.degrees(-18))
                            .offset(x: 0, y: CGFloat(index) * 88 - height * 0.24)
                    }

                    PixelBlock(color: palette.accent.opacity(0.18), size: 18)
                        .offset(x: width * 0.34, y: height * -0.27)

                    PixelBlock(color: palette.label.opacity(0.14), size: 14)
                        .offset(x: width * -0.36, y: height * 0.30)
                }
            }

            Color.black.opacity(0.24)
        }
    }
}

private struct PixelBlock: View {
    let color: Color
    let size: CGFloat

    var body: some View {
        VStack(spacing: size * 0.25) {
            HStack(spacing: size * 0.25) {
                Rectangle().fill(color)
                Rectangle().fill(color.opacity(0.45))
            }
            HStack(spacing: size * 0.25) {
                Rectangle().fill(color.opacity(0.55))
                Rectangle().fill(color)
            }
        }
        .frame(width: size * 2.25, height: size * 2.25)
    }
}

private struct BossPlaceholder: View {
    let initials: String
    let paletteIndex: Int
    let isDisabled: Bool

    private let palettes: [(Color, Color)] = [
        (.yellow, .orange), (.brown, .red), (.cyan, .blue), (.orange, .pink),
        (.red, .yellow), (.mint, .purple), (.gray, .red), (.cyan, .white),
        (.blue, .mint), (.red, .orange), (.orange, .gray), (.yellow, .cyan),
        (.red, .purple), (.green, .brown), (.mint, .gray), (.red, .pink),
        (.purple, .cyan), (.brown, .yellow), (.pink, .mint), (.green, .yellow),
        (.yellow, .indigo), (.purple, .black), (.yellow, .white), (.green, .cyan),
        (.orange, .gray), (.yellow, .orange), (.red, .cyan), (.brown, .gray),
        (.blue, .teal), (.white, .black)
    ]

    var body: some View {
        let palette = palettes[paletteIndex % palettes.count]

        ZStack {
            Rectangle()
                .fill(.black)

            VStack(spacing: 0) {
                ForEach(0..<6, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<6, id: \.self) { column in
                            Rectangle()
                                .fill(pixelColor(row: row, column: column, palette: palette))
                        }
                    }
                }
            }
            .opacity(isDisabled ? 0.45 : 1)

            Text(initials)
                .font(.system(size: 38, weight: .black, design: .rounded))
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 0, x: 3, y: 3)
        }
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private func pixelColor(row: Int, column: Int, palette: (Color, Color)) -> Color {
        if row == 0 || row == 5 || column == 0 || column == 5 {
            return .black
        }

        return (row + column + paletteIndex).isMultiple(of: 2) ? palette.0 : palette.1
    }
}

private struct BossArtwork: View {
    let track: MusicTrack
    let initials: String

    var body: some View {
        ZStack {
            if let artwork = bundleImage(named: track.artworkName) {
                artwork
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
            } else {
                BossPlaceholder(
                    initials: initials,
                    paletteIndex: track.paletteIndex,
                    isDisabled: !track.isPlayable
                )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .clipped()
    }
}

private func bundleImage(named name: String?) -> Image? {
    guard let name,
          let url = Bundle.main.url(forResource: name, withExtension: "png") else {
        return nil
    }

    #if os(iOS)
    guard let platformImage = UIImage(contentsOfFile: url.path) else {
        return nil
    }
    return Image(uiImage: platformImage)
    #elseif os(macOS)
    guard let platformImage = NSImage(contentsOf: url) else {
        return nil
    }
    return Image(nsImage: platformImage)
    #else
    return nil
    #endif
}

private struct NowPlayingBar: View {
    let track: MusicTrack
    let isPlaying: Bool
    let onPlayPause: () -> Void
    let onStop: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            BossArtwork(track: track, initials: initials)
                .frame(width: 52, height: 52)

            VStack(alignment: .leading, spacing: 3) {
                Text(track.bossName)
                    .font(.system(size: 16, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Text("\(track.game.title) - \(track.stageName)")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundStyle(.cyan)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }

            Spacer(minLength: 8)

            Button(action: onPlayPause) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 18, weight: .black))
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(PlayerButtonStyle(color: .cyan))
            .accessibilityLabel(isPlaying ? "Pause" : "Play")

            Button(action: onStop) {
                Image(systemName: "stop.fill")
                    .font(.system(size: 16, weight: .black))
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(PlayerButtonStyle(color: .orange))
            .accessibilityLabel("Stop")
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.black.opacity(0.88))
        .overlay(alignment: .top) {
            Rectangle()
                .fill(.cyan)
                .frame(height: 2)
        }
    }

    private var initials: String {
        track.bossName
            .split(separator: " ")
            .compactMap(\.first)
            .map(String.init)
            .joined()
    }
}

private struct PlayerButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.black)
            .background(color.opacity(configuration.isPressed ? 0.75 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
