package ir.maktab.homeserviceprovider.controller;

import ir.maktab.homeserviceprovider.repository.entity.ConfirmationToken;
import ir.maktab.homeserviceprovider.repository.entity.Expert;
import ir.maktab.homeserviceprovider.repository.entity.User;
import ir.maktab.homeserviceprovider.repository.enums.ConfirmationState;
import ir.maktab.homeserviceprovider.repository.enums.UserRole;
import ir.maktab.homeserviceprovider.serviceclasses.ConfirmationTokenService;
import ir.maktab.homeserviceprovider.serviceclasses.ExpertService;
import ir.maktab.homeserviceprovider.serviceclasses.FileUploadUtil;
import ir.maktab.homeserviceprovider.serviceclasses.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Controller
@RequestMapping({"/user", "/"})
public class UserController {

    private UserService userService;
    private ExpertService expertService;
    private ConfirmationTokenService confirmationTokenService;
    private FileUploadUtil fileUploadUtil;

    @Autowired
    public UserController(UserService userService, ConfirmationTokenService confirmationTokenService,
                          FileUploadUtil fileUploadUtil, ExpertService expertService) {
        this.userService = userService;
        this.expertService = expertService;
        this.confirmationTokenService = confirmationTokenService;
        this.fileUploadUtil = fileUploadUtil;
    }

    @GetMapping
    public String hello() {
        return "home";
    }

    @GetMapping("/home")
    public String getHomePage(){
        return "home";
    }

    @GetMapping("/home/loginPage")
    public String getLoginPage(Model model){
        return "loginPage";
    }

    @GetMapping("/home/loginError")
    public String getLoginErrorPage(Model model){
        model.addAttribute("login_error", "username or password incorrect!");
        return "loginPage";
    }

    @GetMapping("/allUsers")
    @ResponseBody
    public List<User> getUsers() {
        List<User> users = userService.getUsers();
        return users;
    }

    @PreAuthorize("permitAll()")
    @PostMapping("/checkEmail")
    @ResponseBody
    public Boolean checkEmail(@RequestBody User user) {
        if (userService.checkUserEmail(user).isPresent()) {
            return false;
        } else
            return true;
    }

    @PreAuthorize("permitAll()")
    @PostMapping("/checkPassword")
    @ResponseBody
    public Boolean checkPassword(@RequestBody User user) {
        if (userService.checkPassword(user)) {
            return true;
        } else
            return false;
    }

    @PostMapping
    @ResponseBody
    public ResponseEntity saveAdmin(@RequestBody User user) {
        if (!userService.checkUserEmail(user).isPresent()) {
            if (userService.checkPassword(user)) {
                userService.registerUser(user);
                return ResponseEntity.ok("New Admin with " + user.getEmail() + " is added!");
            } else {
                return ResponseEntity.badRequest().body("the pass word is wrong!");
            }
        } else {
            return ResponseEntity.badRequest().body("the email is already exist!!!");
        }
    }

    @GetMapping("/register")
    public String getRegistrationPage(Model model) {
        User user = new User();
        model.addAttribute("user", user);
        List<String> userRoleList = Arrays.asList("-------","CUSTOMER", "EXPERT");
        model.addAttribute("userRoleList", userRoleList);
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user,Model model,
                                     @RequestParam("image") MultipartFile multipartFile,
                                     RedirectAttributes redirectAttributes) throws IOException {

        if(Objects.isNull(user.getFirstName()) || user.getFirstName().length()>15){
            redirectAttributes.addFlashAttribute("firstNameMessage", "Name must be meaningful and upto 15 character!");
            return "redirect:register";
        }
        if(Objects.isNull(user.getLastName()) || user.getLastName().length()>30){
            redirectAttributes.addFlashAttribute("lastNameMessage", "Family must be meaningful and upto 30 character!");
            return "redirect:register";
        }
        if(Objects.isNull(user.getEmail()) || user.getEmail().length()==0){
            redirectAttributes.addFlashAttribute("emailMessage", "Email is null!");
            return "redirect:register";
        }
        if(!checkEmail(user)){
            redirectAttributes.addFlashAttribute("emailMessage", "Email is already exist!");
            return "redirect:register";
        }
        if(!checkPassword(user)){
            redirectAttributes.addFlashAttribute("passwordMessage", "Password must be at least 8 digits and contain letters and numbers!");
            return "redirect:register";
        }
        String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
        if (user.getUserRole().equals(UserRole.EXPERT)) {
            if (multipartFile.isEmpty()) {
                redirectAttributes.addFlashAttribute("imageMessage", "Please select a file to upload");
                return "redirect:register";
            }
            else if(multipartFile.getSize() > 512000){
                redirectAttributes.addFlashAttribute("imageMessage", "Please select a file with size of 500 kB or less");
                return "redirect:register";
            }
            else if(!StringUtils.cleanPath(multipartFile.getOriginalFilename()).endsWith(".jpg")){
                redirectAttributes.addFlashAttribute("imageMessage", "The format is wrong!!");
                return "redirect:register";
            }
            Expert expert = new Expert();
            expert.setFirstName(user.getFirstName());
            expert.setLastName(user.getLastName());
            expert.setEmail(user.getEmail());
            expert.setPassword(user.getPassword());
            expert.setUserRole(UserRole.EXPERT);
            expert.setConfirmationState(ConfirmationState.WAITING_TO_BE_CONFIRMED);
            expert.setPhoto(fileName);
            Expert savedExpert = expertService.registerExpert(expert);
            String uploadDir = "user-photos/" + savedExpert.getId();
            fileUploadUtil.saveFile(uploadDir, fileName, multipartFile);
            ConfirmationToken confirmationToken = new ConfirmationToken(expert);
            confirmationTokenService.saveConfirmationToken(confirmationToken);
            userService.sendConfirmationMail(expert.getEmail(), confirmationToken.getConfirmationToken());
        } else {
            User savedUser = userService.registerUser(user);
            ConfirmationToken confirmationToken = new ConfirmationToken(user);
            confirmationTokenService.saveConfirmationToken(confirmationToken);
            userService.sendConfirmationMail(user.getEmail(), confirmationToken.getConfirmationToken());
        }
        model.addAttribute(user);
        //ModelAndView modelAndView = new ModelAndView("welcome", "user", user);
        return "welcome";
    }

    @GetMapping("/confirm")
    String confirmMail(@RequestParam("token") String confirmationToken) {
        Optional<ConfirmationToken> optionalConfirmationToken =
                confirmationTokenService.findConfirmationTokenByToken(confirmationToken);
        if (optionalConfirmationToken.isPresent()) {
            userService.confirmUser(optionalConfirmationToken.get());
            return "welcome";
        } else
            return "tokenError";
    }

}
