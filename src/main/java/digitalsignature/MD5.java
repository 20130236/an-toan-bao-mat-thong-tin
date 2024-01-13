package digitalsignature;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.math.BigInteger;
import java.security.DigestInputStream;
import java.security.MessageDigest;

public class MD5 {

    public String getHashFromText(String text) throws Exception {
        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
        byte [] output = messageDigest.digest(text.getBytes());
        BigInteger bigInt = new BigInteger(1, output);
        return bigInt.toString(16);
    }

    public String getHashFromFile(File file) throws Exception {
        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
        if(file.isFile()) {
            DigestInputStream dis = new DigestInputStream(new BufferedInputStream(new FileInputStream(file)), messageDigest);
            byte [] read = new byte[1024];
            int i;
            do {
                i = dis.read(read);
            } while(i != -1);
            BigInteger num = new BigInteger(1,dis.getMessageDigest().digest());
            return num.toString(16);
        } else {
           System.out.println("wrong path");
        }
        return null;
    }
}
