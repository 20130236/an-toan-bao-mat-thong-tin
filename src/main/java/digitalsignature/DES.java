package digitalsignature;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class DES {
    private final String DES = "DES";
    private SecretKey key;

    public SecretKey createKey() throws NoSuchAlgorithmException {
        KeyGenerator keyGenerator = KeyGenerator.getInstance("DES");
        keyGenerator.init(56);
        key = keyGenerator.generateKey();
        return key;
    }

    public String encrypt(String text) throws Exception {
        if(key == null) {
            return null;
        }
        Cipher cipher = Cipher.getInstance(DES);

        try {
            cipher.init(Cipher.ENCRYPT_MODE,key);
        }catch(Exception e) {
           e.printStackTrace();
        }

        byte [] plainText = text.getBytes("UTF-8");
        return Base64.getEncoder().encodeToString(cipher.doFinal(plainText));
    }

    public void encryptFile(String src,String des) throws Exception {
        if(key == null) {
            return;
        }
        File file = new File(src);
        if(file.isFile()) {
            Cipher cipher = Cipher.getInstance(DES);

            try {
                cipher.init(Cipher.ENCRYPT_MODE,key);
            }catch(Exception e) {
                e.printStackTrace();
            }

            FileInputStream fis = new FileInputStream(file);
            FileOutputStream fos = new FileOutputStream(des);
            byte [] input = new byte[64];
            int byteRead;

            while((byteRead = fis.read(input)) != -1) {
                byte [] output = cipher.update(input,0,byteRead);
                if(output != null)
                    fos.write(output);
            }

            byte [] output = cipher.doFinal();
            if(output != null)
                fos.write(output);

            fis.close();
            fos.flush();
            fos.close();
        } else {
            System.out.println("wrong path");
        }
    }

    public void decryptFile(String src,String des) throws Exception {
        if(key == null) {
            return;
        }
        File file = new File(src);
        if(file.isFile()) {
            Cipher cipher = Cipher.getInstance("DES");

            try {
                cipher.init(Cipher.DECRYPT_MODE,key);
            }catch(Exception e) {
                e.printStackTrace();
            }

            FileInputStream fis = new FileInputStream(file);
            FileOutputStream fos = new FileOutputStream(des);
            byte [] input = new byte[64];
            int byteRead;

            while((byteRead = fis.read(input)) != -1) {
                byte [] output = cipher.update(input,0,byteRead);
                if(output != null)
                    fos.write(output);
            }
            try{
                byte [] output = cipher.doFinal();
                if(output != null)
                    fos.write(output);

            } catch (Exception e) {

                fis.close();
                fos.flush();
                fos.close();
                return;
            }
            fis.close();
            fos.flush();
            fos.close();
        }  else {
            System.out.println("wrong path");
        }
    }

    public String decrypt(String text) throws Exception {
        if(key == null) {
            return null;
        }
        Cipher cipher = Cipher.getInstance(DES);

        try {
            cipher.init(Cipher.DECRYPT_MODE,key);
        }catch(Exception e) {
            e.printStackTrace();
        }

        try {
            byte [] plainText = cipher.doFinal(Base64.getDecoder().decode(text));
            return new String(plainText,"UTF-8");
        } catch(Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String showKey() {
        if(key == null) return null;
        return Base64.getEncoder().encodeToString(key.getEncoded());
    }

    public SecretKey setKey(String secretKey) {
        try {
            key = new SecretKeySpec(secretKey.getBytes(), "AES");
        } catch(Exception e) {
            return null;
        }
        return key;
    }
}
