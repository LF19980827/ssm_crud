package hanhan.test_crud;

import bean.Employee;
import hanhan.dao.DeptMapper;
import hanhan.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author LFuser
 * @create 2019-08-06-9:42
 * 使用Spring的测试模块
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application.xml"})
public class test_mapper {

    @Autowired
    DeptMapper deptMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void CRUD() {
        System.out.println(deptMapper);

        //1.插入部门

        System.out.println(deptMapper.selectByPrimaryKey(1));

//        deptMapper.insertSelective(new bean.Dept(null,"运营"));
//        deptMapper.insertSelective(new bean.Dept(null,"测试"));

//          employeeMapper.insertSelective(new Employee(null,"litao","男","litao@qq.com",1));

//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//
//        for (int i = 0; i < 1000; i++) {
//            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
//            mapper.insertSelective(new Employee(null, uid, "男", uid+"@qq.com", 1));
//
//        }
//
    }
}
