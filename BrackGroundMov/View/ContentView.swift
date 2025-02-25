//
//  ContentView.swift
//  BrackGroundMov
//
//  Created by Paul F on 25/02/25.
//  Background Harry Potter.

import SwiftUI
//Liberia para el audio.
import AVKit

struct ContentView: View {
    //V-92 ,Paso 15,animations
    @State private var scalePlayButton = false
    //Paso 1.9, para mover el background
    @State private var moveBackgroundImage = false
    //Para el audio.
    @State private var audioPlayer: AVAudioPlayer!
    //Animation letters
    @State private var animateViewsIn = false
   
    var body: some View {
        //V-95 ,Paso 1.0 empezamos con el GeometryReader
        GeometryReader{
            geo in
            ZStack{
                //Paso 1.3,ponemos la imagen de Howarts
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3 ,height: geo.size.height)
                    .padding(.top,3)
                    //Paso 1.10,para mover la imagen
                    .offset(x:moveBackgroundImage ? geo.size.width/1.1 :
                                -geo.size.width/1.1)
                    //Paso 1.11,Modifier para que se mueva la imagen.
                    .onAppear{
                        withAnimation(.linear(duration: 60).repeatForever()){
                            moveBackgroundImage.toggle()
                        }
                    }
                //Paso 1.4 ,ponemos el Vstack
                VStack{
                    //Paso 1.6,Sstack para animacion
                    VStack{
                        //Para la animacon de las letras
                        if animateViewsIn{
                            //Paso 1.7, ponemos un Vstack para add la imagen.
                            VStack{
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                Text("HP")
                                //Paso 1.8,usamos nuestra fuente de texto.
                                    .font(.custom(Constants.hpFont, size: 70))
                                    .padding(.bottom,-50)
                                Text("Trivia")
                                    .font(.custom(Constants.hpFont, size: 60))
                            }
                            //Paso 13, agregamos el padding
                            .padding(.top,70)
                            //Paso 23 movimiento de las letras
                            .transition(.move(edge: .top))
                        }
                        //Paso 27, para poner las letras en animcion.
                    }.animation(.easeOut(duration: 0.7).delay(2),value: animateViewsIn)
                    
                    Spacer()
                }
            }
            //Paso 1.1 , ponemos el frame
            .frame(width: geo.size.width,height: geo.size.height)
        }
        .ignoresSafeArea()
        //Tan pronto aparezca la pantalla ponemos el audio, con el onAppear
        .onAppear(){
            //llamamos las letras al frente
            animateViewsIn = true
            //Paso 1.12.
            playAudio()
            
        }
    }
 
    //Paso 1.12, Function to initialize and play audio.
    private func playAudio() {
        if let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3") {
             // Replace "Audio/magic-in-the-air" with "magic-in-the-air" if you have not placed the music files in a separate Audio folder
            do {
                // Try to initialize the audio player
                audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: sound))
                // Set the number of loops and play the audio
                audioPlayer.numberOfLoops = -1
                audioPlayer.play()
            } catch {
                // This block will execute if any error occurs
                print("There was an issue playing the sound: \(error)")
            }
        } else {
            print("Couldn't find the sound file")
        }
    }
}
    

#Preview {
    VStack{
        ContentView()
    }
}

