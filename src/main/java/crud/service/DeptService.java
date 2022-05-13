package crud.service;

import crud.bean.Dept;
import crud.dao.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: Xugp
 * @date: 2022/4/26 16:36
 * @description:
 */
@Service
public class DeptService {
    @Autowired
    private DeptMapper deptMapper;

    public List<Dept> getAllDept() {
        List<Dept> depts = deptMapper.selectByExample(null);
        return depts;
    }
}
