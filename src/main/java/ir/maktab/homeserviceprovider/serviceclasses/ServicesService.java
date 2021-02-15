package ir.maktab.homeserviceprovider.serviceclasses;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.dao.ServiceDao;
import ir.maktab.homeserviceprovider.repository.entity.Services;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class ServicesService {

    @Autowired
    ServiceDao serviceDao;
    @Autowired
    SubServicesService subServicesService;

    public Services create(Services services) {
        if (Objects.nonNull(services.getTitle()) & services.getTitle().length() > 0) {
            if (Objects.isNull(serviceDao.findByTitle(services.getTitle()))) {
                return serviceDao.save(services);
            } else {
                throw new NullPointerException(BusinessException.This_Service_Is_Already_Exist);
            }
        } else {
            throw new NullPointerException(BusinessException.The_Name_Of_Service_Must_Be_Meaningful);
        }
    }

    public Services findByTitle(String name) {
        if (Objects.nonNull(name) & name.length() > 0) {
            return serviceDao.findByTitle(name);
        } else {
            throw new NullPointerException(BusinessException.The_Name_Of_Service_Must_Be_Meaningful);
        }
    }

    public List<Services> findAll() {
        List<Services> services = (List<Services>) serviceDao.findAll();
        if (!services.isEmpty()) {
            return services;
        } else {
            throw new NullPointerException(BusinessException.No_Service_Was_Found);
        }
    }

    public Services findById(int serviceId) {
        return serviceDao.findById(serviceId).get();
    }

    public Services saveService(Services service) {
        return serviceDao.save(service);
    }

    public void deleteService(int serviceId) {
        if(Objects.nonNull(findById(serviceId))){
            List<SubServices> subServicesList = subServicesService.findByServiceId(serviceId);
            for (SubServices subService : subServicesList) {
                subServicesService.deleteSubService(subService.getId());
            }
            serviceDao.deleteById(serviceId);
        }else{
            throw new NullPointerException(BusinessException.This_Service_Is_Not_Already_Exist);
        }
    }
}
