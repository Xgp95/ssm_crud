import com.github.pagehelper.PageInfo;
import crud.bean.Emp;
import crud.dao.DeptMapper;
import crud.dao.EmpMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.UUID;

/**
 * @author: Xugp
 * @date: 2022/4/20 17:50
 * @description:
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext_mybatis.xml", "file:src/main/resources/springmvc_servlet.xml"})
public class MapperTest {
    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private DeptMapper deptMapper;
    @Autowired
    private SqlSession sqlSession;
    @Autowired
    private WebApplicationContext context;

    @Test
    public void queryTest() throws Exception {
        MockMvc mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders
                .get("/getAllEmp_1").param("pn", "37"))
                .andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo<Emp> empPageInfo = (PageInfo<Emp>) request.getAttribute("empPageInfo");

//        String contentAsString = result.getResponse().getContentAsString();
//        System.out.println(contentAsString);
//        Gson gson = new Gson();
//        String s = gson.toJson(contentAsString);
//        System.out.println(s);
        System.out.println("当前页码" + empPageInfo.getPageNum());
        System.out.println("总页码" + empPageInfo.getPages());
        System.out.println("总记录数" + empPageInfo.getTotal());
        System.out.println("连续显示的页码的第一页" + empPageInfo.getNavigateFirstPage());
        System.out.println("连续显示的页码的最后一页" + empPageInfo.getNavigateLastPage());
        System.out.println("需要连续显示的页码" + empPageInfo.getNavigatePages());
        int[] navigatepageNums = empPageInfo.getNavigatepageNums();
        System.out.println(Arrays.toString(navigatepageNums));
        System.out.println();
        System.out.println("$$$$$$$$$$");
        List<Emp> list = empPageInfo.getList();
        System.out.println(list);
        for (Emp emp : list) {
            System.out.println(emp);
            System.out.println(emp.getDept().getDeptName());
            System.out.println("############");
        }
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i));
        }
    }

    @Test
    @Transactional
    @Rollback(value = false)
    public void mapperTest() {
//        Dept dept = new Dept();
//        dept.setDeptId(3);
//        dept.setDeptName("");
//        deptMapper.insertSelective(dept);
//        System.out.println(empMapper);
//        System.out.println("$$$$$$$$$$$$$$$$$$$$$$$");
//        System.out.println(deptMapper);

        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        long start = System.currentTimeMillis();
        for (int i = 0; i <= 1000; i++) {
            String name = UUID.randomUUID().toString().replace("-", "").substring(0, 10);
            int dId = new Random().nextInt(3) + 1;
            int gender = new Random().nextInt(2);
            Emp emp = new Emp(name, "" + gender, name + "@123.com", dId);
            mapper.insertSelective(emp);
//            empMapper.insertSelective(emp);
        }
        long end = System.currentTimeMillis();
        System.out.println(end - start);
    }
}
