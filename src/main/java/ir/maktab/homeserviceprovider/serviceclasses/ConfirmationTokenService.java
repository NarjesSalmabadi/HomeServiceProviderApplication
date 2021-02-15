package ir.maktab.homeserviceprovider.serviceclasses;

import ir.maktab.homeserviceprovider.repository.dao.ConfirmationTokenDao;
import ir.maktab.homeserviceprovider.repository.entity.ConfirmationToken;
import ir.maktab.homeserviceprovider.repository.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ConfirmationTokenService {
    private ConfirmationTokenDao confirmationTokenDao;
    @Autowired
    public ConfirmationTokenService(ConfirmationTokenDao confirmationTokenDao) {
        this.confirmationTokenDao = confirmationTokenDao;
    }

    public void saveConfirmationToken(ConfirmationToken confirmationToken){
        confirmationTokenDao.save(confirmationToken);
    }

    public void deleteConfirmationToken(Integer id){

        confirmationTokenDao.deleteById(id);
    }
    public Optional<ConfirmationToken> findConfirmationTokenByToken(String token){
        Optional<ConfirmationToken> confirmationTokenByToken = confirmationTokenDao.findConfirmationTokenByConfirmationToken(token);
        return confirmationTokenByToken;
    }

    public ConfirmationToken findConfirmationTokenByUser(User user){
        return confirmationTokenDao.findByUser(user);
    }
}
