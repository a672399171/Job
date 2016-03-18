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
		int x, y;
		x = y = 0;

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

		//cutPic(filePath,x,y);
	}

	public static void cutPic(String srcFile,int x,int y) {
		FileInputStream is = null;
		ImageInputStream iis = null;
		try {
			// 如果源图片不存在
			if (!new File(srcFile).exists()) {
				return;
			}

			// 读取图片文件
			is = new FileInputStream(srcFile);

			// 获取文件格式
			String ext = srcFile.substring(srcFile.lastIndexOf(".") + 1);

			// ImageReader声称能够解码指定格式
			Iterator<ImageReader> it = ImageIO.getImageReadersByFormatName(ext);
			ImageReader reader = it.next();

			// 获取图片流
			iis = ImageIO.createImageInputStream(is);

			// 输入源中的图像将只按顺序读取
			reader.setInput(iis, true);

			// 描述如何对流进行解码
			ImageReadParam param = reader.getDefaultReadParam();

			// 图片裁剪区域
			Rectangle rect = new Rectangle(x, y, newWidth, newWidth);

			// 提供一个 BufferedImage，将其用作解码像素数据的目标
			param.setSourceRegion(rect);

			// 使用所提供的 ImageReadParam 读取通过索引 imageIndex 指定的对象
			BufferedImage bi = reader.read(0, param);

			// 保存新图片
			File tempOutFile = new File(srcFile);
			if (!tempOutFile.exists()) {
				tempOutFile.mkdirs();
			}
			ImageIO.write(bi, ext, new File(srcFile));
			return;
		} catch (Exception e) {
			e.printStackTrace();
			return;
		} finally {
			try {
				if (is != null) {
					is.close();
				}
				if (iis != null) {
					iis.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
				return;
			}
		}
	}

	public static void main(String[] args) {
		cutPicture("C:\\Users\\Administrator\\Desktop\\2.png");
	}
}
