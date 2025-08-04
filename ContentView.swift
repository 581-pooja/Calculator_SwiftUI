//
//  ContentView.swift
//  CalculatorDemo
//
//  Created by Pooja4 Bhagat on 17/12/24.
//

import SwiftUI

enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case decimal = "."
    case clear = "C"
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self{
        case .add, .subtract, .multiply, .divide, .equal:
            return Color(.orange)
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0,
                                 green: 55/255.0,
                                 blue: 55/255.0,
                                alpha: 1))
        }
    }
}

enum Operation{
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    // @State property wrapper is used to declare a piece of mutable state that is owned by a view.
    // Control the state of view as updated
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    
    // it is 2d array with items of type CalcButton
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack{
             Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Spacer()
                // Text Display
                HStack(spacing: 12){
                    Spacer()  // used to create flexible space between views in a layout
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                // Buttons
                ForEach(buttons, id: \.self){
                    row in
                    HStack{
                        ForEach(row, id: \.self){
                            item in Button(action:{
                                self.didTap(button: item)
                            },  label: {
                                Text(item.rawValue)
                                    .frame(width: buttonWidth(item: item),
                                           height: buttonHeight(item: item))
                                    .font(.system(size: 32))
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(40)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton){
        switch button{
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
            }
            
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal{
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
            break
            
        case .decimal:
            if !self.value.contains(".") {
                self.value = "\(self.value)."
            }
            
        case .percent:
            let currentValue = Double(self.value) ?? 0
            self.value = "\(currentValue * 0.01)"
            
        case .negative:
            if let currentValue = Double(self.value) {
                self.value = "\(currentValue * -1)"
            }
            
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number   // 0 -> 8
            }
            else{
                self.value = "\(self.value)\(number)"  // 567
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero{
            return ((UIScreen.main.bounds.width - (5 * 12))/4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12))/4
    }
    
    func buttonHeight(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12))/4
    }
}

#Preview {
    ContentView()
}
