package hanhan.controller;

import hanhan.bean.Message;
import hanhan.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author LFuser
 * @create 2019-08-07-10:12
 */
@Controller
public class DeptController {

    @Autowired
    DeptService deptService;

    @RequestMapping("/depts")
    @ResponseBody
    public Message getDepts(){
        List<bean.Dept> list = deptService.getDepts();
        return Message.success().add("depts",list);
    }
}
