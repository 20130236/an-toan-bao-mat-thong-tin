package digitalsignature;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Arrays;
import java.util.Base64;

public class RSA {

    private static String RSA = "RSA";
    private PublicKey publicKey;
    private PrivateKey privateKey;
    private KeyPair keyPair;

    private Integer keySize = 1024;

    public void createKey() throws NoSuchAlgorithmException {
        KeyPairGenerator keyGenerator = KeyPairGenerator.getInstance(RSA);
        keyGenerator.initialize(keySize);
        keyPair = keyGenerator.genKeyPair();
        privateKey = keyPair.getPrivate();
        publicKey = keyPair.getPublic();
    }

    public String encrypt(String text) throws Exception {
        if(privateKey == null) {
            return null;
        }

        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");

        try {
            cipher.init(Cipher.ENCRYPT_MODE,privateKey);
        }catch(Exception e) {
            e.printStackTrace();
        }

        byte [] plainText = text.getBytes(StandardCharsets.UTF_8);
        return Base64.getEncoder().encodeToString(cipher.doFinal(plainText));
    }

    public void encryptFile(String src,String des) throws Exception {
        if(publicKey == null|| privateKey == null) {
            return;
        }
        File file = new File(src);
        if(file.isFile()) {
            KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
            keyGenerator.init(256);
            byte[] iv = new byte[16];

            IvParameterSpec spec = new IvParameterSpec(iv);
            SecretKey secretKey = keyGenerator.generateKey();
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE,secretKey,spec);

            CipherInputStream inputStream = new CipherInputStream(new FileInputStream(src), cipher);
            DataOutputStream dataOutputStream = new DataOutputStream(new FileOutputStream(des));

            String stringKey = encrypt(Base64.getEncoder().encodeToString(secretKey.getEncoded()));
            dataOutputStream.writeUTF(stringKey);
            dataOutputStream.writeLong(new File(src).length());
            dataOutputStream.writeUTF(Base64.getEncoder().encodeToString(iv));

            byte [] input = new byte[1024];
            int byteRead;

            while((byteRead = inputStream.read(input)) != -1) {
                dataOutputStream.write(input,0,byteRead);
            }

            inputStream.close();
            dataOutputStream.flush();
            dataOutputStream.close();
        }
    }

    public void decryptFile(String src,String des) throws Exception {
        if(publicKey == null|| privateKey == null) {
            return;
        }
        File file = new File(src);
        if(file.isFile()) {
            DataInputStream dataInputStream = new DataInputStream(new FileInputStream(src));
            String stringKey = dataInputStream.readUTF();

            long length = dataInputStream.readLong();
            byte [] iv = Base64.getDecoder().decode(dataInputStream.readUTF());
            SecretKey secretKey = new SecretKeySpec(Base64.getDecoder().decode(decrypt(stringKey)),"AES");

            IvParameterSpec spec = new IvParameterSpec(iv);
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE,secretKey,spec);
            CipherInputStream cis = new CipherInputStream(dataInputStream, cipher);
            BufferedOutputStream buf = new BufferedOutputStream(new FileOutputStream(des));

            byte [] input = new byte[1024];
            int byteRead;

            while((byteRead = cis.read(input)) != -1) {
                buf.write(input,0,byteRead);
            }

            cis.close();
            buf.close();

        }
    }

    public String decrypt(String text) throws Exception {
        if(publicKey == null) {
            return null;
        }
        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
        try {
            cipher.init(Cipher.DECRYPT_MODE,publicKey);
        }catch(Exception e) {
            e.printStackTrace();
        }

        try {
            byte [] plainText = cipher.doFinal(Base64.getDecoder().decode(text));
            return new String(plainText, StandardCharsets.UTF_8);
        } catch(Exception e) {
            return null;
        }
    }

    public String getPublicKey() {
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }

    public String getPrivateKey() {
        return Base64.getEncoder().encodeToString(privateKey.getEncoded());
    }

    public void loadPublicKey(String stringPublicKey) throws Exception{
        byte[] data = Base64.getDecoder().decode((stringPublicKey.getBytes()));
        X509EncodedKeySpec spec = new X509EncodedKeySpec(data);
        KeyFactory fact = KeyFactory.getInstance("RSA");
        this.publicKey = fact.generatePublic(spec);
    }

    public void loadPrivateKey(String privateKey) throws Exception {
        byte[] clear = Base64.getDecoder().decode(privateKey.getBytes());
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(clear);
        KeyFactory fact = KeyFactory.getInstance("RSA");
        PrivateKey priv = fact.generatePrivate(keySpec);
        Arrays.fill(clear, (byte) 0);
        this.privateKey = priv;
    }

    public void setKeySize(Integer keySize){
        this.keySize = keySize;
    }
}

