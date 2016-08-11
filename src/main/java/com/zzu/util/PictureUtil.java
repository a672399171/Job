package com.zzu.util;

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

	//先裁剪再缩放
	public static void cutPicture(String src) {
		File file = new File(src);
		ImageIcon ii = null;
		try {
			ii = new ImageIcon(file.getCanonicalPath());
		} catch (IOException e) {
			e.printStackTrace();
		}
		String format = src.substring(src.lastIndexOf(".") + 1);

		Image i = ii.getImage();

		int iWidth = i.getWidth(null);
		int iHeight = i.getHeight(null);
		int x = 0, y = 0, w = 0;

		if (iWidth > iHeight) {
			y = 0;
			x = (iWidth - iHeight) / 2;
			w = iHeight;
		} else {
			x = 0;
			y = (iHeight - iWidth) / 2;
			w = iWidth;
		}

		//裁剪图片
		cut(src, x, y, w, w,format);

		//缩放图片
		//zoomPicture(src);
	}

	//缩放图片
	/*private static void zoomPicture(String src) {
		File file = new File(src);
		ImageIcon ii = null;
		try {
			ii = new ImageIcon(file.getCanonicalPath());
		} catch (IOException e) {
			e.printStackTrace();
		}
		Image i = ii.getImage();
		Image resizedImage = null;

		resizedImage = i.getScaledInstance(newWidth, newWidth, Image.SCALE_SMOOTH);

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
			out = new FileOutputStream(src);
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
	}*/

	private static void cut(String src, int x, int y, int w, int h,String format) {
		Iterator iterator = ImageIO.getImageReadersByFormatName(format);
		ImageReader reader = (ImageReader) iterator.next();
		InputStream in = null;
		ImageInputStream iis = null;
		BufferedImage bi = null;

		try {
			in = new FileInputStream(src);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		try {
			iis = ImageIO.createImageInputStream(in);
			reader.setInput(iis, true);
			ImageReadParam param = reader.getDefaultReadParam();
			Rectangle rect = new Rectangle(x, y, w, h);
			param.setSourceRegion(rect);

			bi = reader.read(0, param);
			ImageIO.write(bi, format, new File(src));
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (iis != null) {
				try {
					iis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public static void main(String[] args) {
		cutPicture("C:\\Users\\Administrator\\Desktop\\1.jpg");
	}
}
