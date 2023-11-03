//
//  Game.swift
//  Right on target
//
//  Created by Макей 😈 on 03.11.2023.
//

import Foundation
import UIKit

protocol GameProtocol {
    // Количество заработанных очков
    var score: Int { get }
    // Загаданное значение
    var currentSecretValue: Int { get }
    // Проверяет, закончена ли игра
    var isGameEnded: Bool { get }
    // Начинает новую игру и сразу стартует первый раунд
    func restartGame()
    // Начинает новый раунд (обновляет загаданное число)
    func startNewRound()
    // Сравнивает переданное значение с загаданным и начисляет очки
    func calculateScore(with value: Int)
}

class Game: GameProtocol {
    var score: Int = 0
    // Минимальное загаданное значение
    private var minSecretValue: Int
    // Максимальное загаданное значение
    private var maxSecretValue: Int
    var currentSecretValue: Int = 0
    // Количество раундов
    private var lastRound: Int
    private var currentRound: Int = 1
    var isGameEnded: Bool {
        if currentRound >= lastRound { return true}
        else {
            return false
        }
    }
    
    init?(startValue: Int, endValue: Int, rounds: Int) {
        // Стартовое значение для выбора случайного числа не может быть больше конечного
        guard startValue <= endValue else {
            return nil }
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = rounds
        currentSecretValue = self.getNewSecretValue()
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentSecretValue = self.getNewSecretValue()
        currentRound += 1
    }
    // Загадать и вернуть новое случайное значение
    private func getNewSecretValue() -> Int { (minSecretValue...maxSecretValue).randomElement()!
    }
    // Подсчитывает количество очков
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
}
