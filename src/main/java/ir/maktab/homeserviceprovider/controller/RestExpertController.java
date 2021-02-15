package ir.maktab.homeserviceprovider.controller;

import ir.maktab.homeserviceprovider.exceptions.BusinessException;
import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.Reservation;
import ir.maktab.homeserviceprovider.repository.entity.SubServices;
import ir.maktab.homeserviceprovider.repository.enums.ConfirmationState;
import ir.maktab.homeserviceprovider.repository.enums.ReservationState;
import ir.maktab.homeserviceprovider.serviceclasses.ExpertService;
import ir.maktab.homeserviceprovider.serviceclasses.FileUploadUtil;
import ir.maktab.homeserviceprovider.serviceclasses.ReservationService;
import ir.maktab.homeserviceprovider.serviceclasses.SubServicesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.websocket.server.PathParam;
import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@RestController
//@RequestMapping({"/expert"})
public class RestExpertController {

    @Autowired
    ExpertService expertService;
    @Autowired
    FileUploadUtil fileUploadUtil;
    @Autowired
    SubServicesService subServicesService;
    @Autowired
    ReservationService reservationService;

    @GetMapping("/expert")
    @ResponseBody
    public List<Expert> getAllExpert() {
        List<Expert> expertList = expertService.getAllExperts();
        expertList.stream().filter(e -> Objects.isNull(e.getPhoto())).forEach(e -> e.setPhoto("Not Found"));
        return expertList;
    }

    @GetMapping("/expert/confirmedAndEnabled")
    @ResponseBody
    public List<Expert> getAllExpertAreConfirmedAndEnabled() {
        List<Expert> expertList = expertService.getAllExpertAreConfirmedAndEnabled();
        expertList.stream().filter(e -> Objects.isNull(e.getPhoto())).forEach(e -> e.setPhoto("Not Found"));
        return expertList;
    }

    @GetMapping("/expert/{id}")
    @ResponseBody
    public Expert getExpertById(@PathVariable("id") int id) {
        Expert expert = expertService.findExpertById(id);
        if (Objects.nonNull(expert)) {
            return expert;
        } else {
            throw new NullPointerException(BusinessException.No_Expert_was_found_With_This_Id);
        }
    }

    @PostMapping("/expert")
    @ResponseBody
    public ResponseEntity createNewExpert(@RequestBody Expert expert) throws IOException {
        if (Objects.nonNull(expert.getFirstName()) && expert.getFirstName().length() > 0 && expert.getFirstName().length() < 15) {
            if (Objects.nonNull(expert.getLastName()) && expert.getLastName().length() > 0 && expert.getLastName().length() < 25) {
                if (Objects.nonNull(expert.getEmail()) && expert.getEmail().length() > 0) {
                    if (Objects.nonNull(expert.getPassword()) && expert.getPassword().length() > 0) {
                        if (expertService.checkUserEmail(expert).isEmpty()) {
                            if (expertService.checkPassword(expert)) {
                                Expert savedExpert = expertService.registerExpert(expert);
                                return ResponseEntity.ok("Expert with personnel code " + savedExpert.getId() + " is add successfully");
                            } else {
                                return ResponseEntity.badRequest().body("Password must be at least 8 digits and contain letters and numbers!");
                            }
                        } else {
                            return ResponseEntity.badRequest().body("Email is already exist!");
                        }
                    } else {
                        return ResponseEntity.badRequest().body("Expert's password must be meaningful!");
                    }
                } else {
                    return ResponseEntity.badRequest().body("Expert's email must be meaningful!");
                }
            } else {
                return ResponseEntity.badRequest().body("Expert's family must be meaningful!");
            }
        } else {
            return ResponseEntity.badRequest().body("Expert's name must be meaningful!");
        }
    }

    @PutMapping(path = "/expert/{id}")
    @ResponseBody
    public ResponseEntity confirmExpert(@PathVariable("id") int id) {
        Expert expert = expertService.findExpertById(id);
        if (Objects.nonNull(expert)) {
            if (expert.getConfirmationState().equals(ConfirmationState.WAITING_TO_BE_CONFIRMED)) {
                expert.setConfirmationState(ConfirmationState.CONFIRMED);
                expertService.saveExpert(expert);
                return ResponseEntity.ok("Expert with personnel code " + expert.getId() + " is confirmed successfully");
            } else {
                return ResponseEntity.badRequest().body(BusinessException.This_Expert_was_Confirmed_Already);
            }
        } else
            return ResponseEntity.badRequest().body(BusinessException.No_Expert_was_found_With_This_Id);
    }

