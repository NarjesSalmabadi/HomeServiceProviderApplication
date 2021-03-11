package ir.maktab.homeserviceprovider.controller;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.ExpertSuggestion;
import ir.maktab.homeserviceprovider.repository.entity.Reservation;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import ir.maktab.homeserviceprovider.repository.enums.ConfirmationState;
import ir.maktab.homeserviceprovider.serviceclasses.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.time.LocalTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Controller
public class ExpertController {

    @Autowired
    ExpertService expertService;
    @Autowired
    FileUploadUtil fileUploadUtil;
    @Autowired
    SubServicesService subServicesService;
    @Autowired
    ReservationService reservationService;
    @Autowired
    ExpertSuggestionService expertSuggestionService;


    @GetMapping("/expertProfile")
    public String getExpertProfilePage(Model model) {
        model.addAttribute("suggestion", new ExpertSuggestion());
        return "expertProfile";
    }

    @PostMapping("/expertProfile/createSuggestion")
    public String createSuggestionForReservation(@ModelAttribute("suggestion") ExpertSuggestion suggestion,
                                                 @RequestParam("expertStartTime") String expertStartTime, Model model,
                                                 RedirectAttributes redirectAttributes) {
        Expert expert = expertService.findExpertById(suggestion.getExpert().getId());
        Optional<Reservation> reservation = reservationService.getById(suggestion.getReservation().getId());
        Optional<ExpertSuggestion> expertSuggestion = expertSuggestionService.findByExpertIdAndReservationId(suggestion.getExpert().getId(),
                suggestion.getReservation().getId());
        if (Objects.isNull(expert)) {
            redirectAttributes.addFlashAttribute("message", "متخصص برای این پیشنهاد تعیین نشده است.");
            return "redirect:/expertProfile";
        }
        if (reservation.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "سفارشی که قصد دارید برای آن پیشنهاد ثبت کنید، درست وارد نشده است.");
            return "redirect:/expertProfile";
        }
        if(expertSuggestion.isPresent()){
            redirectAttributes.addFlashAttribute("message", "شما قبلا برای این سفارش، پیشنهادی ثبت کرده اید.");
            return "redirect:/expertProfile";
        }
        if (suggestion.getDuration() < 30) {
            redirectAttributes.addFlashAttribute("message", "مدت زمان انجام سفارش باید حداقل 30 دقیقه باشد.");
            return "redirect:/expertProfile";
        }
        if (suggestion.getExpertPrice() < reservation.get().getSubServices().getBasePrice()) {
            redirectAttributes.addFlashAttribute("message", "قیمت پیشنهادی نمی تواند از قیمت پایه ی تخصص کمتر باشد.");
            return "redirect:/expertProfile";
        }
        suggestion.setStartTime(LocalTime.parse(expertStartTime));
        if (suggestion.getStartTime().compareTo(LocalTime.now()) < 0) {
            redirectAttributes.addFlashAttribute("message", "ساعت شروع کار نمی تواند قبل از ساعت فعلی باشد.");
            return "redirect:/expertProfile";
        }
        ExpertSuggestion submittedSuggestion = expertSuggestionService.createSuggestion(suggestion);
        redirectAttributes.addFlashAttribute("message", "پیشنهاد شما با موفقیت ثبت شد. لطفا منتظر انتخاب مشتری باشید. شناسه پیشنهاد: " + submittedSuggestion.getId());
        return "redirect:/expertProfile";
    }

    @GetMapping("/expertProfile/newService")
    public String getExpertServicePage(Model model) {
        return "expertNewService";
    }

    @GetMapping("/expertProfile/expertReservation")
    public String getExpertReservationPage(Model model) {
        return "expertReservation";
    }

}
