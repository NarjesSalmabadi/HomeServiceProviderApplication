package ir.maktab.homeserviceprovider.controller;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import ir.maktab.homeserviceprovider.repository.enums.ConfirmationState;
import ir.maktab.homeserviceprovider.serviceclasses.ExpertService;
import ir.maktab.homeserviceprovider.serviceclasses.FileUploadUtil;
import ir.maktab.homeserviceprovider.serviceclasses.SubServicesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

@Controller
//@RequestMapping({"/expert"})
public class ExpertController {

    @Autowired
    ExpertService expertService;
    @Autowired
    FileUploadUtil fileUploadUtil;
    @Autowired
    SubServicesService subServicesService;


    @GetMapping("/expertProfile")
    public String getExpertProfilePage(Model model) {
        return "expertProfile";
    }

}
