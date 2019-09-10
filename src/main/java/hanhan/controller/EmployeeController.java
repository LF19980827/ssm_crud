package hanhan.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import hanhan.bean.Message;
import hanhan.service.EmployeeService;
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
 * @author LFuser
 * @create 2019-08-06-11:30
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    /**
     * 删除员工
     *
     * @return
     */
    @RequestMapping(value = "/employee/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Message deleteEmployee(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            //批量删除
            String[] strings = ids.split("-");
            List<Integer> del_ids = new ArrayList<Integer>();
            //组装id的集合
            for (String s:strings){
                del_ids.add(Integer.parseInt(s));
            }
            employeeService.deleteBatchEmployee(del_ids);
        }else {
            //单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmployee(id);
        }
        return Message.success();
    }


    /**
     * 员工更新方法
     * @param employee
     * @return
     */
    @RequestMapping(value = "/employee/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Message updateEmployee(bean.Employee employee){
        employeeService.updateEmployee(employee);
        return Message.success();
    }

    /**
     * 查询员工
     * @param id
     * @return
     */
    @RequestMapping(value = "/employee/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Message getEmployee(@PathVariable("id")Integer id){
        bean.Employee employee = employeeService.getEmployee(id);
        return Message.success().add("employee",employee);
    }

    /**
     * 添加员工信息
     * @return
     */
    @RequestMapping(value = "/employee",method = RequestMethod.POST)
    @ResponseBody
    public Message insertEmployee(@Valid bean.Employee employee, BindingResult result){
        if (result.hasErrors()){
           //校验失败,在模态框中显示校验失败的信息
            Map<String ,Object> map = new HashMap<String, Object>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError:errors){
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Message.fail().add("errors",map);
        }else{
            employeeService.insertEmployee(employee);
            return Message.success();
        }

    }

    /**
     * 提交所有员工信息
     * @param pn
     * @return
     */
    @RequestMapping("/employees")
    @ResponseBody
    public Message getemployees(@RequestParam(value = "pn",defaultValue ="1") Integer pn){
        //引入PageHelper分页插件
        PageHelper.startPage(pn,5);
        //startPage后面的这个查询就是分页查询
        List<bean.Employee> employees = employeeService.getAll();
        //使用PageInfo包装查询结果
        PageInfo page = new PageInfo(employees);

        return Message.success().add("pageInfo",page);
    }

    /**
     * 检查用户名是否可用
     * @param name
     * @return
     */
    @RequestMapping("/checkName")
    @ResponseBody
    public Message checkName(@RequestParam("empName") String name){
        boolean b = employeeService.checkName(name);
        if (b){
            return Message.success();
        }else {
            return Message.fail();
        }
    }

//    @RequestMapping("/employees")
//    public String getemployees(@RequestParam(value = "pn",defaultValue ="1") Integer pn, Model model){
//        //引入PageHelper分页插件
//        PageHelper.startPage(pn,5);
//        //startPage后面的这个查询就是分页查询
//        List<bean.Employee> employees = employeeService.getAll();
//        //使用PageInfo包装查询结果
//        PageInfo page = new PageInfo(employees);
//        model.addAttribute("pageInfo",page);
//
//        return "list";
//    }
}
