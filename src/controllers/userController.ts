import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import { v4 as uuidv4 } from "uuid";
import { BASE_URL, SECRET } from "../global";
import md5 from "md5";
import { sign } from "jsonwebtoken";
import fs from "fs";

const prisma = new PrismaClient({ errorFormat: "pretty" });

export const createUser = async (request: Request, response: Response) => {
  try {
    const { name, email, password, role } = request.body;

    if (!email) {
      return response.status(400).json({
        status: false,
        message: "Email is required",
      });
    }

    const userExists = await prisma.user.findUnique({
      where: { email },
    });

    if (userExists) {
      return response.status(409).json({
        status: false,
        message: "User already exists",
      });
    }

    const uuid = uuidv4();
    const hashedPassword = md5(password);

    const newUser = await prisma.user.create({
      data: {
        uuid,
        name: name || "",
        email,
        password: hashedPassword,
        role: role || "CASHIER",
      },
    });

    return response.status(201).json({
      status: true,
      data: newUser,
      message: "New user has been created",
    });
  } catch (error) {
    return response.status(400).json({
      status: false,
      message: `There is an error: ${error}`,
    });
  }
};

export const updateUser = async (request: Request, response: Response) => {
  try {
    const { id } = request.params;
    const { name, email, role } = request.body;

    const findUser = await prisma.user.findFirst({
      where: { idUser: Number(id) },
    });

    if (!findUser) {
      return response.status(404).json({
        status: false,
        message: "User is not found",
      });
    }

    const updatedUser = await prisma.user.update({
      data: {
        name: name || findUser.name,
        email: email || findUser.email,
        role: role || findUser.role,
      },
      where: { idUser: Number(id) },
    });

    return response.status(200).json({
      status: true,
      data: updatedUser,
      message: "User has been updated",
    });
  } catch (error) {
    return response.status(400).json({
      status: false,
      message: `There is an error: ${error}`,
    });
  }
};

export const changePicture = async (request: Request, response: Response) => {
  try {
    const { id } = request.params;

    const findUser = await prisma.user.findFirst({
      where: { idUser: Number(id) },
    });
    if (!findUser)
      return response
        .status(200)
        .json({ status: false, message: "User is not found" });

    let filename = findUser.picture;
    if (request.file) {
      filename = request.file.filename;
      let path = `${BASE_URL}/../public/user_picture/${findUser.picture}`;
      let exists = fs.existsSync(path);
      if (exists && findUser.picture !== ``) fs.unlinkSync(path);
    }

    const updatePicture = await prisma.user.update({
      data: { picture: filename },
      where: { idUser: Number(id) },
    });

    return response
      .json({
        status: true,
        data: updatePicture,
        message: `Picture has changed`,
      })
      .status(200);
  } catch (error) {
    return response
      .json({
        status: false,
        message: `There is an error. ${error}`,
      })
      .status(400);
  }
};

export const deleteUser = async (request: Request, response: Response) => {
  try {
    const { id } = request.params;

    const findUser = await prisma.user.findFirst({
      where: { idUser: Number(id) },
    });

    if (!findUser) {
      return response.status(404).json({
        status: false,
        message: "User not found",
      });
    }

    await prisma.user.delete({
      where: { idUser: Number(id) },
    });

    if (findUser.picture) {
      const picturePath = `${BASE_URL}/../public/user_picture/${findUser.picture}`;
      if (fs.existsSync(picturePath)) {
        fs.unlinkSync(picturePath);
      }
    }

    return response.status(200).json({
      status: true,
      message: "User has been deleted",
    });
  } catch (error) {
    return response.status(400).json({
      status: false,
      message: `There is an error: ${error}`,
    });
  }
};

export const authentication = async (request: Request, response: Response) => {
  try {
    const { email, password } = request.body;

    const findUser = await prisma.user.findFirst({
      where: { email, password: md5(password) },
    });

    if (!findUser) {
      return response.status(400).json({
        status: false,
        logged: false,
        message: "Email or password is invalid",
      });
    }

    const data = {
      id: findUser.idUser,
      name: findUser.name,
      email: findUser.email,
      role: findUser.role,
    };

    const payload = JSON.stringify(data);
    const token = sign(payload, SECRET || "token");

    return response.status(200).json({
      status: true,
      logged: true,
      message: "Login successful",
      token,
    });
  } catch (error) {
    return response.status(400).json({
      status: false,
      message: `There is an error: ${error}`,
    });
  }
};

export const getAllUser = async (request: Request, response: Response) => {
  try {
    const { search } = request.query;
    const allUser = await prisma.user.findMany({
      where: { name: { contains: search?.toString() || "" } },
    });

    return response.status(200).json({
      status: true,
      data: allUser,
      message: "Users have been retrieved",
    });
  } catch (error) {
    return response.status(400).json({
      status: false,
      message: `There is an error: ${error}`,
    });
  }
};
