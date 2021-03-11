package ir.maktab.homeserviceprovider.serviceclasses;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.dao.ExpertSuggestionDao;
import ir.maktab.homeserviceprovider.repository.entity.ExpertSuggestion;
import ir.maktab.homeserviceprovider.repository.entity.Reservation;
import ir.maktab.homeserviceprovider.repository.enums.ReservationState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExpertSuggestionService {
    @Autowired
    ExpertSuggestionDao expertSuggestionDao;
    @Autowired
    ReservationService reservationService;

    public ExpertSuggestion createSuggestion(ExpertSuggestion suggestion){
        Optional<Reservation> reservation = reservationService.getById(suggestion.getReservation().getId());
        if(reservation.isPresent()){
            reservation.get().setState(ReservationState.WAITING_FOR_EXPERT_SELECTION);
            return expertSuggestionDao.save(suggestion);
        }
        throw new NullPointerException(BusinessException.No_Reservation_Was_Founded);
    }

    public List<ExpertSuggestion> findAllByReservationId(Integer reservationId){
        return expertSuggestionDao.findAllByReservationId(reservationId);
    }

    public Optional<ExpertSuggestion> findByExpertIdAndReservationId(int expertId, int reservationId){
        return expertSuggestionDao.findByExpertIdAndReservationId(expertId, reservationId);
    }

}

