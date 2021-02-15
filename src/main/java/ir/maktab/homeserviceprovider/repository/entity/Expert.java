package ir.maktab.homeserviceprovider.repository.entity;

import ir.maktab.homeserviceprovider.repository.enums.ConfirmationState;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Expert extends User {
    @Enumerated(EnumType.STRING)
    private ConfirmationState confirmationState;
    private String photo;
    private int score;
    @ManyToMany(cascade = CascadeType.MERGE)
    private List<SubServices> specialties = new ArrayList<>();

    public ConfirmationState getConfirmationState() {
        return confirmationState;
    }

    public void setConfirmationState(ConfirmationState confirmationState) {
        this.confirmationState = confirmationState;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public List<SubServices> getSpecialties() {
        return specialties;
    }

    public void setSpecialties(List<SubServices> specialties) {
        this.specialties = specialties;
    }

    @Transient
    public String getPhotoImagePath() {
        if (photo == null || super.getId() == null) return null;
        return "/user-photos/" + super.getId() + "/" + photo;
    }

    @Override
    public String toString() {
        return "Expert{" +
                "confirmationState=" + confirmationState +
                ", photo='" + photo + '\'' +
                ", score=" + score +
                ", specialties=" + specialties +
                "} " + super.toString();
    }
}