    @DeleteMapping(path = "/expert/{id}")
    @ResponseBody
    public ResponseEntity deleteExpert(@PathVariable("id") int id) {
        try {
            expertService.deleteExpertById(id);
            return ResponseEntity.ok("Expert with personnel code " + id + " is deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(BusinessException.No_Expert_was_found_With_This_Id);
        }
    }

    @PostMapping(path = "/expert/report")
    @ResponseBody
    public List<Expert> searchBySpecifiedField(@RequestBody Expert expert) {
        System.out.println(expert);
        return expertService.findBySpecifiedField(expert);
    }

    @GetMapping("/expertProfile1")
    public String getExpertProfilePage(Model model) {
//        Expert expert = expertService.findExpertById(4);
//        model.addAttribute("expert", expert);
        return "expertProfile1";
    }

    @GetMapping("/expertProfile1/getExpert")
    public Expert getExpertForProfilePage(@RequestParam(value = "expertEmail") String email) {
        Expert expert = expertService.findByEmail(email);
//        Expert expert = expertService.findExpertById(4);
//        model.addAttribute("expert", expert);
        return expert;
    }

    @GetMapping("/expertProfile1/showService/{id}")
    @ResponseBody
    public List<SubServices> showSubServicesOfExpert(@PathVariable("id") int expertId) {
        Expert expert = expertService.findExpertById(expertId);
        return expert.getSpecialties();
    }

    @PostMapping("/expertProfile1/selectService/{email}")
    @ResponseBody
    public ResponseEntity assignSubServiceToExpert(@PathVariable("email") String email,
                                                   @RequestParam(value = "subServiceId") int subServiceId) {
        Expert expert = expertService.findByEmail(email);
        if (expert.getConfirmationState().equals(ConfirmationState.WAITING_TO_BE_CONFIRMED)) {
            return ResponseEntity.badRequest().body("You are not confirmed!");
        }
        boolean answer = expertService.assignSubServiceToExpert(expert.getId(), subServiceId);
        if (answer) {
            return ResponseEntity.ok("New sub service is added successfully.");
        } else {
            return ResponseEntity.badRequest().body("This service choose already!");
        }
    }

    @DeleteMapping("/expertProfile1/deleteService/{id}")
    @ResponseBody
    public ResponseEntity deleteSubServiceFromExpert(@PathVariable("id") int expertId,
                                                     @RequestParam(value = "subServiceId") int subServiceId) {
        boolean answer = expertService.deleteSubServiceFromExpert(expertId, subServiceId);
        if (answer) {
            return ResponseEntity.ok("sub service is removed successfully from expert's specialties.");
        } else {
            return ResponseEntity.badRequest().body("Sub service not found!");
        }
    }

    @PutMapping("/expertProfile1/edit/{id}")
    @ResponseBody
    public ResponseEntity editExpert(@PathVariable("id") int expertId, @RequestBody Expert expert) {
        Expert foundedExpert = expertService.findExpertById(expertId);
        if (Objects.nonNull(foundedExpert)) {
            if (Objects.nonNull(expert.getFirstName()) && expert.getFirstName().length() > 0) {
                foundedExpert.setFirstName(expert.getFirstName());
            }
            if (Objects.nonNull(expert.getLastName()) && expert.getLastName().length() > 0) {
                foundedExpert.setLastName(expert.getLastName());
            }
            if (expert.getScore() >= 0) {
                foundedExpert.setScore(expert.getScore());
            }
            if (Objects.nonNull(expert.getConfirmationState())) {
                foundedExpert.setConfirmationState(expert.getConfirmationState());
            }
            expertService.saveExpert(foundedExpert);
            return ResponseEntity.ok("");
        } else {
            return ResponseEntity.badRequest().body(BusinessException.No_Expert_was_found_With_This_Id);
        }
    }

    @GetMapping("/expertProfile1/reservation/{subServiceId}")
    @ResponseBody
    public List<Reservation> getBySubServiceAndWaitingForExpertSuggestion(@PathVariable("subServiceId") Integer subServiceId){
        return reservationService.getBySubServiceAndWaitingForExpertSuggestion(subServiceId);
    }

    @PostMapping("/expertProfile1/suggestion/{expertEmail}")
    @ResponseBody
    public ResponseEntity registerNewSuggestion(@PathVariable("expertEmail") String emil, @RequestBody Reservation reservation){

        if(Objects.isNull(reservation.getAddress()) || reservation.getAddress().length()==0){

        }
        if(Objects.isNull(reservation.getDueDate())){

        }
        if(Objects.isNull(reservation.getDueDate())){

        }
        Reservation reservation1 = reservationService.createReservation(reservation);
        return ResponseEntity.ok("New suggestion with code "+reservation1.getId()+" is created");
    }

    @PutMapping("/expertProfile1/reservation/changeState/{reservationId}")
    @ResponseBody
    public ResponseEntity changeReservationState(@PathVariable("reservationId") Integer reservationId,
                                                    @RequestParam(value = "state") ReservationState reservationState){
        try {
            if(Objects.nonNull(reservationState)){
                reservationService.changeReservationState(reservationState,reservationId);
                return ResponseEntity.ok("");
            } else {
                return ResponseEntity.badRequest().body(BusinessException.Reservation_State_Must_Be_Meaningful);
            }
        }catch (Exception e){
            return ResponseEntity.badRequest().body(BusinessException.No_Reservation_Was_Founded);
        }
    }
    /*@PostMapping
    @ResponseBody
    public ModelAndView createNewExpert(@ModelAttribute("expert") Expert expert, @RequestParam("image") MultipartFile multipartFile) throws IOException {
        String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
        expert.setPhoto(fileName);
        expert.setUserRole(UserRole.EXPERT);
        expert.setConfirmationState(ConfirmationState.WAITING_TO_BE_CONFIRMED);
        Expert savedExpert = expertService.registerExpert(expert);
        String uploadDir = "user-photos/" + savedExpert.getId();
        fileUploadUtil.saveFile(uploadDir, fileName, multipartFile);
        return new ModelAndView("admin", "expert", savedExpert);
    }*/
}
