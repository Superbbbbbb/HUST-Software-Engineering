package email;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.PasswordAuthentication;

public class mail {

    public static void send_mail(String mail, String password) throws Exception {

        String host = "smtp.163.com";   //发件人使用发邮件的电子信箱服务器
        String from = "r1245110373@163.com";    //发邮件的出发地（发件人的信箱）

        // Get system properties
        Properties props = System.getProperties();

        props.put("mail.transport.protocol", "smtp");
        // Setup mail server
        props.put("mail.smtp.host", host);

        props.put("mail.smtp.port", "465");

        // Get session
        props.put("mail.smtp.auth", "true"); //这样才能通过验证
        props.put("mail.smtp.ssl.enable", "true");

        MyAuthenticator myauth = new MyAuthenticator(from, "SVVVHAQKQITGZCCX");
        Session session = Session.getDefaultInstance(props, myauth);

        // Define message
        MimeMessage message = new MimeMessage(session);

        // Set the from address
        message.setFrom(new InternetAddress(from));

        // Set the to address
        message.addRecipient(Message.RecipientType.TO,
                new InternetAddress(mail));

        // Set the subject
        message.setSubject("your password", "utf-8");

        // Set the content
        message.setText(password,"utf-8");

        message.saveChanges();

        Transport.send(message);

    }
}

class MyAuthenticator extends javax.mail.Authenticator {

    private String strUser;
    private String strPwd;

    public MyAuthenticator(String user, String password) {
        this.strUser = user;
        this.strPwd = password;
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(strUser, strPwd);
    }

}
