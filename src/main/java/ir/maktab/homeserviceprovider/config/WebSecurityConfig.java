package ir.maktab.homeserviceprovider.config;
import ir.maktab.homeserviceprovider.serviceclasses.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private MySimpleUrlAuthenticationSuccessHandler successHandler;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .authorizeRequests()
                .antMatchers("/resources/theme/css/**", "/resources/theme/js/**", "/resources/theme/images/**","/user/**","/","/home","/home/subService/**","/user/home/**","/user/register",
                        "/user/welcome/**").permitAll()
                .antMatchers("/expertProfile").hasAnyAuthority("EXPERT")
                .antMatchers("/admin/**","/admin","/customerProfile/**").hasAnyAuthority("ADMIN")
                .antMatchers("/customerProfile/**").hasAnyAuthority("CUSTOMER")
                //.antMatchers(HttpMethod.POST,"/user/register","/user/register/**").permitAll()
                .antMatchers(HttpMethod.POST,"/user/checkPassword","/user/checkPassword/**").permitAll()
                .antMatchers(HttpMethod.POST,"/user/checkEmail","/user/checkEmail/**").permitAll()
                .antMatchers(HttpMethod.GET,"/services","/services/subServices/**").permitAll()
                .antMatchers(HttpMethod.POST,"/services/**","/services/subServices/**").hasAnyAuthority("ADMIN")
//                .antMatchers("/services/subServices/**","/services/**","/expertProfile/**").hasAnyAuthority("ADMIN")
//                .antMatchers(HttpMethod.GET,"/ServiceManagement/allSubServicesByID","/ServiceManagement/allSubServicesByID/**").permitAll()
//                .antMatchers(HttpMethod.POST,"/user/checkFileSize","/user/checkFileSize/**").permitAll()
                .anyRequest().authenticated()

                .and()
                .formLogin()
                .loginPage("/home/loginPage")
                .loginProcessingUrl("/doLogin")
                .usernameParameter("email")
                .passwordParameter("password")
                .successHandler(successHandler)
//                .defaultSuccessUrl("/home").permitAll()
//                .successForwardUrl()
                .failureUrl("/home/loginError")
                .permitAll()
                .and()
                .logout()
                .permitAll()
                .and().httpBasic();

    }
    @Bean
    public PasswordEncoder passwordEncoder(){

        return new BCryptPasswordEncoder();
    }
    @Autowired
    private UserService userService;
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
    }

//    @Bean
//    public MultipartResolver multipartResolver() {
//        return new StandardServletMultipartResolver();
//    }



    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/jsp/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }
}
