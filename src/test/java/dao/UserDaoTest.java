package dao;

import dao.impl.UserDAOImpl;
import entity.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;

import static org.testng.Assert.assertNotNull;
import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.fail;

public class UserDaoTest {
    private UserDAO userDAO;
    private final String testUserId = "testUser1903"; //id ảo dùng để test

    @BeforeEach
    public void setup() {
        userDAO = new UserDAOImpl();
    }

    @AfterEach
    public void tearDown() {
        try {
            if (userDAO.findById(testUserId) != null) {
                userDAO.delete(testUserId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testCreateAndFindUser() {
        User user = new User(
                testUserId,
                "123",
                "sowntest@gmail.com",
                "XuanSown",
                false, //admin
                new ArrayList<>(), //favories
                new ArrayList<>() //shares
        );
        try {
            userDAO.create(user);
        } catch (Exception e) {
            fail("lỗi gọi hàm create: " + e.getMessage());
        }

        //assert
        //findById xem dl vào db chưa
        User assertUser = userDAO.findById(testUserId);

        //assertions
        assertNotNull(assertUser, "User sau khi tạo phải tìm thấy được khong null");
        assertEquals("Email lưu trong db phải khớp", "sowntest@gmail.com", assertUser.getEmail());
    }
}