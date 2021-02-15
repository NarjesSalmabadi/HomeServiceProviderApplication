package ir.maktab.homeserviceprovider.repository.dao;

import ir.maktab.homeserviceprovider.repository.entity.ExpertSuggestion;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExpertSuggestionDao extends CrudRepository<ExpertSuggestion, Integer> {

    @Query("select suggestion from ExpertSuggestion suggestion where suggestion.reservation.id=:reservationId")
    List<ExpertSuggestion> findAllByReservationId(Integer reservationId);
}
