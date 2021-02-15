package ir.maktab.homeserviceprovider.controller;

import ir.maktab.homeserviceprovider.repository.entity.Expert;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping({"/admin"})
public class AdminController {

    @GetMapping
    public String getAdminPage(Model model) {
        Expert expert = new Expert();
        model.addAttribute(expert);
        return "admin";
    }

//    @GetMapping("/adminProfile")
//    public String getAdminProfilePage(Model model) {
//        Expert expert = new Expert();
//        model.addAttribute(expert);
//        return "adminProfile";
//    }

    @GetMapping("/confirmNewExpert")
    public String getConfirmNewExpertPage() {
        return "confirmNewExpert";
    }

    @GetMapping("/manageService")
    public String getManageServicePage() {
        return "manageService";
    }

    @GetMapping("/expertReport")
    public String getExpertReportPage() {
        return "expertReport";
    }

    @GetMapping("/userReport")
    public String getUserReportPage() {
        return "userReport";
    }
}
