package ir.maktab.homeserviceprovider.repository.entity;

import javax.persistence.*;

@Entity
public class Services {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String title;
    @OneToOne(cascade = CascadeType.ALL)
    private Category category;
//    @OneToMany(mappedBy = "services")
//    private List<SubServices> subServicesList=new ArrayList<>();

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

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

   /* public List<SubServices> getSubServicesList() {
        return subServicesList;
    }

    public void setSubServicesList(List<SubServices> subServicesList) {
        this.subServicesList = subServicesList;
    }*/

    @Override
    public String toString() {
        return "Services{" +
                "title='" + title + '\'' +
                ", category=" + category +
                '}';
    }
}
