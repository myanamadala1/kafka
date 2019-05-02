package com.mbusa.eai.sample.springboot1;

import org.springframework.boot.autoconfigure.security.oauth2.client.EnableOAuth2Sso;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
public class MainController {

    @GetMapping("/")
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