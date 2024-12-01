/*
  Warnings:

  - Made the column `description` on table `menu` required. This step will fail if there are existing NULL values in that column.
  - Made the column `profile_picture` on table `user` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `menu` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `name` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `price` INTEGER NOT NULL DEFAULT 0,
    MODIFY `picture` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `description` TEXT NOT NULL DEFAULT '';

-- AlterTable
ALTER TABLE `order` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `customer` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `table_number` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `total_price` INTEGER NOT NULL DEFAULT 0,
    MODIFY `idUser` INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `orderlist` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `idOrder` INTEGER NOT NULL DEFAULT 0,
    MODIFY `idMenu` INTEGER NOT NULL DEFAULT 0,
    MODIFY `quantity` INTEGER NOT NULL DEFAULT 0,
    MODIFY `note` TEXT NOT NULL DEFAULT '';

-- AlterTable
ALTER TABLE `user` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `name` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `email` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `password` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `profile_picture` VARCHAR(191) NOT NULL DEFAULT '';
