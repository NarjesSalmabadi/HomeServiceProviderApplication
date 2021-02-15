package ir.maktab.homeserviceprovider.repository.dao;

import ir.maktab.homeserviceprovider.repository.entity.ConfirmationToken;
import ir.maktab.homeserviceprovider.repository.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ConfirmationTokenDao extends CrudRepository<ConfirmationToken,Integer> {
    Optional<ConfirmationToken> findConfirmationTokenByConfirmationToken(String token);
    ConfirmationToken findByUser(User user);
}
