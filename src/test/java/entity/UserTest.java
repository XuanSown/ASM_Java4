package entity;

import org.junit.jupiter.api.Test;

import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class UserTest {
    @Test
    public void testUserGetterSetter() {
        User user = new User();
        user.setId("sowntest");
        user.setFullname("Tran Xuan Sown");
        user.setEmail("a@gmail.com");
        user.setAdmin(true);

        assertEquals("sowntest", user.getId());
        assertEquals("Tran Xuan Sown", user.getFullname());
        assertTrue(user.getAdmin());
    }
}
