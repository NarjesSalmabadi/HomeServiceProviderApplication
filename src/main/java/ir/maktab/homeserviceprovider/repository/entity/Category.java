package ir.maktab.homeserviceprovider.repository.entity;

import javax.persistence.*;

@Entity
public class Category {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String title;
//    @OneToMany(mappedBy = "category")
//    List<SubCategory> categoryElementList=new ArrayList<>();

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

   /* public List<SubCategory> getCategoryElementList() {
        return categoryElementList;
    }

    public void setCategoryElementList(List<SubCategory> categoryElementList) {
        this.categoryElementList = categoryElementList;
    }*/

    @Override
    public String toString() {
        return "Category{" +
                "title='" + title + '\'' +
                '}';
    }
}
