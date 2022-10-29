//
//  ContentView.swift
//  MyFirstApp
//
//  Created by geonhui Yu on 2022/10/15.
//

import SwiftUI

enum ButtonType: Hashable {
//    case first, second, third, forth, fifth, sixth, seventh,
//    eighth, nineth, zero
    case number(String)
    case calculation(String)
    case unit(String)
    
    var buttonDisplayName: String {
        switch self {
        case .number(let num):
            return num
        case .calculation(let cal):
            return cal
        case .unit(let unit):
            return unit
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .number:
            return .gray
        case .calculation:
            return .orange
        case .unit:
            return .yellow
        }
    }
    
    var forgroundColor: Color {
        switch self{
        case .number, .calculation: return .white
        case .unit: return .black
        }
    }
//    case comma, equal, plus, minus, multiple, devide
//    case percent, opposite, clear
//    var buttonDisplayName: String {
//        switch self {
//        case.first :
//            return "1"
//        case .second:
//            return "2"
//        case .third:
//            return "3"
//        case .forth:
//            return "4"
//        case .fifth:
//            return "5"
//        case .sixth:
//            return "6"
//        case .seventh:
//            return "7"
//        case .eighth:
//            return "8"
//        case .nineth:
//            return "9"
//        case .zero:
//            return "0"
//        case .comma:
//            return "."
//        case .equal:
//            return "="
//        case .plus:
//            return "+"
//        case .minus:
//            return "="
//        case .multiple:
//            return "X"
//        case .devide:
//            return "%"
//        case .percent:
//            return "/"
//        case .opposite:
//            return "C"
//        case .clear:
//            return "C"
//        }
//    }
//
//    var backgroundColor: Color {
//        switch self {
//        case .first, .second, .third, .forth, .fifth, .sixth, .seventh,
//                .eighth, .nineth, .zero, .comma:
//            return .gray
//        case .equal, .plus, .minus, .multiple, .devide:
//            return .orange
//        case .percent, .opposite, .clear:
//            return .gray
//        }
//    }
//
//    var forgroundColor: Color {
//        switch self {
//        case .first, .second, .third, .forth, .fifth, .sixth, .seventh,
//                .eighth, .nineth, .zero, .comma, .equal, .plus, .minus, .multiple, .devide:
//            return .white
//        case .percent, .opposite, .clear:
//            return .black
//        }
//    }
}


struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var isFirstInput: Bool = true
    
    @State var operateType: ButtonType = .unit("C")
    
    private let buttonData: [[ButtonType]] = [
        [.unit("C"), .unit("+/-"), .unit("%"), .calculation("/")],
        [.number("7"), .number("8"), .number("9"), .calculation("X")],
        [.number("4"), .number("5"), .number("6"), .calculation("-")],
        [.number("1"), .number("2"), .number("3"), .calculation("+")],
        [.number("0"), .number(","), .calculation("=")],
    ]
    var body: some View {
        
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(totalNumber)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundColor(.white)
                }
                
                ForEach(buttonData, id: \.self) { line in
                    HStack {
                        ForEach(line, id: \.self) { item in
                            Button {
                                self.calculate(item)
                                
                            } label: {
                                Text(item.buttonDisplayName)
                                    .bold()
                                    .frame(width: calculateButtonWidth(button: item), height: calculateButtonHeight(button: item))
                                    .background(item.backgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(item.forgroundColor)
                                    .font(.system(size: 33))
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func calculateButtonWidth(button buttonType: ButtonType) -> CGFloat {
        switch buttonType {
        case .number("0"):
            return (UIScreen.main.bounds.width - 5 * 10) / 4 * 2
        default :
            return (UIScreen.main.bounds.width - 5 * 10) / 4
        }
    }
    
    private func calculateButtonHeight(button buttonType: ButtonType) -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 10) / 4
    }
    
}
extension ContentView {
    
    private func calculate(_ type: ButtonType) {
        
        if isFirstInput {
            switch type {
                
            case .unit("C"): return totalNumber = "0"
            case .number:
                totalNumber += type.buttonDisplayName
                self.isFirstInput = false
                return
            case .calculation: return self.isFirstInput = false
            case .unit: return self.isFirstInput = false
            }
        }
        
        else {
            
            switch type {
            case .unit("C"): return totalNumber = "0"
            case .number:
                totalNumber = ""
                totalNumber += type.buttonDisplayName
                return
                
            case .calculation("+"), .calculation("-"), .calculation("*"), .calculation("/"): do {
                tempNumber = Int(totalNumber) ?? 0
                self.operateType = type
            }
                
            case .calculation("="): do {
                switch self.operateType {
                case .calculation("+"): return totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)
                case .calculation("-"): return totalNumber = String((Int(totalNumber) ?? 0) - tempNumber)
                case .calculation("*"): return totalNumber = String((Int(totalNumber) ?? 0) * tempNumber)
                case .calculation("/"): return totalNumber = String((Int(totalNumber) ?? 0) / tempNumber)
                default: return
                }
            }
                
            default: return
            }
        }
    }
}

func showZeroElement(item: ButtonType) -> CGFloat {
    
    return item == .number("0") ? 170 : 80
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
