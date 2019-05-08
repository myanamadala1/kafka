package com.mbusa.eai.sample.springboot1;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {


/*	public String Welcome(Model model, HttpServletRequest request) {
				request.setAttribute("mode", "MODE_HOME");
		return "homepage";*/
    @RequestMapping("/")
    public String forward() {
        return "forward:/user";
    }
	}

