/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ahmad
 */
public class FareCalculator {
    private List<FareStrategy> strategies = new ArrayList<>();

    public void addStrategy(FareStrategy strategy) {
        strategies.add(strategy);
    }

  
    public double calculateFare(double baseFare) {
        double totalDiscount = 0;
        for (FareStrategy strategy : strategies) {
            totalDiscount += strategy.getDiscount(baseFare);
        }
        totalDiscount = Math.min(totalDiscount, baseFare * 0.50);
        return baseFare - totalDiscount;
    }

    public void clearStrategies() {
        strategies.clear();
    }
}