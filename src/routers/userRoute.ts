import express from "express";
import {
  authentication,
  changePicture,
  createUser,
  deleteUser,
  getAllUser,
  updateUser,
} from "../controllers/userController";
import validateEmail from "../middlewares/validateEmail";
import { verifyAuthentication } from "../middlewares/userValidation";
import { verifyRole, verifyToken } from "../middlewares/authorization";
import uploadProfilePicture from "../middlewares/userUpload";

const app = express();
app.use(express.json());

app.post(`/create`, [validateEmail], createUser);
app.post(`/login`, [verifyAuthentication], authentication);
app.get(`/`, [verifyToken, verifyRole(["CASHIER", "MANAGER"])], getAllUser);
app.put("/:id", [verifyToken, verifyRole(["MANAGER"])], updateUser);
app.put("/pic/:id", [verifyToken, verifyRole(["MANAGER"])], [uploadProfilePicture.single("picture")], changePicture);
app.delete("/:id", [verifyToken, verifyRole(["MANAGER"])], deleteUser);

export default app;
