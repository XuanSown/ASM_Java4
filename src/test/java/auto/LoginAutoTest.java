package auto;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

public class LoginAutoTest {
    WebDriver driver;
    @BeforeClass
    public void setup(){
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();
    }

    @Test
    public void testLoginSuccess() throws InterruptedException {
        driver.get("http://localhost:8080/ASM_Java4/login");
        WebElement txtId = driver.findElement(By.name("id"));
        WebElement txtPass = driver.findElement(By.name("password"));
        WebElement btnLogin = driver.findElement(By.cssSelector("button[type='submit']"));
        txtId.sendKeys("u01");
        txtPass.sendKeys("113");
        btnLogin.click();
        Thread.sleep(2000);

        String currentUrl = driver.getCurrentUrl();
        Assert.assertTrue(currentUrl.contains("home"), "Login failed!");
    }

    @AfterClass
    public void teardown(){
        if(driver != null){
            driver.quit();
        }
    }
}
