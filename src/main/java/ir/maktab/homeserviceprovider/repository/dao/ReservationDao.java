package ir.maktab.homeserviceprovider.repository.dao;

import ir.maktab.homeserviceprovider.repository.entity.Reservation;
import ir.maktab.homeserviceprovider.repository.entity.Services;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservationDao extends CrudRepository<Reservation, Integer> {

    @Query("select reservation from Reservation reservation where reservation.subServices.id=:id")
    List<Reservation> findAllBySubServiceId(@Param("id") Integer subServiceId);

    @Query("select reservation from Reservation reservation where reservation.customer.id=:id")
    List<Reservation> findAllByCustomerId(@Param("id") Integer customerId);

    @Query("select reservation from Reservation reservation where reservation.customer.email=:email")
    List<Reservation> findAllByCustomerEmail(@Param("email") String email);

    @Query("select reservation from Reservation reservation where reservation.subServices.id=:id AND" +
            " reservation.state=\'WAITING_FOR_EXPERTS_SUGGESTION\'")
    List<Reservation> findAllBySubServiceAndWaitingForExpertSuggestion(@Param("id")Integer subServiceId);

    @Query("select reservation from Reservation reservation where reservation.customer.id=:id AND" +
            " reservation.state=\'WAITING_FOR_EXPERT_SELECTION\' or reservation.state=\'WAITING_FOR_EXPERTS_SUGGESTION\'")
    List<Reservation> getByCustomerAndWaitingForExpertSelectionOrSuggestion(@Param("id")Integer customerId);
}
