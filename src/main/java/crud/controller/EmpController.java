package crud.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Emp;
import crud.bean.Msg;
import crud.service.EmpService;
//import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;


import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: Xugp
 * @date: 2022/4/21 14:48
 * @description:
 */
@Controller
public class EmpController {

    @Autowired
    private EmpService empService;
    private Map<String, Object> map;

    //合并删除单个/多个员工
    @RequestMapping(value = "/emp/{empIds}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmps(@PathVariable String empIds) {

        if (empIds.contains("_")) {
            String[] ids = empIds.split("_");
            List<Integer> list = new ArrayList<>();
            for (String id : ids) {
                int i = Integer.parseInt(id);
                list.add(i);
            }
            Integer delCount = empService.deleteEmpByIds(list);
            Msg msg = Msg.success().add("delCount", delCount);
            return msg;
        } else {
            int empId = Integer.parseInt(empIds);
            Integer delCount = empService.deleteEmp(empId);
            Msg msg = Msg.success().add("delCount", delCount);
            return msg;
        }
    }

    //删除单个员工
//    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.DELETE)
//    @ResponseBody
//    public Msg deleteEmp(@PathVariable Integer empId) {
//        Integer integer = empService.deleteEmp(empId);
//        return Msg.success();
//    }

    //更新emp前回显需要更新的emp信息
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable Integer empId) {
        Emp emp = empService.getEmp(empId);
//        System.out.println(emp);
        return Msg.success().add("emp", emp);
    }

    //更新emp
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(@Valid Emp emp, BindingResult bindingResult) {
//        System.out.println(emp);
        if (bindingResult.hasErrors()) {
            map = new HashMap<>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
//                System.out.println(fieldError);
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("fieldErrors", map);
        } else {
            empService.updateEmp(emp);
            return Msg.success();
        }
    }

    //添加emp前校验名字是否存在
    @RequestMapping(value = "/checkEmpNameExist", method = RequestMethod.GET)
    @ResponseBody
    public Msg checkEmpNameExist(@RequestParam(value = "empName") String empName) {
        boolean result = empService.checkEmpNameExist(empName);
        if (result) {
            return Msg.success();
        } else {
            return Msg.fail().add("ajax_va", "用户已经存在");
        }
    }

    //添加emp
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Emp emp, BindingResult bindingResult) {
        System.out.println(bindingResult + "#####################");
        if (bindingResult.hasErrors()) {
            map = new HashMap<>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
//                System.out.println(fieldError);
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("fieldErrors", map);
        } else {
            Integer addEmpNum = empService.addEmp(emp);
            if (addEmpNum != 0) {
                return Msg.success();
            }
            return Msg.fail();
        }
    }

//    @RequestMapping(value = "/addEmp",method = RequestMethod.POST)
//    @ResponseBody
//    public Msg addEmp(Emp emp) {
//        Integer addEmpNum = empService.addEmp(emp);
//        if (addEmpNum != 0 ) {
//            return Msg.success();
//        }
//        return Msg.fail();
//    }

    //获取emp
    @RequestMapping("/getAllEmp")
    @ResponseBody
    public Msg getAllEmp(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 10);
        List<Emp> allEmp = empService.getAllEmp();
        PageInfo<Emp> empPageInfo = new PageInfo<>(allEmp, 7);
        Msg msg = Msg.success().add("empPageInfo", empPageInfo);
        return msg;
    }

    @RequestMapping("/getAllEmp_1")
    public String getAllEmp_1(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        PageHelper.startPage(pn, 10);
        List<Emp> allEmp = empService.getAllEmp();
        PageInfo empPageInfo = new PageInfo(allEmp, 5);
        model.addAttribute("empPageInfo", empPageInfo);
        return "list";
    }
}
