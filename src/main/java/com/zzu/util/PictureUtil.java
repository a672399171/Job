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
}
