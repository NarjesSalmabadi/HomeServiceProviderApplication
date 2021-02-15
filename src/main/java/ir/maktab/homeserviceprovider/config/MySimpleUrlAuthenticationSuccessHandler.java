package ir.maktab.homeserviceprovider.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

@Component
public class MySimpleUrlAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest arg0, HttpServletResponse arg1,
                                        Authentication authentication) throws IOException, ServletException {

        boolean hasExpertRole = false;
        boolean hasAdminRole = false;
        boolean hasCustomerRole=false;
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (GrantedAuthority grantedAuthority : authorities) {
            if (grantedAuthority.getAuthority().equals("EXPERT")) {
                hasExpertRole = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ADMIN")) {
                hasAdminRole = true;
                break;
            }  else if (grantedAuthority.getAuthority().equals("CUSTOMER")) {
            hasCustomerRole = true;
            break;
        }
        }

        if (hasExpertRole) {
            redirectStrategy.sendRedirect(arg0, arg1, "/expertProfile");
        } else if (hasAdminRole) {
            redirectStrategy.sendRedirect(arg0, arg1, "/admin");
        }else if(hasCustomerRole){
            redirectStrategy.sendRedirect(arg0, arg1, "/customerProfile");
        } else {
            throw new IllegalStateException();
        }
    }

}
