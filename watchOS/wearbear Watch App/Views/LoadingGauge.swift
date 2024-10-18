import SwiftUI

struct LoadingGauge: View {
    let number: Int
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .foregroundColor(.gray.opacity(0.3)) // Círculo de fundo

            Circle()
                .trim(from: 0, to: 0.75) // Mostra 75% do círculo (ajuste conforme necessário)
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .foregroundColor(.green) // Cor do círculo carregando
                .rotationEffect(Angle(degrees: rotation))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: rotation)
                .onAppear {
                    rotation = 360 // Inicia a rotação ao aparecer
                }

            Text("\(number)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white) // Cor do número no centro
        }
        .frame(width: 60, height: 60) // Tamanho do gauge
    }
}
