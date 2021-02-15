package ir.maktab.homeserviceprovider.serviceclasses;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.dao.ServiceDao;
import ir.maktab.homeserviceprovider.repository.dao.SubServiceDao;
import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLOutput;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class SubServicesService {

    @Autowired
    SubServiceDao subServiceDao;
    @Autowired
    ServiceDao serviceDao;
    @Autowired
    ExpertService expertService;

    public SubServices create(SubServices subService) {
        //return subServiceDao.save(subService);
        if (Objects.nonNull(subService.getTitle()) && subService.getTitle().length() > 0) {
            if (Objects.nonNull(subService.getBasePrice()) && subService.getBasePrice() >= 0) {
                if (Objects.nonNull(subService.getDescription()) && subService.getDescription().length() > 0) {
                    if (serviceDao.findById(subService.getServices().getId()).isPresent()) {
                    System.out.println();
                    if (findByTitle(subService.getTitle()).isEmpty()) {
                        System.out.println(subService);
                        subService.setServices(serviceDao.findById(subService.getServices().getId()).get());
                        return subServiceDao.save(subService);
                    } else {
                        throw new NullPointerException(BusinessException.This_Sub_Service_Is_Already_Exist);
                    }
                    } else {
                        throw new NullPointerException(BusinessException.This_Service_Is_Not_Already_Exist);
                    }
                } else {
                    throw new NullPointerException(BusinessException.The_Description_Of_SubService_Must_Be_Meaningful);
                }
            } else {
                throw new NullPointerException(BusinessException.The_BasePrice_Of_SubService_Must_Be_Meaningful);
            }
        } else {
            throw new NullPointerException(BusinessException.The_Name_Of_SubService_Must_Be_Meaningful);
        }
    }

    public Optional<SubServices> findByTitle(String title) {
        if (Objects.nonNull(title) && title.length() > 0) {
            return subServiceDao.findByTitle(title);
        } else {
            throw new NullPointerException(BusinessException.The_Name_Of_SubService_Must_Be_Meaningful);
        }
    }

    public SubServices findById(int subServiceId) {
        if (subServiceDao.findById(subServiceId).isPresent()) {
            return subServiceDao.findById(subServiceId).get();
        } else {
            throw new NullPointerException(BusinessException.No_SubService_was_found_With_This_Id);
        }
    }

    public List<SubServices> findByServiceId(int id) {
        List<SubServices> subServices = subServiceDao.findByServiceId(id);
        return subServices;
    }

    public SubServices saveSubService(SubServices subServices) {
        return subServiceDao.save(subServices);
    }

    public void deleteSubService(int subServiceId) {
        if (Objects.nonNull(findById(subServiceId))) {
            List<Expert> expertList = expertService.findAllExpertsHaveSpecifiedSubService(subServiceId);
            for (Expert expert : expertList) {
                for (SubServices subServices : expert.getSpecialties()) {
                    if (subServices.getId() == subServiceId) {
                        expert.getSpecialties().remove(subServices);
                        expertService.saveExpert(expert);
                        break;
                    }
                }
            }
            subServiceDao.deleteById(subServiceId);
        } else {
            throw new NullPointerException(BusinessException.No_SubService_was_found_With_This_Id);
        }
    }
}
