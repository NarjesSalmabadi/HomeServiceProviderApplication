package ir.maktab.homeserviceprovider.serviceclasses;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.dao.ReservationDao;
import ir.maktab.homeserviceprovider.repository.entity.Reservation;
import ir.maktab.homeserviceprovider.repository.enums.ReservationState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class ReservationService {
    @Autowired
    ReservationDao reservationDao;

    public Reservation createReservation(Reservation reservation) {
            Date date = new Date();
            reservation.setRegisterDate(date);
            reservation.setState(ReservationState.WAITING_FOR_EXPERTS_SUGGESTION);
            return reservationDao.save(reservation);
    }

    public List<Reservation> getAllBySubServiceId(Integer subServiceId) {
        return reservationDao.findAllBySubServiceId(subServiceId);
    }

    public List<Reservation> getAllByCustomerId(Integer customerId) {
        return reservationDao.findAllByCustomerId(customerId);
    }

    public List<Reservation> getAllByCustomerEmail(String email) {
        return reservationDao.findAllByCustomerEmail(email);
    }

    public List<Reservation> getBySubServiceAndWaitingForExpertSuggestion(Integer subServiceId) {
        return reservationDao.findAllBySubServiceAndWaitingForExpertSuggestion(subServiceId);
    }

    public List<Reservation> getByCustomerAndWaitingForExpertSelectionOrSuggestion(Integer customerId) {
        return reservationDao.getByCustomerAndWaitingForExpertSelectionOrSuggestion(customerId);
    }

    public Optional<Reservation> getById(Integer reservationId) {
        return reservationDao.findById(reservationId);
    }

    public boolean changeReservationState(ReservationState reservationState, Integer reservationId) {
        Optional<Reservation> founded = getById(reservationId);
        if (founded.isPresent()) {
            if (Objects.nonNull(reservationState)) {
                founded.get().setState(reservationState);
                reservationDao.save(founded.get());
                return true;
            } else {
                throw new NullPointerException(BusinessException.Reservation_State_Must_Be_Meaningful);
            }
        } else {
            return false;
        }
    }
}
