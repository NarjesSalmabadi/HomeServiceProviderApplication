package ir.maktab.homeserviceprovider.controller;

import ir.maktab.homeserviceprovider.repository.entity.Reservation;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import ir.maktab.homeserviceprovider.repository.entity.User;
import ir.maktab.homeserviceprovider.serviceclasses.ReservationService;
import ir.maktab.homeserviceprovider.serviceclasses.SubServicesService;
import ir.maktab.homeserviceprovider.serviceclasses.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;
import java.util.Optional;

@Controller
public class CustomerController {

    @Autowired
    SubServicesService subServicesService;
    @Autowired
    ReservationService reservationService;
    @Autowired
    UserService userService;

    @GetMapping("/customerProfile")
    public String getCustomerProfilePage(){
        return "customerProfile";
    }

    @GetMapping("/showSubService/{id}")
    public String getSubServicePage(@PathVariable("id") int id, Model model) {
        SubServices subService = subServicesService.findById(id);
        model.addAttribute("subService", subService);
        Reservation reservation = new Reservation();
        model.addAttribute("reservation", reservation);
        return "subService";
    }

    @PostMapping("/createReservation")
    public String createReservation(@ModelAttribute("reservation") Reservation reservation,
                                    @RequestParam("userDueDate") String userDueDate, Model model,
                                    RedirectAttributes redirectAttributes) throws ParseException {
        Optional<User> foundedUser = userService.findUserByEmail(reservation.getCustomer().getEmail());
        SubServices foundedSubService = subServicesService.findById(reservation.getSubServices().getId());

        if (foundedUser.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "مشتری این سفارش تعیین نشده است.");
            return "redirect:/showSubService/"+reservation.getSubServices().getId();
        }
        if (Objects.isNull(reservation.getSubServices())) {
            redirectAttributes.addFlashAttribute("message", "زیرخدمت این سفارش تعیین نشده است.");
            return "redirect:/showSubService/"+reservation.getSubServices().getId();
        }
        if (reservation.getAddress().equals("")) {
            redirectAttributes.addFlashAttribute("message", "آدرس نمي تواند خالی باشد.");
            return "redirect:/showSubService/"+reservation.getSubServices().getId();
        }
        if (reservation.getDescription().equals("")) {
            redirectAttributes.addFlashAttribute("message", "توضيحات نمي تواند خالی باشد.");
            return "redirect:/showSubService/"+reservation.getSubServices().getId();
        }
        if (reservation.getCustomerPrice() < 0) {
            redirectAttributes.addFlashAttribute("message", "قيمت پيشنهادی نمی تواند منفی باشد.");
            return "redirect:/showSubService/"+reservation.getSubServices().getId();
        }

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        reservation.setDueDate(format.parse(userDueDate));
        Date date = new Date();
        if (reservation.getDueDate().compareTo(date) < 0) {
            redirectAttributes.addFlashAttribute("message", "تاریخ انتخابی قبل از امروز می باشد.");
            return "redirect:/showSubService/"+reservation.getSubServices().getId();
        }

        reservation.setSubServices(foundedSubService);
        reservation.setCustomer(foundedUser.get());
        Reservation registeredReservation = reservationService.createReservation(reservation);
        redirectAttributes.addFlashAttribute("message", "سفارش شما با موفقیت ثبت شد. منتظر پیشنهاد متخصصان باشید. شناسه سفارش: "+registeredReservation.getId());
        return "redirect:/showSubService/"+reservation.getSubServices().getId();
    }
}
