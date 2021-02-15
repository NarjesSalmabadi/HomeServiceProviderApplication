package ir.maktab.homeserviceprovider.repository.dao;

import ir.maktab.homeserviceprovider.repository.entity.Services;
import ir.maktab.homeserviceprovider.repository.entity.SubCategory;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubCategoryDao extends CrudRepository<SubCategory, Integer> {
}
