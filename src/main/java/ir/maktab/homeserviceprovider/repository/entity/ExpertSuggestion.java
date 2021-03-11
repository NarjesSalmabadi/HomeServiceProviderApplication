package ir.maktab.homeserviceprovider.repository.entity;

import javax.persistence.*;
import java.time.LocalTime;

@Entity
public class ExpertSuggestion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Long expertPrice;
    private Integer duration;
    private LocalTime startTime;
    @ManyToOne
    Expert expert;
    @ManyToOne(cascade = CascadeType.MERGE)
    Reservation reservation;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Long getExpertPrice() {
        return expertPrice;
    }

    public void setExpertPrice(Long expertPrice) {
        this.expertPrice = expertPrice;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }

    public Reservation getReservation() {
        return reservation;
    }

    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }

    @Override
    public String toString() {
        return "ExpertSuggestion{" +
                "expertPrice=" + expertPrice +
                ", duration=" + duration +
                ", startTime=" + startTime +
                ", expert=" + expert +
                ", reservation=" + reservation +
                '}';
    }
}
