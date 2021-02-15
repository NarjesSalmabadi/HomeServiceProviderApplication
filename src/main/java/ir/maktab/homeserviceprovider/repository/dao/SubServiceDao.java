package ir.maktab.homeserviceprovider.repository.dao;

import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SubServiceDao extends CrudRepository<SubServices, Integer> {

    Optional<SubServices> findByTitle(String name);

    @Query("select s from SubServices s where s.services.id=:id")
    List<SubServices> findByServiceId(@Param("id") int id);
}
