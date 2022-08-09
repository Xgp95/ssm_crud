import org.junit.jupiter.api.Test;

/**
 * @author: Xugp
 * @date: 2022/8/9 12:16
 * @description:
 */
public class StringTest {
    String str = new String("good");
    User user = new User("zhansan", 18);
    private void change(String str, User user) {
        System.out.println(str + "<===");
        str = "moring";
        System.out.println(str + "<===");
        user.setName("lisi");
        user.setAge(20);
    }
    @Test
    public void valueTest() {
        change(str, user);
        System.out.println(str);
        System.out.println(user);
    }
}
