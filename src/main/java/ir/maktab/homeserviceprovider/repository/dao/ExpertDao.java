package ir.maktab.homeserviceprovider.repository.dao;

import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@Repository
public interface ExpertDao extends CrudRepository<Expert, Integer>, JpaSpecificationExecutor<Expert> {


    static Specification<Expert> findBy(Expert expert) {
        return (Specification<Expert>) (root, criteriaQuery, criteriaBuilder) -> {

            CriteriaQuery<Expert> query = criteriaBuilder.createQuery(Expert.class);
            List<Predicate> conditions = new ArrayList<>();

            if (!expert.getSpecialties().get(0).getTitle().equals("")) {
                Join<Expert, SubServices> expertSpecialities = root.join("specialties", JoinType.INNER);
                conditions.add(criteriaBuilder.like(expertSpecialities.get("title"), "%" + expert.getSpecialties().get(0).getTitle() + "%"));
            }
            if (Objects.nonNull(expert.getFirstName())) {
                conditions.add(criteriaBuilder.like(root.get("firstName"), "%" + expert.getFirstName() + "%"));
            }
            if (Objects.nonNull(expert.getLastName())) {
                conditions.add(criteriaBuilder.like(root.get("lastName"), "%" + expert.getLastName() + "%"));
            }
            if (Objects.nonNull(expert.getEmail())) {
                conditions.add(criteriaBuilder.like(root.get("email"), "%" + expert.getEmail() + "%"));
            }
            if (expert.getScore() > 0) {
                conditions.add(criteriaBuilder.equal(root.get("score"), expert.getScore()));
            }
            if (Objects.nonNull(expert.getConfirmationState())) {
                conditions.add(criteriaBuilder.equal(root.get("confirmationState"), expert.getConfirmationState()));
            }
            conditions.add(criteriaBuilder.equal(root.get("enabled"), true));

            CriteriaQuery<Expert> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

    Expert findByEmail(String email);

    static Specification<Expert> findAllBySubServiceId(int subServiceId) {
        return (Specification<Expert>) (root, criteriaQuery, criteriaBuilder) -> {

            CriteriaQuery<Expert> query = criteriaBuilder.createQuery(Expert.class);
            List<Predicate> conditions = new ArrayList<>();
            Join<Expert, SubServices> expertSpecialities = root.join("specialties", JoinType.INNER);
            conditions.add(criteriaBuilder.equal(expertSpecialities.get("id"), subServiceId));
            CriteriaQuery<Expert> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

    @Query("select expert from Expert expert where expert.confirmationState=\'CONFIRMED\' and expert.enabled=true")
    List<Expert> findAllAreConfirmedAndEnabled();

    /*@Query("select expert from Expert expert join fetch expert.specialties specialty join specialty.experts ex where specialty.id=: id")
    List<Expert> findAllBySubServiceId(@Param("id") int subServiceId);*/
}
