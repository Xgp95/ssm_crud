package crud.service;


import crud.bean.Emp;
import crud.bean.EmpExample;
import crud.dao.EmpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

/**
 * @author: Xugp
 * @date: 2022/4/21 14:49
 * @description:
 */
@Service
public class EmpService {
    @Autowired
    private EmpMapper empMapper;

    public List<Emp> getAllEmp() {
        List<Emp> emps = empMapper.selectByExampleWithDept(null);
        return emps;
    }

    public Integer addEmp(Emp emp) {
        return empMapper.insertSelective(emp);
    }

    public boolean checkEmpNameExist(String empName) {
        EmpExample empExa = new EmpExample();
        EmpExample.Criteria criteria = empExa.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long l = empMapper.countByExample(empExa);
        return l == 0;
    }

    public void updateEmp(Emp emp) {
        int updateByPrimaryKeyResult = empMapper.updateByPrimaryKeySelective(emp);
    }

    public Emp getEmp(Integer empId) {
        Emp emp = empMapper.selectByPrimaryKey(empId);
        return emp;
    }

    public Integer deleteEmp(Integer empId) {
        int i = empMapper.deleteByPrimaryKey(empId);
        return i;
    }

    public Integer deleteEmpByIds(List<Integer> list) {
        EmpExample empExa = new EmpExample();
        empExa.createCriteria().andEmpIdIn(list);
        int num = empMapper.deleteByExample(empExa);
        return num;
    }
}
