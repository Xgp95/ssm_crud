package crud.controller;

import crud.bean.Dept;
import crud.bean.Msg;
import crud.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author: Xugp
 * @date: 2022/4/26 16:34
 * @description:
 */
@Controller
public class DeptController {
    @Autowired
    private DeptService deptService;

    @RequestMapping("/getAllDept")
    @ResponseBody
    public Msg getAllDept() {
        List<Dept> depts = deptService.getAllDept();
        Msg msg = Msg.success().add("depts", depts);
        return msg;
    }
}
