package com.mbusa.eai.sample.springboot1;

import java.security.Principal;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {

   @GetMapping("/login")
    String home(Principal user) {
        StringBuilder sb = new StringBuilder();
        sb.append("<html><body>");
        sb.append("Hello " + user.getName());
        sb.append("<br />");
        sb.append("<a href=\"/logout\">Logout</a>");
        sb.append("</body></html>");
        return sb.toString();
    }

    @GetMapping("/unprotected")
    String unprotected() {
        return "This page is not protected";
    }
}