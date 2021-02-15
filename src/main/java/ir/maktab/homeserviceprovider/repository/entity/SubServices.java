package ir.maktab.homeserviceprovider.repository.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
public class SubServices {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String title;
    private Long basePrice;
    private String description;
    @OneToOne(cascade = CascadeType.ALL)
    private SubCategory subCategory;
    @ManyToOne
    private Services services;
    @ManyToMany(mappedBy = "specialties")
    private List<Expert> experts = new ArrayList<>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String name) {
        this.title = name;
    }

    public Long getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(Long basePrice) {
        this.basePrice = basePrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public SubCategory getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(SubCategory subCategory) {
        this.subCategory = subCategory;
    }

    public Services getServices() {
        return services;
    }

    public void setServices(Services services) {
        this.services = services;
    }

    @Override
    public String toString() {
        return "SubServices{" +
                "title='" + title + '\'' +
                ", basePrice=" + basePrice +
                ", description='" + description + '\'' +
                ", subCategory=" + subCategory +
                ", services=" + services +
                ", experts=" + experts +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SubServices that = (SubServices) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(title, that.title) &&
                Objects.equals(basePrice, that.basePrice) &&
                Objects.equals(description, that.description) &&
                Objects.equals(subCategory, that.subCategory) &&
                Objects.equals(services, that.services);
    }
}
