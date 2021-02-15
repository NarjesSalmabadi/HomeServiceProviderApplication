package ir.maktab.homeserviceprovider.serviceclasses;

import ir.maktab.homeserviceprovider.repository.dao.ExpertSuggestionDao;
import ir.maktab.homeserviceprovider.repository.entity.ExpertSuggestion;
import ir.maktab.homeserviceprovider.repository.enums.ReservationState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExpertSuggestionService {
    @Autowired
    ExpertSuggestionDao expertSuggestionDao;

    public ExpertSuggestion createSuggestion(ExpertSuggestion suggestion){
        suggestion.getReservation().setState(ReservationState.WAITING_FOR_EXPERT_SELECTION);
        return expertSuggestionDao.save(suggestion);
    }

    public List<ExpertSuggestion> getAllByReservationId(Integer reservationId){
        return expertSuggestionDao.findAllByReservationId(reservationId);
    }

}

