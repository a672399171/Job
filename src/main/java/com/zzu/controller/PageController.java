package com.zzu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by Administrator on 2016/7/27.
 */
@Controller
@RequestMapping
public class PageController {

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String index(Model model) {
        return "index";
    }
}
