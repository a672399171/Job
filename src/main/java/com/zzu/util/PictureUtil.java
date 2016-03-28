package com.zzu.util;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Iterator;

/**
 * Created by Administrator on 2016/3/3.
 */
public class PictureUtil {
	public static final int newWidth = 100;

	public static void cutPicture(String filePath) {
		//缩放图片
		File file = new File(filePath);
		ImageIcon ii = null;
		try {
			ii = new ImageIcon(file.getCanonicalPath());
		} catch (IOException e) {
			e.printStackTrace();
		}
		Image i = ii.getImage();
		Image resizedImage = null;

		int iWidth = i.getWidth(null);
		int iHeight = i.getHeight(null);
		int x = 0, y = 0;

		if (iWidth < iHeight) {
			resizedImage = i.getScaledInstance(newWidth, (newWidth * iHeight)
					/ iWidth, Image.SCALE_SMOOTH);
			x = 0;
			y = ((newWidth * iHeight) / iWidth - newWidth) / 2;
		} else {
			resizedImage = i.getScaledInstance((newWidth * iWidth) / iHeight,
					newWidth, Image.SCALE_SMOOTH);
			x = ((newWidth * iWidth) / iHeight - newWidth) / 2;
			y = 0;
		}

		// This code ensures that all the pixels in the image are loaded.
		Image temp = new ImageIcon(resizedImage).getImage();

		// Create the buffered image.
		BufferedImage bufferedImage = new BufferedImage(temp.getWidth(null),
				temp.getHeight(null), BufferedImage.TYPE_INT_RGB);

		// Copy image to buffered image.
		Graphics g = bufferedImage.createGraphics();

		// Clear background and paint the image.
		g.setColor(Color.white);
		g.fillRect(0, 0, temp.getWidth(null), temp.getHeight(null));
		g.drawImage(temp, 0, 0, null);
		g.dispose();

		// Write the jpeg to a file.
		FileOutputStream out = null;
		try {
			out = new FileOutputStream(filePath);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		// Encodes image as a JPEG data stream
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);

		JPEGEncodeParam param = encoder
				.getDefaultJPEGEncodeParam(bufferedImage);

		param.setQuality((float) 0.7, true);

		encoder.setJPEGEncodeParam(param);
		try {
			encoder.encode(bufferedImage);
		} catch (IOException e) {
			e.printStackTrace();
		}

		//裁剪图片
		cut(filePath, x, y);
	}

	private static void cut(String src, int x, int y) {
		Iterator iterator = ImageIO.getImageReadersByFormatName("jpg");
		ImageReader reader = (ImageReader) iterator.next();
		InputStream in = null;
		ImageInputStream iis = null;

		try {
			in = new FileInputStream(src);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		try {
			iis = ImageIO.createImageInputStream(in);
			reader.setInput(iis, true);
			ImageReadParam param = reader.getDefaultReadParam();
			Rectangle rect = new Rectangle(x, y, newWidth, newWidth);
			param.setSourceRegion(rect);
			BufferedImage bi = null;
			bi = reader.read(0, param);
			ImageIO.write(bi, "jpg", new File(src));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		cutPicture("C:\\Users\\Administrator\\Desktop\\1.png");
	}
}
