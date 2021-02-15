package ir.maktab.homeserviceprovider.repository.dto;

import ir.maktab.homeserviceprovider.repository.enums.ConfirmationState;

public class ExpertDto {
    private String firstName;
    private String lastName;
    private String email;
    private String specialty;
    private int score;
    private ConfirmationState confirmationState;

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public ConfirmationState getConfirmationState() {
        return confirmationState;
    }

    public void setConfirmationState(ConfirmationState confirmationState) {
        this.confirmationState = confirmationState;
    }
}
