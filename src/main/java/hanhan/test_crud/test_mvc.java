package hanhan.test_crud;

import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author LFuser
 * @create 2019-08-06-12:03
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:application.xml","classpath:springmvc.xml"})
public class test_mvc {
    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
       mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public  void testPage() throws Exception {
        //模拟请求拿到返回值
       MvcResult result= mockMvc.perform(MockMvcRequestBuilders.get("/employees").param("pn","1")).andReturn();

        //请求成功以后，请求域种会有pageInfo，我们可以去pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo p = (PageInfo)request.getAttribute("pageInfo");

        System.out.println(p.getTotal());


    }
}
