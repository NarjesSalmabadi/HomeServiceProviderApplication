package ir.maktab.homeserviceprovider.controller;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.User;
import ir.maktab.homeserviceprovider.serviceclasses.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
public class RestCustomerController {

    @Autowired
    UserService userService;

    @GetMapping("/customerProfile/getCustomer")
    public User getCustomerForProfilePage(@RequestParam(value = "customerEmail") String email) {
        Optional<User> customer = userService.findUserByEmail(email);
        if(customer.isPresent()){
            return customer.get();
        }else {
            throw new NullPointerException(BusinessException.No_User_Founded_By_This_Email);
        }
    }
}
