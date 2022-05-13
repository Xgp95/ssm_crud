package crud.bean;

import sun.awt.SunHints;

import java.util.HashMap;
import java.util.Map;

/**
 * @author: Xugp
 * @date: 2022/4/23 15:45
 * @description:
 */
public class Msg {
    private Integer code;
    private String msg;
    private Map<String,Object> extend = new HashMap<>();

    public static Msg success() {
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理成功");
        return msg;
    }
    public static Msg fail() {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理失败");
        return msg;
    }

    public Msg add(String key,Object value) {
        this.getExtend().put(key, value);
        return this;
    }

    public Msg() {
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
