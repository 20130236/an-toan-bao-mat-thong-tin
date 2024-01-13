package digitalsignature;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;
import java.util.Random;

public class SignatureImageCreator extends HttpServlet {

    public static String createSignature(String signatureText,String username){
        int width = 400;
        int height = 160;

        // Create a BufferedImage with the specified width and height
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        // Get the Graphics2D object from the image
        Graphics2D g2d = image.createGraphics();

        // Set the background color
        Color backgroundColor = Color.getHSBColor(0, 0, 0.9f);
        g2d.setColor(backgroundColor);
        g2d.fillRect(0, 0, width, height);

        // Set the signature text and font
        signatureText = "Dung";

        Font randomFont = getRandomFont();

        // Set the font color
        g2d.setColor(Color.BLACK);

        // Set the font
        g2d.setFont(randomFont);

        // Calculate the position to center the text
        int stringWidth = g2d.getFontMetrics().stringWidth(signatureText);
        int x = (width - stringWidth) / 2;
        int y = height / 2;

        // Draw the signature text on the image
        g2d.drawString(signatureText, x, y);
        // Dispose the Graphics2D object
        g2d.dispose();


        // Save the image to a file
        File outputFile = new File("../webapp/signature/" + username +".png");
        try{
                outputFile.createNewFile();
            } catch (Exception e){
                e.printStackTrace();
            }

        try {
            ImageIO.write(image, "png", outputFile);
            System.out.println("Image created successfully.");
        } catch (IOException e) {
            System.out.println("Error creating image: " + e.getMessage());
        }
        return outputFile.getAbsolutePath();
    }

    private static Font getRandomFont()  {
        String[] fontNames = {"Arial", "Helvetica", "Times New Roman", "Verdana", "Courier New"};
        Random random = new Random();
        int randomIndex = random.nextInt(fontNames.length);
        String randomFontName = fontNames[randomIndex];

        try {
            File file = new File("../webapp/fonts/" + randomFontName + ".ttf");
            System.out.println(file.getAbsolutePath());
            Font font = Font.createFont(Font.TRUETYPE_FONT, file);
            return font.deriveFont(Font.PLAIN, 50);
        } catch (FontFormatException | IOException e) {
            System.out.println("Error loading font: " + e.getMessage());
        }
        return new Font("Arial", Font.PLAIN, 50);
    }
}
