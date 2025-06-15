/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Ahmad
 */
public class StudentFareStrategy implements FareStrategy {
    @Override
    public double getDiscount(double baseFare) {
        return baseFare * 0.20;
    }
}
