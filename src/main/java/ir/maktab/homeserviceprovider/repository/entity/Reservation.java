package ir.maktab.homeserviceprovider.repository.entity;

import ir.maktab.homeserviceprovider.repository.enums.ReservationState;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Reservation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Date dueDate;
    private String description;
    private String address;
    private Long customerPrice;
    @CreationTimestamp
    private Date registerDate;
    @Enumerated(value = EnumType.STRING)
    private ReservationState state;
    @ManyToOne
    private User customer;
    @ManyToOne
    private SubServices subServices;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date date) {
        this.registerDate = date;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Long getCustomerPrice() {
        return customerPrice;
    }

    public void setCustomerPrice(Long customerPrice) {
        this.customerPrice = customerPrice;
    }

    public ReservationState getState() {
        return state;
    }

    public void setState(ReservationState orderState) {
        this.state = orderState;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public SubServices getSubServices() {
        return subServices;
    }

    public void setSubServices(SubServices subServices) {
        this.subServices = subServices;
    }

    @Override
    public String toString() {
        return "Reservation{" +
                "date=" + registerDate +
                ", dueDate=" + dueDate +
                ", description='" + description + '\'' +
                ", address='" + address + '\'' +
                ", price=" + customerPrice +
                ", orderState=" + state +
                ", customer=" + customer +
                ", subServices=" + subServices +
                '}';
    }
}
