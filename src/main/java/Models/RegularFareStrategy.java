/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Ahmad
 */
public class RegularFareStrategy implements FareStrategy {
    @Override
    public double getDiscount(double baseFare) {
        return 0;
    }
}