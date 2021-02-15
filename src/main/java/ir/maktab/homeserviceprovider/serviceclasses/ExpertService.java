package ir.maktab.homeserviceprovider.serviceclasses;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.dao.ExpertDao;
import ir.maktab.homeserviceprovider.repository.dao.UserDao;
import ir.maktab.homeserviceprovider.repository.entity.ConfirmationToken;
import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import ir.maktab.homeserviceprovider.repository.enums.ConfirmationState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class ExpertService extends UserService {
    @Autowired
    private ExpertDao expertDao;
    @Autowired
    private SubServicesService subServicesService;
    @Autowired
    private ConfirmationTokenService confirmationTokenService;

    public ExpertService(UserDao userDao, PasswordEncoder passwordEncoder,
                         ConfirmationTokenService confirmationTokenService, EmailSenderService emailSenderService) {
        super(userDao, passwordEncoder, confirmationTokenService, emailSenderService);
    }

    public Expert registerExpert(Expert expert) {
        expert.setPassword(passwordEncoder.encode(expert.getPassword()));
        return expertDao.save(expert);
    }

    public List<Expert> getAllExperts() {
        List<Expert> experts = (List<Expert>) expertDao.findAll();
        if (!experts.isEmpty())
            return experts;
        else {
            throw new NullPointerException(BusinessException.No_Expert_was_found);
        }
    }

    public Expert findExpertById(int id) {
        if(expertDao.findById(id).isPresent()){
            return expertDao.findById(id).get();
        }
        return null;
    }

    public boolean deleteExpertById(int id) {
        if (expertDao.findById(id).isPresent()) {
            Expert expert = expertDao.findById(id).get();
            if(expert.getEnabled().equals(false)){
                ConfirmationToken confirmationTokenOfExpert = confirmationTokenService.findConfirmationTokenByUser(expert);
                confirmationTokenService.deleteConfirmationToken(confirmationTokenOfExpert.getId());
            }
            expertDao.deleteById(id);
            return true;
        } else {
            throw new NullPointerException(BusinessException.No_Expert_was_found_With_This_Id);
        }
    }

    public List<Expert> findBySpecifiedField(Expert expert) {
        List<Expert> experts = expertDao.findAll(ExpertDao.findBy(expert));
        return experts;
        /*if (!experts.isEmpty()) {
            return experts;
        } else {
            throw new NullPointerException(BusinessException.No_Expert_was_found);
        }*/
    }

    public Expert findByEmail(String email) {
        return expertDao.findByEmail(email);
    }

    public void saveExpert(Expert expert) {
        expertDao.save(expert);
    }

    public boolean assignSubServiceToExpert(int expertId, int subServiceId) {
        Expert expert = findExpertById(expertId);
        SubServices subService = subServicesService.findById(subServiceId);
        if(expert.getConfirmationState().equals(ConfirmationState.WAITING_TO_BE_CONFIRMED)){
            return false;
        }
        if (!hasExpertASubService(expert, subService)) {
            expert.getSpecialties().add(subService);
            saveExpert(expert);
            return true;
        } else {
            return false;
        }
    }

    public boolean hasExpertASubService(Expert expert, SubServices subService) {
        for (SubServices subServices : expert.getSpecialties()) {
            if (subServices.equals(subService))
                return true;
        }
        return false;
    }

    public List<Expert> findAllExpertsHaveSpecifiedSubService(int subServiceId) {
        return expertDao.findAll(ExpertDao.findAllBySubServiceId(subServiceId));
    }

    public boolean deleteSubServiceFromExpert(int expertId, int subServiceId) {
        Expert expert = findExpertById(expertId);
        SubServices subService = subServicesService.findById(subServiceId);
        if (hasExpertASubService(expert, subService)) {
            expert.getSpecialties().remove(subService);
            saveExpert(expert);
            return true;
        } else {
            return false;
        }
    }

    public List<Expert> getAllExpertAreConfirmedAndEnabled() {
        return expertDao.findAllAreConfirmedAndEnabled();
    }
}
