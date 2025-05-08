import SwiftUI
import SCTokens

public struct CalendarView: View {
    @ObservedObject var viewModel = CalendarViewModel()
    
    public init(viewModel : CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: Spacing.spacing2x) {
            TabView(
                selection:
                    Binding<Int>(get: {
                        viewModel.selectedWeekIndex
                    }, set: { value in
                        viewModel.selectedWeekIndex = value
                    })
            ) {
                ForEach(Array(viewModel.currentWeeks.enumerated()), id: \.element) { index, week in
                    WeekView(viewModel: viewModel, week: week)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: Sizing.sizing10x * 2)
        }
    }
}

private struct WeekView: View {
    @StateObject var viewModel: CalendarViewModel
    let week: WeekModel
    var body: some View {
        HStack {
            ForEach(week.dates) { date in
                DayView(date: date, selectedDate: $viewModel.selectedDate)
            }
        }
        .background {
            GeometryReader { proxy in
                let minX = proxy.frame(in: .global).minX
                Color.clear
                    .preference(key: WeekViewOffsetKey.self, value: minX)
                    .onPreferenceChange(WeekViewOffsetKey.self, perform: { value in
                        // we need to detect index change + stop of scrolling
                        if value == 0.0 && (viewModel.selectedWeekIndex == 0 || viewModel.selectedWeekIndex == 2) {
                            viewModel.addNeededWeek()
                            viewModel.updateSelectedDate()
                        }
                    })
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
                date.formatted(Date.FormatStyle().weekday(.abbreviated)),
                style: .size75(
                    weight: .regular,
                    theme: isDateBeyondToday ? .secondry : .primary,
                    alignment: .center
                )
            )
            
            ZStack {
                SDText(
                    date.formatted(Date.FormatStyle().day()),
                    style: .size200(
                        weight: .medium,
                        theme: isDateBeyondToday ? .secondry : .primary,
                        alignment: .center
                    )
                )
                .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
                
                if isSelected {
                    selectionView
                        .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.2)) {
                if !isDateBeyondToday {
                    selectedDate = date
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var selectionView: some View {
        return VStack {
            Spacer()
            Rectangle()
                .fill(Color.royalBlue)
                .frame(width: Sizing.sizing2x, height: Sizing.sizing2x)
                .clipShape(.circle)
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
