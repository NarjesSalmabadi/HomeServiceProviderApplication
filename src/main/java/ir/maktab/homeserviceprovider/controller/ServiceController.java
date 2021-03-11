package ir.maktab.homeserviceprovider.controller;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.Services;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import ir.maktab.homeserviceprovider.serviceclasses.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/services")
public class ServiceController {

    @Autowired
    ServicesService servicesService;
    @Autowired
    SubServicesService subServicesService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    SubCategoryService subCategoryService;
    @Autowired
    ExpertService expertService;

    @PostMapping("/newService")
    @ResponseBody
    public ResponseEntity createNewService(@RequestBody Services services) {
        try {
            Services savedService = servicesService.create(services);
            return ResponseEntity.ok("Service with code " + savedService.getId() + " is add successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/newSubService")
    @ResponseBody
    public ResponseEntity createNewSubService(@RequestBody SubServices subService) {
        try {
            Services service = servicesService.findById(subService.getServices().getId());
            if (Objects.nonNull(service)) {
                subService.setServices(service);
                subService.getSubCategory().setCategory(service.getCategory());
            } else {
                return ResponseEntity.badRequest().body(BusinessException.This_Service_Is_Not_Already_Exist);
            }
            SubServices savedSubService = subServicesService.create(subService);
            return ResponseEntity.ok("Sub Service with code " + savedSubService.getId() + " is add successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @GetMapping
    public List<Services> getAllServices() {
        List<Services> servicesList = servicesService.findAll();
        if (!servicesList.isEmpty()) {
            return servicesList;
        } else {
            throw new NullPointerException(BusinessException.No_Service_Was_Found);
        }

    }

    @GetMapping ("/hasSubServices")
    public List<Services> getAllServicesHasSubServices() {
        List<Services> servicesList = servicesService.findAll();
        if (!servicesList.isEmpty()) {
            for(int i=servicesList.size()-1;i>=0;i--){
               if(subServicesService.findByServiceId(servicesList.get(i).getId()).isEmpty()){
                   servicesList.remove(servicesList.get(i));
               };
            }
            return servicesList;
        } else {
            throw new NullPointerException(BusinessException.No_Service_Was_Found);
        }

    }

    @GetMapping("/subServices/{id}")
    public List<SubServices> getAllSubServicesByServiceId(@PathVariable("id") int id) {
        List<SubServices> subServices = subServicesService.findByServiceId(id);
        return subServices;
    }

    @PutMapping("/editService/{id}")
    public ResponseEntity editService(@PathVariable("id") int serviceId, @RequestBody Services service) {
        Services foundedService = servicesService.findById(serviceId);
        if (Objects.nonNull(foundedService)) {
            if (Objects.nonNull(service.getTitle()) && service.getTitle().length() > 0) {
                foundedService.setTitle(service.getTitle());
                foundedService.getCategory().setTitle(service.getTitle());
                servicesService.saveService(foundedService);
                return ResponseEntity.ok("Service with code " + serviceId + " is edited successfully");
            } else {
                return ResponseEntity.badRequest().body(BusinessException.The_Name_Of_Service_Must_Be_Meaningful);
            }
        } else {
            return ResponseEntity.badRequest().body(BusinessException.This_Service_Is_Not_Already_Exist);
        }
    }

    @PutMapping("/editSubService/{id}")
    @ResponseBody
    public ResponseEntity editSubService(@PathVariable("id") int subServiceId, @RequestBody SubServices subService) {
        SubServices foundedSubServices = subServicesService.findById(subServiceId);
        if (Objects.nonNull(foundedSubServices)) {
            if (Objects.nonNull(subService.getTitle()) && subService.getTitle().length() > 0) {
                foundedSubServices.setTitle(subService.getTitle());
                foundedSubServices.getSubCategory().setTitle(subService.getTitle());
            }
            if (Objects.nonNull(subService.getBasePrice()) && subService.getBasePrice() >= 0) {
                foundedSubServices.setBasePrice(subService.getBasePrice());
            }
            if (Objects.nonNull(subService.getDescription()) && subService.getDescription().length() > 0) {
                foundedSubServices.setDescription(subService.getDescription());
            }
            subServicesService.saveSubService(foundedSubServices);
            return ResponseEntity.ok("Sub Service with code " + subServiceId + " is edited successfully");
        }
        return ResponseEntity.badRequest().body(BusinessException.No_SubService_was_found_With_This_Id);
    }

    @DeleteMapping("/deleteService/{id}")
    @ResponseBody
    public ResponseEntity deleteService(@PathVariable("id") int serviceId) {
        try{
            servicesService.deleteService(serviceId);
            return ResponseEntity.ok("Service with code " + serviceId + " is deleted successfully");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/deleteSubService/{id}")
    @ResponseBody
    public ResponseEntity deleteSubService(@PathVariable("id") int subServiceId) {
        try{
            subServicesService.deleteSubService(subServiceId);
            return ResponseEntity.ok("Sub Service with code " + subServiceId + " is deleted successfully");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/subServices/showExpert/{id}")
    @ResponseBody
    public List<Expert> findAllExpertsHaveSpecifiedSubService(@PathVariable("id") int subServiceId) {
        List<Expert> expertList = expertService.findAllExpertsHaveSpecifiedSubService(subServiceId);
        return expertList;
    }

}
