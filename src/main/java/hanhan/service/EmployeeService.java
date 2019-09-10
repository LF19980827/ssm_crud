package hanhan.service;

import bean.EmployeeExample;
import hanhan.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author LFuser
 * @create 2019-08-06-11:37
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 批量删除员工
     * @param ids
     */
    public void deleteBatchEmployee(List<Integer> ids){
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
    }

    /**
     * 单个删除员工
     * @param id
     */
    public void deleteEmployee(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 员工更新
     * @param employee
     */
    public void updateEmployee(bean.Employee employee){
        System.out.println(employee);
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 根据员工ID查询员工
     * @param id
     * @return
     */
    public bean.Employee getEmployee(Integer id){
        bean.Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 新增员工
     * @param employee
     */
    public void insertEmployee(bean.Employee employee){
        employeeMapper.insertSelective(employee);
    }

    /**
     * 查询所有员工
     * @return
     */
    public List<bean.Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 检验用户名是否可用
     * @param name
     * @return ture:姓名可用 false:姓名不可用
     */
    public boolean checkName(String name){
        bean.EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(name);
        long count = employeeMapper.countByExample(employeeExample);
        return count==0;
    }
}
