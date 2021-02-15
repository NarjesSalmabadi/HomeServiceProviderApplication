package ir.maktab.homeserviceprovider;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.multipart.support.MultipartFilter;

@SpringBootApplication
public class HomeserviceproviderApplication {

    public static void main(String[] args) {
        SpringApplication.run(HomeserviceproviderApplication.class, args);
    }

}
