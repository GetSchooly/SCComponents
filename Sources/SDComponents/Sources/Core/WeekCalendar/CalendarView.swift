import SwiftUI
import SCTokens

public struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    @State private var hasScrolledToCurrentWeek = false

    public init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(viewModel.weeks) { week in
                            WeekView(viewModel: viewModel, week: week)
                                .frame(width: geo.size.width)
                                .id(week.id)
                                .onAppear {
                                    // Only start infinite-past loading AFTER the first jump to today
                                    if hasScrolledToCurrentWeek,
                                       week.id == viewModel.weeks.first?.id {
                                        viewModel.loadMorePastWeeks()
                                        
                                    }
                                }
                                
                        }
                        
                    }
                }
                // initial jump to the current week (today is already selected in your VM init)
                .onAppear {
                    if !hasScrolledToCurrentWeek {
                        scrollToCurrentWeek(proxy)
                    }
                }
                // If data mutates on appear, try again once.
                .onChange(of: viewModel.weeks.count) { _ in
                    if !hasScrolledToCurrentWeek {
                        scrollToCurrentWeek(proxy)
                    }
                }
            }
        }
        .frame(height: Sizing.sizing14x + Sizing.sizing2x)
    }

    private func scrollToCurrentWeek(_ proxy: ScrollViewProxy) {
        guard let lastID = viewModel.weeks.last?.id else { return }
        // Ensure layout has happened before scrolling
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.25)) {
                proxy.scrollTo(lastID, anchor: .trailing) // lock current week at the right edge
            }
            hasScrolledToCurrentWeek = true
        }
    }
}

private struct WeekView: View {
    @ObservedObject var viewModel: CalendarViewModel
    let week: WeekModel

    var body: some View {
        HStack {
            ForEach(week.dates) { date in
                DayView(date: date, selectedDate: $viewModel.selectedDate)
            }
        }
    }
}

private struct DayView: View {
    let date: Date
    @Binding var selectedDate: Date
    private var isSelected: Bool { date == selectedDate }
    private var isDateBeyondToday: Bool { date > Date() }

    var body: some View {
        VStack(spacing: Spacing.spacing2x) {
            SDText(
                date.formatted(.dateTime.weekday(.abbreviated)),
                style: .size75(
                    weight: .regular,
                    theme: isDateBeyondToday ? .secondry : .primary,
                    alignment: .center
                )
            )

            ZStack {
                SDText(
                    date.formatted(.dateTime.day()),
                    style: .size100(
                        weight: .medium,
                        theme: isDateBeyondToday ? .secondry : .primary,
                        alignment: .center
                    )
                )

                    .frame(height: Sizing.sizing8x)

                if isSelected {
                    Circle()
                        .fill(Color.royalBlue)
                        .frame(width: Sizing.sizing2x, height: Sizing.sizing2x)
                        .offset(y: Spacing.spacing4x)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            if !isDateBeyondToday {
                withAnimation(.easeIn(duration: 0.2)) {
                    selectedDate = date
                }
            }
        }
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel())
}

private struct WeekViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
