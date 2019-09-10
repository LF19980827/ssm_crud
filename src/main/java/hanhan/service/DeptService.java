package hanhan.service;

import hanhan.dao.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author LFuser
 * @create 2019-08-07-10:12
 */
@Service
public class DeptService {

    @Autowired
    DeptMapper deptMapper;

    public List<bean.Dept> getDepts(){
        List<bean.Dept> list = deptMapper.selectByExample(null);
        return list;
    }
}
