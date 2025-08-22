import SwiftUI
import SCTokens

public struct SDScoreCard: View {
    private let title: String
    private let subTitle: String
    private let backgroundColor: SDTextTheme
    private let foregroundColor: SDTextTheme

    public init(
        title: String,
        subTitle: String,
        foregroundColor: SDTextTheme,
        backgroundColor: SDTextTheme
    ) {
        self.title = title
        self.subTitle = subTitle
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        Font.loadMyFonts
    }

    public var body: some View {
        VStack {
            SDText(
                title,
                style: .size75(
                    weight: .medium,
                    theme: foregroundColor,
                    alignment: .center
                )
            )
            .padding(.top, Spacing.spacing2x)
            .padding(.horizontal, Spacing.spacing2x)

            SDText(
                subTitle,
                style: .size300(
                    weight: .bold,
                    theme: backgroundColor,
                    alignment: .center
                )
            )
            .frame(
                minWidth: Sizing.sizing5x * Sizing.sizing1x,
                maxWidth: .infinity,
                minHeight: Sizing.sizing10x,
                maxHeight: .infinity
            )
            .background(foregroundColor.textColor)
            .cornerRadius(Sizing.sizing3x)
            .padding(.bottom, Spacing.spacing1x)
            .padding(.horizontal, Spacing.spacing1x)
        }
        .background(backgroundColor.textColor)
        .cornerRadius(Sizing.sizing3x)
    }
}

#Preview {
    HStack(spacing: Spacing.spacing4x) {
        SDScoreCard(title: "Total Points", subTitle: "29", foregroundColor: .standard, backgroundColor: .bright)
            .frame(width: 120)

        SDScoreCard(title: "Score", subTitle: "98", foregroundColor: .standard, backgroundColor: .royalBlue)
            .frame(width: 105)

        SDScoreCard(title: "Timing", subTitle: "1:45", foregroundColor: .standard, backgroundColor: .positive)
            .frame(width: 150)
    }
    .frame(width: 120, height: 100)
}
